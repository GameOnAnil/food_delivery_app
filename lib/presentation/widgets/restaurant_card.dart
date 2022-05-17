import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
                height: 150.h,
                width: 250.w,
              ),
              Container(
                width: 250.w,
                decoration: BoxDecoration(
                    border: Border.all(width: 1, color: Colors.black38)),
                padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                child: Row(
                  children: [
                    Image.asset(
                      "assets/images/" + restaurant.logo,
                      width: 50.w,
                      height: 50.h,
                      fit: BoxFit.cover,
                    ),
                    SizedBox(width: 10.w),
                    Container(
                      height: 50.w,
                      width: 1.w,
                      color: Colors.black.withOpacity(0.5),
                    ),
                    SizedBox(width: 10.w),
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
