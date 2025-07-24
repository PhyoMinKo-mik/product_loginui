import 'dart:io';
import 'package:dio/dio.dart';
import 'package:hive/hive.dart';
import 'package:product_loginui/api_exception.dart';
import 'package:product_loginui/user_manager.dart';
import 'package:product_loginui/user_model.dart';
import 'package:talker_dio_logger/talker_dio_logger_interceptor.dart';
import 'package:talker_dio_logger/talker_dio_logger_settings.dart';
import 'product_model.dart';

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

      final Map<String, dynamic> data = response.data['data'];

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

      return {'success': true, 'data': data};
    } on DioException catch (e) {
      return {
        'success': false,
        'message': ApiException().getExceptionMessage(e).join(" - "),
      };
    } on SocketException {
      return {'success': false, 'message': 'No internet connection'};
    } catch (e) {
      return {'success': false, 'message': 'Something went wrong'};
    }
  }

  static Future<Map<String, dynamic>> fetchPersonalData(String token) async {
    try {
      final headers = {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Mobile-Request': 'Secure',
        'Authorization':
            "Bearer ${UserManager.instance.currentUser.accessToken}",
      };

      final response = await _dio.get(
        'https://hr.esoftmm.com/core/api/m/personal',
        options: Options(headers: headers),
      );

      if (response.statusCode == 200 && response.data != null) {
        return {'success': true, 'data': response.data['data']};
      } else {
        return {
          'success': false,
          'message': 'Unexpected status: ${response.statusCode}',
        };
      }
    } on DioException catch (e) {
      return {
        'success': false,
        'message': ApiException().getExceptionMessage(e).join(" - "),
      };
    } on SocketException {
      return {'success': false, 'message': 'No internet connection'};
    } catch (e) {
      return {'success': false, 'message': 'Something went wrong'};
    }
  }

  static Future<Map<String, dynamic>> userToken(
    String refreshToken,
    String accessToken,
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
        return {
          'success': true,
          'access_token': response.data['data']['access_token'],
          'refresh_token': response.data['data']['refresh_token'],
        };
      } else {
        return {
          'success': false,
          'message': 'Unexpected status: ${response.statusCode}',
        };
      }
    } on DioException catch (e) {
      return {
        'success': false,
        'message': ApiException().getExceptionMessage(e).join(" - "),
      };
    } catch (e) {
      return {'success': false, 'message': 'Something went wrong'};
    }
  }

  static Future<List<Product>> fetchProducts() async {
    try {
      // throw Exception('sww');
      final response = await _dio.get('https://fakestoreapi.com/products');

      if (response.statusCode == 200 && response.data is List) {
        return (response.data as List)
            .map((item) => Product.fromJson(item))
            .toList();
      } else {
        throw Exception('Failed to load products: ${response.statusCode}');
      }
    } on DioException catch (e) {
      throw Exception(ApiException().getExceptionMessage(e).join(" - "));
    } catch (e) {
      throw Exception('Something went wrong');
    }
  }
}
