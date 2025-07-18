import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:product_loginui/product_detail_screen.dart';
import 'package:product_loginui/user_model.dart';
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
  final Box _box = Hive.box('favoriteBox');

  String get _currentUserKey {
    final userBox = Hive.box<UserModel>('userBox');
    final currentUser = userBox.get('currentUser');
    return currentUser != null
        ? 'favorites_${currentUser.id}'
        : 'favorites_guest';
  }

  List<Product> get favorites {
    final rawList = _box.get(_currentUserKey, defaultValue: <dynamic>[]);
    return rawList.cast<Product>();
  }

  void toggleFavorite(Product product) {
    final currentFavorites = [...favorites];
    final exists = currentFavorites.any((p) => p.id == product.id);
    if (exists) {
      currentFavorites.removeWhere((p) => p.id == product.id);
    } else {
      currentFavorites.add(product);
    }
    _box.put(_currentUserKey, currentFavorites);
    notifyListeners();
  }

  void removeFavorite(Product product) {
    final currentFavorites = [...favorites];
    currentFavorites.removeWhere((p) => p.id == product.id);
    _box.put(_currentUserKey, currentFavorites);
    notifyListeners();
  }

  bool isFavorite(Product product) {
    return favorites.any((p) => p.id == product.id);
  }
}
