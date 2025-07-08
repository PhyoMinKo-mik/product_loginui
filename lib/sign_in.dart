import 'package:flutter/material.dart';
import 'package:product_loginui/apiservices.dart';
import 'package:product_loginui/sign_up.dart';

class SignIn extends StatefulWidget {
  const SignIn({super.key});

  @override
  State<SignIn> createState() => _IntroPageState();
}

class _IntroPageState extends State<SignIn> {
  bool rememberMe = false;

  final _formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  void _showErrorDialog(BuildContext context, String message, [String? error]) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Error'),
          content: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(message),
                if (error != null && error.isNotEmpty) ...[
                  const SizedBox(height: 10),
                  Text(
                    error,
                    style: const TextStyle(fontSize: 12, color: Colors.red),
                  ),
                ],
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  String? validateEmail(String? value) {
    if (value == null || value.isEmpty) return 'Email is required';
    final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+');
    if (!emailRegex.hasMatch(value)) return 'Enter a valid email';
    return null;
  }

  void handleSignIn() {
    if (_formKey.currentState!.validate()) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Login Successful')));
    }
  }

  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double screenwidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 37, 35, 35),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: screenwidth,
              height: 280,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(50),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.only(top: 60, right: 30),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    IconButton(
                      onPressed: () {
                        Navigator.pop(context, '/');
                      },
                      icon: const Icon(Icons.arrow_back),
                    ),
                    const SizedBox(height: 30),
                    Padding(
                      padding: const EdgeInsets.only(left: 30),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text(
                            'Welcome',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 30,
                            ),
                          ),
                          Text(
                            'Back!',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 30,
                            ),
                          ),
                          Text(
                            'Continue Your Adventure.',
                            style: TextStyle(fontSize: 20),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 80),

            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                      controller: emailController,
                      style: const TextStyle(color: Colors.white),
                      decoration: const InputDecoration(
                        labelText: 'Email',
                        labelStyle: TextStyle(color: Colors.white70),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.white38),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                        ),
                      ),
                      validator: validateEmail,
                    ),
                    const SizedBox(height: 20),

                    TextFormField(
                      style: const TextStyle(color: Colors.white),
                      obscureText: true,
                      decoration: const InputDecoration(
                        labelText: 'Password',
                        labelStyle: TextStyle(color: Colors.white70),
                      ),
                    ),
                    const SizedBox(height: 15),

                    Row(
                      children: [
                        Checkbox(
                          value: rememberMe,
                          onChanged: (bool? newValue) {
                            setState(() {
                              rememberMe = newValue!;
                            });
                          },
                        ),
                        const Text(
                          'Remember Me',
                          style: TextStyle(color: Colors.white),
                        ),
                      ],
                    ),
                    const SizedBox(height: 15),

                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      child: SizedBox(
                        width: double.infinity,
                        height: 50,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFFECE8E4),
                            foregroundColor: Colors.black,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          onPressed: () async {
                            final result = await Apiservice.userLogin(
                              emailController.text,
                              passwordController.text,
                            );

                            if (result['success']) {
                              print("Login Successful: ${result['data']}");
                            } else {
                              _showErrorDialog(
                                context,
                                result['message'],
                                result['error'],
                              );
                            }
                          },

                          child: const Text("Sign In"),
                        ),
                      ),
                    ),
                    const SizedBox(height: 15),

                    Center(
                      child: TextButton(
                        onPressed: () {},
                        child: const Text(
                          "Forgot Password?",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
