import 'package:flutter/material.dart';
import '../models/product.dart';

class FavoritesProvider extends ChangeNotifier {
  final List<Product> _favorites = [];

  List<Product> get favorites => _favorites;
  int get count => _favorites.length;

  void toggleFavorite(Product product) {
    final existingIndex = _favorites.indexWhere((p) => p.id == product.id);
    
    if (existingIndex >= 0) {
      _favorites.removeAt(existingIndex);
    } else {
      _favorites.add(product);
    }
    notifyListeners();
  }

  bool isFavorite(String productId) {
    return _favorites.any((p) => p.id == productId);
  }

  void clearFavorites() {
    _favorites.clear();
    notifyListeners();
  }
}