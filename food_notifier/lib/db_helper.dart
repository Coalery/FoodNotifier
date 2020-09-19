import 'dart:convert';

import 'package:food_notifier/unit/barcode.dart';
import 'package:food_notifier/unit/food.dart';
import 'package:food_notifier/unit/recipe.dart';
import 'package:food_notifier/unit/user.dart';
import 'package:food_notifier/util.dart';
import 'package:http/http.dart' as http;

class DBHelper {
  static const String IP = '13.125.39.144';

  // GET

  static Future<Barcode> getBarcode(String barcode) async {
    http.Response response = await http.get('http://$IP:3000/barcode/$barcode');
    dynamic rawJson = jsonDecode(response.body);
    bool success = rawJson['status'];
    if(!success) return null;
    return Barcode.fromJson(rawJson['info']);
  }

  static Future<User> getUser(String uid) async {
    http.Response response = await http.get('http://$IP:3000/user/$uid');
    dynamic rawJson = jsonDecode(response.body);
    bool success = rawJson['status'];
    if(!success) return null;
    return User.fromJson(rawJson['info']);
  }

  static Future<List<Food>> getOutofDateFoods(User user) async {
    http.Response response = await http.get('http://$IP:3000/outofdatefoods/${user.id}');

    dynamic rawJson = jsonDecode(response.body);
    List<dynamic> jsonArray = List.from(rawJson['result']);
    List<Food> resultList = [];

    for(dynamic json in jsonArray) {
      String id = json['id'];
      Barcode barcode = await getBarcode(json['bid']);
      DateTime registerDateTime = parseStringToDateTime(json['registerDateTime']);

      Food newFood = new Food(id, user, barcode, registerDateTime);
      resultList.add(newFood);
    }
    
    return resultList;
  }

  static Future<List<Recipe>> getRecipes(String ingredient) async {
    http.Response response = await http.get('http://$IP:3000/recipe/$ingredient');

    dynamic rawJson = jsonDecode(response.body);
    List<dynamic> jsonArray = List.from(rawJson['result']);
    List<Recipe> resultList = [];
    for(dynamic json in jsonArray) {
      resultList.add(Recipe.fromJson(json));
    }
    return resultList;
  }

  // POST

  static Future<String> postUserIfNotExist(String name, int age, String gender, String job) async {
    http.Response existResponse = await http.get('http://$IP:3000/userinfo?name=$name&age=$age&gender=$gender&job=$job');
    dynamic existResponseJSON = jsonDecode(existResponse.body);
    bool success = existResponseJSON['status'];
    if(!success) {
      return existResponseJSON['info']['id'];
    }

    http.Response postResponse = await http.post(
      'http://$IP:3000/adduser',
      headers: {'Content-Type': 'application/json; charset=UTF-8'},
      body: jsonEncode({'name' : name, 'age' : age, 'gender' : gender, 'job' : job})
    );
    dynamic json = jsonDecode(postResponse.body);

    if(json['status'] == 'success') {
      return json['uid'];
    } else {
      return null;
    }
  }

  static Future<bool> postFood(String uid, String fid, DateTime registerTime) async {
    http.Response postResponse = await http.post(
      'http://$IP:3000/addfood',
      headers: {'Content-Type': 'application/json; charset=UTF-8'},
      body: jsonEncode({
        'uid' : uid,
        'fid' : fid,
        'registerDateTime' : parseDateTimeToString(registerTime)
      })
    );
    print(postResponse.body);
    dynamic json = jsonDecode(postResponse.body);
    bool isSuccess = json['status'] == 'success';
    return isSuccess;
  }
}