import 'package:flutter_games/src/core/utils/constants/storage_constants.dart';
import 'package:get_storage/get_storage.dart';

class AppSharedPrefs {
  final GetStorage _preferences;

  AppSharedPrefs(this._preferences);

  /// __________ Dark Theme __________ ///
  bool getIsDarkTheme() {
    return _preferences.read(StorageConstants.theme) ?? false;
  }

  void setDarkTheme(bool isDark) {
    _preferences.write(StorageConstants.theme, isDark);
  }
}
