import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_games/src/core/styles/app_colors.dart';
import 'package:flutter_games/src/core/utils/constants/app_constants.dart';
import 'package:flutter_games/src/core/utils/injections.dart';
import 'package:flutter_games/src/features/features.dart';
import 'package:flutter_games/src/features/minesweeper/data/repository/minesweeper_repository.dart';

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
              },
              child: const Text('Try Again'),
            ),
          ],
        );
      },
    );
  }

  void _showHowToPlayDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return const MinesweeperInstructionWidget();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => mineSweeperBloc,
      child: BlocListener<MinesweeperBloc, MinesweeperState>(
        listener: (context, state) {
          if (state is MinesweeperCompleted) {
            showDialog(
              context: context,
              barrierDismissible: false,
              builder: (BuildContext context) {
                return SudokuDialogWidget(
                  onTap: () {
                    Navigator.pop(context);
                    mineSweeperBloc.add(MinesweeperGenerateEvent());
                  },
                  buttonIcon: Icon(
                    Icons.celebration,
                    color: Colors.black,
                  ),
                  buttonTitle: "Play Again",
                  title: "Congratulations!",
                  message:
                      "Well done! You've successfully completed the Sudoku puzzle. Every cell is correctly filled.",
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
          if (state is GameOver) {
            _showGameOverDialog();
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
            actions: [
              IconButton(
                icon: const Icon(Icons.info_outline),
                onPressed: () => _showHowToPlayDialog(context),
              ),
            ],
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
                                "0",
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
                      GridView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: state.minesweeper.width,
                        ),
                        itemCount:
                            state.minesweeper.width * state.minesweeper.height,
                        itemBuilder: (context, index) {
                          int row = index ~/ state.minesweeper.height;
                          int col = index % state.minesweeper.height;
                          return GridCell(
                            onTap: () {
                              mineSweeperBloc.add(MinesweeperCellTappedEvent(
                                row: row,
                                column: col,
                              ));
                            },
                            onLongPress: () {
                              mineSweeperBloc.add(
                                MinesweeperCellTappedEvent(
                                  row: row,
                                  column: col,
                                  isFlagged: true,
                                ),
                              );
                            },
                            cell: state.minesweeper.board[row][col],
                          );
                        },
                      ),
                      MinesweeperInstructionWidget()
                    ],
                  ),
                );
              }
              return Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                child: MinesweeperInstructionWidget(),
              );
            },
          ),
        ),
      ),
    );
  }
}
