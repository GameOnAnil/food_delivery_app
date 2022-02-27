import 'dart:developer';
import 'package:flutter/material.dart';

import 'package:food_delivery_app/data/repository/home_page_repo.dart';

class TestScreen extends StatelessWidget {
  const TestScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(children: [
        ElevatedButton(
          onPressed: () async {
            HomePageRepository homePageRepository = HomePageRepository();
            var foods = await homePageRepository.getDefaultFood();
            log(foods.toString());
          },
          child: const Text("Json"),
        ),
      ]),
    );
  }
}
