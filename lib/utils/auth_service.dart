import 'package:firebase_auth/firebase_auth.dart';

class AuthenticationService {
  final FirebaseAuth _firebaseAuth;
  AuthenticationService(this._firebaseAuth);

  Stream<User?> get authUserState => _firebaseAuth.authStateChanges();

  Future<String> signIn(
      {required String email, required String password}) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      return "Signed In";
    } on FirebaseAuthException catch (e) {
      return e.message ?? "Unknown Error";
    }
  }

  Future<String> signUp(
      {required String email, required String password}) async {
    try {
      await _firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);
      await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      return "Signed Up";
    } on FirebaseAuthException catch (e) {
      return e.message ?? "Unknown Error";
    }
  }

  Future<String> signOut() async {
    try {
      await _firebaseAuth.signOut();
      return "Signed Out";
    } on FirebaseAuthException catch (e) {
      return e.message ?? "Unknown Error";
    }
  }
}
