import 'dart:convert';

import 'package:food_notifier/unit/food.dart';
import 'package:food_notifier/unit/recipe.dart';
import 'package:http/http.dart' as http;

class DBHelper {
  static const String IP = '13.125.1.184';

  static Future<Food> getFood(String barcode) async {
    http.Response response = await http.get('http://$IP:3000/barcode/' + barcode);
    String body = response.body;

    return Food.fromJsonString(body.substring(1, body.length - 1));
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