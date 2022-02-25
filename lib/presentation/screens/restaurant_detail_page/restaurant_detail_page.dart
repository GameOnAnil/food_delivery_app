import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:food_delivery_app/data/model/food.dart';
import 'package:food_delivery_app/data/model/restaurant.dart';
import 'package:food_delivery_app/presentation/screens/food_detail_page/food_detail_page.dart';
import 'package:food_delivery_app/presentation/widgets/horizontal_food_tile.dart';

class RestaurantDetailsPage extends StatelessWidget {
  final Restaurant restaurant;
  const RestaurantDetailsPage({Key? key, required this.restaurant})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          elevation: 0,
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          backgroundColor: Colors.transparent,
        ),
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              _buildHeader(),
              _buildDescription(),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.restaurant_menu,
                    color: Colors.red,
                  ),
                  const SizedBox(
                    width: 4,
                  ),
                  Text(
                    "MENU",
                    style: TextStyle(
                        color: Colors.black.withOpacity(0.8),
                        fontWeight: FontWeight.w500,
                        fontSize: 25),
                  )
                ],
              ),
              MediaQuery.removePadding(
                removeTop: true,
                context: context,
                child: ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  scrollDirection: Axis.vertical,
                  itemBuilder: (context, index) {
                    return HorizontalFoodTile(
                      food: restaurant.title == "KFC"
                          ? kfcList[index]
                          : foodList[index],
                    );
                  },
                  itemCount: foodList.length,
                ),
              )
            ],
          ),
        ));
  }

  Widget _buildDescription() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            restaurant.title,
            style: TextStyle(
              color: Colors.black.withOpacity(0.7),
              fontWeight: FontWeight.w900,
              fontSize: 35,
            ),
          ),
          TextWithIcon(
            icon: Icon(
              Icons.location_on,
              color: Colors.black.withOpacity(0.5),
            ),
            text: restaurant.location,
          ),
          const SizedBox(height: 15),
          Text(
            "About Restaurant",
            style: TextStyle(
              color: Colors.black.withOpacity(0.7),
              fontWeight: FontWeight.w900,
              fontSize: 25,
            ),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Text(
              "KFC is an American fast food restaurant chain headquartered in Louisville, Kentucky that specializes in fried chicken. It is the world's second-largest restaurant chain after McDonald's, with 22,621 locations globally in 150 countries as of December 2019. ",
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              TextWithIcon(
                icon: const Icon(
                  Icons.local_taxi,
                  size: 30,
                ),
                text: restaurant.deliveryTime.toString(),
              ),
              const SizedBox(width: 10),
              const TextWithIcon(
                icon: Icon(
                  Icons.food_bank,
                  color: Colors.red,
                ),
                text: "Fast Food",
              ),
              const SizedBox(width: 10),
              const TextWithIcon(
                icon: Icon(
                  Icons.star,
                  color: Colors.yellow,
                ),
                text: "4",
              ),
            ],
          ),
        ],
      ),
    );
  }

  Container _buildHeader() {
    return Container(
      decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage(restaurant.defaultImage), fit: BoxFit.cover)),
      height: 280,
      child: Stack(
        alignment: Alignment.topCenter,
        children: [
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              height: 50,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            child: Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.black45, width: 1),
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(50)),
              height: 100,
              width: 100,
              child: Image.asset(
                restaurant.logo,
                fit: BoxFit.contain,
              ),
            ),
          )
        ],
      ),
    );
  }
}
