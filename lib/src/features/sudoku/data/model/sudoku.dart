class Sudoku {
  List<List<int>> grid;
  List<List<int>> task;

  Sudoku({
    required this.grid,
    required this.task,
  });

  factory Sudoku.fromJson(Map<String, dynamic> json) => Sudoku(
        grid: List<List<int>>.from(
            json["grid"].map((x) => List<int>.from(x.map((x) => x)))),
        task: List<List<int>>.from(
            json["task"].map((x) => List<int>.from(x.map((x) => x)))),
      );

  Map<String, dynamic> toJson() => {
        "grid": List<dynamic>.from(
            grid.map((x) => List<dynamic>.from(x.map((x) => x)))),
        "task": List<dynamic>.from(
            task.map((x) => List<dynamic>.from(x.map((x) => x)))),
      };
}
