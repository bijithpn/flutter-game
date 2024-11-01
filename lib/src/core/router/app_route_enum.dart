enum AppRouteEnum { sudoku, cardGame, errorScreen }

extension AppRouteExtension on AppRouteEnum {
  String get name {
    switch (this) {
      case AppRouteEnum.sudoku:
        return "/sudoku";
      case AppRouteEnum.cardGame:
        return "/cardGame";
      default:
        return "/error";
    }
  }
}
