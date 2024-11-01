import 'package:dio/dio.dart';

String handleDioError(DioException error) {
  String errorDescription = "";

  switch (error.type) {
    case DioExceptionType.cancel:
      errorDescription = "Request to API server was cancelled";
      break;
    case DioExceptionType.connectionTimeout:
      errorDescription = "Connection timeout with API server";
      break;
    case DioExceptionType.receiveTimeout:
      errorDescription = "Receive timeout in connection with API server";
      break;
    case DioExceptionType.sendTimeout:
      errorDescription = "Send timeout in connection with API server";
      break;
    case DioExceptionType.badResponse:
      errorDescription =
          "Received invalid status code: ${error.response?.statusCode}";
      break;
    case DioExceptionType.badCertificate:
      errorDescription = "SSL certificate validation failed";
      break;
    case DioExceptionType.connectionError:
      errorDescription =
          "Failed to connect to the API server. Please check your internet connection.";
      break;
    case DioExceptionType.unknown:
      if (error.message?.contains("SocketException") ?? false) {
        errorDescription =
            "No internet connection. Please check your network and try again.";
      } else {
        errorDescription = "Unexpected error occurred. Please try again later.";
      }
      break;
  }

  return errorDescription;
}
