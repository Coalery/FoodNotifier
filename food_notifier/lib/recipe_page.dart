import 'package:flutter/material.dart';
import 'package:food_notifier/bar_widget.dart';
import 'package:food_notifier/unit/recipe.dart';
import 'package:scroll_snap_list/scroll_snap_list.dart';

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
            alignment: Alignment.center,
            child: Container(
              height: 500,
              child: ScrollSnapList(
                scrollDirection: Axis.horizontal,
                onItemFocus: (index) {},
                itemBuilder: (_, index) {
                  ProcessUnit process = recipe.processes[index];
                  return Container(
                    width: 350,
                    margin: EdgeInsets.symmetric(vertical: 25),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 5
                        )
                      ]
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          AspectRatio(
                            aspectRatio: 1,
                            child: process.image,
                          ),
                          Padding(
                            padding: EdgeInsets.all(10),
                            child: Text(
                              process.description,
                              style: TextStyle(fontSize: 16),
                            ),
                          )
                        ],
                      ),
                    ),
                  );
                },
                itemSize: 350,
                itemCount: recipe.processes.length,
                dynamicItemSize: true,
              ),
            ),
          ),
        ),
      ),
    );
  }
}