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
}

List<Restaurant> restaurantLists = [
  Restaurant(
      title: "KFC",
      description:
          "KFC is an American fast food restaurant chain headquartered in Louisville, Kentucky that specializes in fried chicken.",
      location: "Ghattaghar, Bhaktapur",
      deliveryTime: "10am to 7 pm",
      logo: 'assets/images/kfc_logo.png',
      defaultImage: "assets/images/kfc_default.jpg"),
  Restaurant(
      title: "Pizza Hut",
      description:
          "KFC is an American fast food restaurant chain headquartered in Louisville, Kentucky that specializes in fried chicken.",
      location: "Ghattaghar, Bhaktapur",
      deliveryTime: "10am to 7 pm",
      logo: 'assets/images/pizza_logo.png',
      defaultImage: "assets/images/pizza_def.jpg"),
  Restaurant(
      title: "Bajeko Sekuwa",
      description:
          "KFC is an American fast food restaurant chain headquartered in Louisville, Kentucky that specializes in fried chicken.",
      location: "Ghattaghar, Bhaktapur",
      deliveryTime: "10am to 7 pm",
      logo: 'assets/images/kfc_logo.png',
      defaultImage: "assets/images/kfc_default.jpg"),
];
