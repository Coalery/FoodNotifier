import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BarWidget extends StatelessWidget {
  final Widget _child;
  final String _title;

  BarWidget({
    @required Widget child,
    String title : ''
  })
  : _child = child,
    _title = title;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Padding(
          padding: EdgeInsets.only(top: 50),
          child: _child
        ),
        Container( // Upper bar
          height: 50,
          child: Stack(
            children: [
              Material(
                type: MaterialType.transparency,
                child: Row(
                  children: [
                    IconButton(
                      icon: Icon(Icons.keyboard_arrow_left),
                      onPressed: () => Navigator.pop(context),
                    ),
                    Text(
                      _title,
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    )
                  ],
                ),
              )
            ],
          ),
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 5,
              )
            ]
          )
        )
      ],
    );
  }
}