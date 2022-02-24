class Food {
  int? id;
  String name;
  double price;
  String available;
  String address;
  double rating;
  String image;
  Food({
    this.id,
    required this.name,
    required this.price,
    required this.available,
    required this.address,
    required this.rating,
    required this.image,
  });
}

List<Food> foodList = [
  Food(
      name: "Pizza",
      price: 1000,
      available: "10 am to 7 pm",
      address: "Radhe Radhe",
      rating: 4.5,
      image: "assets/images/pizza_def.jpg"),
  Food(
      name: "Sekuwa",
      price: 1000,
      available: "10 am to 7 pm",
      address: "Radhe Radhe",
      rating: 4.5,
      image: "assets/images/sekuwa.jpeg"),
  Food(
      name: "Burger",
      price: 1000,
      available: "10 am to 7 pm",
      address: "Radhe Radhe",
      rating: 4.5,
      image: "assets/images/burger.jpeg"),
  Food(
      name: "Cake",
      price: 1000,
      available: "10 am to 7 pm",
      address: "Radhe Radhe",
      rating: 4.5,
      image: "assets/images/cake.jpeg"),
];
