import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_games/src/features/features.dart';
import 'package:flutter_games/src/features/minesweeper/data/model/minesweeper_model.dart';

import 'grid_cell.dart';

class MineSweeperGrid extends StatelessWidget {
  final int cellSize;
  final List<List<Cell>> board;
  const MineSweeperGrid({
    super.key,
    required this.cellSize,
    required this.board,
  });

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: cellSize,
      ),
      itemCount: cellSize * cellSize,
      itemBuilder: (context, index) {
        int row = index ~/ cellSize;
        int col = index % cellSize;
        return GridCell(
          onTap: () {
            BlocProvider.of<MinesweeperBloc>(context)
                .add(MinesweeperCellTappedEvent(
              row: row,
              column: col,
            ));
          },
          onLongPress: () {
            BlocProvider.of<MinesweeperBloc>(context).add(
              MinesweeperCellTappedEvent(
                row: row,
                column: col,
                isFlagged: true,
              ),
            );
          },
          cell: board[row][col],
        );
      },
    );
  }
}
