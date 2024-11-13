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

final class MinesweeperCompleted extends MinesweeperState {
  const MinesweeperCompleted();
}

final class GameOver extends MinesweeperState {
  const GameOver();
}

final class MinesweeperError extends MinesweeperState {
  final String message;

  const MinesweeperError({required this.message});
}
