import 'package:flutter/material.dart';

class CartItemCountNotifier extends ChangeNotifier {
  int count = 1;

  CartItemCountNotifier();

  Future<void> plusOne() async {
    count++;
    notifyListeners();
  }

  Future<void> minusOne() async {
    if (count > 1) {
      count--;
      notifyListeners();
    }
  }
}
