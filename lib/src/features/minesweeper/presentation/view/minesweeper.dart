import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_games/src/core/styles/app_colors.dart';
import 'package:flutter_games/src/core/utils/constants/app_constants.dart';
import 'package:flutter_games/src/core/utils/injections.dart';
import 'package:flutter_games/src/features/features.dart';
import 'package:flutter_games/src/features/minesweeper/data/repository/minesweeper_repository.dart';

import '../../../../core/helper/minesweeper_helper.dart';
import '../widget/widget.dart';

class MinesweeperScreen extends StatefulWidget {
  const MinesweeperScreen({super.key});

  @override
  State<MinesweeperScreen> createState() => _MinesweeperScreenState();
}

class _MinesweeperScreenState extends State<MinesweeperScreen> {
  late MinesweeperBloc mineSweeperBloc;

  @override
  void initState() {
    mineSweeperBloc = MinesweeperBloc(sl<MineSweeperRepository>())
      ..add(MinesweeperGenerateEvent());
    super.initState();
  }

  void _showGameOverDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Game Over'),
          content: const Text('You hit a bomb!'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                mineSweeperBloc.add(MinesweeperResetEvent());
              },
              child: const Text('Try Again'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => mineSweeperBloc,
      child: BlocListener<MinesweeperBloc, MinesweeperState>(
        listener: (context, state) {
          if (state is GameWon) {
            showDialog(
              context: context,
              barrierDismissible: false,
              builder: (BuildContext context) {
                return SudokuDialogWidget(
                  onTap: () {
                    Navigator.pop(context);
                    mineSweeperBloc.add(MinesweeperResetEvent());
                  },
                  buttonIcon: Icon(
                    Icons.celebration,
                    color: Colors.black,
                  ),
                  buttonTitle: "Play Again",
                  title: "Congratulations!",
                  message:
                      "Well done! You've successfully completed the Minesweeper.You found every mine correctly.",
                );
              },
            );
          }
          if (state is MinesweeperError) {
            showDialog(
              context: context,
              barrierDismissible: false,
              builder: (BuildContext context) {
                return SudokuDialogWidget(
                  title: "Oops!",
                  message: state.message,
                  buttonIcon: Icon(
                    Icons.error_outline,
                    color: Colors.black,
                  ),
                  onTap: () {
                    Navigator.pop(context);
                    mineSweeperBloc.add(MinesweeperGenerateEvent());
                  },
                  buttonTitle: "Try again",
                );
              },
            );
          }
        },
        child: Scaffold(
          appBar: AppBar(
            title: Text(
              'Minesweeper',
              style: Theme.of(context)
                  .textTheme
                  .titleLarge!
                  .copyWith(fontWeight: FontWeight.bold),
            ),
          ),
          body: BlocBuilder<MinesweeperBloc, MinesweeperState>(
            builder: (context, state) {
              if (state is MinesweeperGenerated) {
                var mineData = state.minesweeper;
                return SingleChildScrollView(
                  padding:
                      const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Flexible(
                            child: ListTile(
                              leading: Image.asset(
                                AppImages.tiles,
                                width: 27,
                                color: AppColors.red,
                              ),
                              title: Text(
                                "${mineData.width} x ${mineData.height}",
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyLarge!
                                    .copyWith(fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                          Flexible(
                            child: ListTile(
                              leading: Icon(
                                Icons.flag,
                                color: AppColors.red,
                              ),
                              title: Text(
                                "${MinesweeperHelper.getFlagCount(mineData.width, mineData.board)}",
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyLarge!
                                    .copyWith(fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                          Flexible(
                            child: ListTile(
                              leading: Image.asset(
                                AppImages.bomb,
                                width: 27,
                              ),
                              title: Text(
                                mineData.mines.toString(),
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyLarge!
                                    .copyWith(fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        ],
                      ),
                      MineSweeperGrid(
                        cellSize: mineData.width,
                        board: mineData.board,
                      ),
                      MinesweeperInstructionWidget()
                    ],
                  ),
                );
              }
              return SingleChildScrollView(
                padding:
                    const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                child: Column(
                  children: [
                    if (state is GameOver)
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Game Over",
                            style: Theme.of(context)
                                .textTheme
                                .titleLarge!
                                .copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                          ),
                          Row(
                            children: [
                              Image.asset(
                                AppImages.bomb,
                                width: 24,
                              ),
                              SizedBox(width: 10),
                              Text(
                                'You hit a bomb!',
                                style: Theme.of(context).textTheme.bodyLarge,
                              ),
                            ],
                          ),
                          SizedBox(height: 10),
                          MineSweeperGrid(
                            cellSize: state.cellSize,
                            board: state.board,
                          ),
                          Center(
                            child: TextButton.icon(
                              icon: Icon(
                                Icons.sentiment_very_dissatisfied,
                                color: AppColors.red,
                              ),
                              onPressed: () {
                                mineSweeperBloc.add(MinesweeperResetEvent());
                              },
                              label: Text(
                                'Try Again',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyLarge!
                                    .copyWith(fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        ],
                      ),
                    MinesweeperInstructionWidget(),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
