import 'dart:convert';

class Restaurant {
  int? id;
  String title;
  String description;
  String location;
  String deliveryTime;
  String logo;
  String defaultImage;
  Restaurant({
    this.id,
    required this.title,
    required this.description,
    required this.location,
    required this.deliveryTime,
    required this.logo,
    required this.defaultImage,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
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
      id: map['id']?.toInt(),
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

List<Restaurant> restaurantLists = [
  Restaurant(
      title: "Bajeko Sekuwa",
      description:
          "KFC is an American fast food restaurant chain headquartered in Louisville, Kentucky that specializes in fried chicken.",
      location: "Ghattaghar, Bhaktapur",
      deliveryTime: "10am to 7 pm",
      logo: 'assets/images/bajeko_logo.png',
      defaultImage: "assets/images/bajeko_default.jpg"),
  Restaurant(
      title: "Pizza Hut",
      description:
          "Pizza Hut is an American multinational restaurant chain and international franchise founded in 1958 in Wichita, Kansas by Dan and Frank Carney..",
      location: "Radhe, Radhe",
      deliveryTime: "10am to 5 pm",
      logo: 'assets/images/pizza_logo.png',
      defaultImage: "assets/images/pizza_def.jpeg"),
  Restaurant(
      title: "KFC",
      description:
          "KFC is an American fast food restaurant chain headquartered in Louisville, Kentucky that specializes in fried chicken.",
      location: "Ghattaghar, Bhaktapur",
      deliveryTime: "10am to 7 pm",
      logo: 'assets/images/kfc_logo.png',
      defaultImage: "assets/images/kfc_default.jpeg"),
];
