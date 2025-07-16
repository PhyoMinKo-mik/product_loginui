import 'package:flutter/material.dart';
import 'package:product_loginui/favroite_screen.dart';
import 'package:product_loginui/product_detail_screen.dart';
import 'package:product_loginui/product_model.dart';
import 'package:provider/provider.dart';

class ProductCard extends StatelessWidget {
  final Product product;

  const ProductCard({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    final favoriteManager = Provider.of<FavoriteManager>(context);
    final isFav = favoriteManager.isFavorite(product);

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => ProductDetailScreen(product: product),
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(18),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.15),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image and Favorite Icon
            Expanded(
              child: Stack(
                children: [
                  ClipRRect(
                    borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(18),
                    ),
                    child: Container(
                      width: double.infinity,
                      color: Colors.grey[100],
                      child: Image.network(
                        product.image,
                        fit: BoxFit.contain,
                        height: double.infinity,
                      ),
                    ),
                  ),
                  Positioned(
                    top: 8,
                    right: 8,
                    child: InkWell(
                      onTap: () {
                        favoriteManager.toggleFavorite(product);
                      },
                      child: CircleAvatar(
                        radius: 18,
                        backgroundColor: Colors.white,
                        child: Icon(
                          isFav ? Icons.favorite : Icons.favorite_border,
                          color: isFav ? Colors.red : Colors.grey,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
              child: Text(
                product.title,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                  height: 1.3,
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.only(left: 10, bottom: 10),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.orange.shade50,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Text(
                  "Trending Now",
                  style: TextStyle(fontSize: 12, color: Colors.deepOrange),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
