import 'package:flutter/material.dart';
import 'package:food_delivery_app/data/model/food.dart';
import 'package:food_delivery_app/data/model/restaurant.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(10),
            child: Column(
              children: [
                const Text(
                  "Good Food Fast Delivery",
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 24),
                ),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: 230,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return RestaurantCard(
                        restaurant: restaurantLists[index],
                      );
                    },
                    itemCount: restaurantLists.length,
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: 300,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return FoodCard(
                        food: foodList[index],
                      );
                    },
                    itemCount: foodList.length,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class FoodCard extends StatelessWidget {
  final Food food;
  const FoodCard({
    Key? key,
    required this.food,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15),
        child: Stack(alignment: Alignment.bottomLeft, children: [
          Image.asset(
            food.image,
            fit: BoxFit.cover,
            height: 300,
            width: 250,
          ),
          Container(
            width: 250,
            height: 130,
            color: Colors.black.withOpacity(0.2),
          ),
          Positioned(
            bottom: 0,
            right: 0,
            left: 0,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        food.name,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 35,
                            color: Colors.white),
                      ),
                      Text(
                        "Rs. ${food.price}",
                        style: TextStyle(
                            fontSize: 20,
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.electric_scooter,
                        color: Colors.white,
                      ),
                      Text(
                        ": " + food.available,
                        style: TextStyle(fontSize: 20, color: Colors.white),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.location_city,
                        color: Colors.white,
                      ),
                      Text(
                        ": " + food.address,
                        style: TextStyle(fontSize: 20, color: Colors.white),
                      ),
                    ],
                  ),
                  Text(
                    "☆ ☆ ☆ ☆ ☆",
                    style: TextStyle(fontSize: 20, color: Colors.white),
                  )
                ],
              ),
            ),
          ),
        ]),
      ),
    );
  }
}

class RestaurantCard extends StatelessWidget {
  Restaurant restaurant;
  RestaurantCard({
    Key? key,
    required this.restaurant,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, "/restaurantDetail");
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5.0),
        child: ClipRRect(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(10),
            topRight: Radius.circular(10),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.asset(
                restaurant.defaultImage,
                fit: BoxFit.cover,
                height: 150,
                width: 250,
              ),
              Container(
                width: 250,
                decoration: BoxDecoration(
                    border: Border.all(width: 1, color: Colors.black38)),
                padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                child: Row(
                  children: [
                    Image.asset(
                      restaurant.logo,
                      width: 50,
                      height: 50,
                      fit: BoxFit.cover,
                    ),
                    const SizedBox(width: 10),
                    Container(
                      height: 50,
                      width: 1,
                      color: Colors.black.withOpacity(0.5),
                    ),
                    const SizedBox(width: 10),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(restaurant.title),
                        Text(restaurant.deliveryTime),
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
