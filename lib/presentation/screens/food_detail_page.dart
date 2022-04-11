import 'package:flutter/material.dart';
import 'package:food_delivery_app/data/model/food.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:food_delivery_app/presentation/screens/add_to_cart.dart';
import 'package:food_delivery_app/provider/cart_item_count_provider.dart';

class FoodDetailPage extends StatelessWidget {
  final Food food;
  const FoodDetailPage({Key? key, required this.food}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        elevation: 0.0,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        backgroundColor: Colors.transparent,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          _buildBackgoundImage(),
          Container(
            padding: const EdgeInsets.all(8),
            width: MediaQuery.of(context).size.width,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  food.name,
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
                  text: food.address,
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const TextWithIcon(
                      icon: Icon(
                        Icons.local_taxi,
                        size: 30,
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
                      text: food.rating.toString(),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "A hamburger is a food consisting of one or more cooked patties—usually ground meat, typically beef—placed inside a sliced bun or bread roll. The patty may be pan fried, grilled, smoked or flame broiled.",
                    style: TextStyle(
                      color: Colors.black.withOpacity(0.7),
                      fontSize: 15,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const Expanded(child: SizedBox()),
          _buildAddButton(context),
          const SizedBox(
            height: 25,
          ),
        ],
      ),
    );
  }

  Widget _buildAddButton(BuildContext context) {
    return Consumer(builder: (context, ref, child) {
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        width: MediaQuery.of(context).size.width,
        child: Row(
          children: [
            Expanded(
              child: Container(
                height: 50,
                decoration: BoxDecoration(
                    color: Colors.orange[500],
                    borderRadius: BorderRadius.circular(10)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextButton(
                      onPressed: () {
                        ref.read(cartItemCountProvider).minusOne();
                      },
                      child: const Text(
                        "-",
                        style: TextStyle(
                            fontSize: 35,
                            color: Colors.white,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                    Text(
                      ref.watch(cartItemCountProvider).count.toString(),
                      style: const TextStyle(
                          fontSize: 25,
                          color: Colors.white,
                          fontWeight: FontWeight.w500),
                    ),
                    TextButton(
                      onPressed: () {
                        ref.read(cartItemCountProvider).plusOne();
                      },
                      child: const Text(
                        "+",
                        style: TextStyle(
                            fontSize: 25,
                            color: Colors.white,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Text("Rs: " + food.price.toString(),
                        style: const TextStyle(
                            fontSize: 20,
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
                icon: const Icon(
                  Icons.shopping_cart,
                  color: Colors.white,
                  size: 30,
                ),
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const AddToCartPage()));
                },
              ),
            ),
          ],
        ),
      );
    });
  }

  SizedBox _buildBackgoundImage() {
    return SizedBox(
      height: 300,
      child: Stack(
        alignment: Alignment.topCenter,
        children: [
          Container(
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("assets/images/" + food.image + ".jpeg"),
                    fit: BoxFit.cover)),
          ),
          Positioned(
            bottom: 0,
            right: 0,
            left: 0,
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
          )
        ],
      ),
    );
  }
}

class TextWithIcon extends StatelessWidget {
  final Icon icon;
  final String text;
  const TextWithIcon({
    Key? key,
    required this.icon,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        icon,
        const SizedBox(
          width: 4,
        ),
        Text(
          text,
          style:
              const TextStyle(color: Colors.black, fontWeight: FontWeight.w500),
        )
      ],
    );
  }
}
