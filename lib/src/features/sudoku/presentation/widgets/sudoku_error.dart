import 'package:flutter/material.dart';
import 'package:flutter_games/src/features/sudoku/presentation/bloc/sudoku_bloc.dart';

class SudokuValidationErrorWidget extends StatelessWidget {
  final SudokuBloc sudokuBloc;
  const SudokuValidationErrorWidget({
    super.key,
    required this.sudokuBloc,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        "Validation Error",
        style: Theme.of(context).textTheme.titleLarge,
        textAlign: TextAlign.center,
      ),
      content: Text(
        "Oops! It seems that some columns are missing, or the Sudoku data is incorrect. Please check the puzzle and try again.",
        style: Theme.of(context).textTheme.bodyLarge,
        textAlign: TextAlign.center,
      ),
      actionsAlignment: MainAxisAlignment.center,
      actions: [
        ElevatedButton.icon(
          onPressed: () {
            Navigator.pop(context);
            sudokuBloc.add(SudokuGenerateEvent());
          },
          icon: Icon(Icons.refresh),
          label: Text(
            "Try Again",
            style: Theme.of(context).textTheme.titleLarge,
          ),
        ),
      ],
    );
  }
}
