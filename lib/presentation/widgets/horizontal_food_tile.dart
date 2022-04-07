import 'package:flutter/material.dart';
import 'package:food_delivery_app/data/model/food.dart';
import 'package:food_delivery_app/presentation/screens/food_detail_page.dart';

class HorizontalFoodTile extends StatelessWidget {
  final Food food;
  const HorizontalFoodTile({
    Key? key,
    required this.food,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => FoodDetailPage(food: food),
        ),
      ),
      child: Container(
        margin: const EdgeInsets.all(5),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: Image.asset(
                food.image,
                width: 150,
                height: 150,
                fit: BoxFit.cover,
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      food.name,
                      style: const TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.w500),
                    ),
                    const Text(
                      "Pizza Hut",
                      style: TextStyle(
                        color: Colors.blueGrey,
                      ),
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Icon(
                          Icons.star,
                          color: Colors.yellow[700],
                        ),
                        Text(
                          food.rating.toString(),
                          style: const TextStyle(
                            color: Colors.blueGrey,
                            fontSize: 18,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                    Container(
                      height: 1,
                      width: 160,
                      color: Colors.black.withOpacity(0.3),
                    ),
                    SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: const [
                            Icon(
                              Icons.local_taxi,
                              color: Colors.red,
                            ),
                            Text(
                              "30 min",
                              style: TextStyle(
                                color: Colors.blueGrey,
                                fontSize: 15,
                              ),
                            ),
                          ],
                        ),
                        Text(
                          "Rs. " + food.price.toInt().toString(),
                          style: const TextStyle(
                              color: Colors.black,
                              fontSize: 15,
                              fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
