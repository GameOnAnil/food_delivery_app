import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:food_delivery_app/data/model/cart_food.dart';

class FirestoreService {
  FirestoreService();
  Future<void> insertDate() async {
    final collectionRef = FirebaseFirestore.instance
        .collection("cart")
        .doc("qwdfXDfZFhQcWvj80IGCiQOAJOD2")
        .collection("foodlist");
    final newUser = CartFood(
            id: "b",
            name: "Pizza",
            image: "pizza_def",
            price: 1000,
            quantity: 1)
        .toMap();
    await collectionRef
        .doc()
        .set(newUser)
        .then(
            (value) => Fluttertoast.showToast(msg: "Entry Added Successfully"))
        .catchError((e) =>
            Fluttertoast.showToast(msg: "Error Adding Data:" + e.toString()));
  }

  Future<void> getData() async {}
}
