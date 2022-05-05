import 'dart:developer';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:food_delivery_app/data/model/auth_response.dart';
import 'package:food_delivery_app/provider/token_auth_provider.dart';
import 'package:food_delivery_app/utils/token_auth_service.dart';

abstract class LoginState {}

class LoginInitial extends LoginState {}

class LoginLoading extends LoginState {}

class LoginSuccess extends LoginState {
  final AuthResponse authResponse;

  LoginSuccess(this.authResponse);
}

class LoginFailure extends LoginState {
  final String exception;

  LoginFailure(this.exception);
}

final tokenAuthStateNotifierProvider =
    StateNotifierProvider<LoginNotifier, LoginState>((ref) {
  return LoginNotifier(LoginInitial(),
      authenticationService: ref.watch(tokenAuthProvider));
});

class LoginNotifier extends StateNotifier<LoginState> {
  final TokenAuthService authenticationService;

  LoginNotifier(state, {required this.authenticationService})
      : super(LoginInitial());

  Future<void> signIn(String email, String password) async {
    log("Signin called");
    try {
      state = LoginLoading();
      final response = await authenticationService.postLogin(
          email: email, password: password);
      if (response != null) {
        state = LoginSuccess(response);
      } else {
        state = LoginFailure("Opps something went wrong.");
      }
    } catch (e) {
      state = LoginFailure(e.toString());
    }
  }

  Future<void> resetState() async {
    state = LoginInitial();
  }
}
