import 'dart:io';

import 'package:flutter/services.dart';
import 'package:food_notifier/food.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DBHelper {

  DBHelper._();
  static final DBHelper _db = DBHelper._();
  factory DBHelper() => _db;

  static Database _database;

  Future<Database> get database async {
    if(_database != null) return _database;
    _database = await initDB();
    return _database;
  }

  Future<Database> initDB() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, 'data.db');

    if(FileSystemEntity.typeSync(path) == FileSystemEntityType.notFound) {
      ByteData data = await rootBundle.load(join('assets', 'data.db'));
      List<int> bytes = data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);

      await new File(path).writeAsBytes(bytes);
    }

    return await openDatabase(path, version: 1);
  }

  Future<Food> getFood(String barcode) async {
    Database db = await database;
    var res = await db.rawQuery("select * from Food where BAR_CD='$barcode'");
    if(res.length == 0) {
      return Food.none;
    }
    return Food.byMap(res.first);
  }

}