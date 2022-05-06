import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:food_delivery_app/data/model/auth_response.dart';
import 'package:food_delivery_app/data/model/cart_item.dart';
import 'package:food_delivery_app/data/model/cart_response.dart';
import 'package:food_delivery_app/data/model/food.dart';
import 'package:food_delivery_app/data/model/restaurant.dart';
import 'package:food_delivery_app/utils/my_shared_pref.dart';

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
      _dio.options.headers["Authorization"] = "Bearer $token";
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
    _dio.options.headers["Authorization"] = "Bearer $token";
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

  Future<AuthResponse?> postLogin(
      {required String email, required String password}) async {
    try {
      final response = await _dio.post(
          "https://food-api-mongo.herokuapp.com/users/login",
          data: {"name": email, "password": password});

      // final response = await _dio.post("http://192.168.1.79:3000/users/login",
      //     data: {"name": email, "password": password});
      if (response.statusCode == 200) {
        final jsonResult = Map<String, dynamic>.from(response.data);
        final authModel = AuthResponse.fromMap(jsonResult);

        await MySharedPreference().setUserDetail(
            name: authModel.user.name,
            id: authModel.user.id,
            password: authModel.user.password,
            token: authModel.token);
        return authModel;
      }
      return null;
    } on DioError catch (e) {
      final statusCode = e.response?.statusCode!;
      if (statusCode == 500 || statusCode == 400) {
        throw e.response ?? "Unknown error";
      }
      throw DioExceptions.fromDioError(e).toString();
    } on Exception catch (e) {
      throw e.toString();
    }
  }

  Future<List<CartItem>?> getCartItem() async {
    final user = await MySharedPreference().getUser();
    try {
      final response = await _dio
          .get("https://food-api-mongo.herokuapp.com/carts/${user.id}");

      final jsonResult = Map<String, dynamic>.from(response.data);

      CartResponse cartResponse = CartResponse.fromMap(jsonResult);
      return cartResponse.foodlist;
    } on DioError catch (e) {
      throw DioExceptions.fromDioError(e);
    } on SocketException {
      throw "No Internet Idiot";
    }
  }

  Future<void> editCartItem(CartResponse newRes) async {
    final user = await MySharedPreference().getUser();
    try {
      final response = await _dio.patch(
          "https://food-api-mongo.herokuapp.com/carts/${user.id}",
          data: newRes.toMap());
    } on DioError catch (e) {
      throw DioExceptions.fromDioError(e);
    } on SocketException {
      throw "No Internet Idiot";
    }
  }

  Future<String> updateList(List<CartItem> cartList) async {
    final user = await MySharedPreference().getUser();
    final newRes = CartResponse(id: user.id, foodlist: cartList).toMap();

    try {
      final response = await _dio.patch(
          "https://food-api-mongo.herokuapp.com/carts/${user.id}",
          data: newRes);
      if (response.statusCode == 200) {
        return "Success";
      } else {
        return response.toString();
      }
    } on DioError catch (e) {
      return DioExceptions.fromDioError(e).message;
    } on SocketException {
      return "No Internet Idiot";
    }
  }

  Future<String> insertIntoCart(
      CartItem cartItem, List<CartItem> cartList) async {
    final user = await MySharedPreference().getUser();
    List<CartItem> newList = cartList;
    newList.add(cartItem);
    final newRes = CartResponse(id: user.id, foodlist: newList).toMap();

    try {
      final response = await _dio.patch(
          "https://food-api-mongo.herokuapp.com/carts/${user.id}",
          data: newRes);
      log("Response code" + response.statusCode.toString());
      return "Success";
    } on DioError catch (e) {
      return DioExceptions.fromDioError(e).message;
    } on SocketException {
      return "No Internet Idiot";
    }
  }
}
