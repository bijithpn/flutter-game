part of 'sudoku_bloc.dart';

sealed class SudokuEvent extends Equatable {
  const SudokuEvent();

  @override
  List<Object> get props => [];
}

class SudokuLoadingEvent extends SudokuEvent {}

class SudokuGenerateEvent extends SudokuEvent {}

class SudokuResetEvent extends SudokuEvent {}

class SudokuVerifyEvent extends SudokuEvent {
  final String sudokuData;
  const SudokuVerifyEvent(this.sudokuData);
}

class SudokuValidateEvent extends SudokuEvent {}

class SudokuUpdateEvent extends SudokuEvent {
  final List<List<int>> sudokuData;
  const SudokuUpdateEvent(this.sudokuData);
}
