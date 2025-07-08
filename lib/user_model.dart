import 'package:flutter/foundation.dart';

class UserModel {
  final String accessToken;
  final String refreshToken;
  final String id;
  final String userName;
  final String phoneNumber;
  final String email;

  UserModel({
    required this.accessToken,
    required this.refreshToken,
    required this.id,
    required this.userName,
    required this.phoneNumber,
    required this.email,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      userName: json['userName'],
      email: json['email'],
      phoneNumber: json['phoneNumber'],
      accessToken: json['access_token'],
      refreshToken: json['refresh_token'],
    );
  }
}
