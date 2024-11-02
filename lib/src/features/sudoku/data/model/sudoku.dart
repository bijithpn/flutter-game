class Sudoku {
  List<List<int>> grid;
  List<List<int>> task;
  List<List<bool>> isEditable;

  Sudoku({
    required this.grid,
    required this.task,
    required this.isEditable,
  });

  factory Sudoku.fromJson(Map<String, dynamic> json) {
    List<List<int>> task = List<List<int>>.from(
        json["task"].map((x) => List<int>.from(x.map((x) => x))));
    return Sudoku(
      grid: List<List<int>>.from(
          json["grid"].map((x) => List<int>.from(x.map((x) => x)))),
      task: task,
      isEditable:
          List.generate(9, (i) => List.generate(9, (j) => task[i][j] == 0)),
    );
  }

  Map<String, dynamic> toJson() => {
        "grid": grid.map((row) => row.toList()).toList(),
        "task": task.map((row) => row.toList()).toList(),
        "isEditable": isEditable.map((row) => row.toList()).toList(),
      };
}
