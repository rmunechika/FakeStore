import 'package:fake_store/model/barang.dart';
import 'package:flutter/foundation.dart';

import 'barang_provider.dart';

class ScrollProvider with ChangeNotifier {
  final BarangProvider barangProvider;

  bool _isLoading = false;
  int _page = 1;

  List<Products> get products => barangProvider.products;
  bool get isLoading => _isLoading;

  ScrollProvider(this.barangProvider);

  void loadMoreProducts() async {
    if (_isLoading) return;

    _isLoading = true;
    notifyListeners();

    try {
      await barangProvider.fetchBarang(page: _page);
      _page++;
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
