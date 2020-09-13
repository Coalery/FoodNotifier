import 'dart:convert';

class Barcode {
  final String id;
  final String barcode;
  final String foodType;
  final String makerName;
  final String productName;
  final DateTime shelfLife;

  Barcode(this.id, this.barcode, this.foodType, this.makerName, this.productName, this.shelfLife);

  factory Barcode.fromJsonString(String jsonString) {
    JsonCodec codec = new JsonCodec();
    return Barcode.fromJson(codec.decode(jsonString));
  }

  factory Barcode.fromJson(dynamic json) {
    DateTime today = DateTime.now();
    DateTime shelfLife = new DateTime(today.year, today.month, today.day);

    String strPOG = json['shelf_life'];

    int dateValue = 0;

    if(strPOG.length == 0) {
      shelfLife = shelfLife.add(Duration(days: 30));
    } else {
      if(strPOG.contains(new RegExp(r'[0-9]'))) {
        for(int i=0; i<strPOG.length; i++) {
          if(strPOG[i].contains(new RegExp(r'[0-9]'))) {
            int val = int.parse(strPOG[i]);
            dateValue += val;
            dateValue *= 10;
          } else {
            if(dateValue != 0) {
              break;
            }
          }
        }
        dateValue ~/= 10;
        if(strPOG.contains('일')) {
          shelfLife = shelfLife.add(Duration(days: dateValue));
        } else if(strPOG.contains('년')) {
          shelfLife = shelfLife.add(Duration(days: dateValue * 365));
        } else {
          shelfLife = shelfLife.add(Duration(days: dateValue * 30));
        }
      } else {
        shelfLife = shelfLife.add(Duration(days: 30));
      }
    }

    return Barcode(json['id'], json['barcode'], json['food_type'], json['maker_name'], json['name'], shelfLife);
  }
}