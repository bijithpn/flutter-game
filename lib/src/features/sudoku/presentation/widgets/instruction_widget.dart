import 'package:flutter/material.dart';

class InstructionWidget extends StatelessWidget {
  const InstructionWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: 16,
        ),
        Text(
          'Sudoku Instructions',
          style: Theme.of(context).textTheme.titleLarge!.copyWith(
                fontWeight: FontWeight.bold,
              ),
        ),
        const SizedBox(height: 16),
        Text(
            'Sudoku is a puzzle game based on logic. The objective is to fill a 9x9 grid so that each column, row, and 3x3 subgrid contains all numbers from 1 to 9.',
            style: Theme.of(context).textTheme.bodyLarge),
        const SizedBox(height: 16),
        Text(
          'Basic Rules',
          style: Theme.of(context)
              .textTheme
              .titleMedium!
              .copyWith(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        ListTile(
          leading: const Icon(Icons.looks_one),
          title: Text(
              'Rule 1: Every row must contain numbers from 1 to 9 without any repetition.',
              style: Theme.of(context).textTheme.bodyMedium),
        ),
        ListTile(
          leading: const Icon(Icons.looks_two),
          title: Text(
              'Rule 2: Every column must contain numbers from 1 to 9 without any repetition.',
              style: Theme.of(context).textTheme.bodyMedium),
        ),
        ListTile(
          leading: const Icon(Icons.looks_3),
          title: Text(
              'Rule 3: Each of the 3x3 subgrids must contain numbers from 1 to 9 without any repetition.',
              style: Theme.of(context).textTheme.bodyMedium),
        ),
        const SizedBox(height: 16),
        Text('Tips for Solving Sudoku',
            style: Theme.of(context)
                .textTheme
                .titleMedium!
                .copyWith(fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        ListTile(
          leading: const Icon(Icons.lightbulb_outline),
          title: Text(
              'Start with easy numbers: Look for rows, columns, or subgrids where only one or two numbers are missing.',
              style: Theme.of(context).textTheme.bodyMedium),
        ),
        ListTile(
          leading: const Icon(Icons.lightbulb_outline),
          title: Text(
              'Use pencil marks: Lightly note down possible numbers in each cell to help narrow down choices.',
              style: Theme.of(context).textTheme.bodyMedium),
        ),
        ListTile(
          leading: const Icon(Icons.lightbulb_outline),
          title: Text(
              'Use process of elimination: If a number can only fit in one cell within a row, column, or subgrid, place it there.',
              style: Theme.of(context).textTheme.bodyMedium),
        ),
        ListTile(
          leading: const Icon(Icons.lightbulb_outline),
          title: Text(
              'Look for patterns: Certain numbers might form a pattern that makes it easier to deduce others.',
              style: Theme.of(context).textTheme.bodyMedium),
        ),
        const SizedBox(height: 16),
        Text(
            'Remember, Sudoku is a game of patience and logic. Keep practicing, and you’ll get better over time!',
            style: Theme.of(context)
                .textTheme
                .bodyMedium!
                .copyWith(fontStyle: FontStyle.italic)),
      ],
    );
  }
}
