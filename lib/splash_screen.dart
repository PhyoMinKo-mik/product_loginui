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

// import 'package:flutter/material.dart';
// import 'package:hive/hive.dart';
// import 'package:product_loginui/intro.dart';
// import 'package:product_loginui/sign_in.dart';
// import 'package:product_loginui/user_model.dart';

// class SplashScreen extends StatefulWidget {
//   const SplashScreen({super.key});

//   @override
//   State<SplashScreen> createState() => _SplashScreenState();
// }

// class _SplashScreenState extends State<SplashScreen> {
//   @override
//   void initState() {
//     super.initState();
//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       _navigateAfterDelay();
//     });
//   }

//   Future<void> _navigateAfterDelay() async {
//     // await Future.delayed(const Duration(seconds: 2));

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
//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: const [
//             Image(
//               image: AssetImage('assets/image/CatBatman.jpg'),
//               width: 120,
//               height: 120,
//             ),
//             SizedBox(height: 30),
//             CircularProgressIndicator(strokeWidth: 3, color: Colors.black),
//             SizedBox(height: 16),
//             Text(
//               "Loading...",
//               style: TextStyle(fontSize: 16, color: Colors.black54),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// import 'package:flutter/material.dart';
// import 'package:hive/hive.dart';
// import 'package:product_loginui/apiservices.dart';
// import 'package:product_loginui/intro.dart';
// import 'package:product_loginui/sign_in.dart';
// import 'package:product_loginui/user_model.dart';

// class SplashScreen extends StatefulWidget {
//   const SplashScreen({super.key});

//   @override
//   State<SplashScreen> createState() => _SplashScreenState();
// }

// class _SplashScreenState extends State<SplashScreen> {
//   @override
//   void initState() {
//     super.initState();
//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       _navigateAfterDelay();
//     });
//   }

//   Future<void> _navigateAfterDelay() async {
//     final box = Hive.box<UserModel>('userBox');
//     final user = box.get('currentUser');
//     print('Saving user: ${user?.userName}');
//     print('Saving user: ${user?.id}');
//     print('Saving user: ${user?.phoneNumber}');
//     print('Saving user: ${user?.email}');
//     print('Saving user: ${user?.accessToken}');

//     if (user != null) {
//       final refreshed = await Apiservice.userToken(
//         user.refreshToken,
//         user.accessToken,
//       );

//       if (refreshed != null) {
//         final updatedUser = UserModel(
//           accessToken: refreshed['access_token'],
//           refreshToken: refreshed['refresh_token'],
//           id: user.id,
//           userName: user.userName,
//           phoneNumber: user.phoneNumber,
//           email: user.email,
//         );
//         await box.put('currentUser', updatedUser);
//         print('user $updatedUser');

//         Navigator.pushReplacement(
//           context,
//           MaterialPageRoute(builder: (context) => const Intro()),
//         );
//       }
//     } else {
//       Navigator.pushReplacement(
//         context,
//         MaterialPageRoute(builder: (context) => const Loginpage()),
//       );
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: const [
//             Image(
//               image: AssetImage('assets/image/CatBatman.jpg'),
//               width: 120,
//               height: 120,
//             ),
//             SizedBox(height: 30),
//             CircularProgressIndicator(strokeWidth: 3, color: Colors.black),
//             SizedBox(height: 16),
//             Text(
//               "Loading...",
//               style: TextStyle(fontSize: 16, color: Colors.black54),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:product_loginui/apiservices.dart';
import 'package:product_loginui/intro.dart';
import 'package:product_loginui/sign_in.dart';
import 'package:product_loginui/user_model.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool _hasNoInternet = false;

  @override
  void initState() {
    super.initState();
    _checkConnectivityAndProceed();
  }

  Future<void> _checkConnectivityAndProceed() async {
    final connectivity = await Connectivity().checkConnectivity();

    if (connectivity == ConnectivityResult.none) {
      setState(() {
        _hasNoInternet = true;
      });
    } else {
      await _navigateAfterDelay();
    }
  }

  Future<void> _navigateAfterDelay() async {
    final box = Hive.box<UserModel>('userBox');
    final user = box.get('currentUser');

    if (user != null) {
      try {
        final refreshed = await Apiservice.userToken(
          user.refreshToken,
          user.accessToken,
        );

        if (refreshed != null) {
          final updatedUser = UserModel(
            accessToken: refreshed['access_token'],
            refreshToken: refreshed['refresh_token'],
            id: user.id,
            userName: user.userName,
            phoneNumber: user.phoneNumber,
            email: user.email,
          );
          await box.put('currentUser', updatedUser);

          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const Intro()),
          );
          return;
        }
      } catch (e) {
        debugPrint("Error refreshing token: $e");
      }
    }

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const Loginpage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: _hasNoInternet
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.wifi_off, size: 60, color: Colors.black54),
                  const SizedBox(height: 16),
                  const Text(
                    'No internet connection',
                    style: TextStyle(fontSize: 16, color: Colors.black87),
                  ),
                  const SizedBox(height: 24),
                  ElevatedButton(
                    onPressed: () {
                      setState(() => _hasNoInternet = false);
                      _checkConnectivityAndProceed();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black,
                    ),
                    child: const Text('Retry'),
                  ),
                ],
              ),
            )
          : Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Image(
                    image: AssetImage('assets/image/CatBatman.jpg'),
                    width: 120,
                    height: 120,
                  ),
                  SizedBox(height: 30),
                  CircularProgressIndicator(
                    strokeWidth: 3,
                    color: Colors.black,
                  ),
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
