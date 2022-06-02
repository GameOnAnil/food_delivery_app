import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:food_delivery_app/data/model/food.dart';
import 'package:food_delivery_app/data/model/restaurant.dart';
import 'package:food_delivery_app/presentation/screens/cart_list_page.dart';
import 'package:food_delivery_app/presentation/screens/login_page.dart';
import 'package:food_delivery_app/presentation/widgets/foodcard.dart';
import 'package:food_delivery_app/presentation/widgets/restaurant_card.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:food_delivery_app/riverpod/providers/foodprovider.dart';
import 'package:food_delivery_app/utils/my_shared_pref.dart';

class HomePage extends ConsumerWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.transparent,
        leadingWidth: 80.w,
        leading: Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: Center(
            child: CircleAvatar(
              radius: 23.r,
              backgroundColor: Colors.black.withOpacity(0.4),
              child: CircleAvatar(
                radius: 22.r,
                backgroundImage: const AssetImage("assets/images/profile.PNG"),
              ),
            ),
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    settings: const RouteSettings(name: "/cartlist"),
                    builder: (context) => const CartListPage(),
                  ));
            },
            icon: Icon(
              Icons.shopping_cart,
              color: Colors.black,
              size: 30.r,
            ),
          ),
          IconButton(
            onPressed: () async {
              await MySharedPreference().resetPref();
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: ((context) => const LoginPage())),
                ModalRoute.withName('/login'),
              );
              // ref.read(authServiceProvider).signOut();
            },
            icon: const Icon(
              Icons.logout,
              color: Colors.black,
            ),
          ),
          SizedBox(
            width: 10.w,
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
                _header(),
                SizedBox(
                  height: 10.h,
                ),
                _restaurantPart(),
                _specialOrderPart(),
                SizedBox(
                  height: 15.h,
                ),
                _kfcSpecialPart(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Column _kfcSpecialPart() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: Text(
            "🍟 KFC Special 🍟",
            style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w500,
                fontSize: 20.sp),
          ),
        ),
        Consumer(
          builder: (context, ref, child) {
            return ref.watch(kfcFutureProvider).when(
                  error: (e, s) => Center(
                    child: Text("ERROR: ${e.toString()}"),
                  ),
                  loading: () => const Center(
                    child: CircularProgressIndicator(),
                  ),
                  data: (foods) {
                    if (foods != null) {
                      return RefreshIndicator(
                          onRefresh: () {
                            return ref.refresh(kfcFutureProvider.future);
                          },
                          child:
                              _buildFoodListView(context, foods, 270.h, 185.w));
                    }

                    return const Text("No Data");
                  },
                );
          },
        ),
      ],
    );
  }

  Column _specialOrderPart() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: Text(
            "🔥Special Orders🔥",
            style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w500,
                fontSize: 20.sp),
          ),
        ),
        Consumer(
          builder: (context, ref, child) {
            return ref.watch(foodFutureProvider).when(
                  error: (e, s) => Center(
                    child: Text("ERROR: ${e.toString()}"),
                  ),
                  loading: () => const Center(
                    child: CircularProgressIndicator(),
                  ),
                  data: (foods) {
                    if (foods != null) {
                      return RefreshIndicator(
                          onRefresh: () {
                            return ref.refresh(foodFutureProvider.future);
                          },
                          child:
                              _buildFoodListView(context, foods, 270.h, 185.w));
                    }

                    return const Text("No Data");
                  },
                );
          },
        ),
      ],
    );
  }

  Widget _restaurantPart() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: Text(
            "🍔 Restaurants 🍔",
            style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w500,
                fontSize: 20.sp),
          ),
        ),
        //_buildRestaurantList(context,restaurants,),
        Consumer(
          builder: (context, ref, child) {
            return ref.watch(restaurantFutureProvider).when(
                  error: (e, s) => Center(
                    child: Text("ERROR: ${e.toString()}"),
                  ),
                  loading: () => const Center(
                    child: CircularProgressIndicator(),
                  ),
                  data: (restaurants) {
                    if (restaurants != null) {
                      return RefreshIndicator(
                          onRefresh: () {
                            return ref.refresh(restaurantFutureProvider.future);
                          },
                          child: _buildRestaurantList(
                              context, restaurants, 240.h, 200.w));
                    }
                    return const Text("No Data");
                  },
                );
          },
        ),
      ],
    );
  }

  Column _header() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: Text(
            "Good Food ",
            style: TextStyle(
                color: Colors.blueGrey[800],
                fontWeight: FontWeight.bold,
                fontSize: 28.sp),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: Text(
            "Fast Delivery",
            style: TextStyle(
                color: Colors.blueGrey[800],
                fontWeight: FontWeight.bold,
                fontSize: 28.sp),
          ),
        ),
      ],
    );
  }

  Widget _buildRestaurantList(BuildContext context,
      List<Restaurant> restaurants, double height, double width) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: height,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        itemBuilder: (context, index) {
          return RestaurantCard(
            restaurant: restaurants[index],
          );
        },
        itemCount: restaurants.length,
      ),
    );
  }

  Widget _buildFoodListView(
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
