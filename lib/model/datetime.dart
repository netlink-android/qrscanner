import 'package:flutter/animation.dart';
import 'package:flutter/cupertino.dart';

class DateTimeModel {
  late final String dayStr;
  late final int year;
  late final int month;
  late final int day;
  late final String time;

  DateTimeModel(
    this.dayStr,
    this.year,
    this.month,
    this.day,
    this.time,
  );

  //constructor that convert json to object instance
  DateTimeModel.fromJson(Map<String, dynamic> json)
      : dayStr = json['dayStr'],
        year = json['year'],
        month = json['month'],
        day = json['day'],
        time = json['time'];

  //a method that convert object to json
  Map<String, dynamic> toJson() => {
        'dayStr': dayStr,
        'year': year,
        'month': month,
        'day': day,
        'time': time,
      };

      @override
  String toString() {
    return '$dayStr $year/$month/$day';
  }
}
