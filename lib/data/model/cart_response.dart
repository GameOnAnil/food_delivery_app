import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:food_delivery_app/data/model/cart_item.dart';

class CartResponse {
  String id;
  List<CartItem>? foodlist;
  CartResponse({
    required this.id,
    this.foodlist,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'foodlist': foodlist?.map((x) => x.toMap()).toList(),
    };
  }

  factory CartResponse.fromMap(Map<String, dynamic> map) {
    return CartResponse(
      id: map['id'] ?? '',
      foodlist: map['foodlist'] != null
          ? List<CartItem>.from(
              map['foodlist']?.map((x) => CartItem.fromMap(x)))
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory CartResponse.fromJson(String source) =>
      CartResponse.fromMap(json.decode(source));

  CartResponse copyWith({
    String? id,
    List<CartItem>? foodlist,
  }) {
    return CartResponse(
      id: id ?? this.id,
      foodlist: foodlist ?? this.foodlist,
    );
  }

  @override
  String toString() => 'CartResponse(id: $id, foodlist: $foodlist)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is CartResponse &&
        other.id == id &&
        listEquals(other.foodlist, foodlist);
  }

  @override
  int get hashCode => id.hashCode ^ foodlist.hashCode;
}
