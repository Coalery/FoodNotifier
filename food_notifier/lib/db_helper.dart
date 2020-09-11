import 'dart:convert';

import 'package:food_notifier/unit/food.dart';
import 'package:food_notifier/unit/recipe.dart';
import 'package:http/http.dart' as http;

class DBHelper {
  static const String IP = '13.125.39.144';

  static Future<Food> getFood(String barcode) async {
    String requestURL = 'http://$IP:3000/barcode/' + barcode;

    http.Response response = await http.get(requestURL);
    String body = response.body;

    return Food.fromJsonString(body);
  }

  static Future<List<Recipe>> getRecipes(String ingredient) async {
    http.Response response = await http.get('http://$IP:3000/recipe/' + ingredient);
    JsonCodec codec = new JsonCodec();

    List<dynamic> jsonArray = List.from(codec.decode(response.body));
    List<Recipe> resultList = [];
    for(dynamic json in jsonArray) {
      resultList.add(Recipe.fromJson(json));
    }
    return resultList;
  }
}