import 'package:fake_store/model/barang.dart';
import 'package:flutter/material.dart';

class FavoriteProvider with ChangeNotifier {
  List<Products> _favorites = [];

  List<Products> get favorites => _favorites;

  void addFavorite(Products product) {
    if (!_favorites.contains(product)) {
      _favorites.add(product);
      notifyListeners();
    }
  }

  void removeFavorite(Products product) {
    if (_favorites.contains(product)) {
      _favorites.remove(product);
      notifyListeners();
    }
  }

  bool isFavorite(Products product) {
    return _favorites.contains(product);
  }
}
