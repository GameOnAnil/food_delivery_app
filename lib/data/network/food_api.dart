import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:food_delivery_app/data/model/food.dart';
import 'package:food_delivery_app/data/model/restaurant.dart';

import 'custom_exception.dart';

final foodServiceProvider = Provider<FoodService>((ref) {
  return FoodService(Dio());
});

class FoodService {
  FoodService(this._dio);
  final Dio _dio;

  Future<List<Food>> getFoods() async {
    try {
      final response =
          await _dio.get("https://food-api-mongo.herokuapp.com/foods");

      final jsonResult = List<Map<String, dynamic>>.from(response.data);

      List<Food> foods = jsonResult.map((food) => Food.fromMap(food)).toList();
      return foods;
    } on DioError catch (e) {
      throw DioExceptions.fromDioError(e).toString();
    }
  }

  Future<List<Restaurant>> getRestaurants() async {
    try {
      final response =
          await _dio.get("https://food-api-mongo.herokuapp.com/restaurants");

      final jsonResult = List<Map<String, dynamic>>.from(response.data);

      List<Restaurant> restaurants =
          jsonResult.map((e) => Restaurant.fromMap(e)).toList();

      return restaurants;
    } on DioError catch (e) {
      throw DioExceptions.fromDioError(e).toString();
    }
  }
}
