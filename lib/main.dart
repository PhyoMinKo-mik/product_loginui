import 'package:flutter/material.dart';
import 'package:product_loginui/intro.dart';
import 'package:product_loginui/sign_in.dart';
import 'package:product_loginui/sign_up.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: <String, WidgetBuilder>{
        '/': (context) => SignUp(),
        '/SignIn': (context) => SignIn(),
        '/Intro': (context) => Intro(),
      },
    );
  }
}
