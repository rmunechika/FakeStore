import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../model/barang.dart';

class BarangProvider with ChangeNotifier {
  List<Products> _products = [];
  bool _isLoading = true;

  List<Products> get products => _products;
  bool get isLoading => _isLoading;

  BarangProvider() {
    fetchBarang();
  }

  Future<void> fetchBarang({int page = 1}) async {
    try {
      final response = await http
          .get(Uri.parse('https://fakestoreapi.in/api/products?page=$page'))
          .timeout(Duration(seconds: 15));

      if (response.statusCode == 200) {
        var jsonResponse = json.decode(response.body);

        if (jsonResponse is Map<String, dynamic> &&
            jsonResponse.containsKey('products')) {
          List<dynamic> productData = jsonResponse['products'];
          List<Products> newProducts =
              productData.map((item) => Products.fromJson(item)).toList();
          _products.addAll(newProducts);
        } else if (jsonResponse is List) {
          List<Products> newProducts =
              jsonResponse.map((item) => Products.fromJson(item)).toList();
          _products.addAll(newProducts);
        } else {
          throw Exception('Invalid API response');
        }
      } else {
        throw Exception('Failed to load data');
      }
    } catch (e) {
      print('Error loading data: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
