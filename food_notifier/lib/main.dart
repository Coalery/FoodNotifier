import 'package:flutter/material.dart';
import 'package:food_notifier/main_page.dart';
import 'package:food_notifier/recipe_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        '/' : (context) => MainPage(),
        MainPage.routeName : (context) => MainPage(),
        RecipePage.routeName : (context) => RecipePage()
      },
    );
  }
}