import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery_app/data/model/cart_food.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:food_delivery_app/presentation/widgets/cart_item_tile.dart';
import 'package:food_delivery_app/provider/firestore_provider.dart';

class AddToCartPage extends ConsumerWidget {
  AddToCartPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final Stream<QuerySnapshot> _foodStream = FirebaseFirestore.instance
        .collection("cart")
        .doc("qwdfXDfZFhQcWvj80IGCiQOAJOD2")
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
          IconButton(
              onPressed: () async {
                ref.watch(firestoreServideProvider).insertDate();
              },
              icon: const Icon(Icons.add)),
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Expanded(child: _buildListView(_foodStream)),
          _buildBottomSheet(context)
        ],
      ),
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
        return ListView(
          children: snapshot.data!.docs.map((DocumentSnapshot document) {
            Map<String, dynamic> data =
                document.data()! as Map<String, dynamic>;
            return CartItemTile(food: CartFood.fromMap(data));
          }).toList(),
        );
      },
    );
  }

  Container _buildBottomSheet(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 250,
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Column(children: [
          _bottomTextRow(title: "Item total", price: "1000"),
          _bottomTextRow(title: "Delivary Charge", price: "100"),
          _bottomTextRow(title: "Tax", price: "50"),
          const SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              Text(
                "Total",
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w500,
                    fontSize: 25),
                maxLines: 2,
              ),
              Text(
                "\$" "1150",
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w600,
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
        ]),
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
