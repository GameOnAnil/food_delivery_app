import 'package:flutter/material.dart';

class RestaurantDetailsPage extends StatelessWidget {
  const RestaurantDetailsPage({Key? key}) : super(key: key);

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
        body: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: _buildHeader(),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      "KFX",
                      style:
                          TextStyle(fontWeight: FontWeight.w600, fontSize: 25),
                    ),
                    Text(
                      "Radhe Radhe",
                      style:
                          TextStyle(fontWeight: FontWeight.w400, fontSize: 18),
                    ),
                    Text(
                      "Description/ About Restaurant",
                      style:
                          TextStyle(fontWeight: FontWeight.w600, fontSize: 25),
                    ),
                    Text(
                      "KFC is an American fast food restaurant chain headquartered in Louisville, Kentucky that specializes in fried chicken. It is the world's second-largest restaurant chain after McDonald's, with 22,621 locations globally in 150 countries as of December 2019. ",
                    )
                  ],
                ),
              ),
            )
          ],
        ));
  }

  Container _buildHeader() {
    return Container(
      decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage("assets/images/kfc_default.jpg"),
              fit: BoxFit.cover)),
      height: 300,
      child: Stack(
        alignment: Alignment.topCenter,
        children: [
          Container(
            height: 150,
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              height: 100,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 40,
            child: Container(
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.black45, width: 1),
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(50)),
              height: 100,
              width: 100,
              child: Image.asset(
                "assets/images/kfc_logo.png",
                fit: BoxFit.contain,
              ),
            ),
          )
        ],
      ),
    );
  }
}
