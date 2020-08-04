import 'package:barcode_scan/barcode_scan.dart';
import 'package:flutter/material.dart';
import 'package:food_notifier/food.dart';
import 'package:food_notifier/food_unit.dart';

class MainPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
/*        child: Container(
          alignment: Alignment.center,
          child: Wrap(
            children: [
              Container(
                width: 200,
                height: 200,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(100.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 20
                    )
                  ]
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(100.0),
                  child: FlatButton(
                    child: Image.asset('assets/bar_code.png', width: 150, height: 150),
                    onPressed: () async {
                      ScanResult result = await BarcodeScanner.scan();
                      print(result.type);
                      print(result.rawContent);
                      print(result.format);
                      print(result.formatNote);
                    },
                  ),
                ),
              )
            ],
          ),
        ),*/
        child: ListView.builder(
          itemCount: 10,
          itemBuilder: (_, index) => FoodUnit(food: new Food(name: "옴뇸뇸", shelfLife: DateTime(2020, 10, 11), registerDate: DateTime(2020, 8, 5))),
        ),
      )
    );
  }
}