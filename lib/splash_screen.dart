import 'package:flutter/material.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:hive/hive.dart';
import 'package:product_loginui/sign_in.dart';
import 'package:product_loginui/user_model.dart';
import 'package:product_loginui/user_manager.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool _hasNoInternet = false;
  String _errorMessage = "";

  @override
  void initState() {
    super.initState();
    _checkConnectivityAndProceed();
  }

  Future<void> _checkConnectivityAndProceed() async {
    try {
      final result = await Connectivity().checkConnectivity();
      if (result == ConnectivityResult.none) {
        setState(() {
          _hasNoInternet = true;
          _errorMessage =
              "No Internet Connection. Please check your connection.";
        });
        return;
      }

      final box = Hive.box<UserModel>('userBox');
      final user = box.get('currentUser');

      if (user != null) {
        UserManager.instance.loadFromHive(user);
        Navigator.pushReplacementNamed(context, '/Home');
      } else {
        Navigator.pushReplacementNamed(context, '/Login');
      }
    } catch (e) {
      setState(() {
        _hasNoInternet = true;
        _errorMessage = "Something went wrong: ${e.toString()}";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: _hasNoInternet || _errorMessage.isNotEmpty
            ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.error, color: Colors.red, size: 50),
                  const SizedBox(height: 16),
                  Text(
                    _errorMessage,
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 16, color: Colors.black87),
                  ),
                  const SizedBox(height: 24),
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        _hasNoInternet = false;
                        _errorMessage = "";
                      });
                      _checkConnectivityAndProceed();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black,
                    ),
                    child: const Text('Retry'),
                  ),
                  const SizedBox(height: 10),
                  TextButton(
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const Loginpage(),
                        ),
                      );
                    },
                    child: const Text("Go to Login"),
                  ),
                ],
              )
            : Column(
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
