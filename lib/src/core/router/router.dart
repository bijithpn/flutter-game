import 'package:flutter/material.dart';

import '../../features/features.dart';

class AppRouter {
  static String currentRoute = "/";

  static Route<dynamic> generateRoute(RouteSettings settings) {
    currentRoute = settings.name ?? "/";
    switch (settings.name) {
      case '/sudoku':
        return MaterialPageRoute(
          settings: RouteSettings(name: settings.name),
          builder: (_) => const SudokuView(),
        );

      case '/cardGame':
        return MaterialPageRoute(
          settings: RouteSettings(name: settings.name),
          builder: (_) {
            assert(
                settings.arguments != null, "nyTimesArticleModel is required");
            return SizedBox();
          },
        );

      default:
        return MaterialPageRoute(
          settings: RouteSettings(name: settings.name),
          builder: (_) =>
              ErrorView(errorMessage: 'No route defined for ${settings.name}'),
        );
    }
  }
}
