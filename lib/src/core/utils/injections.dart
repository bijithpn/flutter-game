import 'package:flutter_games/src/core/network/dio_network.dart';
import 'package:flutter_games/src/core/utils/log/app_logger.dart';
import 'package:flutter_games/src/features/minesweeper/minesweeper_injection.dart';
import 'package:flutter_games/src/features/sudoku/sudoku_injection.dart';
import 'package:flutter_games/src/shared/app_injections.dart';
import 'package:get_it/get_it.dart';
import 'package:get_storage/get_storage.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';

final sl = GetIt.instance;

Future<void> initInjections() async {
  await initGetStorageInjections();
  await initAppInjections();
  await initHydrateBloc();
  await initDioInjections();
  await initSudokuInjections();
  await initMineSweeperInjections();
}

Future<void> initGetStorageInjections() async {
  await GetStorage.init();
  sl.registerSingleton<GetStorage>(GetStorage());
}

Future<void> initHydrateBloc() async {
  HydratedBloc.storage = await HydratedStorage.build(
    storageDirectory: await getApplicationDocumentsDirectory(),
  );
}

Future<void> initDioInjections() async {
  initRootLogger();
  DioNetwork.initDio();
}
