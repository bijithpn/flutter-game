import 'dart:math';

import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_games/src/core/styles/app_colors.dart';
import 'package:flutter_games/src/core/utils/constants/app_constants.dart';
import 'package:flutter_games/src/core/utils/injections.dart';
import 'package:flutter_games/src/features/features.dart';
import 'package:flutter_games/src/features/minesweeper/data/repository/minesweeper_repository.dart';

import '../../../../core/helper/minesweeper_helper.dart';
import '../../../widgets/widgets.dart';
import '../widget/widget.dart';

class MinesweeperScreen extends StatefulWidget {
  const MinesweeperScreen({super.key});

  @override
  State<MinesweeperScreen> createState() => _MinesweeperScreenState();
}

class _MinesweeperScreenState extends State<MinesweeperScreen> {
  late MinesweeperBloc mineSweeperBloc;
  late ConfettiController _controllerCenterRight;
  late ConfettiController _controllerCenterLeft;
  late ConfettiController _controllerCenter;
  @override
  void initState() {
    mineSweeperBloc = MinesweeperBloc(sl<MineSweeperRepository>())
      ..add(MinesweeperGenerateEvent(initiaLunch: true));

    _controllerCenter =
        ConfettiController(duration: const Duration(seconds: 5));
    _controllerCenterRight =
        ConfettiController(duration: const Duration(seconds: 5));
    _controllerCenterLeft =
        ConfettiController(duration: const Duration(seconds: 5));
    super.initState();
  }

  @override
  void dispose() {
    _controllerCenterRight.dispose();
    _controllerCenterLeft.dispose();

    super.dispose();
  }

  void customMineSweeper() {
    int width = 0, height = 0, mines = 0;
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(
            'Create a Custom Board',
            style: Theme.of(context)
                .textTheme
                .titleLarge!
                .copyWith(fontWeight: FontWeight.bold),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                keyboardType: TextInputType.number,
                textInputAction: TextInputAction.next,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                onChanged: (value) {
                  if (value.isNotEmpty) {
                    width = int.parse(value);
                  }
                },
                decoration: InputDecoration(
                    label: Text('Width',
                        style: Theme.of(context).textTheme.bodyMedium)),
              ),
              TextFormField(
                keyboardType: TextInputType.number,
                textInputAction: TextInputAction.next,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                onChanged: (value) {
                  if (value.isNotEmpty) {
                    height = int.parse(value);
                  }
                },
                decoration: InputDecoration(
                    label: Text('Height',
                        style: Theme.of(context).textTheme.bodyMedium)),
              ),
              TextFormField(
                textInputAction: TextInputAction.done,
                keyboardType: TextInputType.number,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                onChanged: (value) {
                  if (value.isNotEmpty) {
                    mines = int.parse(value);
                  }
                },
                onFieldSubmitted: (value) {
                  Navigator.of(context).pop();
                  mineSweeperBloc.add(MinesweeperGenerateEvent(
                    boardWidth: width,
                    boardHeight: height,
                    mineCount: int.parse(value),
                    initiaLunch: true,
                  ));
                },
                decoration: InputDecoration(
                    label: Text('Mines',
                        style: Theme.of(context).textTheme.bodyMedium)),
              )
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                mineSweeperBloc.add(MinesweeperGenerateEvent(
                  boardWidth: width,
                  boardHeight: height,
                  mineCount: mines,
                  initiaLunch: true,
                ));
              },
              child: const Text('Create'),
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
            _controllerCenter.play();
            _controllerCenterLeft.play();
            _controllerCenterRight.play();
            showDialog(
              context: context,
              barrierDismissible: false,
              builder: (BuildContext context) {
                return Stack(
                  alignment: Alignment.center,
                  children: [
                    DialogWidget(
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
                    ),
                    Align(
                      alignment: Alignment.topCenter,
                      child: Confetti(
                        confettiController: _controllerCenter,
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: Confetti(
                        confettiController: _controllerCenterRight,
                        blastDirection: pi,
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Confetti(
                        confettiController: _controllerCenterLeft,
                        blastDirection: 0,
                      ),
                    ),
                  ],
                );
              },
            );
          }
          if (state is MinesweeperError) {
            showDialog(
              context: context,
              barrierDismissible: false,
              builder: (BuildContext context) {
                return DialogWidget(
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
                              leading: Image.asset(
                                AppImages.flag,
                                width: 27,
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
          floatingActionButton: FloatingActionButton(
              child: Icon(Icons.dashboard_customize),
              onPressed: () => {
                    _controllerCenter.play(),
                    _controllerCenterLeft.play(),
                    _controllerCenterRight.play(),
                  }),
        ),
      ),
    );
  }
}
