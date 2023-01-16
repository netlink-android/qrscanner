import 'package:flutter/material.dart';

import '../const.dart';
import 'datetime.dart';

class QrCustomModel {
  late final String data;
  late final String type;
  late final String image;
  late final String titleType;
  late final String typeicon;

  late final String bodyColor, eyeColor;
  late final int bodyvalue, eyevalue;
  late final DateTimeModel date;
  late final bool favorite;
  QrCustomModel({
    required this.data,
    required this.type,
    required this.image,
    required this.titleType,
    required this.typeicon,
    required this.bodyColor,
    required this.eyeColor,
    required this.bodyvalue,
    required this.eyevalue,
    required this.date,
    required this.favorite,
  });
  QrCustomModel.fromJson(Map<String, dynamic> json)
      : data = json['data'],
        type = json['type'],
        image = json['image'],
        titleType = json['titleType'],
        typeicon = json['typeicon'],
        bodyColor = json['bodyColor'],
        eyeColor = json['eyeColor'],
        bodyvalue = json['bodyvalue'],
        eyevalue = json['eyevalue'],
        date = DateTimeModel.fromJson(json['date']),
        favorite = json['favorite'];

  Map<String, dynamic> toJson() => {
        'data': data,
        'type': type,
        'image': image,
        'titleType': titleType,
        'typeicon': typeicon,
        'bodyColor': bodyColor,
        'eyeColor': eyeColor,
        'bodyvalue': bodyvalue,
        'eyevalue': eyevalue,
        'date': date.toJson(),
        'favorite': favorite
      };

  @override
  String toString() {
    return '{data: $data,type: $type, image: $image, titleType: $titleType, typeicon: $typeicon, bodyColor: $bodyColor, eyeColor: $eyeColor, bodyvalue: $bodyvalue, eyevalue: $eyevalue,  date: $date, favorite: $favorite}';
  }
}
