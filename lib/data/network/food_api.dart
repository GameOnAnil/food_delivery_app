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
    const token =
        "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJfaWQiOiI2MjY3YWMwYTg4OWUxYjhmNWQwNjhhMzYiLCJuYW1lIjoiYW5pbDMiLCJwYXNzd29yZCI6IiQyYiQxMCRaY3FNeVlvTGJ5aDNGYUFic0w2d3BlYzhLU3ZkdmxTeU1ZdzVjSVoxeDY0bVl5OU9YNHp0MiIsIl9fdiI6MCwiaWF0IjoxNjUwOTcwODQwfQ.Lmuk-JUQlHocNL8Mr8CzKicTh3TeX2KhJUX-ZBvKEtI";
    try {
      _dio.options.headers["Authorization"] = "Bearer ${token}";
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
        const token =
        "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJfaWQiOiI2MjY3YWMwYTg4OWUxYjhmNWQwNjhhMzYiLCJuYW1lIjoiYW5pbDMiLCJwYXNzd29yZCI6IiQyYiQxMCRaY3FNeVlvTGJ5aDNGYUFic0w2d3BlYzhLU3ZkdmxTeU1ZdzVjSVoxeDY0bVl5OU9YNHp0MiIsIl9fdiI6MCwiaWF0IjoxNjUwOTcwODQwfQ.Lmuk-JUQlHocNL8Mr8CzKicTh3TeX2KhJUX-ZBvKEtI";
     _dio.options.headers["Authorization"] = "Bearer ${token}";
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
