import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:food_delivery_app/data/model/cart_food.dart';

class FirestoreService {
  final String userId;
  FirestoreService(this.userId);
  Future<void> insertDate(CartFood cartFood) async {
    final collectionRef = FirebaseFirestore.instance
        .collection("cart")
        .doc(userId)
        .collection("foodlist");
    final newUser = cartFood.toMap();
    await collectionRef
        .doc()
        .set(newUser)
        .then(
            (value) => Fluttertoast.showToast(msg: "Entry Added Successfully"))
        .catchError((e) =>
            Fluttertoast.showToast(msg: "Error Adding Data:" + e.toString()));
  }

  Future<void> updateData() async {}
}
