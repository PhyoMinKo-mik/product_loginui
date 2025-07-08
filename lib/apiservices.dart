// import 'dart:convert';

// import 'package:dio/dio.dart';
// import 'package:talker_dio_logger/talker_dio_logger.dart';

// class Apiservice {
//   static final Dio _dio = Dio()
//     ..interceptors.add(
//       TalkerDioLogger(
//         settings: TalkerDioLoggerSettings(
//           printErrorData: true,
//           printErrorHeaders: true,
//           printRequestData: true,
//           printErrorMessage: true,
//         ),
//       ),
//     );

//   static Future userLogin(String email, String password) async {
//     var headers = {
//       'Content-Type': 'application/json',
//       'Mobile-Request': 'Secure',
//     };
//     final data = {"username": email, "password": password, 'device': 'android'};
//     try {
//       var response = await _dio.post(
//         'https://hr.esoftmm.com/core/api/auth/access-token',
//         data: jsonEncode(data),

//         options: Options(headers: headers),
//       );

//       print('Login Success: ${response.data}');
//       return {'success': true, 'data': response.data};
//     } catch (e) {
//       print('Login Success: $e');

//       if (e is DioException) {
//         final statuscode = e.response?.statusCode;
//         if (statuscode == 200 || statuscode == 201) {
//           final response = e.response!.data;
//           return response;
//           // success
//         } else {
//           // final errormessage = e.response?.errormessage;
//           return {
//             'success': false,
//             'data': null,
//             'error': e.toString(),

//             //fail
//           };
//         }
//       }
//       return false;
//     }
//   }
// }

import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:talker_dio_logger/talker_dio_logger.dart';

class Apiservice {
  static final Dio _dio = Dio()
    ..interceptors.add(
      TalkerDioLogger(
        settings: TalkerDioLoggerSettings(
          printErrorData: true,
          printErrorHeaders: true,
          printRequestData: true,
          printErrorMessage: true,
        ),
      ),
    );

  static Future<Map<String, dynamic>> userLogin(
    String email,
    String password,
  ) async {
    var headers = {
      'Content-Type': 'application/json',
      'Mobile-Request': 'Secure',
    };

    final data = {"username": email, "password": password, "device": "android"};

    try {
      var response = await _dio.post(
        'https://hr.esoftmm.com/core/api/auth/access-token',
        data: jsonEncode(data),
        options: Options(headers: headers),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        return {'success': true, 'data': response.data};
      } else {
        return {
          'success': false,
          'message': 'Unexpected status: ${response.statusCode}',
          'error': response.data?.toString() ?? 'No response data',
        };
      }
    } on DioException catch (e) {
      final statusCode = e.response?.statusCode ?? 0;
      final errorData =
          e.response?.data?.toString() ?? e.message ?? 'Unknown Dio error';
      final path = e.requestOptions.path;

      final detailedError =
          '''
Status: $statusCode
Message: $errorData
Path: $path
This exception was thrown because the response has a status code of $statusCode.
Read more: https://developer.mozilla.org/en-US/docs/Web/HTTP/Status
''';

      return {
        'success': false,
        'message': 'Login failed',
        'error': detailedError,
      };
    } catch (e) {
      return {
        'success': false,
        'message': 'Unexpected error occurred',
        'error': e.toString(),
      };
    }
  }
}

// import 'package:dio/dio.dart';

// class Apiservice {
//   static Future<Map<String, dynamic>> userLogin(
//     String email,
//     String password,
//   ) async {
//     try {
//       var response = await Dio().post(
//         'https://api.com/login',
//         data: {'email': email, 'password': password},
//       );
//       return {'success': true, 'data': response.data};
//     } on DioException catch (dioError) {
//       // Special error handling for Dio
//       String detailedError = '';
//       if (dioError.response != null) {
//         detailedError =
//             'Status: ${dioError.response?.statusCode}\n'
//             'Message: ${dioError.response?.data}\n'
//             'Path: ${dioError.requestOptions.path}';
//       } else {
//         detailedError = dioError.message ?? 'Unknown Dio error';
//       }

//       return {
//         'success': false,
//         'message': 'Login failed',
//         'error': detailedError,
//       };
//     } catch (e) {
//       return {
//         'success': false,
//         'message': 'Unexpected error occurred',
//         'error': e.toString(),
//       };
//     }
//   }
// }
