import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:product_loginui/intro.dart';
import 'package:product_loginui/sign_in.dart';
import 'package:product_loginui/sign_up.dart';

void main() => runApp(const MyApp());

// void main() async {
//   WidgetsFlutterBinding.ensureInitialized(); await Hive.initFlutter();
//   Hive.registerAdapter();
// }
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: <String, WidgetBuilder>{
        '/': (context) => SignUp(),
        '/Login': (context) => Loginpage(),
        '/Intro': (context) => Intro(),
      },
    );
  }
}
