import 'package:flutter/material.dart';
import 'package:product_loginui/product_model.dart';

class ProductDetailScreen extends StatelessWidget {
  final Product product;

  const ProductDetailScreen({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          product.title,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0.5,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: AspectRatio(
                aspectRatio: 1,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: Image.network(
                    product.image,
                    fit: BoxFit.contain,
                    loadingBuilder: (context, child, progress) {
                      if (progress == null) return child;
                      return const Center(child: CircularProgressIndicator());
                    },
                  ),
                ),
              ),
            ),
            const SizedBox(height: 24),
            Text(
              product.title,
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            Text(
              product.description,
              style: const TextStyle(fontSize: 16, height: 1.4),
            ),
          ],
        ),
      ),
    );
  }
}
