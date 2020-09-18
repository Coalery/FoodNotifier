import 'package:flutter/material.dart';
import 'package:food_notifier/bar_widget.dart';
import 'package:food_notifier/unit/food.dart';

class FoodPageArguments {
  final Food food;
  FoodPageArguments(this.food);
}

class FoodPage extends StatefulWidget {
  static final routeName = '/food';

  @override
  _FoodPageState createState() => _FoodPageState();
}

class _FoodPageState extends State<FoodPage> {
  List<Widget> _listItems = <Widget>[];
  final GlobalKey<AnimatedListState> _listKey = GlobalKey();

  void _loadItems() {
    final fetchedList = [
      ListTile(
        title: Text('Economy'),
        trailing: Icon(Icons.directions_car),
      ),
      ListTile(
        title: Text('Comfort'),
        trailing: Icon(Icons.motorcycle),
      ),
      ListTile(
        title: Text('Business'),
        trailing: Icon(Icons.flight),
      ),
    ];

    var future = Future(() {});
    for (var i = 0; i < fetchedList.length; i++) {
      future = future.then((_) {
        return Future.delayed(Duration(milliseconds: 100), () {
          _listItems.add(fetchedList[i]);
          _listKey.currentState.insertItem(_listItems.length - 1);
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    FoodPageArguments arguments = ModalRoute.of(context).settings.arguments;
    Food food = arguments.food;

    return Scaffold(
      body: SafeArea(
        child: BarWidget(
          title: food.barcode.productName,
          child: AnimatedList(
            key: _listKey,
            padding: EdgeInsets.all(10),
            itemBuilder: (context, index, animation) {
              return SlideTransition(
                position: CurvedAnimation(
                  curve: Curves.easeOut,
                  parent: animation
                ).drive(Tween<Offset>(
                  begin: Offset(1, 0),
                  end: Offset(0, 0)
                )),
                child: _listItems[index],
              );
            },
          ),
        ),
      ),
    );
  }
}