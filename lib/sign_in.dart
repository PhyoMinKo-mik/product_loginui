import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:product_loginui/apiservices.dart';
import 'package:product_loginui/intro.dart';
import 'package:product_loginui/user_model.dart';

class Loginpage extends StatefulWidget {
  const Loginpage({super.key});

  @override
  State<Loginpage> createState() => _LoginpageState();
}

class _LoginpageState extends State<Loginpage> {
  final TextEditingController _emailcontroller = TextEditingController();
  final TextEditingController _passwordcontroller = TextEditingController();

  bool isChecked = false;
  bool isLoading = false;

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Error'),
          content: Text(message),
          actions: [
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> _login() async {
    setState(() {
      isLoading = true;
    });

    final result = await Apiservice.userLogin(
      _emailcontroller.text.trim(),
      _passwordcontroller.text.trim(),
    );

    if (result['code'] == 200) {
      final user = UserModel.fromJson(result['data']);
      final userBox = Hive.box<UserModel>('userBox');
      await userBox.put('currentUser', user);
      print('access${user.accessToken}');
      print('access${user.refreshToken}');

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const Intro()),
      );
    } else {
      _showErrorDialog(result['message'] ?? 'Login failed. Please try again.');
    }

    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Positioned.fill(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  // HEADER
                  Container(
                    height: 250,
                    width: width,
                    decoration: const BoxDecoration(
                      color: Color.fromARGB(255, 63, 63, 63),
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(50),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 32),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 130,
                            width: width,
                            child: IconButton(
                              alignment: const Alignment(-1.08, 0),
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              icon: const Icon(
                                Icons.arrow_back,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          const Text(
                            'Welcome\nBack!',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 25,
                              color: Colors.white,
                            ),
                          ),
                          const Text(
                            'Continue your adventure',
                            style: TextStyle(color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 100),

                  // Email Field
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 32),
                    child: TextField(
                      controller: _emailcontroller,
                      decoration: const InputDecoration(hintText: 'Email'),
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Password Field
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 32),
                    child: TextField(
                      controller: _passwordcontroller,
                      decoration: const InputDecoration(hintText: 'Password'),
                    ),
                  ),
                  const SizedBox(height: 10),

                  // Remember Me
                  Padding(
                    padding: const EdgeInsets.only(left: 18),
                    child: Row(
                      children: [
                        Checkbox(
                          value: isChecked,
                          onChanged: (bool? value) {
                            setState(() {
                              isChecked = value ?? false;
                            });
                          },
                        ),
                        const Text(
                          'Remember me',
                          style: TextStyle(fontSize: 12),
                        ),
                      ],
                    ),
                  ),

                  // Login Button
                  Padding(
                    padding: const EdgeInsets.only(
                      top: 20,
                      right: 32,
                      left: 32,
                    ),
                    child: SizedBox(
                      height: 50,
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: _login,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color.fromARGB(
                            255,
                            63,
                            63,
                            63,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: const Text(
                          'Login',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),

                  const Padding(
                    padding: EdgeInsets.only(top: 10, left: 180),
                    child: Text('Forgot password?'),
                  ),
                ],
              ),
            ),
          ),

          // Loading Overlay
          if (isLoading)
            Positioned.fill(
              child: Container(
                color: Colors.black45,
                child: const Center(
                  child: CircularProgressIndicator(color: Colors.white),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
