import 'package:flutter/material.dart';
import 'package:flutter_games/src/features/sudoku/presentation/bloc/sudoku_bloc.dart';

class SudokuCompleteWidget extends StatelessWidget {
  final SudokuBloc sudokuBloc;
  const SudokuCompleteWidget({
    super.key,
    required this.sudokuBloc,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        "Congratulations!",
        style: Theme.of(context).textTheme.titleLarge,
        textAlign: TextAlign.center,
      ),
      content: Text(
        "Well done! You've successfully completed the Sudoku puzzle. Every cell is correctly filled.",
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
            "Play Again",
            style: Theme.of(context).textTheme.titleLarge,
          ),
        )
      ],
    );
  }
}
