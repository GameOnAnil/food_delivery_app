import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:food_delivery_app/data/model/cart_item.dart';
import 'package:food_delivery_app/data/model/food.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:food_delivery_app/data/network/food_api.dart';
import 'package:food_delivery_app/presentation/screens/cart_list_page.dart';
import 'package:food_delivery_app/presentation/widgets/text_with_icon.dart';
import 'package:food_delivery_app/riverpod/notifier/food_detail_notifier.dart';
import 'package:food_delivery_app/riverpod/providers/providers.dart';

class FoodDetailPage extends ConsumerStatefulWidget {
  final Food food;
  const FoodDetailPage({Key? key, required this.food}) : super(key: key);

  @override
  ConsumerState<FoodDetailPage> createState() => _FoodDetailPageState();
}

class _FoodDetailPageState extends ConsumerState<FoodDetailPage> {
  @override
  Widget build(BuildContext context) {
    var foodDetailState = ref.watch(foodDetailNotiferProvider).state;
    if (foodDetailState is FoodDetailInitialState) {
      return mainBody(context, ref);
    } else if (foodDetailState is FoodDetailLoadingState) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }
    return mainBody(context, ref);
  }

  Scaffold mainBody(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: Colors.white,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        elevation: 0.0,
        leading: Center(
          child: CircleAvatar(
            backgroundColor: Colors.black.withOpacity(0.3),
            child: IconButton(
              icon: const Icon(
                Icons.arrow_back,
                color: Colors.white,
              ),
              onPressed: () => Navigator.pop(context),
            ),
          ),
        ),
        actions: [
          Center(
            child: CircleAvatar(
              backgroundColor: Colors.black.withOpacity(0.3),
              child: IconButton(
                icon: const Icon(
                  Icons.shopping_cart,
                  color: Colors.white,
                ),
                onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const CartListPage())),
              ),
            ),
          ),
          SizedBox(width: 15.w)
        ],
        backgroundColor: Colors.transparent,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          _buildBackgoundImage(),
          Container(
            padding: const EdgeInsets.all(8),
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  widget.food.name,
                  style: TextStyle(
                    color: Colors.black.withOpacity(0.7),
                    fontWeight: FontWeight.w900,
                    fontSize: 32.sp,
                  ),
                ),
                TextWithIcon(
                  icon: Icon(
                    Icons.location_on,
                    color: Colors.black.withOpacity(0.5),
                  ),
                  text: widget.food.address,
                ),
                SizedBox(
                  height: 10.h,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    TextWithIcon(
                      icon: Icon(
                        Icons.local_taxi,
                        size: 30.r,
                      ),
                      text: "30 min",
                    ),
                    const SizedBox(width: 10),
                    const TextWithIcon(
                      icon: Icon(
                        Icons.food_bank,
                        color: Colors.red,
                      ),
                      text: "247 calories",
                    ),
                    const SizedBox(width: 10),
                    TextWithIcon(
                      icon: const Icon(
                        Icons.star,
                        color: Colors.yellow,
                      ),
                      text: widget.food.rating.toString(),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "A hamburger is a food consisting of one or more cooked patties—usually ground meat, typically beef—placed inside a sliced bun or bread roll. The patty may be pan fried, grilled, smoked or flame broiled.",
                    style: TextStyle(
                      color: Colors.black.withOpacity(0.7),
                      fontSize: 15.sp,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const Expanded(child: SizedBox()),
          _buildAddButton(context, ref),
          SizedBox(
            height: 25.h,
          ),
        ],
      ),
    );
  }

  Widget _buildAddButton(BuildContext context, WidgetRef ref) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      width: MediaQuery.of(context).size.width,
      child: Row(
        children: [
          Expanded(
            child: Container(
              height: 50.h,
              decoration: BoxDecoration(
                  color: Colors.orange[500],
                  borderRadius: BorderRadius.circular(10)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton(
                    onPressed: () {
                      ref.read(foodDetailNotiferProvider).minusOne();
                    },
                    child: Text(
                      "-",
                      style: TextStyle(
                          fontSize: 35.sp,
                          color: Colors.white,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                  Text(
                    ref.watch(foodDetailNotiferProvider).count.toString(),
                    style: TextStyle(
                        fontSize: 25.sp,
                        color: Colors.white,
                        fontWeight: FontWeight.w500),
                  ),
                  TextButton(
                    onPressed: () {
                      ref.read(foodDetailNotiferProvider).plusOne();
                    },
                    child: Text(
                      "+",
                      style: TextStyle(
                          fontSize: 25.sp,
                          color: Colors.white,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Text("Rs: " + widget.food.price.toString(),
                      style: TextStyle(
                          fontSize: 20.sp,
                          color: Colors.white,
                          fontWeight: FontWeight.w500))
                ],
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 5),
            height: 50,
            decoration: BoxDecoration(
                color: Colors.red.withOpacity(0.9),
                borderRadius: BorderRadius.circular(10)),
            child: IconButton(
              icon: Icon(
                Icons.shopping_cart,
                color: Colors.white,
                size: 30.r,
              ),
              onPressed: () async {
                List<CartItem>? cartlist;
                try {
                  cartlist = await ref.read(foodServiceProvider).getCartItem();
                } catch (e) {
                  cartlist = null;
                }
                String response = "";
                if (cartlist == null) {
                  response = await ref
                      .watch(foodDetailNotiferProvider)
                      .createNewCart(
                          CartItem(
                              id: widget.food.sId,
                              name: widget.food.name,
                              image: widget.food.image,
                              price: widget.food.price,
                              quantity:
                                  ref.read(foodDetailNotiferProvider).count),
                          cartlist ?? []);
                } else {
                  bool exists =
                      cartlist.any((file) => file.id == widget.food.sId);
                  if (!exists) {
                    response = await ref
                        .watch(foodDetailNotiferProvider)
                        .insertIntoCart(
                            CartItem(
                                id: widget.food.sId,
                                name: widget.food.name,
                                image: widget.food.image,
                                price: widget.food.price,
                                quantity:
                                    ref.read(foodDetailNotiferProvider).count),
                            cartlist);
                  }
                  Fluttertoast.showToast(msg: "Food already in Cart");
                }

                if (response == "Success") {
                  Fluttertoast.showToast(msg: "Added Successfully");
                } else {
                  if (response.isNotEmpty) {
                    Fluttertoast.showToast(msg: response);
                  }
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  SizedBox _buildBackgoundImage() {
    return SizedBox(
      height: 300.h,
      child: Stack(
        alignment: Alignment.topCenter,
        children: [
          Container(
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("assets/images/" + widget.food.image),
                    fit: BoxFit.cover)),
          ),
          Positioned(
            bottom: 0,
            right: 0,
            left: 0,
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
          )
        ],
      ),
    );
  }
}
