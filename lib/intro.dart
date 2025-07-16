import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:product_loginui/user_model.dart';

class Intro extends StatefulWidget {
  const Intro({super.key});

  @override
  State<Intro> createState() => _IntroState();
}

class _IntroState extends State<Intro> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  final List<Map<String, String>> slides = [
    {
      'image': 'assets/image/Batman.jpg',
      'title': 'Start a new\nsocial adventure.',
    },
    {'image': 'assets/image/Batman2.jpg', 'title': 'Connect with\nnew people.'},
    {'image': 'assets/image/Batman3.jpg', 'title': 'Join events\naround you.'},
  ];

  Future<void> _logout() async {
    // await Hive.box<UserModel>('userBox').delete('currentUser');
    Navigator.pushNamedAndRemoveUntil(context, '/Home', (route) => false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: PageView.builder(
              controller: _pageController,
              itemCount: slides.length,
              onPageChanged: (index) {
                setState(() => _currentPage = index);
              },
              itemBuilder: (context, index) {
                return Stack(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage(slides[index]['image']!),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Container(color: Colors.black.withOpacity(0.4)),
                    Column(
                      children: [
                        const SizedBox(height: 60),
                        const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20.0),
                          child: Align(
                            alignment: Alignment.topLeft,
                            child: Text(
                              'My Social',
                              style: TextStyle(
                                color: Colors.white70,
                                fontSize: 16,
                              ),
                            ),
                          ),
                        ),
                        const Spacer(),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 24.0),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              slides[index]['title']!,
                              style: const TextStyle(
                                fontSize: 28,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                height: 1.3,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: List.generate(
                            slides.length,
                            (dotIndex) => Container(
                              margin: const EdgeInsets.symmetric(horizontal: 4),
                              width: _currentPage == dotIndex ? 10 : 6,
                              height: _currentPage == dotIndex ? 10 : 6,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: _currentPage == dotIndex
                                    ? Colors.white
                                    : Colors.white30,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 150),
                      ],
                    ),
                  ],
                );
              },
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              width: double.infinity,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(36),
                  topRight: Radius.circular(36),
                ),
              ),
              padding: const EdgeInsets.all(24),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    'Get involved with people and events around you.',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 16, color: Colors.black87),
                  ),
                  const SizedBox(height: 24),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.black87,
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      onPressed: _logout,
                      child: const Text('Home', style: TextStyle(fontSize: 16)),
                    ),
                  ),
                  const SizedBox(height: 12),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, '/Home');
                    },
                    child: const Text(
                      'Or Create Account →',
                      style: TextStyle(
                        color: Colors.black87,
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
