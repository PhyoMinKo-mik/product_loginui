import 'package:flutter/material.dart';
import 'package:product_loginui/apiservices.dart';
import 'package:product_loginui/intro.dart';

class Loginpage extends StatefulWidget {
  const Loginpage({super.key});

  @override
  State<Loginpage> createState() => _LoginpageState();
}

class _LoginpageState extends State<Loginpage> {
  final TextEditingController _emailcontroller = TextEditingController();
  final TextEditingController _passwordcontroller = TextEditingController();
  bool isChecked = false;
  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Error'),
          content: Text(message),
          actions: [
            TextButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    // double height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 250,
              width: width,
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 63, 63, 63),
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
                        alignment: Alignment(-1.08, 0),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: Icon(Icons.arrow_back, color: Colors.white),
                      ),
                    ),
                    Text(
                      'Welcome\nBack!',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 25,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      'Continue your adventure',
                      style: TextStyle(color: Colors.white),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 100),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32),
              child: TextField(
                controller: _emailcontroller,
                decoration: InputDecoration(hintText: 'Email'),
              ),
            ),

            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32),
              child: TextField(
                controller: _passwordcontroller,
                decoration: InputDecoration(hintText: 'Password'),
              ),
            ),
            SizedBox(height: 10),
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

                  Text('Remember me', style: TextStyle(fontSize: 12)),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20, right: 32, left: 32),
              child: SizedBox(
                height: 50,
                width: double.infinity,
                child: ElevatedButton(
                  // onPressed: () async {
                  //   final result = await Apiservice.userLogin(
                  //     _emailcontroller.text,
                  //     _passwordcontroller.text,
                  //   );
                  //   if (result != null && result['statusCode'] == 200) {
                  //     Navigator.push(
                  //       context,
                  //       MaterialPageRoute(builder: (context) => Intro()),
                  //     );
                  //   }

                  //   _showErrorDialog('${result!['message']}');

                  //   // if (result['success']) {
                  //   // } else {
                  //   //   return _showErrorDialog(result['message']);
                  //   // }
                  // },
                  onPressed: () async {
                    final result = await Apiservice.userLogin(
                      _emailcontroller.text.trim(),
                      _passwordcontroller.text.trim(),
                    );

                    if (result != null && result['code'] == 200) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const Intro()),
                      );
                    } else {
                      _showErrorDialog(
                        result?['message'] ?? 'Login failed. Please try again.',
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(
                      255,
                      63,
                      63,
                      63,
                    ), // Background color
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: Text(
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
            Padding(
              padding: const EdgeInsets.only(top: 10, left: 180),
              child: Text('Forgot password?'),
            ),
          ],
        ),
      ),
    );
  }
}
