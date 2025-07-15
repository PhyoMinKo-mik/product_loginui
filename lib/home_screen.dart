import 'package:flutter/material.dart';
import 'package:product_loginui/widgets/product_card.dart';
import 'package:product_loginui/apiservices.dart';
import 'package:product_loginui/product_model.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // bottomNavigationBar: BottomNavigationBar(
      //   onTap: (index) {},
      //   items: const [
      //     BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
      //     BottomNavigationBarItem(
      //       icon: Icon(Icons.notification_add),
      //       label: 'Noti',
      //     ),
      //     BottomNavigationBarItem(
      //       icon: Icon(Icons.favorite),
      //       label: 'Favroite',
      //     ),
      //   ],
      // ),
      appBar: AppBar(
        title: const Text(
          'Our Products',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        actions: const [
          CircleAvatar(
            backgroundImage: AssetImage('assets/image/CatBatman.jpg'),
          ),
          SizedBox(width: 10),
        ],
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      body: Padding(
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

            Expanded(
              child: FutureBuilder<List<Product>>(
                future: Apiservice.fetchProducts(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return const Center(child: Text('No products found'));
                  } else {
                    final products = snapshot.data!;
                    return GridView.count(
                      crossAxisCount: 2,
                      childAspectRatio: 0.8,
                      crossAxisSpacing: 12,
                      mainAxisSpacing: 12,
                      children: products.map((product) {
                        return ProductCard(product: product);
                      }).toList(),
                    );
                  }
                },
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
