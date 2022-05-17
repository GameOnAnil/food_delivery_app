import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:food_delivery_app/data/model/restaurant.dart';
import 'package:food_delivery_app/presentation/widgets/horizontal_food_tile.dart';
import 'package:food_delivery_app/presentation/widgets/text_with_icon.dart';

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
                height: 20.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.restaurant_menu,
                    color: Colors.red,
                  ),
                  SizedBox(
                    width: 4.w,
                  ),
                  Text(
                    "MENU",
                    style: TextStyle(
                        color: Colors.black.withOpacity(0.8),
                        fontWeight: FontWeight.w500,
                        fontSize: 25.sp),
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
                    return HorizontalFoodTile(food: restaurant.foodlist[index]);
                  },
                  itemCount: restaurant.foodlist.length,
                ),
              )
            ],
          ),
        ));
  }

  Widget _buildDescription() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 8.0.r),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            restaurant.title,
            style: TextStyle(
              color: Colors.black.withOpacity(0.7),
              fontWeight: FontWeight.w900,
              fontSize: 35.sp,
            ),
          ),
          TextWithIcon(
            icon: Icon(
              Icons.location_on,
              color: Colors.black.withOpacity(0.5),
            ),
            text: restaurant.location,
          ),
          SizedBox(height: 15.h),
          Text(
            "About Restaurant",
            style: TextStyle(
              color: Colors.black.withOpacity(0.7),
              fontWeight: FontWeight.w900,
              fontSize: 25.sp,
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
                icon: Icon(
                  Icons.local_taxi,
                  size: 30.r,
                ),
                text: restaurant.deliveryTime.toString(),
              ),
              SizedBox(width: 10.w),
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
              image: AssetImage("assets/images/${restaurant.defaultImage}"),
              fit: BoxFit.cover)),
      height: 280.h,
      child: Stack(
        alignment: Alignment.topCenter,
        children: [
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              height: 50.h,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30.r),
                  topRight: Radius.circular(30.r),
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            child: Container(
              padding: EdgeInsets.all(20.r),
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.black45, width: 1),
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(50)),
              height: 100.h,
              width: 100.w,
              child: Image.asset(
                "assets/images/${restaurant.logo}",
                fit: BoxFit.contain,
              ),
            ),
          )
        ],
      ),
    );
  }
}
