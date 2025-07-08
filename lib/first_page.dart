// import 'package:flutter/material.dart';

// class FirstPage extends StatefulWidget {
//   const FirstPage({super.key});

//   @override
//   State<FirstPage> createState() => _FirstPageState();
// }

// class _FirstPageState extends State<FirstPage> {
//   final PageController _pageController = PageController();
//   int _currentPage = 0;

//   final List<Map<String, String>> slides = [
//     {
//       'image': 'assets/image/Batman.jpg',
//       'title': 'Start a new\nsocial adventure.',
//     },
//     {'image': 'assets/image/Batman2.jpg', 'title': 'Connect with\nnew people.'},
//     {'image': 'assets/image/Batman3.jpg', 'title': 'Join events\naround you.'},
//   ];

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Stack(
//         children: [
//           Positioned.fill(
//             child: PageView.builder(
//               controller: _pageController,
//               itemCount: slides.length,
//               onPageChanged: (index) {
//                 setState(() {
//                   (() => _currentPage = index);
//                 },itemBuilder: (context, index ) {
//                   return Stack(children: [Container(decoration: ,)],

//                   );
//                 }
//                 );
//               },
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
