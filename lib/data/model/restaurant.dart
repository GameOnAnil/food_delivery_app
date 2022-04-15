import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:food_delivery_app/data/model/food.dart';

class Restaurant {
  String sId;
  String title;
  String description;
  String location;
  String deliveryTime;
  String logo;
  String defaultImage;
  List<Food> foodlist;
  Restaurant({
    required this.sId,
    required this.title,
    required this.description,
    required this.location,
    required this.deliveryTime,
    required this.logo,
    required this.defaultImage,
    required this.foodlist,
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
      'foodlist': foodlist.map((x) => x.toMap()).toList(),
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
      foodlist: List<Food>.from(map['foodlist']?.map((x) => Food.fromMap(x))),
    );
  }

  Restaurant copyWith({
    String? sId,
    String? title,
    String? description,
    String? location,
    String? deliveryTime,
    String? logo,
    String? defaultImage,
    List<Food>? foodlist,
  }) {
    return Restaurant(
      sId: sId ?? this.sId,
      title: title ?? this.title,
      description: description ?? this.description,
      location: location ?? this.location,
      deliveryTime: deliveryTime ?? this.deliveryTime,
      logo: logo ?? this.logo,
      defaultImage: defaultImage ?? this.defaultImage,
      foodlist: foodlist ?? this.foodlist,
    );
  }

  String toJson() => json.encode(toMap());

  factory Restaurant.fromJson(String source) =>
      Restaurant.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Restaurant(sId: $sId, title: $title, description: $description, location: $location, deliveryTime: $deliveryTime, logo: $logo, defaultImage: $defaultImage, foodlist: $foodlist)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Restaurant &&
        other.sId == sId &&
        other.title == title &&
        other.description == description &&
        other.location == location &&
        other.deliveryTime == deliveryTime &&
        other.logo == logo &&
        other.defaultImage == defaultImage &&
        listEquals(other.foodlist, foodlist);
  }

  @override
  int get hashCode {
    return sId.hashCode ^
        title.hashCode ^
        description.hashCode ^
        location.hashCode ^
        deliveryTime.hashCode ^
        logo.hashCode ^
        defaultImage.hashCode ^
        foodlist.hashCode;
  }
}
