import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_games/src/core/network/error/dio_error_handler.dart';
import 'package:flutter_games/src/core/network/error/exceptions.dart';
import 'package:flutter_games/src/features/sudoku/data/model/sudoku.dart';
import 'package:flutter_games/src/features/sudoku/data/repository/sudoku_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

part 'sudoku_event.dart';
part 'sudoku_state.dart';

class SudokuBloc extends HydratedBloc<SudokuEvent, SudokuState> {
  SudokuBloc(this.sudokuRepository) : super(SudokuInitial()) {
    on<SudokuGenerateEvent>(_onGenerateSudoku, transformer: restartable());
    on<SudokuResetEvent>(_onResetSudoku);
    on<SudokuVerifyEvent>(_onVerifySudoku);
    on<SudokuValidateEvent>(_onValidateSudoku);
    on<SudokuUpdateEvent>(_onUpdateSudoku);
  }

  final SudokuRepository sudokuRepository;

  Sudoku? _currentPuzzle;

  @override
  SudokuState? fromJson(Map<String, dynamic> json) {
    try {
      final sudokuData = Sudoku.fromJson(json['currentPuzzle']);
      _currentPuzzle = sudokuData;
      return SudokuGenerated(sudoku: sudokuData);
    } catch (e) {
      return SudokuInitial();
    }
  }

  @override
  Map<String, dynamic>? toJson(SudokuState state) {
    if (state is SudokuGenerated) {
      return {'currentPuzzle': state.sudoku?.toJson()};
    }
    return null;
  }

  Future<void> _onGenerateSudoku(
      SudokuGenerateEvent event, Emitter<SudokuState> emit) async {
    try {
      if (_currentPuzzle != null) {
        emit(SudokuGenerated(sudoku: _currentPuzzle!));
        return;
      }
      emit(SudokuLoading());
      var result = await sudokuRepository.generateSudoku();
      if (result != null) {
        List<List<bool>> editable = List.generate(
            9, (i) => List.generate(9, (j) => result.task[i][j] == 0));
        _currentPuzzle = Sudoku(
          grid: result.grid,
          task: result.task,
          isEditable: editable,
        );
        emit(SudokuGenerated(sudoku: _currentPuzzle!));
      }
    } on DioException catch (e) {
      emit(SudokuError(message: handleDioError(e)));
    } on ServerException {
      emit(SudokuError(
          message: "There seems to be an issue connecting to the server"));
    } catch (e) {
      emit(SudokuError(message: e.toString()));
    }
  }

  Future<void> _onResetSudoku(
      SudokuResetEvent event, Emitter<SudokuState> emit) async {
    try {
      emit(SudokuLoading());
      var result = await sudokuRepository.generateSudoku();
      if (result != null) {
        List<List<bool>> editable = List.generate(
            9, (i) => List.generate(9, (j) => result.task[i][j] == 0));
        _currentPuzzle = Sudoku(
          grid: result.grid,
          task: result.task,
          isEditable: editable,
        );
        emit(SudokuGenerated(sudoku: _currentPuzzle!));
      }
    } on DioException catch (e) {
      emit(SudokuError(message: handleDioError(e)));
    } on ServerException {
      emit(SudokuError(
          message: "There seems to be an issue connecting to the server"));
    } catch (e) {
      emit(SudokuError(message: e.toString()));
    }
  }

  Future<void> _onVerifySudoku(
      SudokuVerifyEvent event, Emitter<SudokuState> emit) async {
    try {
      var result = await sudokuRepository.verifySudoku(event.sudokuData);
      if (result['isValid'] ?? false) {
        emit(SudokuCompleted());
      } else {
        emit(SudokuValidationError(
            buttonIcon: Icon(
              Icons.error_outline,
              color: Colors.black,
            ),
            buttonTitle: "Review Errors",
            title: "Invalid Puzzle Submission",
            message:
                "There seems to be an error in ${result["position"] ?? "sudoku"}. Please review and correct the highlighted row or column before resubmitting."));
        emit(SudokuGenerated(sudoku: _currentPuzzle));
      }
    } on DioException catch (e) {
      emit(SudokuError(message: handleDioError(e)));
    } on ServerException {
      emit(SudokuError(
          message: "There seems to be an issue connecting to the server"));
    } catch (e) {
      emit(SudokuError(message: e.toString()));
    }
  }

  void _onValidateSudoku(SudokuValidateEvent event, Emitter<SudokuState> emit) {
    emit(SudokuValidationError(
        title: "Incomplete Puzzle",
        buttonIcon: Icon(
          Icons.edit,
          color: Colors.black,
        ),
        buttonTitle: "Continue Editing",
        message:
            "It looks like some columns are missing values. Please fill in all cells before submitting."));
    emit(SudokuGenerated(sudoku: _currentPuzzle));
  }

  void _onUpdateSudoku(SudokuUpdateEvent event, Emitter<SudokuState> emit) {
    if (_currentPuzzle != null) {
      _currentPuzzle!.task = event.sudokuData;
      emit(SudokuGenerated(sudoku: _currentPuzzle!));
    }
  }
}
