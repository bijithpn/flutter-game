import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_games/src/core/helper/sudoku_helper.dart';
import 'package:flutter_games/src/features/sudoku/presentation/bloc/sudoku_bloc.dart';

class SudokuAppBar extends StatelessWidget implements PreferredSizeWidget {
  final List<List<TextEditingController>> controllers;

  const SudokuAppBar({super.key, required this.controllers});

  @override
  Widget build(BuildContext context) {
    final sudokuBloc = BlocProvider.of<SudokuBloc>(context);
    return AppBar(
      title: Text(
        'Sudoku',
        style: Theme.of(context)
            .textTheme
            .titleLarge!
            .copyWith(fontWeight: FontWeight.bold),
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.restart_alt),
          onPressed: () {
            sudokuBloc.add(SudokuResetEvent());
          },
        ),
        IconButton(
            icon: const Icon(Icons.check),
            onPressed: () {
              FocusScope.of(context).unfocus();
              bool isComplete = true;
              for (var row in controllers) {
                for (var controller in row) {
                  if (controller.text.isEmpty || controller.text == '0') {
                    isComplete = false;
                    break;
                  }
                }
                if (!isComplete) break;
              }
              if (isComplete) {
                var sudokuData = SudokuHelper.formatSudokuOutput(controllers);
                sudokuBloc.add(SudokuVerifyEvent(sudokuData));
              } else {
                sudokuBloc.add(SudokuValidateEvent());
              }
            }),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(50);
}
