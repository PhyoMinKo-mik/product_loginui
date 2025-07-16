import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:product_loginui/product_detail_screen.dart';
import 'package:provider/provider.dart';
import 'package:product_loginui/product_model.dart';

class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final favoriteManager = Provider.of<FavoriteManager>(context);
    final favorites = favoriteManager.favorites;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Favorite Products'),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
      ),
      body: favorites.isEmpty
          ? const Center(child: Text('No favorites yet'))
          : ListView.builder(
              itemCount: favorites.length,
              itemBuilder: (context, index) {
                final product = favorites[index];
                return InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => ProductDetailScreen(product: product),
                      ),
                    );
                  },
                  child: Card(
                    margin: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 8,
                    ),
                    elevation: 2,
                    child: ListTile(
                      leading: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.network(
                          product.image,
                          width: 60,
                          height: 60,
                          fit: BoxFit.cover,
                        ),
                      ),
                      title: Text(
                        product.title,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text(
                        product.description,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      trailing: IconButton(
                        icon: const Icon(Icons.delete, color: Colors.red),
                        onPressed: () {
                          favoriteManager.removeFavorite(product);
                        },
                      ),
                    ),
                  ),
                );
              },
            ),
    );
  }
}

class FavoriteManager extends ChangeNotifier {
  final Box<Product> _box = Hive.box<Product>('favoriteBox');

  List<Product> get favorites => _box.values.toList();

  void toggleFavorite(Product product) {
    final exists = _box.values.any((p) => p.id == product.id);
    if (exists) {
      final keyToRemove = _box.keys.firstWhere(
        (key) => _box.get(key)?.id == product.id,
      );
      _box.delete(keyToRemove);
    } else {
      _box.add(product);
    }
    notifyListeners();
  }

  void removeFavorite(Product product) {
    final keyToRemove = _box.keys.firstWhere(
      (key) => _box.get(key)?.id == product.id,
    );
    _box.delete(keyToRemove);
    notifyListeners();
  }

  bool isFavorite(Product product) {
    return _box.values.any((p) => p.id == product.id);
  }
}
