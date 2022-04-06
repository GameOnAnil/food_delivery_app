import 'dart:convert';

class Restaurant {
  String sId;
  String title;
  String description;
  String location;
  String deliveryTime;
  String logo;
  String defaultImage;
  Restaurant({
    required this.sId,
    required this.title,
    required this.description,
    required this.location,
    required this.deliveryTime,
    required this.logo,
    required this.defaultImage,
  });

  Map<String, dynamic> toMap() {
    return {
      'sId': sId,
      'title': title,
      'description': description,
      'location': location,
      'deliveryTime': deliveryTime,
      'logo': logo,
      'defaultImage': defaultImage,
    };
  }

  factory Restaurant.fromMap(Map<String, dynamic> map) {
    return Restaurant(
      sId: map['sId'] ?? '',
      title: map['title'] ?? '',
      description: map['description'] ?? '',
      location: map['location'] ?? '',
      deliveryTime: map['deliveryTime'] ?? '',
      logo: map['logo'] ?? '',
      defaultImage: map['defaultImage'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory Restaurant.fromJson(String source) =>
      Restaurant.fromMap(json.decode(source));
}
