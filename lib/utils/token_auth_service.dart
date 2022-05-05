import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:food_delivery_app/data/model/auth_response.dart';
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
}
