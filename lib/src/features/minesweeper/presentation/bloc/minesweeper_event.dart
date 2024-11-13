part of 'minesweeper_bloc.dart';

sealed class MinesweeperEvent extends Equatable {
  const MinesweeperEvent();

  @override
  List<Object> get props => [];
}

class MinesweeperLoadingEvent extends MinesweeperEvent {}

class MinesweeperGenerateEvent extends MinesweeperEvent {}

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

class MinesweeperResetEvent extends MinesweeperEvent {}
