import 'package:dio/dio.dart';

class ApiException {
  List<String> getExceptionMessage(DioException exception) {
    switch (exception.type) {
      case DioExceptionType.badResponse:
        return ["Bad Response", "invaild API response or server error"];
      case DioExceptionType.connectionError:
        return [
          "Connection Error",
          "Failed to connect to the server.Check your internet.",
        ];
      case DioExceptionType.connectionTimeout:
        return [
          "Connection Timeout",
          "Server took too long to respond.Try again later.",
        ];
      default:
        return [
          "Unexpected Error",
          "Something went wrong. Please check your network.",
        ];
    }
  }
}
