import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:food_delivery_app/data/model/food.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
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
          await _dio.get("https://ourfoodapi.herokuapp.com/api/foods");

      final jsonResult = List<Map<String, dynamic>>.from(response.data);

      List<Food> foods =
          jsonResult.map((movie) => Food.fromMap(movie)).toList();

      return foods;
    } on DioError catch (e) {
      throw DioExceptions.fromDioError(e).toString();
    }
  }

  Future<List<Restaurant>> getRestaurants() async {
    try {
      final response =
          await _dio.get("https://ourfoodapi.herokuapp.com/api/restaurants");

      final jsonResult = List<Map<String, dynamic>>.from(response.data);

      List<Restaurant> restaurants =
          jsonResult.map((e) => Restaurant.fromMap(e)).toList();

      return restaurants;
    } on DioError catch (e) {
      throw DioExceptions.fromDioError(e).toString();
    }
  }
}
