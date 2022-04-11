import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final cartItemCountProvider =
    ChangeNotifierProvider.autoDispose<CartItemCountNotifier>((ref) {
  return CartItemCountNotifier();
});

class CartItemCountNotifier extends ChangeNotifier {
  int count = 0;

  CartItemCountNotifier();

  Future<void> plusOne() async {
    count++;
    notifyListeners();
  }

  Future<void> minusOne() async {
    if (count > 0) {
      count--;
      notifyListeners();
    }
  }
}
