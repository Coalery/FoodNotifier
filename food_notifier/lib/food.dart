import 'package:flutter/material.dart';

class Food {
  final String _name; // 식품 이름
  final DateTime _shelfLife; // 유통기한
  final DateTime _registerDate; // 등록일

  Food({
    @required String name,
    @required DateTime shelfLife,
    @required DateTime registerDate,
  })
  : _name = name,
    _shelfLife = shelfLife,
    _registerDate = registerDate;
  
  String get name => _name;
  DateTime get shelfLife => _shelfLife;
  DateTime get registerDate => _registerDate;
}