import 'package:food_delivery_app/provider/auth_provider.dart';
import 'package:food_delivery_app/utils/firestore_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final firestoreServideProvider = Provider<FirestoreService>((ref) {
  var auth = ref.read(firebaseAuthProvider);
  var uid = auth.currentUser!.uid;
  return FirestoreService(uid);
});
