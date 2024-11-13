import 'package:flutter/material.dart';

import 'package:flutter_games/src/core/styles/app_colors.dart';
import 'package:flutter_games/src/core/utils/constants/app_constants.dart';

import '../../data/model/minesweeper_model.dart';

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
    return GestureDetector(
      onTap: cell.cellState == CellState.flagged ? null : onTap,
      onLongPress: cell.cellState == CellState.flagged ? null : onLongPress,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            margin: const EdgeInsets.all(2),
            decoration: BoxDecoration(
              color: cell.cellState == CellState.hidden ||
                      cell.cellState == CellState.flagged
                  ? AppColors.primaryColor
                  : (cell.hasMine ? AppColors.red : AppColors.secondaryColor),
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: Colors.black),
            ),
            child: Center(
              child: cell.cellState == CellState.revealed
                  ? (cell.hasMine
                      ? Image.asset(AppImages.bomb)
                      : Text(
                          "${cell.adjacentMines}",
                          style: Theme.of(context)
                              .textTheme
                              .bodyLarge!
                              .copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.primaryColor),
                        ))
                  : SizedBox.shrink(),
            ),
          ),
          if (cell.cellState == CellState.flagged)
            Icon(
              Icons.flag,
              color: AppColors.red,
              size: 40,
            ),
        ],
      ),
    );
  }
}
