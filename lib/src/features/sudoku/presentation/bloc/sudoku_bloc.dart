import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_games/src/features/sudoku/data/model/sudoku.dart';
import 'package:flutter_games/src/features/sudoku/data/repository/sudoku_repository.dart';

part 'sudoku_event.dart';
part 'sudoku_state.dart';

class SudokuBloc extends Bloc<SudokuEvent, SudokuState> {
  final SudokuRepository sudokuRepository;

  SudokuBloc(this.sudokuRepository) : super(SudokuInitial()) {
    on<SudokuGenerateEvent>(_onGenerateSudoku);
    on<SudokuResetEvent>(_onResetSudoku);
    on<SudokuVerifyEvent>(_onVerifySudoku);
  }

  Future<void> _onGenerateSudoku(
      SudokuGenerateEvent event, Emitter<SudokuState> emit) async {
    try {
      emit(SudokuLoading());
      var result = await sudokuRepository.generateSudoku();
      emit(SudokuGenrated(sudoku: result));
    } catch (e) {
      emit(SudokuError(message: e.toString()));
    }
  }

  Future<void> _onResetSudoku(
      SudokuResetEvent event, Emitter<SudokuState> emit) async {
    try {
      emit(SudokuLoading());
      var result = await sudokuRepository.generateSudoku();
      emit(SudokuGenrated(sudoku: result));
    } catch (e) {
      emit(SudokuError(message: e.toString()));
    }
  }

  Future<void> _onVerifySudoku(
      SudokuVerifyEvent event, Emitter<SudokuState> emit) async {
    try {
      var result = await sudokuRepository.verifySudoku(event.sudokuData);
      if (result) {
        emit(SudokuCompleted());
      } else {
        emit(SudokuError(message: "Given sudokuData is not valid,"));
      }
    } catch (e) {
      emit(SudokuError(message: e.toString()));
    }
  }
}
