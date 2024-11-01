class APIConfig {
  static String baseUrl(String baseUrl) {
    return '$baseUrl/api/';
  }
}

class APIEndpoint {
  static const String sudokuGenerator = 'sudoku/generator';
  static const String sudokuVerifier = 'sudoku/verifier';
}
