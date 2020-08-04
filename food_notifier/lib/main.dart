import 'package:flutter/material.dart';
import 'package:food_notifier/main_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        '/' : (context) => MainPage()
      },
    );
  }
}