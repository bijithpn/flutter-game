import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_games/src/features/sudoku/data/model/sudoku.dart';
import 'package:flutter_games/src/features/sudoku/data/repository/sudoku_repository.dart';

part 'sudoku_event.dart';
part 'sudoku_state.dart';

class SudokuBloc extends Bloc<SudokuEvent, SudokuState> {
  final SudokuRepository sudokuRepository;
  Sudoku? _currentPuzzle;

  SudokuBloc(this.sudokuRepository) : super(SudokuInitial()) {
    on<SudokuGenerateEvent>(_onGenerateSudoku);
    on<SudokuResetEvent>(_onResetSudoku);
    on<SudokuVerifyEvent>(_onVerifySudoku);
    on<SudokuValidateEvent>(_onValidateSudoku);
  }

  Future<void> _onGenerateSudoku(
      SudokuGenerateEvent event, Emitter<SudokuState> emit) async {
    try {
      emit(SudokuLoading());
      _currentPuzzle = await sudokuRepository.generateSudoku();
      emit(SudokuGenerated(sudoku: _currentPuzzle));
    } catch (e) {
      emit(SudokuError(message: e.toString()));
    }
  }

  Future<void> _onResetSudoku(
      SudokuResetEvent event, Emitter<SudokuState> emit) async {
    try {
      emit(SudokuLoading());
      _currentPuzzle = await sudokuRepository.generateSudoku();
      emit(SudokuGenerated(sudoku: _currentPuzzle));
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
        emit(SudokuError(
            message:
                "There seems to be an error in ${result["position"] ?? "sudoku"}. Please review and correct the highlighted row or column before resubmitting."));
        emit(SudokuGenerated(sudoku: _currentPuzzle));
      }
    } catch (e) {
      emit(SudokuError(message: e.toString()));
    }
  }

  void _onValidateSudoku(SudokuValidateEvent event, Emitter<SudokuState> emit) {
    emit(SudokuValidationError(
        message:
            "It looks like some columns are missing values. Please fill in all cells before submitting."));
    emit(SudokuGenerated(sudoku: _currentPuzzle));
  }
}
