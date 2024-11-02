enum AppRouteEnum { sudoku, home, cardGame, errorScreen }

extension AppRouteExtension on AppRouteEnum {
  String get name {
    switch (this) {
      case AppRouteEnum.sudoku:
        return "/sudoku";
      case AppRouteEnum.home:
        return "/";
      case AppRouteEnum.cardGame:
        return "/cardGame";
      default:
        return "/error";
    }
  }
}
