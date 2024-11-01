import 'package:flutter_games/src/core/network/dio_network.dart';
import 'package:flutter_games/src/core/utils/log/app_logger.dart';
import 'package:flutter_games/src/features/sudoku/sudoku_injection.dart';
import 'package:flutter_games/src/shared/app_injections.dart';
import 'package:get_it/get_it.dart';
import 'package:get_storage/get_storage.dart';

final sl = GetIt.instance;

Future<void> initInjections() async {
  initGetStorageInjections();
  await initAppInjections();
  await initDioInjections();
  await initSudokuInjections();
}

void initGetStorageInjections() {
  GetStorage.init();
  sl.registerSingleton<GetStorage>(GetStorage());
}

Future<void> initDioInjections() async {
  initRootLogger();
  DioNetwork.initDio();
}
