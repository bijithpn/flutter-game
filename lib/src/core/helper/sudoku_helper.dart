// sudoku_helper.dart
import 'package:flutter/material.dart';

class SudokuHelper {
  static String formatSudokuOutput(
      List<List<TextEditingController>> controllers) {
    List<String> rows = [];
    for (int row = 0; row < 9; row++) {
      String rowValues = '';
      for (int col = 0; col < 9; col++) {
        String text = controllers[row][col].text;
        rowValues += text.isNotEmpty ? text : '0';
      }
      rows.add(rowValues);
    }
    return rows.join('-');
  }

  static void initializeSudokuGrid(
      List<List<int>> matrix, List<List<TextEditingController>> controllers) {
    for (int row = 0; row < 9; row++) {
      for (int col = 0; col < 9; col++) {
        controllers[row][col].text =
            matrix[row][col] > 0 ? matrix[row][col].toString() : "";
      }
    }
  }

  static List<List<int>> getCurrentMatrixValues(
      List<List<TextEditingController>> controllers) {
    List<List<int>> currentMatrix = List.generate(9, (_) => List.filled(9, 0));
    for (int row = 0; row < 9; row++) {
      for (int col = 0; col < 9; col++) {
        String text = controllers[row][col].text;
        currentMatrix[row][col] = text.isNotEmpty ? int.parse(text) : 0;
      }
    }
    return currentMatrix;
  }
}
