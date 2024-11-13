part of 'minesweeper_bloc.dart';

sealed class MinesweeperEvent extends Equatable {
  const MinesweeperEvent();

  @override
  List<Object> get props => [];
}

class MinesweeperLoadingEvent extends MinesweeperEvent {}

class MinesweeperGenerateEvent extends MinesweeperEvent {
  final int boardWidth;
  final int boardHeight;
  final int mineCount;
  final bool initiaLunch;

  const MinesweeperGenerateEvent(
      {this.boardWidth = 9,
      this.boardHeight = 9,
      this.mineCount = 10,
      this.initiaLunch = false});
}

class MinesweeperCellTappedEvent extends MinesweeperEvent {
  const MinesweeperCellTappedEvent({
    required this.row,
    required this.column,
    this.isFlagged = false,
  });
  final int column;
  final bool isFlagged;
  final int row;
}

class MinesweeperGameOverEvent extends MinesweeperEvent {
  const MinesweeperGameOverEvent();
}

class MinesweeperResetEvent extends MinesweeperEvent {}
