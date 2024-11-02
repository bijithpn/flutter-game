import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_games/src/core/helper/sudoku_helper.dart';
import 'package:flutter_games/src/core/utils/injections.dart';
import 'package:flutter_games/src/features/sudoku/data/repository/sudoku_repository.dart';
import 'package:flutter_games/src/features/sudoku/presentation/bloc/sudoku_bloc.dart';
import 'package:flutter_games/src/features/sudoku/presentation/widgets/widgets.dart';

class SudokuView extends StatefulWidget {
  const SudokuView({super.key});

  @override
  State<SudokuView> createState() => _SudokuViewState();
}

class _SudokuViewState extends State<SudokuView> {
  final List<List<TextEditingController>> controllers = List.generate(
    9,
    (_) => List.generate(9, (_) => TextEditingController()),
  );
  late SudokuBloc sudokuBloc;
  @override
  void initState() {
    sudokuBloc = SudokuBloc(sl<SudokuRepository>())..add(SudokuGenerateEvent());
    super.initState();
  }

  @override
  void dispose() {
    for (var row in controllers) {
      for (var controller in row) {
        controller.dispose();
      }
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sudokuBloc,
      child: BlocListener<SudokuBloc, SudokuState>(
        listener: (context, state) {
          if (state is SudokuCompleted) {
            showDialog(
              context: context,
              barrierDismissible: false,
              builder: (BuildContext context) {
                return SudokuDialogWidget(
                  onTap: () {
                    Navigator.pop(context);
                    sudokuBloc.add(SudokuGenerateEvent());
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
          if (state is SudokuError) {
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
                    sudokuBloc.add(SudokuGenerateEvent());
                  },
                  buttonTitle: "Try again",
                );
              },
            );
          }
          if (state is SudokuValidationError) {
            showDialog(
              context: context,
              barrierDismissible: true,
              builder: (BuildContext context) {
                return SudokuDialogWidget(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    buttonIcon: state.buttonIcon,
                    title: state.title,
                    message: state.message,
                    buttonTitle: state.buttonTitle);
              },
            );
          }
        },
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: SudokuAppBar(controllers: controllers),
          body: BlocBuilder<SudokuBloc, SudokuState>(
            builder: (context, state) {
              if (state is SudokuGenerated) {
                if (state.sudoku != null) {
                  SudokuHelper.initializeSudokuGrid(
                      state.sudoku!.task, controllers);
                }
                return SingleChildScrollView(
                  padding:
                      const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                  child: Column(
                    children: [
                      SudokuGrid(
                        controllers: controllers,
                        sudokuState: state,
                      ),
                      InstructionWidget()
                    ],
                  ),
                );
              }
              return Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                child: InstructionWidget(),
              );
            },
          ),
        ),
      ),
    );
  }
}
