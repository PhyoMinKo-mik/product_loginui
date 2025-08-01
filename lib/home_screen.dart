// import 'package:flutter/material.dart';
// import 'package:product_loginui/apiservices.dart';
// import 'package:product_loginui/shimmer_productcard.dart';
// import 'package:product_loginui/user_data_model/personal_data.dart';
// import 'package:product_loginui/user_manager.dart';
// import 'package:product_loginui/widgets/product_card.dart';
// import 'package:product_loginui/product_model.dart';

// class HomeScreen extends StatefulWidget {
//   const HomeScreen({super.key});

//   @override
//   State<HomeScreen> createState() => _HomeScreenState();
// }

// class _HomeScreenState extends State<HomeScreen> {
//   bool isLoading = true;
//   String errorMessage = '';
//   List<Product> products = [];

//   @override
//   void initState() {
//     super.initState();
//     _loadAllData();
//   }

//   Future<void> _loadAllData() async {
//     final user = UserManager.instance.currentUser;

//     if (user.accessToken.isEmpty) {
//       setState(() {
//         errorMessage = 'User not logged in';
//         isLoading = false;
//       });
//       return;
//     }

//     try {
//       final results = await Future.wait([
//         Apiservice.fetchPersonalData(user.accessToken),
//         Apiservice.fetchProducts(),
//       ]);

//       final personalDataResult = results[0] as Map;
//       final productList = results[1] as List<Product>;

//       if (personalDataResult['success']) {
//         final personalData = PersonalData.fromJson(personalDataResult['data']);
//         UserManager.instance.setPersonalData(personalData);
//       } else {
//         errorMessage = personalDataResult['message'];
//       }

//       products = productList;
//     } catch (e) {
//       errorMessage = 'Something went wrong';
//     }

//     setState(() {
//       isLoading = false;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text(
//           'Our Products',
//           style: TextStyle(fontWeight: FontWeight.bold),
//         ),
//         actions: [
//           GestureDetector(
//             onTap: () => Navigator.pushNamed(context, '/Profile'),
//             child: const CircleAvatar(
//               backgroundImage: AssetImage('assets/image/CatBatman.jpg'),
//             ),
//           ),
//           const SizedBox(width: 10),
//         ],
//         backgroundColor: Colors.white,
//         foregroundColor: Colors.black,
//         elevation: 0,
//       ),
//       body: isLoading
//           ? const HomeShimmer()
//           : errorMessage.isNotEmpty
//           ? Center(child: Text(errorMessage))
//           : Padding(
//               padding: const EdgeInsets.all(16.0),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   const TextField(
//                     decoration: InputDecoration(
//                       hintText: 'Search Products',
//                       prefixIcon: Icon(Icons.search),
//                       border: OutlineInputBorder(
//                         borderRadius: BorderRadius.all(Radius.circular(12)),
//                       ),
//                     ),
//                   ),
//                   const SizedBox(height: 16),
//                   SizedBox(
//                     height: 40,
//                     child: ListView(
//                       scrollDirection: Axis.horizontal,
//                       children: [
//                         _categoryChip('Sneakers', true),
//                         _categoryChip('Watch', false),
//                         _categoryChip('Jacket', false),
//                       ],
//                     ),
//                   ),
//                   const SizedBox(height: 16),
//                   const Text(
//                     'Recommendation for you',
//                     style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//                   ),
//                   const SizedBox(height: 10),
//                   Expanded(
//                     child: products.isEmpty
//                         ? const Center(child: Text('No products found'))
//                         : GridView.count(
//                             crossAxisCount: 2,
//                             childAspectRatio: 0.8,
//                             crossAxisSpacing: 12,
//                             mainAxisSpacing: 12,
//                             children: products
//                                 .map((product) => ProductCard(product: product))
//                                 .toList(),
//                           ),
//                   ),
//                 ],
//               ),
//             ),
//     );
//   }

//   static Widget _categoryChip(String label, bool isSelected) {
//     return Padding(
//       padding: const EdgeInsets.only(right: 8),
//       child: ChoiceChip(
//         label: Text(label),
//         selected: isSelected,
//         selectedColor: Colors.orange,
//         onSelected: (_) {},
//       ),
//     );
//   }
// }

// import 'package:flutter/material.dart';
// import 'package:product_loginui/apiservices.dart';
// import 'package:product_loginui/shimmer_productcard.dart';
// import 'package:product_loginui/user_data_model/personal_data.dart';
// import 'package:product_loginui/user_manager.dart';
// import 'package:product_loginui/widgets/product_card.dart';
// import 'package:product_loginui/product_model.dart';

// class HomeScreen extends StatefulWidget {
//   const HomeScreen({super.key});

//   @override
//   State<HomeScreen> createState() => _HomeScreenState();
// }

// class _HomeScreenState extends State<HomeScreen> {
//   bool isLoading = true;
//   String errorMessage = '';
//   List<Product> products = [];

//   @override
//   void initState() {
//     super.initState();
//     _loadAllData();
//   }

//   Future<void> _loadAllData() async {
//     final user = UserManager.instance.currentUser;

//     if (user.accessToken.isEmpty) {
//       setState(() {
//         errorMessage = 'User not logged in';
//         isLoading = false;
//       });
//       return;
//     }

//     try {
//       final results = await Future.wait([
//         Apiservice.fetchPersonalData(user.accessToken),
//         Apiservice.fetchProducts(),
//       ]);

//       final personalDataResult = results[0] as Map;
//       final productList = results[1] as List<Product>;

//       if (personalDataResult['success']) {
//         final personalData = PersonalData.fromJson(personalDataResult['data']);
//         UserManager.instance.setPersonalData(personalData);
//       } else {
//         errorMessage = personalDataResult['message'];
//       }

//       products = productList;
//     } catch (e) {
//       errorMessage = 'Something went wrong';
//     }

//     setState(() {
//       isLoading = false;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text(
//           'Our Products',
//           style: TextStyle(fontWeight: FontWeight.bold),
//         ),
//         actions: [
//           GestureDetector(
//             onTap: () => Navigator.pushNamed(context, '/Profile'),
//             child: const CircleAvatar(
//               backgroundImage: AssetImage('assets/image/CatBatman.jpg'),
//             ),
//           ),
//           const SizedBox(width: 10),
//         ],
//         backgroundColor: Colors.white,
//         foregroundColor: Colors.black,
//         elevation: 0,
//       ),
//       body: isLoading
//           ? const HomeShimmer()
//           : errorMessage.isNotEmpty
//           ? Center(child: Text(errorMessage))
//           : Padding(
//               padding: const EdgeInsets.all(16.0),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   const TextField(
//                     decoration: InputDecoration(
//                       hintText: 'Search Products',
//                       prefixIcon: Icon(Icons.search),
//                       border: OutlineInputBorder(
//                         borderRadius: BorderRadius.all(Radius.circular(12)),
//                       ),
//                     ),
//                   ),
//                   const SizedBox(height: 16),
//                   SizedBox(
//                     height: 40,
//                     child: ListView(
//                       scrollDirection: Axis.horizontal,
//                       children: [
//                         _categoryChip('Sneakers', true),
//                         _categoryChip('Watch', false),
//                         _categoryChip('Jacket', false),
//                       ],
//                     ),
//                   ),
//                   const SizedBox(height: 16),
//                   const Text(
//                     'Recommendation for you',
//                     style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//                   ),
//                   const SizedBox(height: 10),
//                   Expanded(
//                     child: products.isEmpty
//                         ? const Center(child: Text('No products found'))
//                         : GridView.count(
//                             crossAxisCount: 2,
//                             childAspectRatio: 0.8,
//                             crossAxisSpacing: 12,
//                             mainAxisSpacing: 12,
//                             children: products
//                                 .map((product) => ProductCard(product: product))
//                                 .toList(),
//                           ),
//                   ),
//                 ],
//               ),
//             ),
//     );
//   }

//   static Widget _categoryChip(String label, bool isSelected) {
//     return Padding(
//       padding: const EdgeInsets.only(right: 8),
//       child: ChoiceChip(
//         label: Text(label),
//         selected: isSelected,
//         selectedColor: Colors.orange,
//         onSelected: (_) {},
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:product_loginui/apiservices.dart';
import 'package:product_loginui/shimmer_productcard.dart';
import 'package:product_loginui/user_data_model/personal_data.dart';
import 'package:product_loginui/user_manager.dart';
import 'package:product_loginui/product_model.dart';
import 'package:product_loginui/widgets/product_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool _loading = true;
  bool _isRefreshing = false;
  String? _errorMessage;

  static bool _personalDataLoaded = false;
  List<Product> _products = [];

  @override
  void initState() {
    super.initState();
    _loadAllData();
  }

  Future<void> _loadAllData() async {
    if (!mounted) return;

    setState(() {
      _loading = true;
      _errorMessage = null;
    });

    final user = UserManager.instance.currentUser;
    if (user.accessToken.isEmpty) {
      if (!mounted) return;
      setState(() {
        _errorMessage = 'User not logged in';
        _loading = false;
      });
      return;
    }

    if (!_personalDataLoaded) {
      final personalRes = await ApiService.fetchPersonalData(user.accessToken);
      if (!mounted) return;

      if (personalRes.errorMessage != null) {
        setState(() {
          _errorMessage = personalRes.errorMessage == 'No internet connection'
              ? 'No internet connection'
              : null;
          _loading = false;
        });
        return;
      } else if (personalRes.data != null) {
        UserManager.instance.setPersonalData(personalRes.data!);
        _personalDataLoaded = true;
      }
    }

    await _refreshProducts();
  }

  Future<void> _refreshProducts() async {
    if (!mounted) return;

    setState(() {
      _isRefreshing = true;
      _errorMessage = null;
    });

    final productRes = await ApiService.fetchProducts();
    if (!mounted) return;

    if (productRes.errorMessage != null) {
      setState(() {
        _errorMessage = productRes.errorMessage == 'No internet connection'
            ? 'No internet connection'
            : null;
      });
    } else {
      setState(() {
        _products = productRes.data ?? [];
        _errorMessage = null;
      });
    }

    setState(() {
      _isRefreshing = false;
      _loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Our Products',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        actions: [
          GestureDetector(
            onTap: () => Navigator.pushNamed(context, '/Profile'),
            child: const CircleAvatar(
              backgroundColor: Colors.orange,
              child: Icon(Icons.person, color: Colors.white),
            ),
          ),
          const SizedBox(width: 10),
        ],
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      body: _loading
          ? const HomeShimmer()
          : _errorMessage != null
          ? _buildErrorContent()
          : _buildContent(),
    );
  }

  Widget _buildErrorContent() {
    final msg = _errorMessage ?? 'Something went wrong';
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.error_outline, size: 64, color: Colors.redAccent),
            const SizedBox(height: 20),
            Text(
              msg,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 16, color: Colors.red),
            ),
            const SizedBox(height: 20),
            ElevatedButton.icon(
              icon: const Icon(Icons.refresh),
              label: const Text('Retry'),
              onPressed: _loadAllData,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildContent() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const TextField(
            decoration: InputDecoration(
              hintText: 'Search Products',
              prefixIcon: Icon(Icons.search),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(12)),
              ),
            ),
          ),
          const SizedBox(height: 16),
          SizedBox(
            height: 40,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                _categoryChip('Sneakers', true),
                _categoryChip('Watch', false),
                _categoryChip('Jacket', false),
              ],
            ),
          ),
          const SizedBox(height: 16),
          const Text(
            'Recommendation for you',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          Expanded(
            child: _errorMessage != null
                ? _buildErrorContent()
                : _isRefreshing
                ? GridView.count(
                    crossAxisCount: 2,
                    childAspectRatio: 0.8,
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 12,
                    children: List.generate(
                      6,
                      (_) => const ProductShimmerCard(),
                    ),
                  )
                : RefreshIndicator(
                    onRefresh: _refreshProducts,
                    child: _products.isEmpty
                        ? LayoutBuilder(
                            builder: (context, constraints) =>
                                SingleChildScrollView(
                                  physics:
                                      const AlwaysScrollableScrollPhysics(),
                                  child: ConstrainedBox(
                                    constraints: BoxConstraints(
                                      minHeight: constraints.maxHeight,
                                    ),
                                    child: _buildErrorContent(),
                                  ),
                                ),
                          )
                        : GridView.count(
                            crossAxisCount: 2,
                            childAspectRatio: 0.8,
                            crossAxisSpacing: 12,
                            mainAxisSpacing: 12,
                            children: _products
                                .map((p) => ProductCard(product: p))
                                .toList(),
                          ),
                  ),
          ),
        ],
      ),
    );
  }

  static Widget _categoryChip(String label, bool isSelected) {
    return Padding(
      padding: const EdgeInsets.only(right: 8),
      child: ChoiceChip(
        label: Text(label),
        selected: isSelected,
        selectedColor: Colors.orange,
        onSelected: (_) {},
      ),
    );
  }
}
