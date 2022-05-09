import 'dart:developer';

import 'package:food_delivery_app/utils/my_shared_pref.dart';
import 'package:google_sign_in/google_sign_in.dart';

class FirebaseService {
  final googleSignIn = GoogleSignIn();
  final MySharedPreference mySharedPreference = MySharedPreference();

  FirebaseService();

  Future<void> signIn() async {
    await googleSignIn.signIn().then((result) {
      result?.authentication.then((value) async {
        await MySharedPreference().setUserDetail(
            name: result.displayName ?? "",
            id: result.id,
            token: value.idToken!);
        return "Success";
      }).catchError((er) {
        log(er);
        throw er;
      });
    }).catchError((err) {
      log(err);
      throw err;
    });
  }
}
