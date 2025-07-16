// import 'package:flutter/material.dart';
// import 'package:hive/hive.dart';
// import 'package:hive_flutter/adapters.dart';
// import 'package:product_loginui/intro.dart';
// import 'package:product_loginui/sign_in.dart';
// import 'package:product_loginui/sign_up.dart';
// import 'package:product_loginui/user_model.dart';
// import 'package:product_loginui/splash_screen.dart';

// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await Hive.initFlutter();

//   Hive.registerAdapter(UserModelAdapter());
//   await Hive.openBox<UserModel>('userBox');

//   runApp(const MyApp());
// }

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return const MaterialApp(
//       debugShowCheckedModeBanner: false,
//       home: SplashScreen(),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:product_loginui/favroite_screen.dart';
import 'package:product_loginui/navigation.dart';
import 'package:product_loginui/product_model.dart';
import 'package:product_loginui/profile_page.dart';
import 'package:provider/provider.dart';

import 'package:product_loginui/user_model.dart';
import 'package:product_loginui/intro.dart';
import 'package:product_loginui/sign_in.dart';
import 'package:product_loginui/sign_up.dart';
import 'package:product_loginui/splash_screen.dart';
import 'package:product_loginui/profile_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();

  Hive.registerAdapter(UserModelAdapter());
  Hive.registerAdapter(ProductAdapter());
  await Hive.openBox<UserModel>('userBox');
  await Hive.openBox<Product>('favoriteBox');

  runApp(
    ChangeNotifierProvider(
      create: (_) => FavoriteManager(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => const SplashScreen(),
        '/Login': (context) => const Loginpage(),
        '/SignUp': (context) => const SignUp(),
        '/Intro': (context) => const Intro(),
        '/Home': (context) => const MainScreen(),
        '/Profile': (context) => const ProfileScreen(),
      },
    );
  }
}


//   @override
//   Widget build(BuildContext context) {
//     final box = Hive.box<UserModel>('userBox');
//     final user = box.get('currentUser');
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       home: user != null ? const Intro() : const Loginpage(),
//     );
//   }
// }

  // Widget build(BuildContext context) {
  //   return MaterialApp(
  //     routes: <String, WidgetBuilder>{
  //       '/': (context) => SignUp(),
  //       '/Login': (context) => Loginpage(),
  //       '/Intro': (context) => Intro(),
      // },
    
  

