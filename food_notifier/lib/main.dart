import 'package:flutter/material.dart';
import 'package:food_notifier/food_page.dart';
import 'package:food_notifier/login_page.dart';
import 'package:food_notifier/main_page.dart';
import 'package:food_notifier/provider/login_provider.dart';
import 'package:food_notifier/recipe_page.dart';
import 'package:provider/provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<LoginProvider>(create: (_) => LoginProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        routes: {
          '/' : (context) => LoginPage(),
          MainPage.routeName : (context) => MainPage(),
          RecipePage.routeName : (context) => RecipePage(),
          FoodPage.routeName : (context) => FoodPage(),
          LoginPage.routeName : (context) => LoginPage()
        },
      )
    );
  }
}