part of 'minesweeper_bloc.dart';

sealed class MinesweeperState extends Equatable {
  const MinesweeperState();

  @override
  List<Object> get props => [];
}

final class MinesweeperInitial extends MinesweeperState {}

final class MinesweeperLoading extends MinesweeperState {}

final class MinesweeperGenerated extends MinesweeperState {
  final MineData minesweeper;

  const MinesweeperGenerated({required this.minesweeper});

  @override
  List<Object> get props => [minesweeper];
}

final class GameWon extends MinesweeperState {
  const GameWon();
}

final class GameOver extends MinesweeperState {
  final List<List<Cell>> board;
  final int cellSize;

  const GameOver({required this.board, required this.cellSize});

  @override
  List<Object> get props => [board, cellSize];
}

final class MinesweeperError extends MinesweeperState {
  final String message;

  const MinesweeperError({required this.message});
}
