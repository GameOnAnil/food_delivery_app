import 'package:flutter/material.dart';
import 'package:food_delivery_app/data/model/restaurant.dart';
import 'package:food_delivery_app/presentation/screens/restaurant_detail_page.dart';

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
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    RestaurantDetailsPage(restaurant: restaurant)));
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
                "assets/images/${restaurant.defaultImage}",
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
                      "assets/images/" + restaurant.logo,
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
