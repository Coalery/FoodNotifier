import 'package:barcode_scan/barcode_scan.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_notifier/db_helper.dart';
import 'package:food_notifier/food.dart';
import 'package:intl/intl.dart';

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
              color: Colors.white,
              child: ListView(
                children: [
                  SizedBox(height: 20),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      children: [
                        Container(
                          width: 3,
                          height: 30,
                          color: Colors.orange[300],
                        ),
                        SizedBox(width: 10),
                        Text(
                          '유통기한이 얼마 남지 않았어요!',
                          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)
                        )
                      ]
                    )
                  ),
                  Container(
                    width: double.infinity,
                    height: 200,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: 10,
                      itemBuilder: (context, index) {
                        return Container(
                          margin: EdgeInsets.only(top: 10, bottom: 10, left: 20, right: 20),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [
                              BoxShadow(
                                blurRadius: 5,
                                color: Colors.black12
                              )
                            ]
                          ),
                          child: Container(
                            width: 300,
                          ),
                        );
                      },
                    ),
                  ),
                  SizedBox(height: 40),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      children: [
                        Container(
                          width: 3,
                          height: 30,
                          color: Colors.orange[300],
                        ),
                        SizedBox(width: 10),
                        Text(
                          '이런 음식은 어때요?',
                          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)
                        )
                      ]
                    )
                  ),
                  SizedBox(height: 10),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: AspectRatio(
                      aspectRatio: 1,
                      child: Stack(
                        alignment: Alignment.bottomLeft,
                        children: [
                          Container(
                            width: double.infinity,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(20.0),
                              child: Image.network('http://www.foodsafetykorea.go.kr/uploadimg/cook/10_00017_2.png', fit: BoxFit.fill),
                            )
                          ),
                          Column(
                            children: [
                              Text(
                                ''
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 20)
                ],
              ),
            ),
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
                    result.rawContent = '8801045176338';
                    if(result.rawContent == '') {
                      return;
                    }

                    showCupertinoDialog(
                      context: context,
                      builder: (context) {
                        return CupertinoAlertDialog(
                          content: Container(
                            margin: EdgeInsets.symmetric(vertical: 10),
                            child: FutureBuilder(
                              future: DBHelper().getFood(result.rawContent),
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
                                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                                        ),
                                        SizedBox(height: 20),
                                        Text(
                                          '유통기한',
                                          style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                                        ),
                                        SizedBox(height: 10),
                                        Text(
                                          formatter.format(food.f_POG_DAYCNT),
                                          style: TextStyle(fontSize: 14),
                                        )
                                      ],
                                    ),
                                  );
                                } else {
                                  return Center(child: CircularProgressIndicator());
                                }
                              },
                            )
                          ),
                          actions: [
                            CupertinoDialogAction(
                              child: Text("등록"),
                              onPressed: () {
                                Navigator.pop(context);
                              },
                            ),
                            CupertinoDialogAction(
                              child: Text("취소"),
                              onPressed: () => Navigator.pop(context),
                            )
                          ],
                        );
                      }
                    );
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