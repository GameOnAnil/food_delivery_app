import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:food_delivery_app/data/model/cart_food.dart';

class FirestoreService {
  final String userId;
  FirestoreService(this.userId);


  Future<void> insertFood(CartFood cartFood) async {
    final collectionRef = FirebaseFirestore.instance
        .collection("cart")
        .doc(userId)
        .collection("foodlist");
    final newUser = cartFood.toMap();
    await collectionRef
        .doc(cartFood.id)
        .set(newUser)
        .then(
            (value) => Fluttertoast.showToast(msg: "Entry Added Successfully"))
        .catchError((e) =>
            Fluttertoast.showToast(msg: "Error Adding Data:" + e.toString()));
  }

  Future<void> updateFood(CartFood cartFood) async {
    final collectionRef = FirebaseFirestore.instance
        .collection("cart")
        .doc(userId)
        .collection("foodlist");
    final newUser = cartFood.toMap();
    //todo..................`
    collectionRef
        .doc(cartFood.id)
        .set(newUser)
        .catchError((e) => Fluttertoast.showToast(msg: "Error" + e.toString()));
  }

  Future<void> deleteFood(CartFood cartFood) async {
    await FirebaseFirestore.instance
        .collection("cart")
        .doc(userId)
        .collection("foodlist")
        .doc(cartFood.id)
        .delete()
        .then(
            (value) => Fluttertoast.showToast(msg: "Food Deleted Successfully"))
        .catchError((e) => Fluttertoast.showToast(msg: "Error" + e.toString()));
  }
}
