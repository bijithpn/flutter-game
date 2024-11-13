import 'package:flutter/material.dart';
import 'package:flutter_games/src/core/styles/app_colors.dart';
import 'package:flutter_games/src/core/utils/constants/app_constants.dart';

class MinesweeperInstructionWidget extends StatelessWidget {
  const MinesweeperInstructionWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final titleStyle = Theme.of(context)
        .textTheme
        .titleLarge!
        .copyWith(fontWeight: FontWeight.bold);
    final bodyStyle = Theme.of(context).textTheme.bodyMedium;
    final bodyBoldStyle = Theme.of(context)
        .textTheme
        .bodyMedium!
        .copyWith(fontWeight: FontWeight.bold);
    final subTitleStyle = Theme.of(context)
        .textTheme
        .bodyLarge!
        .copyWith(fontWeight: FontWeight.bold);
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 20),
          Text('How to Play Minesweeper', style: titleStyle),
          Text('Objective:', style: subTitleStyle),
          Text(
            'Reveal all cells without detonating any bombs.',
            style: bodyStyle,
          ),
          const SizedBox(height: 10),
          Text(
            'Instructions:',
            style: subTitleStyle,
          ),
          Text(
            '1. Tap a cell to reveal it.\n'
            '   - If the cell contains a bomb, you lose the game!\n'
            '   - If the cell is safe, it will display a number indicating how many bombs are adjacent to it.\n',
            style: bodyStyle,
          ),
          Text(
            '2. Use the numbers on safe cells to deduce where the bombs are located.\n',
            style: bodyStyle,
          ),
          Text(
            '3. Long press a cell to mark it as a suspected bomb (flagging). This helps keep track of bomb locations.\n',
            style: bodyStyle,
          ),
          Text(
            '4. Reveal all safe cells to win the game.',
            style: bodyStyle,
          ),
          const SizedBox(height: 10),
          Text(
            'Tips:',
            style: subTitleStyle,
          ),
          Text(
            '- Start with the corners or edges.\n'
            '- Use logic and deduction to avoid guessing.\n'
            '- Flag cells you suspect contain bombs to prevent accidental taps.',
            style: bodyStyle,
          ),
          const SizedBox(height: 20),
          Text(
            'Icons:',
            style: subTitleStyle,
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              Container(
                width: 28,
                height: 28,
                padding: EdgeInsets.all(3),
                decoration: BoxDecoration(
                  color: AppColors.primaryColor,
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Image.asset(
                  AppImages.flag,
                  width: 28,
                  color: AppColors.red,
                ),
              ),
              const SizedBox(width: 8),
              Text('Flagged cell (suspected bomb)', style: bodyBoldStyle),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Container(
                width: 28,
                height: 28,
                padding: EdgeInsets.all(3),
                decoration: BoxDecoration(
                  color: AppColors.red,
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Image.asset(
                  AppImages.bomb,
                  width: 28,
                ),
              ),
              const SizedBox(width: 8),
              Text('Bomb (game over if revealed)', style: bodyBoldStyle),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Container(
                width: 28,
                height: 28,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: AppColors.secondaryColor,
                  borderRadius: BorderRadius.circular(4),
                  border: Border.all(color: Colors.black),
                ),
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Text(
                    "1",
                    style: Theme.of(context).textTheme.titleLarge!.copyWith(
                        fontWeight: FontWeight.bold,
                        color: AppColors.primaryColor),
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Text('Safe cell (revealed)', style: bodyBoldStyle),
            ],
          ),
        ],
      ),
    );
  }
}
