part of 'sudoku_bloc.dart';

sealed class SudokuState extends Equatable {
  const SudokuState();

  @override
  List<Object> get props => [];
}

final class SudokuInitial extends SudokuState {}

final class SudokuLoading extends SudokuState {}

final class SudokuGenerated extends SudokuState {
  final Sudoku? sudoku;

  const SudokuGenerated({required this.sudoku});
}

final class SudokuVerify extends SudokuState {
  final bool isValid;

  const SudokuVerify({required this.isValid});
}

final class SudokuCompleted extends SudokuState {
  const SudokuCompleted();
}

final class SudokuError extends SudokuState {
  final String message;

  const SudokuError({required this.message});
}

final class SudokuValidationError extends SudokuState {
  final String message;

  const SudokuValidationError({required this.message});
}
