import 'package:flutter_games/src/core/network/dio_network.dart';
import 'package:flutter_games/src/core/utils/injections.dart';
import 'package:flutter_games/src/features/sudoku/data/repository/sudoku_repository.dart';

initSudokuInjections() {
  sl.registerSingleton<SudokuRepository>(SudokuRepository(DioNetwork.appAPI));
}
