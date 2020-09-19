import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class Recipe {
  static final Recipe none = new Recipe(null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

  final String id; // 일련번호
  final String name; // 메뉴명
  final String way; // 조리방법
  final String type; // 요리종류
  final double wgt; // 중량(1인분)
  final double eng; // 열량
  final double car; // 탄수화물
  final double pro; // 단백질
  final double fat; // 지방
  final double nat; // 나트륨
  final String hashTag; // 해시태그
  final Widget smallImage; // 이미지(소)
  final Widget bigImage; // 이미지(대)
  final String ingredients; // 재료정보
  final List<ProcessUnit> processes;

  Recipe(this.id, this.name, this.way, this.type, this.wgt, this.eng, this.car, this.pro, this.fat, this.nat, this.hashTag, this.smallImage, this.bigImage, this.ingredients, this.processes);

  factory Recipe.fromJsonString(String jsonString) {
    JsonCodec codec = new JsonCodec();
    return Recipe.fromJson(codec.decode(jsonString));
  }

  static double parse(String target) {
    if(target == '') {
      return 0.0;
    } else return double.parse(target);
  }

  static Widget getImage(String url) {
    Image errorImage = Image.asset('assets/404.png');
    if(url == null) return errorImage;
    if(url == '') return errorImage;
    if(!url.startsWith('http')) return errorImage;
    return CachedNetworkImage(
      imageUrl: url,
      placeholder: (context, url) => CircularProgressIndicator(),
      errorWidget: (context, url, error) => errorImage,
    );
  }

  factory Recipe.fromJson(dynamic json) {
    String id = json['id'];
    String name = json['name'];
    String way = json['way'];
    String type = json['type'];

    double wgt = parse(json['wgt']);
    double eng = parse(json['eng']);
    double car = parse(json['car']);
    double pro = parse(json['pro']);
    double fat = parse(json['fat']);
    double nat = parse(json['nat']);

    String hashTag = json['hash_tag'];

    Widget smallImage = getImage(json['image_small']);
    Widget bigImage = getImage(json['image_big']);

    String ingredients = json['ingredients'];

    List<ProcessUnit> processes = [];
    for(int i=1; i<=20; i++) {
      String intFormat = i.toString();
      if(i < 10) intFormat = "0" + intFormat;

      String imageURL = json['manual_img' + intFormat];
      String description = json['manual' + intFormat];

      Widget image;
      if(imageURL != '') {
        image = getImage(imageURL);
      }

      if(description != null && description != '') {
        processes.add(new ProcessUnit(image, description));
      }
    }

    return Recipe(id, name, way, type, wgt, eng, car, pro, fat, nat, hashTag, smallImage, bigImage, ingredients, processes);
  }
}

class ProcessUnit {
  final Widget image;
  final String description;
  ProcessUnit(this.image, this.description);
}