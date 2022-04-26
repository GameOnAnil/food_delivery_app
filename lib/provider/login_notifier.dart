import 'dart:developer';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:food_delivery_app/provider/auth_provider.dart';
import 'package:food_delivery_app/utils/auth_service.dart';

abstract class LoginState {}

class LoginInitial extends LoginState {}

class LoginLoading extends LoginState {}

class LoginSuccess extends LoginState {
  final String message;

  LoginSuccess(this.message);
}

class LoginFailure extends LoginState {
  final String exception;

  LoginFailure(this.exception);
}

final loginStateNotifierProvider =
    StateNotifierProvider<LoginNotifier, LoginState>((ref) {
  return LoginNotifier(LoginInitial(),
      authenticationService: ref.watch(authServiceProvider));
});

class LoginNotifier extends StateNotifier<LoginState> {
  final AuthenticationService authenticationService;

  LoginNotifier(state, {required this.authenticationService})
      : super(LoginInitial());

  Future<void> signIn(String email, String password) async {
    log("Signin called");
    try {
      state = LoginLoading();
      final response =
          await authenticationService.signIn(email: email, password: password);
      if (response == "Signed In") {
        state = LoginSuccess(response);
      } else {
        state = LoginFailure(response);
      }
    } on Exception catch (e) {
      state = LoginFailure(e.toString());
    }
  }

  Future<void> signInWithGoogle() async {
    try {
      state = LoginLoading();
      final response = await authenticationService.signInwithGoogle();
      if (response == "Success") {
        state = LoginSuccess(response);
      } else {
        state = LoginFailure(response);
      }
    } on Exception catch (e) {
      state = LoginFailure(e.toString());
    }
  }

  void reset() {
    state = LoginInitial();
  }
}
