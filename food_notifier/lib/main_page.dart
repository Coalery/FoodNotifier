import 'package:flutter/material.dart';

class MainPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          alignment: Alignment.center,
          child: Wrap(
            children: [
              Container(
                width: 200,
                height: 200,
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
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(100.0),
                  child: FlatButton(
                    child: Image.asset('assets/bar_code.png', width: 150, height: 150),
                    onPressed: () {
                      
                    },
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}