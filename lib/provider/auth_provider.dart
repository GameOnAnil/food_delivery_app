import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:food_delivery_app/utils/auth_service.dart';

final firebaseAuthProvider =
    Provider<FirebaseAuth>((ref) => FirebaseAuth.instance);

final authServiceProvider = Provider<AuthenticationService>((ref) {
  var auth = ref.read(firebaseAuthProvider);
  return AuthenticationService(auth);
});

final authStateProvider = StreamProvider((ref) {
  return ref.watch(authServiceProvider).authUserState;
});
