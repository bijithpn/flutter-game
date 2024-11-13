import 'dart:convert';

enum CellState { hidden, revealed, flagged }

MineData mineDataFromJson(String str) => MineData.fromJson(json.decode(str));

String mineDataToJson(MineData data) => json.encode(data.toJson());

class MineData {
  MineData({
    required this.start,
    required this.width,
    required this.height,
    required this.board,
    required this.mines,
  });

  factory MineData.fromJson(Map<String, dynamic> json) {
    var boardJson = json["board"] as List<dynamic>;
    List<List<Cell>> board = boardJson.map((row) {
      return (row as List<dynamic>).map((cell) {
        return Cell.fromString(cell as String);
      }).toList();
    }).toList();

    return MineData(
      start: json["start"],
      width: json["width"],
      height: json["height"],
      board: board,
      mines: json["mines"],
    );
  }

  List<List<Cell>> board;
  int height;
  int mines;
  String start;
  int width;

  Map<String, dynamic> toJson() => {
        "start": start,
        "width": width,
        "height": height,
        "board": List<dynamic>.from(board.map(
            (row) => List<dynamic>.from(row.map((cell) => cell.toString())))),
        "mines": mines,
      };

  MineData copyWith({List<List<Cell>>? board}) {
    return MineData(
      start: start,
      board: board ?? this.board,
      width: width,
      height: height,
      mines: mines,
    );
  }
}

class Cell {
  Cell({
    this.hasMine = false,
    this.adjacentMines = 0,
    this.cellState = CellState.hidden,
  });

  factory Cell.fromString(String value) {
    bool hasMine = value == 'x';
    int adjacentMines = value == 'x' ? 0 : int.tryParse(value) ?? 0;
    return Cell(
      hasMine: hasMine,
      adjacentMines: adjacentMines,
      cellState: CellState.hidden,
    );
  }

  int adjacentMines;
  CellState cellState;
  bool hasMine;

  @override
  String toString() {
    if (hasMine) {
      return 'x';
    }
    return adjacentMines == 0 ? 'o' : adjacentMines.toString();
  } // Add the copyWith method

  Cell copyWith({
    bool? hasMine,
    int? adjacentMines,
    CellState? cellState,
  }) {
    return Cell(
      adjacentMines: adjacentMines ?? this.adjacentMines,
      hasMine: hasMine ?? this.hasMine,
      cellState: cellState ?? this.cellState,
    );
  }
}
