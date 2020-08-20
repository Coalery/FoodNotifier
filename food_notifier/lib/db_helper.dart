import 'package:food_notifier/food.dart';
import 'package:http/http.dart' as http;

class DBHelper {
  Future<Food> getFood(String barcode) async {
    http.Response response = await http.get('http://13.124.188.74:3000/barcode/' + barcode);
    String body = response.body;

    return Food.fromJsonString(body.substring(1, body.length - 1));
  }
}