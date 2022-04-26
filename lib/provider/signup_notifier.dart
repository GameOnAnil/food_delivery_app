import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:food_delivery_app/provider/auth_provider.dart';

import '../utils/auth_service.dart';

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
      authenticationService: ref.watch(authServiceProvider));
}));

class SignupNotifier extends StateNotifier<SignupState> {
  final AuthenticationService authenticationService;

  SignupNotifier(state, {required this.authenticationService})
      : super(SignupInitial());

  Future<void> signUp(String email, String password) async {
    try {
      state = SignupLoading();
      final response =
          await authenticationService.signUp(email: email, password: password);
      if (response == "Success") {
        state = SignupSuccess(response);
      } else {
        state = SignupFailure(response);
      }
    } on Exception catch (e) {
      state = SignupFailure(e.toString());
    }
  }

  void reset() {
    state = SignupInitial();
  }
}
