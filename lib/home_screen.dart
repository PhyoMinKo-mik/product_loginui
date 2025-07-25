import 'package:flutter/material.dart';
import 'package:product_loginui/apiservices.dart';
import 'package:product_loginui/shimmer_productcard.dart';
import 'package:product_loginui/user_data_model/personal_data.dart';
import 'package:product_loginui/user_manager.dart';
import 'package:product_loginui/widgets/product_card.dart';
import 'package:product_loginui/product_model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isLoading = true;
  String errorMessage = '';
  List<Product> products = [];

  @override
  void initState() {
    super.initState();
    _loadAllData();
  }

  Future<void> _loadAllData() async {
    final user = UserManager.instance.currentUser;

    if (user.accessToken.isEmpty) {
      setState(() {
        errorMessage = 'User not logged in';
        isLoading = false;
      });
      return;
    }

    try {
      final results = await Future.wait([
        Apiservice.fetchPersonalData(user.accessToken),
        Apiservice.fetchProducts(),
      ]);

      final personalDataResult = results[0] as Map;
      final productList = results[1] as List<Product>;

      if (personalDataResult['success']) {
        final personalData = PersonalData.fromJson(personalDataResult['data']);
        UserManager.instance.setPersonalData(personalData);
      } else {
        errorMessage = personalDataResult['message'];
      }

      products = productList;
    } catch (e) {
      errorMessage = 'Something went wrong';
    }

    setState(() {
      isLoading = false;
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
              backgroundImage: AssetImage('assets/image/CatBatman.jpg'),
            ),
          ),
          const SizedBox(width: 10),
        ],
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      body: isLoading
          ? const HomeShimmer()
          : errorMessage.isNotEmpty
          ? Center(child: Text(errorMessage))
          : Padding(
              padding: const EdgeInsets.all(16.0),
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
                    child: products.isEmpty
                        ? const Center(child: Text('No products found'))
                        : GridView.count(
                            crossAxisCount: 2,
                            childAspectRatio: 0.8,
                            crossAxisSpacing: 12,
                            mainAxisSpacing: 12,
                            children: products
                                .map((product) => ProductCard(product: product))
                                .toList(),
                          ),
                  ),
                ],
              ),
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
