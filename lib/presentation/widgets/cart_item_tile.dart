import 'package:flutter/material.dart';
import 'package:food_delivery_app/data/model/cart_food.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:food_delivery_app/provider/firestore_provider.dart';

class CartItemTile extends ConsumerWidget {
  final CartFood food;

  const CartItemTile({required this.food});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SizedBox(
      height: 120,
      width: MediaQuery.of(context).size.width,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        child: Row(children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(8)),
              child: SizedBox(
                  height: 120,
                  width: 120,
                  child: Image.asset(
                    "assets/images/${food.image}.jpeg",
                    fit: BoxFit.cover,
                  )),
            ),
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 15, top: 8),
                  child: Text(
                    food.name,
                    style: const TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w800,
                        fontSize: 24),
                    maxLines: 2,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 15),
                  child: Text(
                    "Rs. ${food.price}",
                    style: const TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w400,
                        fontSize: 20),
                    maxLines: 2,
                  ),
                ),
                const Expanded(child: SizedBox()),
                Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            elevation: 0,
                            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                            primary: Colors.orange.withOpacity(0.85),
                            shape: const CircleBorder(),
                            padding: EdgeInsets.zero),
                        child: const Icon(
                          Icons.remove,
                          size: 15,
                        ),
                        onPressed: () {
                          if (food.quantity > 1) {
                            ref.read(firestoreServideProvider).updateFood(
                                CartFood(
                                    id: food.id,
                                    name: food.name,
                                    image: food.image,
                                    price: food.price,
                                    quantity: food.quantity - 1));
                          }
                        },
                      ),
                      Text(
                        food.quantity.toString(),
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                        ),
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            elevation: 0,
                            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                            primary: Colors.orange.withOpacity(0.85),
                            shape: const CircleBorder(),
                            padding: EdgeInsets.zero),
                        child: const Icon(
                          Icons.add,
                          size: 15,
                        ),
                        onPressed: () {
                          ref.read(firestoreServideProvider).updateFood(
                              CartFood(
                                  id: food.id,
                                  name: food.name,
                                  image: food.image,
                                  price: food.price,
                                  quantity: food.quantity + 1));
                        },
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
          Align(
            alignment: Alignment.topCenter,
            child: IconButton(
                onPressed: () {
                  ref.read(firestoreServideProvider).deleteFood(food);
                },
                icon: const Icon(
                  Icons.delete,
                  color: Colors.red,
                )),
          )
        ]),
      ),
    );
  }
}
