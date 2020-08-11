import 'package:barcode_scan/barcode_scan.dart';
import 'package:flutter/material.dart';
import 'package:food_notifier/food_page.dart';

class MainPage extends StatefulWidget {
  static String routeName = '/main';

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  bool expanded = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Container(
              alignment: Alignment.bottomCenter,
              child: Container(
                width: 64,
                height: 64,
                margin: EdgeInsets.only(bottom: 10),
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
                child: IconButton(
                  icon: Icon(Icons.add),
                  onPressed: () async {
                    ScanResult result = await BarcodeScanner.scan();
                    Navigator.pushNamed(context, FoodPage.routeName, arguments: new FoodPageArguments(barcode: '8801045176338'));
                    if(result.rawContent == '') {
                      return;
                    }
                    //Navigator.pushNamed(context, FoodPage.routeName, arguments: new FoodPageArguments(barcode: result.rawContent));
                  },
                ),
              )
            )
          ],
        )
      )
    );
  }
}