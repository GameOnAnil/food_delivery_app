import 'package:dio/dio.dart';
import 'package:food_delivery_app/data/model/auth_response.dart';
import 'package:food_delivery_app/data/network/custom_exception.dart';
import 'package:food_delivery_app/utils/constants.dart';
import 'package:food_delivery_app/utils/my_shared_pref.dart';

class AuthService {
  final Dio _dio;

  AuthService(this._dio);

  Future<AuthResponse?> signIn(
      {required String email, required String password}) async {
    try {
      final response = await _dio.post("${AppConstants.BASE_URL}/users/login",
          data: {"email": email, "password": password});

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

  Future<String> signUp(
      {required String name,
      required String email,
      required String password}) async {
    try {
      final response = await _dio.post("${AppConstants.BASE_URL}/users/signup",
          data: {"name": name, "email": email, "password": password});
      if (response.statusCode == 200) {
        return "Success";
      }
      return response.toString();
    } on DioError catch (e) {
      if (e.response!.statusCode == 400) {
        return e.response.toString();
      }
      return DioExceptions.fromDioError(e).toString();
    } on Exception catch (e) {
      return e.toString();
    }
  }
}
