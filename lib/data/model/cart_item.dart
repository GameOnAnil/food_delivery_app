import 'dart:convert';

class CartItem {
  String id;
  String name;
  int price;
  String image;
  int quantity;
  CartItem({
    required this.id,
    required this.name,
    required this.price,
    required this.image,
    required this.quantity,
  });

  Map<String, dynamic> toMap() {
    return {
      '_id': id,
      'name': name,
      'price': price,
      'image': image,
      'quantity': quantity,
    };
  }

  factory CartItem.fromMap(Map<String, dynamic> map) {
    return CartItem(
      id: map['_id'] ?? '',
      name: map['name'] ?? '',
      price: map['price']?.toInt() ?? 0,
      image: map['image'] ?? '',
      quantity: map['quantity']?.toInt() ?? 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory CartItem.fromJson(String source) =>
      CartItem.fromMap(json.decode(source));

  CartItem copyWith({
    String? id,
    String? name,
    int? price,
    String? image,
    int? quantity,
  }) {
    return CartItem(
      id: id ?? this.id,
      name: name ?? this.name,
      price: price ?? this.price,
      image: image ?? this.image,
      quantity: quantity ?? this.quantity,
    );
  }
}
