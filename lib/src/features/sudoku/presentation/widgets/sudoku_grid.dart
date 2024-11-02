import 'package:flutter/material.dart';
import 'package:flutter_games/src/core/helper/sudoku_helper.dart';

import 'package:flutter_games/src/features/sudoku/presentation/bloc/sudoku_bloc.dart';
import 'package:provider/provider.dart';

import 'sudoku_cell.dart';

class SudokuGrid extends StatelessWidget {
  final SudokuGenerated sudokuState;
  final List<List<TextEditingController>> controllers;

  const SudokuGrid({
    super.key,
    required this.sudokuState,
    required this.controllers,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
      child: AspectRatio(
        aspectRatio: 1,
        child: sudokuState.sudoku == null
            ? Center(
                child: Text(
                  "Oops! Something went wrong",
                  style: Theme.of(context).textTheme.titleLarge!.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
              )
            : Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  border: Border.all(width: 5, color: Colors.grey.shade400),
                ),
                child: GridView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 9,
                    childAspectRatio: .91,
                  ),
                  itemCount: 81,
                  itemBuilder: (context, index) {
                    int row = index ~/ 9;
                    int col = index % 9;
                    return SudokuCell(
                      key: ValueKey(index),
                      updateCallback: () {
                        context.read<SudokuBloc>().add(SudokuUpdateEvent(
                            SudokuHelper.getCurrentMatrixValues(controllers)));
                      },
                      index: index,
                      controller: controllers[row][col],
                      isPreFilled:
                          sudokuState.sudoku?.isEditable[row][col] ?? false,
                    );
                  },
                ),
              ),
      ),
    );
  }
}
