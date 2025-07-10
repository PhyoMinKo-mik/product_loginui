// import 'package:flutter/material.dart';
// import 'package:hive/hive.dart';
// import 'package:product_loginui/sign_in.dart';
// import 'user_model.dart';
// import 'intro.dart';
// import 'package:logging/logging.dart';

// class SplashScreen extends StatefulWidget {
//   const SplashScreen({super.key});

//   @override
//   State<SplashScreen> createState() => _SplashScreenState();
// }

// class _SplashScreenState extends State<SplashScreen> {
//   @override
//   void initState() {
//     super.initState();
//     _checkLogin();
//   }

//   Future<void> _checkLogin() async {
//     await Future.delayed(const Duration(seconds: 2));

//     final box = Hive.box<UserModel>('userBox');
//     final user = box.get('currentUser');

//     if (user != null) {
//       Navigator.pushReplacement(
//         context,
//         MaterialPageRoute(builder: (context) => const Intro()),
//       );
//     } else {
//       Navigator.pushReplacement(
//         context,
//         MaterialPageRoute(builder: (context) => const Loginpage()),
//       );
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     // TODO: implement build
//     throw UnimplementedError();
//   }
// }

// @override
// Widget build(BuildContext context) {
//   return Scaffold(
//     backgroundColor: Colors.white,
//     body: Center(child: Image.asset('assets/image/CatBatman.jpg', width: 120)),
//   );
// }

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:product_loginui/intro.dart';
import 'package:product_loginui/sign_in.dart';
import 'package:product_loginui/user_model.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _navigateAfterDelay();
    });
  }

  Future<void> _navigateAfterDelay() async {
    // await Future.delayed(const Duration(seconds: 2));

    final box = Hive.box<UserModel>('userBox');
    final user = box.get('currentUser');

    if (user != null) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const Intro()),
      );
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const Loginpage()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Image(
              image: AssetImage('assets/image/CatBatman.jpg'),
              width: 120,
              height: 120,
            ),
            SizedBox(height: 30),
            CircularProgressIndicator(strokeWidth: 3, color: Colors.black),
            SizedBox(height: 16),
            Text(
              "Loading...",
              style: TextStyle(fontSize: 16, color: Colors.black54),
            ),
          ],
        ),
      ),
    );
  }
}
