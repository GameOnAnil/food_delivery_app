import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:food_delivery_app/data/model/auth_response.dart';
import 'package:food_delivery_app/data/model/cart_item.dart';
import 'package:food_delivery_app/data/model/cart_response.dart';
import 'package:food_delivery_app/data/network/custom_exception.dart';
import 'package:food_delivery_app/utils/my_shared_pref.dart';

class TokenAuthService {
  TokenAuthService(this._dio);
  final Dio _dio;

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

        log("Auth model" + authModel.toString());
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
      log(response.toString());
    } on DioError catch (e) {
      log(DioExceptions.fromDioError(e).toString());
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
      return response.toString();
    } on DioError catch (e) {
      log(DioExceptions.fromDioError(e).toString());
      throw DioExceptions.fromDioError(e);
    } on SocketException {
      throw "No Internet Idiot";
    }
  }
}
