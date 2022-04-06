import 'package:food_delivery_app/data/model/restaurant.dart';
import 'package:food_delivery_app/data/network/food_api.dart';
import '../data/model/food.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final foodFutureProvider = FutureProvider.autoDispose<List<Food>?>((ref) async {
  ref.maintainState = true;

  final foodService = ref.read(foodServiceProvider);
  final foods = await foodService.getFoods();
  return foods;
});

final restaurantFutureProvider =
    FutureProvider.autoDispose<List<Restaurant>?>((ref) async {
  ref.maintainState = true;

  final restaurantService = ref.read(foodServiceProvider);
  final restaurants = await restaurantService.getRestaurants();
  return restaurants;
});
