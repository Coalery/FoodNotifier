import 'package:flutter/material.dart';
import 'package:food_notifier/bar_widget.dart';
import 'package:food_notifier/unit/recipe.dart';

class RecipePageArguments {
  Recipe recipe;
  RecipePageArguments(this.recipe);
}

class RecipePage extends StatelessWidget {
  static final routeName = '/recipe';

  @override
  Widget build(BuildContext context) {
    RecipePageArguments arguments = ModalRoute.of(context).settings.arguments;
    Recipe recipe = arguments.recipe;

    return Scaffold(
      body: SafeArea(
        child: BarWidget(
          title: recipe.name,
          child: Container(
            
          ),
        ),
      ),
    );
  }
}