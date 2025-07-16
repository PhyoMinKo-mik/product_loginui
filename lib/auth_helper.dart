import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:product_loginui/user_model.dart';

Future<void> logout(BuildContext context) async {
  await Hive.box<UserModel>('userBox').delete('currentUser');

  Navigator.pushNamedAndRemoveUntil(context, '/Login', (route) => false);
}
