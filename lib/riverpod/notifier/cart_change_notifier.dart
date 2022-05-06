import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:food_delivery_app/data/model/cart_item.dart';
import 'package:food_delivery_app/data/network/food_api.dart';

abstract class CartState {}

class CartInitialState extends CartState {}

class CartLoadingState extends CartState {}

class CartLoadedState extends CartState {}

class CartChangeNotifier extends ChangeNotifier {
  final FoodService authenticationService;
  List<CartItem> cartList = [];
  String exception = "";
  CartState cartState = CartInitialState();

  CartChangeNotifier({required this.authenticationService}) : super();

  Future<String> updateCartInDb() async {
    cartState = CartLoadingState();
    notifyListeners();
    final response = await authenticationService.updateList(cartList);
    cartState = CartLoadedState();
    notifyListeners();
    return response;
  }

  Future<void> getCartList() async {
    try {
      final response = await authenticationService.getCartItem();
      if (response != null) {
        cartList = response;
        notifyListeners();
      }
    } catch (e) {
      exception = e.toString();
      notifyListeners();
    }
  }

  void decreaseQuantity(CartItem cartItem) {
    var newList = cartList.map((e) {
      if (e.id == cartItem.id) {
        return e.copyWith(quantity: e.quantity - 1);
      } else {
        return e;
      }
    }).toList();
    cartList = newList;
    log("Decrease called:" + cartList[1].toJson().toString());
    notifyListeners();
  }

  void increaseQuantity(CartItem cartItem) {
    var newList = cartList.map((e) {
      if (e.id == cartItem.id) {
        return e.copyWith(quantity: e.quantity + 1);
      }
      return e;
    }).toList();
    cartList = newList;
    notifyListeners();
  }

  void removeItem(CartItem cartItem) {
    cartList.removeWhere((item) => item.id == cartItem.id);
    notifyListeners();
  }
}
