import 'dart:developer';

import 'package:food_delivery_app/data/model/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MySharedPreference {
  static late SharedPreferences _pref;

  static Future init() async => _pref = await SharedPreferences.getInstance();

  Future setUserDetail(
      {required String name,
      required String id,
      required String token,
      required String password}) async {
    _pref.setString("name", name);
    _pref.setString("id", id);
    _pref.setString("password", password);
    _pref.setString("token", token);
  }

  static String getToken() {
    return _pref.getString("token") ?? "";
  }

  Future<User> getUser() async {
    final name = _pref.getString("name");
    final id = _pref.getString("id");
    final password = _pref.getString("password");
    final user =
        User(id: id ?? "", name: name ?? "", password: password ?? "", v: 1);
    return user;
  }

  Future resetPref() async {
    log("reset called");
    _pref.clear();
  }

  static bool userExists() {
    final user = _pref.getString("id");
    if (user != null && user.isNotEmpty) {
      return true;
    }
    return false;
  }
}
