import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:food_delivery_app/provider/auth_provider.dart';

final cartItemCountProvider =
    ChangeNotifierProvider.autoDispose<CartItemCountNotifier>((ref) {
  return CartItemCountNotifier();
});

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