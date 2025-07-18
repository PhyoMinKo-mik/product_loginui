import 'package:dio/dio.dart';

class ApiException {
  List<String> getExceptionMessage(DioException exception) {
    String title = "Error";
    String description = "Something went wrong";

    try {
      if (exception.response != null &&
          exception.response?.data is Map<String, dynamic>) {
        final data = exception.response?.data as Map<String, dynamic>;
        if (data.containsKey('message')) {
          description = data['message'].toString();
        } else {
          description = exception.message ?? description;
        }
      } else {
        description = exception.message ?? description;
      }
    } catch (_) {
      description = "Something went wrong";
    }

    return [title, description];
  }
}
