import 'package:flutter/material.dart';
import 'package:food_delivery_app/data/model/food.dart';
import 'package:food_delivery_app/data/model/restaurant.dart';
import 'package:food_delivery_app/data/repository/home_page_repo.dart';

import 'package:food_delivery_app/presentation/screens/restaurant_detail_page/restaurant_detail_page.dart';
import 'package:food_delivery_app/presentation/widgets/foodcard.dart';
import 'package:food_delivery_app/presentation/widgets/restaurant_card.dart';

class HomePage extends StatelessWidget {
  HomePageRepository repository = HomePageRepository();
  HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.transparent,
        leading: IconButton(
          onPressed: () {},
          icon: const Icon(
            Icons.restaurant_menu_outlined,
            color: Colors.black,
          ),
        ),
        actions: [
          CircleAvatar(
            radius: 26,
            backgroundColor: Colors.black.withOpacity(0.4),
            child: const CircleAvatar(
              radius: 25,
              backgroundImage: AssetImage("assets/images/profile.PNG"),
            ),
          ),
          const SizedBox(
            width: 10,
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Text(
                    "Good Food ",
                    style: TextStyle(
                        color: Colors.blueGrey[800],
                        fontWeight: FontWeight.bold,
                        fontSize: 28),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Text(
                    "Fast Delivery",
                    style: TextStyle(
                        color: Colors.blueGrey[800],
                        fontWeight: FontWeight.bold,
                        fontSize: 28),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                const Padding(
                  padding: EdgeInsets.only(left: 8.0),
                  child: Text(
                    "Restaurants",
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w500,
                        fontSize: 20),
                  ),
                ),
                _buildRestaurantList(context),
                const SizedBox(
                  height: 15,
                ),
                const Padding(
                  padding: EdgeInsets.only(left: 8.0),
                  child: Text(
                    "🔥Special Orders🔥",
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w500,
                        fontSize: 20),
                  ),
                ),
                FutureBuilder(
                    future: repository.getDefaultFood(),
                    builder: (context, AsyncSnapshot<List<Food>> snapshot) {
                      if (snapshot.hasData) {
                        return _buildFoodListView(
                            context, snapshot.data!, 280, 230);
                      } else {
                        return CircularProgressIndicator();
                      }
                    }),
                const SizedBox(
                  height: 15,
                ),
                const Padding(
                  padding: EdgeInsets.only(left: 8.0),
                  child: Text(
                    "KFC Special",
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w500,
                        fontSize: 20),
                  ),
                ),
                _buildFoodListView(context, kfcList, 280, 200),
              ],
            ),
          ),
        ),
      ),
    );
  }

  SizedBox _buildRestaurantList(BuildContext context) {
    return SizedBox(
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
    );
  }

  SizedBox _buildFoodListView(
      BuildContext context, List<Food> foodList, double height, double width) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: height,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        itemBuilder: (context, index) {
          return FoodCard(
            food: foodList[index],
            height: height,
            width: width,
          );
        },
        itemCount: foodList.length,
      ),
    );
  }
}
