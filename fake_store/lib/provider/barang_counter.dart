import 'package:flutter/material.dart';

class BarangCounter extends ChangeNotifier {
  int _barangCount = 0;
  double _sumPrice = 0.0;

  int get barangCount => _barangCount;
  double get sumPrice => _sumPrice;

  int getBarangCount() {
    return _barangCount;
  }

  void addItem(double price) {
    _barangCount++;
    _sumPrice += price;
    notifyListeners();
  }

  void removeItem(double price) {
    if (_barangCount > 0) {
      _barangCount--;
      _sumPrice -= price;
      notifyListeners();
    }
  }

  void reset() {
    _barangCount = 0;
    _sumPrice = 0;
    notifyListeners();
  }
}
