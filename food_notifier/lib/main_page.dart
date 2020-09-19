import 'package:barcode_scan/barcode_scan.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_notifier/db_helper.dart';
import 'package:food_notifier/provider/login_provider.dart';
import 'package:food_notifier/unit/barcode.dart';
import 'package:food_notifier/food_page.dart';
import 'package:food_notifier/unit/food.dart';
import 'package:food_notifier/unit/user.dart';
import 'package:food_notifier/util.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class MainPage extends StatefulWidget {
  static String routeName = '/main';

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    User me = Provider.of<LoginProvider>(context).me;

    return Scaffold(
      key: _scaffoldKey,
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
                          color: mainColor,
                        ),
                        SizedBox(width: 10),
                        Text(
                          '유통기한이 얼마 남지 않았어요!',
                          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)
                        )
                      ]
                    )
                  ),
                  FutureBuilder<List<Food>>(
                    future: DBHelper.getOutofDateFoods(me),
                    builder: (context, snapshot) {
                      print(snapshot);
                      if(snapshot.hasData) {
                        List<Food> foodList = snapshot.data;
                        foodList.sort((food1, food2) {
                          if(food1.barcode.remainedDays < food2.barcode.remainedDays) return 1;
                          else if(food1.barcode.remainedDays > food2.barcode.remainedDays) return -1;
                          return 0;
                        });

                        if(foodList.length == 0) {
                          return Container(
                            width: double.infinity,
                            height: 200,
                            alignment: Alignment.center,
                            child: Text(
                              '등록된 음식이 없습니다!',
                              style: TextStyle(fontSize: 18)
                            ),
                          );
                        }

                        return Container(
                          width: double.infinity,
                          height: 200,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: foodList.length,
                            itemBuilder: (context, index) {
                              Food food = foodList[index];

                              int remainedDays = food.barcode.remainedDays;
                              String remainedDaysStr = 'D' + (remainedDays > 0 ? '+' : '') + remainedDays.toString();

                              return GestureDetector(
                                child: Container(
                                  width: 300,
                                  margin: EdgeInsets.only(top: 10, bottom: 10, left: 20, right: 20),
                                  padding: EdgeInsets.all(20),
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
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        food.barcode.productName,
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(color: mainColor, fontSize: 26, fontWeight: FontWeight.bold)
                                      ),
                                      SizedBox(height: 5),
                                      Text(
                                        remainedDaysStr,
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(fontSize: 24)
                                      )
                                    ],
                                  ),
                                ),
                                onTap: () => Navigator.pushNamed(context, FoodPage.routeName, arguments: FoodPageArguments(foodList[index])),
                              );
                            },
                          ),
                        );
                      } else {
                        return Container(
                          height: 200,
                          child: Center(child: CircularProgressIndicator()),
                        );
                      }
                    },
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
                  SizedBox(height: 20),
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
                    result.rawContent = '8801005107020';
                    if(result.rawContent == '') {
                      return;
                    }

                    Barcode barcode;

                    showCupertinoDialog(
                      context: context,
                      builder: (context) {
                        return CupertinoAlertDialog(
                          content: Container(
                            margin: EdgeInsets.symmetric(vertical: 10),
                            child: FutureBuilder(
                              future: DBHelper.getBarcode(result.rawContent),
                              builder: (_, snapshot) {
                                if(snapshot.hasData) {
                                  barcode = snapshot.data;
                                  if(barcode == null) {
                                    return Center(child: Text('바코드를 인식할 수 없습니다.'));
                                  }

                                  DateFormat formatter = new DateFormat('yyyy/MM/dd');
                                  return Container(
                                    alignment: Alignment.center,
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          barcode.productName,
                                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                                        ),
                                        SizedBox(height: 20),
                                        Text(
                                          '유통기한',
                                          style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                                        ),
                                        SizedBox(height: 10),
                                        Text(
                                          formatter.format(barcode.shelfLife),
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
                              onPressed: () async {
                                if(me == null || barcode == null) {
                                  return;
                                }
                                print(me.id);
                                bool isSuccess = await DBHelper.postFood(me.id, barcode.barcode, DateTime.now());
                                if(!isSuccess) {
                                  _scaffoldKey.currentState.showSnackBar(
                                    SnackBar(
                                      content: Text('음식을 등록하는데 실패하였습니다!'),
                                      backgroundColor: Colors.redAccent,
                                    )
                                  );
                                } else {
                                  setState(() {});
                                }
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