import 'package:flutter/material.dart';

import '../model/barang.dart';
import '../model/cart_model.dart';

class CartProvider extends ChangeNotifier {
  final List<CartModel> _cart = [];
  List<CartModel> get cart => _cart;

  void addToCart(Products products, int qty) {
    final index = _cart.indexWhere((item) => item.name == products.name);

    if (index != -1) {
      int currentQuantity = int.parse(_cart[index].quantity ?? '0');
      _cart[index].quantity = (currentQuantity + qty).toString();
    } else {
      _cart.add(
        CartModel(
          name: products.name,
          price: products.price.toString(),
          image: products.image,
          quantity: qty.toString(),
        ),
      );
    }

    notifyListeners();
  }

  void clearCart() {
    _cart.clear();
    notifyListeners();
  }

  void removeItem(CartModel item) {
    _cart.remove(item);
    notifyListeners();
  }

  void decreaseQty(Products products) {
    final index = _cart.indexWhere((item) => item.name == products.name);

    if (index != -1) {
      int currentQuantity = int.parse(_cart[index].quantity ?? '0');
      if (currentQuantity > 1) {
        _cart[index].quantity = (currentQuantity - 1).toString();
      } else {
        _cart.removeAt(index);
      }
      notifyListeners();
    }
  }
}
