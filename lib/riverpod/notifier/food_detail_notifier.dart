import 'package:flutter/material.dart';
import 'package:food_delivery_app/data/model/cart_item.dart';
import 'package:food_delivery_app/data/network/food_api.dart';

abstract class FoodDetailState {}

class FoodDetailInitialState extends FoodDetailState {}

class FoodDetailLoadingState extends FoodDetailState {}

class FoodDetailLoadedState extends FoodDetailState {}

class FoodDetailNotifier extends ChangeNotifier {
  int count = 1;
  FoodDetailState state = FoodDetailInitialState();
  final FoodService foodService;

  FoodDetailNotifier(this.foodService);

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

  Future<String> insertIntoCart(CartItem cartItem, List<CartItem> list) async {
    try {
      state = FoodDetailLoadingState();
      notifyListeners();

      var response = await foodService.insertIntoCart(cartItem, list);
      state = FoodDetailLoadedState();
      notifyListeners();
      return response;
    } catch (e) {
      state = FoodDetailLoadedState();
      notifyListeners();
      return e.toString();
    }
  }
}
