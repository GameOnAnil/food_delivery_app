import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

class CartFood {
  String id;
  String name;
  String image;
  int price;
  int quantity;
  CartFood({
    required this.id,
    required this.name,
    required this.image,
    required this.price,
    required this.quantity,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'image': image,
      'price': price,
      'quantity': quantity,
    };
  }

  factory CartFood.fromMap(Map<String, dynamic> map) {
    return CartFood(
      id: map['id'] ?? '',
      name: map['name'] ?? '',
      image: map['image'] ?? '',
      price: map['price']?.toInt() ?? 0,
      quantity: map['quantity']?.toInt() ?? 0,
    );
  }

  CartFood.fromDocumentSnapshot(DocumentSnapshot<Map<String, dynamic>> doc)
      : id = doc.id,
        name = doc.data()!["name"],
        image = doc.data()!["image"],
        price = doc.data()!["price"],
        quantity = doc.data()!["quantity"];

  String toJson() => json.encode(toMap());

  factory CartFood.fromJson(String source) =>
      CartFood.fromMap(json.decode(source));

  CartFood copyWith({
    String? id,
    String? name,
    String? image,
    int? price,
    int? quantity,
  }) {
    return CartFood(
      id: id ?? this.id,
      name: name ?? this.name,
      image: image ?? this.image,
      price: price ?? this.price,
      quantity: quantity ?? this.quantity,
    );
  }

  @override
  String toString() {
    return 'CartFood(id: $id, name: $name, image: $image, price: $price, quantity: $quantity)';
  }
}

final dummyCartList = [
  CartFood(id: "a", name: "Pizza", image: "pizza_def", price: 500, quantity: 2),
  CartFood(id: "a", name: "Coke", image: "coke", price: 100, quantity: 1),
  CartFood(id: "a", name: "Cake", image: "cake", price: 700, quantity: 1),
];
