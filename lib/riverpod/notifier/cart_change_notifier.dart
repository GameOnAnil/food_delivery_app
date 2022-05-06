import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:food_delivery_app/data/model/cart_item.dart';

import 'package:food_delivery_app/utils/token_auth_service.dart';

class CartChangeNotifier extends ChangeNotifier {
  final TokenAuthService authenticationService;
  List<CartItem> cartList = [];
  String exception = "";

  CartChangeNotifier({required this.authenticationService}) : super();

  Future<void> getCartList() async {
    try {
      final response = await authenticationService.getCartItem();
      if (response != null) {
        cartList = response;
      }
      notifyListeners();
    } catch (e) {
      exception = e.toString();
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
    cartList.removeWhere((element) => cartItem.id == element.id);
    notifyListeners();
  }
}
