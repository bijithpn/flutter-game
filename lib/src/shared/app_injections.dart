import 'package:flutter_games/src/core/utils/injections.dart';
import 'package:flutter_games/src/shared/data/data_sources/app_shared_pref.dart';

initAppInjections() {
  sl.registerFactory<AppSharedPrefs>(() => AppSharedPrefs(sl()));
}
