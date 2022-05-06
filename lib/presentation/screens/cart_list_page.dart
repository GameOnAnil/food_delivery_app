import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:food_delivery_app/data/model/cart_item.dart';
import 'package:food_delivery_app/presentation/widgets/cart_item_tile.dart';
import 'package:food_delivery_app/riverpod/providers/providers.dart';

class CartListPage extends ConsumerStatefulWidget {
  const CartListPage({Key? key}) : super(key: key);

  @override
  ConsumerState<CartListPage> createState() => _CartListPageState();
}

class _CartListPageState extends ConsumerState<CartListPage> {
  @override
  void initState() {
    super.initState();
    ref.read(cartChangeNotifierProvider).getCartList();
  }

  @override
  Widget build(BuildContext context) {
    var cartList = ref.watch(cartChangeNotifierProvider).cartList;
    // ref.read(cartChangeNotifierProvider).getCartList();
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
          IconButton(
              onPressed: () async {
                try {
                  final response =
                      await ref.watch(tokenAuthProvider).updateList(cartList);
                  Fluttertoast.showToast(msg: response);
                } catch (e) {
                  Fluttertoast.showToast(msg: e.toString());
                }
              },
              icon: const Icon(Icons.save)),
        ],
      ),
      body: _buildListView(cartList, context, ref),
    );
  }

  Widget _buildListView(
      List<CartItem>? cartList, BuildContext context, WidgetRef ref) {
    return Column(
      children: [
        Expanded(
          child: ListView.builder(
              itemCount: cartList?.length,
              itemBuilder: (context, index) {
                if (cartList != null) {
                  return CartItemTile(
                    food: cartList[index],
                    cartList: cartList,
                    ref: ref,
                  );
                }
                return Container();
              }),
        ),
        _buildBottomSheet(cartList, context)
      ],
    );
  }

  Container _buildBottomSheet(List<CartItem>? cartList, BuildContext context) {
    var totalPrice = 0;
    var totalDelivaryChange = 0;
    var totalTax = 0.0;
    var totalSum = 0.0;

    if (cartList != null) {
      cartList.map((food) {
        totalPrice = totalPrice + food.price * food.quantity;
        totalDelivaryChange = totalDelivaryChange + 50;
        totalTax = 0.04 * totalPrice;
        totalSum = totalPrice + totalDelivaryChange + totalTax;
      }).toList();
    }

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
            _bottomTextRow(
                title: "Tax", price: totalTax.toStringAsFixed(2).toString()),
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
          "Rs." + price,
          style: const TextStyle(
              color: Colors.black, fontWeight: FontWeight.w500, fontSize: 20),
          maxLines: 2,
        ),
      ],
    );
  }
}
