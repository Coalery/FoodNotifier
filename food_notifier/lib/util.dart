import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

const Color mainColor = Colors.blueAccent;

DateTime parseStringToDateTime(String val) {
  int year = int.parse(val.substring(0, 4));
  int month = int.parse(val.substring(4, 6));
  int day = int.parse(val.substring(6, 8));
  int hour = int.parse(val.substring(8, 10));
  int minute = int.parse(val.substring(10, 12));

  return DateTime(year, month, day, hour, minute);
}

String parseDateTimeToString(DateTime val) {
  DateFormat formatter = new DateFormat("yyyyMMddHHmm");
  return formatter.format(val);
}