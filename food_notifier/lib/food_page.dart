import 'package:flutter/material.dart';
import 'package:food_notifier/dbhelper.dart';
import 'package:food_notifier/food.dart';

class FoodPageArguments {
  final String barcode;
  FoodPageArguments({this.barcode});
}

class FoodPage extends StatelessWidget {
  static String routeName = '/food';

  @override
  Widget build(BuildContext context) {
    FoodPageArguments parameters =  ModalRoute.of(context).settings.arguments;

    return Scaffold(
      body: SafeArea(
        child: FutureBuilder(
          future: DBHelper().getFood(parameters.barcode),
          builder: (_, snapshot) {
            if(snapshot.hasData) {
              Food food = snapshot.data;
              if(food == Food.none) {
                return Center(child: Text('바코드를 인식할 수 없습니다.'));
              }
              return Center(child: Text(food.f_PRDLST_NM));
            } else {
              return Center(child: CircularProgressIndicator());
            }
          },
        ),
      ),
    );
  }
}