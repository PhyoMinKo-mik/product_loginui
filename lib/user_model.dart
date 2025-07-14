// import 'package:flutter/foundation.dart';
// import 'package:json_annotation/json_annotation.dart';

// class UserModel {
//   final String accessToken;
//   final String refreshToken;
//   final String id;
//   final String userName;
//   final String phoneNumber;
//   final String email;

//   UserModel({
//     required this.accessToken,
//     required this.refreshToken,
//     required this.id,
//     required this.userName,
//     required this.phoneNumber,
//     required this.email,
//   });

//   factory UserModel.fromJson(Map<String, dynamic> json) {
//     return UserModel(
//       id: json['id'],
//       userName: json['userName'],
//       email: json['email'],
//       phoneNumber: json['phoneNumber'],
//       accessToken: json['access_token'],
//       refreshToken: json['refresh_token'],
//     );
//   }
// }

import 'package:hive/hive.dart';

part 'user_model.g.dart';

@HiveType(typeId: 0)
class UserModel extends HiveObject {
  @HiveField(0)
  final String accessToken;

  @HiveField(1)
  final String refreshToken;

  @HiveField(2)
  final String id;

  @HiveField(3)
  final String userName;

  @HiveField(4)
  final String phoneNumber;

  @HiveField(5)
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
      id: json['user']['id'] ?? '',
      userName: json['user']['userName'] ?? '',
      email: json['user']['email'] ?? '',
      phoneNumber: json['user']['phoneNumber'] ?? '',
      accessToken: json['access_token'] ?? '',
      refreshToken: json['refresh_token'] ?? '',
    );
  }
}
