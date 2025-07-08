import 'package:flutter/material.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final _formKey = GlobalKey<FormState>();

  // Controllers
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();

  bool agreeToTerms = false;

  @override
  void dispose() {
    emailController.dispose();
    phoneController.dispose();
    super.dispose();
  }

  String? validateEmail(String? value) {
    if (value == null || value.isEmpty) return 'Email is required';
    if (value.length < 15) return 'Email must be at least 15 characters';
    final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+');
    if (!emailRegex.hasMatch(value)) return 'Enter a valid email format';
    return null;
  }

  String? validatePhone(String? value) {
    if (value == null || value.isEmpty) return 'Phone number is required';
    final phoneRegex = RegExp(r'^\d+$');
    if (!phoneRegex.hasMatch(value)) return 'Only digits are allowed';
    if (value.length < 7 || value.length > 11) {
      return 'Phone number must be 7 to 11 digits';
    }
    return null;
  }

  void handleSubmit() {
    if (_formKey.currentState!.validate()) {
      if (!agreeToTerms) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("You must agree to the terms.")),
        );
        return;
      }

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Form Submitted Successfully!")),
      );
    }
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
                      onPressed: () {},
                      icon: const Icon(Icons.arrow_back),
                    ),
                    const SizedBox(height: 30),
                    Padding(
                      padding: const EdgeInsets.only(left: 30),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text(
                            'Create',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 30,
                            ),
                          ),
                          Text(
                            'Account.',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 30,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 50),

            Padding(
              padding: const EdgeInsets.all(22.0),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                      style: const TextStyle(color: Colors.white),
                      decoration: const InputDecoration(
                        labelText: 'Full Name',
                        labelStyle: TextStyle(color: Colors.white70),
                      ),
                    ),
                    const SizedBox(height: 15),

                    TextFormField(
                      controller: emailController,
                      style: const TextStyle(color: Colors.white),
                      decoration: const InputDecoration(
                        labelText: 'Email',
                        labelStyle: TextStyle(color: Colors.white70),
                      ),
                      validator: validateEmail,
                    ),
                    const SizedBox(height: 15),

                    TextFormField(
                      controller: phoneController,
                      style: const TextStyle(color: Colors.white),
                      decoration: const InputDecoration(
                        labelText: 'Phone Number',
                        labelStyle: TextStyle(color: Colors.white70),
                      ),
                      keyboardType: TextInputType.phone,
                      validator: validatePhone,
                    ),
                    const SizedBox(height: 15),

                    TextFormField(
                      style: const TextStyle(color: Colors.white),
                      obscureText: true,
                      decoration: const InputDecoration(
                        labelText: 'Password',
                        labelStyle: TextStyle(color: Colors.white70),
                      ),
                    ),
                    const SizedBox(height: 15),

                    TextFormField(
                      style: const TextStyle(color: Colors.white),
                      obscureText: true,
                      decoration: const InputDecoration(
                        labelText: 'Confirm Password',
                        labelStyle: TextStyle(color: Colors.white70),
                      ),
                    ),
                    const SizedBox(height: 15),

                    Padding(
                      padding: const EdgeInsets.only(right: 40),
                      child: Row(
                        children: [
                          Checkbox(
                            value: agreeToTerms,
                            onChanged: (value) {
                              setState(() {
                                agreeToTerms = value!;
                              });
                            },
                            activeColor: Colors.white,
                            checkColor: Colors.black,
                          ),
                          const Expanded(
                            child: Text(
                              "Agree to terms and conditions",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ],
                      ),
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
                          onPressed: handleSubmit,
                          child: const Text("Sign Up"),
                        ),
                      ),
                    ),

                    const SizedBox(height: 15),

                    Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            "Already have an account?",
                            style: TextStyle(color: Colors.white70),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.pushNamed(context, '/SignIn');
                            },
                            child: const Text("Sign In"),
                          ),
                        ],
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
