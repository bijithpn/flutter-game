import 'package:flutter_games/src/core/utils/injections.dart';
import 'package:flutter_games/src/shared/data/data_sources/app_shared_pref.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../utils/constants/app_constants.dart';

class Helper {
  /// Get svg picture path
  static String getSvgPath(String name) {
    return "$svgPath$name";
  }

  /// Get image picture path
  static String getImagePath(String name) {
    return "$imagePath$name";
  }

  /// Get vertical space
  static double getVerticalSpace() {
    return 10.h;
  }

  /// Get horizontal space
  static double getHorizontalSpace() {
    return 10.w;
  }

  /// Get Dio Header
  static Map<String, dynamic> getHeaders() {
    return {}..removeWhere((key, value) => value == null);
  }

  static bool isDarkTheme() {
    return sl<AppSharedPrefs>().getIsDarkTheme();
  }
}
