import 'package:flutter/material.dart';
import 'package:food_notifier/bar_widget.dart';
import 'package:food_notifier/db_helper.dart';
import 'package:food_notifier/unit/food.dart';
import 'package:food_notifier/unit/recipe.dart';

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
  List<Widget> _listItems = [];
  final GlobalKey<AnimatedListState> _listKey = GlobalKey();

  void _loadItems(Food food) {
    Future<List<Recipe>> recipes = DBHelper.getRecipes(food.barcode.foodType);
    recipes.then((recipeList) {
      var future = Future(() {});
      for (var i = 0; i < recipeList.length; i++) {
        future = future.then((_) {
          return Future.delayed(Duration(milliseconds: 100), () {
            _listItems.add(_buildRecipeItem(recipeList[i]));
            _listKey.currentState.insertItem(_listItems.length - 1);
          });
        });
      }
    });
  }

  Widget _buildRecipeItem(Recipe recipe) {
    return Container(
      height: 150,
      margin: EdgeInsets.only(bottom: 10),
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
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Stack(
          children: [
            Container(
              alignment: Alignment.centerRight,
              width: 150,
              height: 150,
              child: recipe.smallImage
            ),
            Container(
              width: 300,
              height: 150,
              color: Colors.black,
            )
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    FoodPageArguments arguments = ModalRoute.of(context).settings.arguments;
    Food food = arguments.food;

    _loadItems(food);

    return Scaffold(
      body: SafeArea(
        child: BarWidget(
          title: food.barcode.productName,
          child: AnimatedList(
            key: _listKey,
            padding: EdgeInsets.only(top: 10, left: 10, right: 10),
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