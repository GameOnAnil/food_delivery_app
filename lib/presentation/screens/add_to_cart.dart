import 'package:flutter/material.dart';

class AddToCartPage extends StatelessWidget {
  const AddToCartPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
        actions: [IconButton(onPressed: () {}, icon: const Icon(Icons.check))],
      ),
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: 3,
                itemBuilder: ((context, index) {
                  return const CartItemTile();
                }),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: const Divider(color: Colors.black),
            ),
            _buildBottomSheet(context)
          ],
        ),
      ),
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
          _bottomTextRow(title: "Item total", price: "10000"),
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
                "\$" "10150",
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

class CartItemTile extends StatelessWidget {
  const CartItemTile({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
                    "assets/images/pizza_def.jpeg",
                    fit: BoxFit.cover,
                  )),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.only(left: 15, top: 8),
                child: Text(
                  "Pizza",
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w800,
                      fontSize: 24),
                  maxLines: 2,
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(left: 15),
                child: Text(
                  "Rs. 1000",
                  style: TextStyle(
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
                      onPressed: () {},
                    ),
                    const Text(
                      "1",
                      style: TextStyle(
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
                      onPressed: () {},
                    ),
                  ],
                ),
              )
            ],
          )
        ]),
      ),
    );
  }
}
