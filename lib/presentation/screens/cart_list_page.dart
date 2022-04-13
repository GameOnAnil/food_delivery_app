import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery_app/data/model/cart_food.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:food_delivery_app/presentation/widgets/cart_item_tile.dart';
import 'package:food_delivery_app/provider/auth_provider.dart';

class CartListPage extends ConsumerWidget {
  CartListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final Stream<QuerySnapshot> _foodStream = FirebaseFirestore.instance
        .collection("cart")
        .doc(ref.read(firebaseAuthProvider).currentUser!.uid)
        .collection("foodlist")
        .snapshots();

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        title: const Text(
          "My Cart",
          style: TextStyle(color: Colors.black),
        ),
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.check)),
        ],
      ),
      body: _buildListView(_foodStream),
    );
  }

  StreamBuilder<QuerySnapshot<Object?>> _buildListView(
      Stream<QuerySnapshot<Object?>> _foodStream) {
    return StreamBuilder<QuerySnapshot>(
      stream: _foodStream,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return const Scaffold(
              body: Center(child: Text('Something went wrong')));
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }
        var totalPrice = 0;
        var totalDelivaryChange = 0;
        var totalTax = 0.0;
        var totalSum = 0.0;
        List<CartFood> foodList =
            snapshot.data!.docs.map((DocumentSnapshot document) {
          Map<String, dynamic> data = document.data()! as Map<String, dynamic>;
          var food = CartFood.fromMap(data);
          totalPrice = totalPrice + food.price * food.quantity;
          totalDelivaryChange = totalDelivaryChange + 50;
          totalTax = 0.04 * totalPrice;
          totalSum = totalPrice + totalDelivaryChange + totalTax;

          return food;
        }).toList();

        return Column(
          children: [
            Expanded(
              child: ListView.builder(
                  itemCount: foodList.length,
                  itemBuilder: (context, index) => CartItemTile(
                        food: foodList[index],
                      )),
            ),
            _buildBottomSheet(
                context, totalPrice, totalDelivaryChange, totalTax, totalSum)
          ],
        );
      },
    );
  }

  Container _buildBottomSheet(
    BuildContext context,
    int totalPrice,
    int totalDelivaryChange,
    double totalTax,
    double totalSum,
  ) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 250,
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Consumer(builder: (context, ref, child) {
          // var total = ref.watch(cartTotalProvider).total;
          return Column(children: [
            _bottomTextRow(title: "Item total", price: totalPrice.toString()),
            _bottomTextRow(
                title: "Delivary Charge",
                price: totalDelivaryChange.toString()),
            _bottomTextRow(title: "Tax", price: totalTax.toString()),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Total",
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w500,
                      fontSize: 25),
                  maxLines: 2,
                ),
                Text(
                  "Rs. " + totalSum.toString(),
                  style: const TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w500,
                      fontSize: 25),
                  maxLines: 2,
                ),
              ],
            ),
            const Expanded(child: SizedBox()),
            SafeArea(
              child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  width: MediaQuery.of(context).size.width,
                  height: 55,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.orange.withOpacity(0.8)),
                  child: TextButton(
                      onPressed: () {},
                      child: const Text(
                        "Confirm Order",
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                        ),
                      ))),
            ),
            const SizedBox(
              height: 8,
            )
          ]);
        }),
      ),
    );
  }

  Row _bottomTextRow({required String title, required String price}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: TextStyle(
              color: Colors.black.withOpacity(0.7),
              fontWeight: FontWeight.w400,
              fontSize: 20),
          maxLines: 2,
        ),
        Text(
          "\$" + price,
          style: const TextStyle(
              color: Colors.black, fontWeight: FontWeight.w500, fontSize: 20),
          maxLines: 2,
        ),
      ],
    );
  }
}
