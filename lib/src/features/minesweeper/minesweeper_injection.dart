import 'package:flutter_games/src/core/network/dio_network.dart';
import 'package:flutter_games/src/core/utils/injections.dart';
import 'package:flutter_games/src/features/minesweeper/data/repository/minesweeper_repository.dart';

initMineSweeperInjections() {
  sl.registerSingleton<MineSweeperRepository>(
      MineSweeperRepository(DioNetwork.appAPI));
}
