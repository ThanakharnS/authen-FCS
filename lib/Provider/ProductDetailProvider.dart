import 'package:flutter/foundation.dart';

class ProductDetailProvider with ChangeNotifier {
  int _quantity = 0;

  int get quantity => _quantity;

  void increment() {
    _quantity++;
    notifyListeners();
  }

  void decrement() {
    if (_quantity > 1) {
      _quantity--;
      notifyListeners();
    }
  }

  void reset() {
    _quantity = 0;
    notifyListeners();
  }
}
