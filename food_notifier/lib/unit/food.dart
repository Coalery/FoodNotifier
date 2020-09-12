import 'package:food_notifier/unit/barcode.dart';
import 'package:food_notifier/unit/user.dart';

class Food {
  final String id;
  final User user;
  final Barcode barcode;
  final DateTime registerDateTime;

  Food(this.id, this.user, this.barcode, this.registerDateTime);


}