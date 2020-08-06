import 'package:barcode_scan/barcode_scan.dart';
import 'package:flutter/material.dart';
import 'package:food_notifier/dbhelper.dart';
import 'package:food_notifier/food.dart';
import 'package:food_notifier/food_unit.dart';

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  bool expanded = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: FutureBuilder(
          future: DBHelper().getFood('8801791000055'),
          builder: (_, snapshot) {
            if(snapshot.hasData) {
              Food food = snapshot.data;
              return Center(child: Text(food.f_PRDLST_NM));
            } else {
              return Center(child: CircularProgressIndicator());
            }
          },
        ),
      ),
    );
  }
  /*
  @override
  Widget build(BuildContext context) {
    Icon icon = (expanded == true ? Icon(Icons.keyboard_arrow_down) : Icon(Icons.keyboard_arrow_up));

    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Container(
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
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: AnimatedContainer(
                duration: Duration(seconds: 1),
                curve: Curves.fastOutSlowIn,
                height: (expanded == true ? MediaQuery.of(context).size.height : 50),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20)),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 5
                      )
                    ]
                  ),
                  child: Stack(
                    children: [
                      GestureDetector(
                        child: Container(
                          color: Colors.transparent,
                          width: double.infinity,
                          height: 50,
                          child: Center(
                            child: icon
                          )
                        ),
                        onTap: () {
                            if(expanded == false || expanded == null) {
                              setState(() {
                                expanded = true;
                              });
                            } else {
                              setState(() {
                                expanded = false;
                              });
                            }
                          }
                      ),
                      // Container(
                      //   margin: EdgeInsets.only(top: 50),
                      //   child: ListView.builder(
                      //     itemBuilder: (_, index) => FoodUnit(food: new Food(name: "옴뇸뇸", shelfLife: DateTime(2020, 10, 11), registerDate: DateTime(2020, 8, 5))),
                      //     itemCount: 20,
                      //   )
                      // )
                    ],
                  ),
                ),
              )
            )
          ],
        )
      )
    );
  }*/
}