import 'package:flutter/material.dart';
import 'package:product_loginui/product_model.dart';
import 'package:provider/provider.dart';

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
                return Card(
                  margin: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  child: ListTile(
                    leading: Image.network(
                      product.image,
                      width: 50,
                      fit: BoxFit.cover,
                    ),
                    title: Text(
                      product.title,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
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
                );
              },
            ),
    );
  }
}

class FavoriteManager extends ChangeNotifier {
  final List<Product> _favorites = [];

  List<Product> get favorites => _favorites;

  void toggleFavorite(Product product) {
    final exists = _favorites.any((p) => p.id == product.id);
    if (exists) {
      _favorites.removeWhere((p) => p.id == product.id);
    } else {
      _favorites.add(product);
    }
    notifyListeners();
  }

  void removeFavorite(Product product) {
    _favorites.removeWhere((p) => p.id == product.id);
    notifyListeners();
  }

  bool isFavorite(Product product) {
    return _favorites.any((p) => p.id == product.id);
  }
}
