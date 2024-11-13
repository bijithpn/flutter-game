import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_games/src/core/styles/app_colors.dart';
import 'package:flutter_games/src/core/utils/constants/app_constants.dart';

import '../../data/model/minesweeper_model.dart';
import '../bloc/minesweeper_bloc.dart';

class GridCell extends StatelessWidget {
  const GridCell({
    super.key,
    this.onTap,
    this.onLongPress,
    required this.cell,
  });
  final VoidCallback? onTap;
  final VoidCallback? onLongPress;
  final Cell cell;

  @override
  Widget build(BuildContext context) {
    final mineBloc = BlocProvider.of<MinesweeperBloc>(context);
    return GestureDetector(
      onTap: cell.cellState == CellState.flagged || mineBloc.state is GameOver
          ? null
          : onTap,
      onLongPress:
          mineBloc.state is GameOver || cell.cellState == CellState.flagged
              ? null
              : onLongPress,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: cell.cellState == CellState.hidden ||
                      cell.cellState == CellState.flagged
                  ? AppColors.primaryColor
                  : (cell.hasMine ? AppColors.red : AppColors.secondaryColor),
              borderRadius: BorderRadius.circular(4),
              border: Border.all(color: Colors.black),
            ),
            child: cell.cellState == CellState.revealed
                ? (cell.hasMine
                    ? FittedBox(
                        fit: BoxFit.scaleDown,
                        child: Image.asset(
                          AppImages.bomb,
                          width: 25,
                        ),
                      )
                    : cell.adjacentMines > 0
                        ? FittedBox(
                            fit: BoxFit.scaleDown,
                            child: Text(
                              "${cell.adjacentMines}",
                              style: Theme.of(context)
                                  .textTheme
                                  .titleLarge!
                                  .copyWith(
                                      fontWeight: FontWeight.bold,
                                      color: AppColors.primaryColor),
                            ),
                          )
                        : SizedBox.shrink())
                : SizedBox.shrink(),
          ),
          if (cell.cellState == CellState.flagged)
            Image.asset(
              AppImages.flag,
              width: 30,
              color: AppColors.red,
            ),
        ],
      ),
    );
  }
}
