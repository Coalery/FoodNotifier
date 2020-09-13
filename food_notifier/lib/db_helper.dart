import 'dart:convert';

import 'package:food_notifier/unit/barcode.dart';
import 'package:food_notifier/unit/recipe.dart';
import 'package:food_notifier/unit/user.dart';
import 'package:http/http.dart' as http;

class DBHelper {
  static const String IP = '13.125.39.144';

  // GET

  static Future<Barcode> getBarcode(String barcode) async {
    http.Response response = await http.get('http://$IP:3000/barcode/$barcode');
    if(response.body == '{}') return null;
    return Barcode.fromJsonString(response.body);
  }

  static Future<List<Barcode>> getOutofDateFoods(int uid) async {
    http.Response response = await http.get('http://$IP:3000/outofdatefoods/$uid');
    JsonCodec codec = new JsonCodec();

    dynamic rawJson = codec.decode(response.body);
    List<dynamic> jsonArray = List.from(rawJson['result']);
    List<Barcode> resultList = [];
    for(dynamic json in jsonArray) {
      resultList.add(Barcode.fromJson(json));
    }
    return resultList;
  }

  static Future<List<Recipe>> getRecipes(String ingredient) async {
    http.Response response = await http.get('http://$IP:3000/recipe/$ingredient');
    JsonCodec codec = new JsonCodec();

    dynamic rawJson = codec.decode(response.body);
    List<dynamic> jsonArray = List.from(rawJson['result']);
    List<Recipe> resultList = [];
    for(dynamic json in jsonArray) {
      resultList.add(Recipe.fromJson(json));
    }
    return resultList;
  }

  static Future<User> getUser(String uid) async {
    http.Response response = await http.get('http://$IP:3000/user/$uid');
    if(response.body == '{}') return null;
    return User.fromJsonString(response.body);
  }

  // POST

  static Future<String> postUser(String name, int age, String gender, String job) async {
    http.Response response = await http.post(
      'http://$IP:3000/adduser',
      headers: {
        'Content-Type': 'application/json; charset=UTF-8'
      },
      body: jsonEncode({
        'name' : name,
        'age' : age,
        'gender' : gender,
        'job' : job
      })
    );
    dynamic json = jsonDecode(response.body);

    if(json['status'] == 'success') {
      return json['uid'];
    } else {
      return null;
    }
  }
}