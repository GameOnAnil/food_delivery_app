import 'dart:convert';

class Food {
  String sId;
  String name;
  int price;
  String available;
  String address;
  double rating;
  String image;
  int iV;
  Food({
    required this.sId,
    required this.name,
    required this.price,
    required this.available,
    required this.address,
    required this.rating,
    required this.image,
    required this.iV,
  });

  Map<String, dynamic> toMap() {
    return {
      '_id': sId,
      'name': name,
      'price': price,
      'available': available,
      'address': address,
      'rating': rating,
      'image': image,
      '__v': iV,
    };
  }

  factory Food.fromMap(Map<String, dynamic> map) {
    return Food(
      sId: map['_id'] ?? '',
      name: map['name'] ?? '',
      price: map['price']?.toInt() ?? 0,
      available: map['available'] ?? '',
      address: map['address'] ?? '',
      rating: map['rating']?.toDouble() ?? 0.0,
      image: map['image'] ?? '',
      iV: map['__v']?.toInt() ?? 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory Food.fromJson(String source) => Food.fromMap(json.decode(source));
}
