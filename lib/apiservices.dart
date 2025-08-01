// import 'dart:io';
// import 'package:dio/dio.dart';
// import 'package:hive/hive.dart';
// import 'package:product_loginui/api_exception.dart';
// import 'package:product_loginui/user_manager.dart';
// import 'package:product_loginui/user_model.dart';
// import 'product_model.dart';
// import 'package:talker_dio_logger/talker_dio_logger_interceptor.dart';
// import 'package:talker_dio_logger/talker_dio_logger_settings.dart';

// class Apiservice {
//   static final Dio _dio = Dio()
//     ..interceptors.add(
//       TalkerDioLogger(
//         settings: TalkerDioLoggerSettings(
//           printRequestData: true,
//           printResponseData: true,
//           printErrorMessage: true,
//         ),
//       ),
//     );

//   static Future<Map<String, dynamic>> userLogin(
//     String username,
//     String password,
//   ) async {
//     try {
//       final headers = {
//         'Content-Type': 'application/json',
//         'Mobile-Request': 'Secure',
//       };

//       final response = await _dio.post(
//         'https://hr.esoftmm.com/core/api/auth/access-token',
//         data: {'username': username, 'password': password, 'device': 'android'},
//         options: Options(headers: headers),
//       );

//       final Map<String, dynamic> data = response.data['data'];

//       final user = UserModel(
//         accessToken: data['access_token'],
//         refreshToken: data['refresh_token'],
//         id: data['user']['id'],
//         userName: data['user']['userName'],
//         phoneNumber: data['user']['phoneNumber'],
//         email: data['user']['email'],
//       );

//       final box = Hive.box<UserModel>('userBox');
//       await box.put('currentUser', user);

//       return {'success': true, 'data': data};
//     } on DioException catch (e) {
//       return {
//         'success': false,
//         'message': ApiException().getExceptionMessage(e).join(" - "),
//       };
//     } on SocketException {
//       return {'success': false, 'message': 'No internet connection'};
//     } catch (e) {
//       return {'success': false, 'message': 'Something went wrong'};
//     }
//   }

//   static Future<Map<String, dynamic>> fetchPersonalData(String token) async {
//     try {
//       final headers = {
//         'Content-Type': 'application/json',
//         'Accept': 'application/json',
//         'Mobile-Request': 'Secure',
//         'Authorization': "Bearer $token",
//       };

//       final response = await _dio.get(
//         'https://hr.esoftmm.com/core/api/m/personal',
//         options: Options(headers: headers),
//       );

//       if (response.statusCode == 200 && response.data != null) {
//         return {'success': true, 'data': response.data['data']};
//       } else {
//         return {
//           'success': false,
//           'message': 'Unexpected status: ${response.statusCode}',
//         };
//       }
//     } on DioException catch (e) {
//       return {
//         'success': false,
//         'message': ApiException().getExceptionMessage(e).join(" - "),
//       };
//     } on SocketException {
//       return {'success': false, 'message': 'No internet connection'};
//     } catch (e) {
//       return {'success': false, 'message': 'Something went wrong'};
//     }
//   }

//   static Future<Map<String, dynamic>> userToken(
//     String refreshToken,
//     String accessToken,
//   ) async {
//     try {
//       final headers = {
//         'Content-Type': 'application/json',
//         'Mobile-Request': 'Secure',
//       };

//       final response = await _dio.post(
//         'https://hr.esoftmm.com/core/api/auth/refresh-token',
//         data: {
//           'access_token': accessToken,
//           'refresh_token': refreshToken,
//           'device': 'android',
//         },
//         options: Options(headers: headers),
//       );

//       if (response.statusCode == 200) {
//         return {
//           'success': true,
//           'access_token': response.data['data']['access_token'],
//           'refresh_token': response.data['data']['refresh_token'],
//         };
//       } else {
//         return {
//           'success': false,
//           'message': 'Unexpected status: ${response.statusCode}',
//         };
//       }
//     } on DioException catch (e) {
//       return {
//         'success': false,
//         'message': ApiException().getExceptionMessage(e).join(" - "),
//       };
//     } catch (e) {
//       return {'success': false, 'message': 'Something went wrong'};
//     }
//   }

//   static Future<List<Product>> fetchProducts() async {
//     try {
//       final response = await _dio.get('https://fakestoreapi.com/products');

//       if (response.statusCode == 200 && response.data is List) {
//         return (response.data as List)
//             .map((item) => Product.fromJson(item))
//             .toList();
//       } else {
//         throw Exception('Failed to load products: ${response.statusCode}');
//       }
//     } on DioException catch (e) {
//       throw Exception(ApiException().getExceptionMessage(e).join(" - "));
//     } catch (e) {
//       throw Exception('Something went wrong');
//     }
//   }
// }
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:hive/hive.dart';
import 'package:product_loginui/api_exception.dart';
import 'package:product_loginui/user_model.dart';
import 'package:product_loginui/product_model.dart';
import 'package:product_loginui/user_data_model/personal_data.dart';
import 'package:product_loginui/user_manager.dart';
import 'package:talker_dio_logger/talker_dio_logger_interceptor.dart';
import 'package:talker_dio_logger/talker_dio_logger_settings.dart';

class ApiResponse<T> {
  final String? errorMessage;
  final T? data;
  ApiResponse({required this.errorMessage, required this.data});
}

class ApiService {
  static final Dio _dio = Dio()
    ..interceptors.add(
      TalkerDioLogger(
        settings: TalkerDioLoggerSettings(
          printRequestData: true,
          printResponseData: true,
          printErrorMessage: true,
        ),
      ),
    );

  //helper
  static bool _isConnectionError(DioException e) =>
      e.type == DioExceptionType.connectionError ||
      e.type == DioExceptionType.sendTimeout ||
      e.type == DioExceptionType.receiveTimeout ||
      e.error is SocketException;

  //userlogin
  static Future<ApiResponse<UserModel>> userLogin(
    String username,
    String password,
  ) async {
    try {
      final headers = {
        'Content-Type': 'application/json',
        'Mobile-Request': 'Secure',
      };
      final response = await _dio.post(
        'https://hr.esoftmm.com/core/api/auth/access-token',
        data: {'username': username, 'password': password, 'device': 'android'},
        options: Options(headers: headers),
      );

      final data = response.data['data'];
      final user = UserModel(
        accessToken: data['access_token'],
        refreshToken: data['refresh_token'],
        id: data['user']['id'],
        userName: data['user']['userName'],
        phoneNumber: data['user']['phoneNumber'],
        email: data['user']['email'],
      );

      final box = Hive.box<UserModel>('userBox');
      await box.put('currentUser', user);

      return ApiResponse(errorMessage: null, data: user);
    } on DioException catch (e) {
      if (_isConnectionError(e)) {
        return ApiResponse(errorMessage: 'No internet connection', data: null);
      }
      return ApiResponse(
        errorMessage: ApiException().getExceptionMessage(e).join(' - '),
        data: null,
      );
    } catch (_) {
      return ApiResponse(errorMessage: 'Something went wrong', data: null);
    }
  }

  //refrshtoken
  static Future<ApiResponse<Map<String, String>>> refreshToken(
    String accessToken,
    String refreshToken,
  ) async {
    try {
      final headers = {
        'Content-Type': 'application/json',
        'Mobile-Request': 'Secure',
      };
      final response = await _dio.post(
        'https://hr.esoftmm.com/core/api/auth/refresh-token',
        data: {
          'access_token': accessToken,
          'refresh_token': refreshToken,
          'device': 'android',
        },
        options: Options(headers: headers),
      );

      if (response.statusCode == 200) {
        final data = response.data['data'];
        return ApiResponse(
          errorMessage: null,
          data: {
            'access_token': data['access_token'],
            'refresh_token': data['refresh_token'],
          },
        );
      } else {
        return ApiResponse(
          errorMessage: 'Unexpected status: ${response.statusCode}',
          data: null,
        );
      }
    } on DioException catch (e) {
      if (_isConnectionError(e)) {
        return ApiResponse(errorMessage: 'No internet connection', data: null);
      }
      return ApiResponse(
        errorMessage: ApiException().getExceptionMessage(e).join(' - '),
        data: null,
      );
    } catch (_) {
      return ApiResponse(errorMessage: 'Something went wrong', data: null);
    }
  }

  //fetchpersonaldata
  static Future<ApiResponse<PersonalData>> fetchPersonalData(
    String token,
  ) async {
    try {
      final headers = {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Mobile-Request': 'Secure',
        'Authorization': "Bearer $token",
      };
      final response = await _dio.get(
        'https://hr.esoftmm.com/core/api/m/personal',
        options: Options(headers: headers),
      );

      if (response.statusCode == 200 && response.data != null) {
        final personalData = PersonalData.fromJson(response.data['data']);
        return ApiResponse(errorMessage: null, data: personalData);
      } else {
        return ApiResponse(
          errorMessage: 'Unexpected status: ${response.statusCode}',
          data: null,
        );
      }
    } on DioException catch (e) {
      if (_isConnectionError(e)) {
        return ApiResponse(errorMessage: 'No internet connection', data: null);
      }
      return ApiResponse(
        errorMessage: ApiException().getExceptionMessage(e).join(' - '),
        data: null,
      );
    } catch (_) {
      return ApiResponse(errorMessage: 'Something went wrong', data: null);
    }
  }

  //fetchpproduct
  static Future<ApiResponse<List<Product>>> fetchProducts() async {
    try {
      final response = await _dio.get('https://fakestoreapi.com/products');

      if (response.statusCode == 200 && response.data is List) {
        final products = (response.data as List)
            .map((item) => Product.fromJson(item))
            .toList();
        return ApiResponse(errorMessage: null, data: products);
      } else {
        return ApiResponse(errorMessage: 'Failed to load products', data: null);
      }
    } on DioException catch (e) {
      if (_isConnectionError(e)) {
        return ApiResponse(errorMessage: 'No internet connection', data: null);
      }
      return ApiResponse(
        errorMessage: ApiException().getExceptionMessage(e).join(' - '),
        data: null,
      );
    } catch (_) {
      return ApiResponse(errorMessage: 'Something went wrong', data: null);
    }
  }
}
