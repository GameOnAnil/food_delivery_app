import 'dart:convert';
import 'dart:developer';

import 'package:flutter/services.dart';
import 'package:food_delivery_app/data/model/food.dart';

class HomePageRepository {
  Future<List<Food>> getDefaultFood() async {
    final response =
        await rootBundle.loadString("assets/json/default_food_list.json");
    final data = await json.decode(response)["foods"] as List<dynamic>;

    return data.map((e) {
      return Food.fromMap(e);
    }).toList();
  }
}
