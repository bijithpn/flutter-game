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
      title: const Text('Sudoku'),
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
            var sudokuData = SudokuHelper.formatSudokuOutput(controllers);
            sudokuBloc.add(SudokuVerifyEvent(sudokuData));
          },
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(50);
}
