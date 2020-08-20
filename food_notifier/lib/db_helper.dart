import 'dart:convert';

import 'package:food_notifier/food.dart';
import 'package:food_notifier/recipe.dart';
import 'package:http/http.dart' as http;

class DBHelper {
  static const String IP = '52.78.203.43';

  Future<Food> getFood(String barcode) async {
    http.Response response = await http.get('http://$IP:3000/barcode/' + barcode);
    String body = response.body;

    return Food.fromJsonString(body.substring(1, body.length - 1));
  }

  Future<List<Recipe>> getRecipes(String ingredient) async {
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