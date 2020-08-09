import 'package:flutter/material.dart';
import 'package:food_notifier/dbhelper.dart';
import 'package:food_notifier/food.dart';
import 'package:intl/intl.dart';

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

              DateFormat formatter = new DateFormat('yyyy/MM/dd');
              return Container(
                alignment: Alignment.center,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      food.f_PRDLST_NM,
                      style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 40),
                    Text(
                      '유통기한',
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 10),
                    Text(
                      formatter.format(food.f_POG_DAYCNT),
                      style: TextStyle(fontSize: 20),
                    ),
                    SizedBox(height: 80),
                    FlatButton(
                      child: Container(
                        width: 200,
                        height: 50,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: Colors.blue[300]
                        ),
                        child: Text('등록'),
                      ),
                      onPressed: () {

                      },
                    )
                  ],
                ),
              );
            } else {
              return Center(child: CircularProgressIndicator());
            }
          },
        ),
      ),
    );
  }
}