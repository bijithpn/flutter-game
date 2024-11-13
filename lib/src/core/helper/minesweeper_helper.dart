import 'package:flutter_games/src/features/minesweeper/data/model/minesweeper_model.dart';

class MinesweeperHelper {
  static int getFlagCount(
    int cellSize,
    List<List<Cell>> board,
  ) {
    int flagCount = 0;
    for (int row = 0; row < cellSize; row++) {
      for (int col = 0; col < cellSize; col++) {
        if (board[row][col].cellState == CellState.flagged) {
          flagCount++;
        }
      }
    }
    return flagCount;
  }

  static List<List<Cell>> revealMines(
    int cellSize,
    List<List<Cell>> board,
  ) {
    List<List<Cell>> newBoard = board;
    for (int row = 0; row < cellSize; row++) {
      for (int col = 0; col < cellSize; col++) {
        if (newBoard[row][col].hasMine &&
            newBoard[row][col].cellState == CellState.hidden) {
          newBoard[row][col].cellState = CellState.revealed;
        }
      }
    }
    return newBoard;
  }

  static List<List<Cell>> getAdjacentValues(
      List<List<Cell>> board, int row, int col) {
    List<List<Cell>> newBoard = board;
    List<List<int>> directions = [
      [-1, 0], // Top
      [1, 0], // Bottom
      [0, -1], // Left
      [0, 1], // Right
      [-1, -1], // Top-Left (diagonal)
      [-1, 1], // Top-Right (diagonal)
      [1, -1], // Bottom-Left (diagonal)
      [1, 1], // Bottom-Right (diagonal)
    ];
    for (var direction in directions) {
      int newRow = row + direction[0];
      int newCol = col + direction[1];
      if (newRow >= 0 &&
          newRow < newBoard.length &&
          newCol >= 0 &&
          newCol < newBoard.first.length) {
        if (newBoard[newRow][newCol].cellState == CellState.hidden &&
            newBoard[newRow][newCol].adjacentMines >= 0 &&
            !newBoard[newRow][newCol].hasMine) {
          newBoard[newRow][newCol].cellState = CellState.revealed;
          if (newBoard[newRow][newCol].adjacentMines == 0) {
            getAdjacentValues(newBoard, newRow, newCol);
          }
        }
      }
    }
    return newBoard;
  }

  static bool isGameWon({
    required List<List<Cell>> board,
    required int mineCount,
    required int cellSize,
  }) {
    int totalCell = (cellSize * cellSize) - mineCount;
    int cellCount = 0;
    for (int row = 0; row < cellSize; row++) {
      for (int col = 0; col < cellSize; col++) {
        if (!board[row][col].hasMine &&
                board[row][col].cellState == CellState.revealed ||
            board[row][col].cellState == CellState.flagged) {
          cellCount++;
        }
      }
    }
    return cellCount == totalCell;
  }
}
