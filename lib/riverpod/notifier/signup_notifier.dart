import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:food_delivery_app/data/network/auth_api.dart';
import 'package:food_delivery_app/riverpod/providers/providers.dart';

abstract class SignupState {}

class SignupInitial extends SignupState {
  SignupInitial();
}

class SignupLoading extends SignupState {}

class SignupSuccess extends SignupState {
  final String message;

  SignupSuccess(this.message);
}

class SignupFailure extends SignupState {
  final String exception;

  SignupFailure(this.exception);
}

final signUpNotifierProvider =
    StateNotifierProvider<SignupNotifier, SignupState>(((ref) {
  return SignupNotifier(SignupInitial(),
      authService: ref.watch(authServiceProvider));
}));

class SignupNotifier extends StateNotifier<SignupState> {
  final AuthService authService;

  SignupNotifier(state, {required this.authService}) : super(SignupInitial());

  Future<void> signUp(String name, String email, String password) async {
    try {
      state = SignupLoading();
      final response = await authService.signUp(
          name: name, email: email, password: password);
      if (response == "Success") {
        state = SignupSuccess(response);
      } else {
        state = SignupFailure(response);
      }
    } catch (e) {
      state = SignupFailure(e.toString());
    }
  }

  void reset() {
    state = SignupInitial();
  }
}
