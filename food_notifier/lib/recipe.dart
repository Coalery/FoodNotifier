import 'dart:convert';

import 'package:flutter/material.dart';

class Recipe {
  static final Recipe none = new Recipe(null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

  final String f_RCP_SEQ; // 일련번호
  final String f_RCP_NM; // 메뉴명
  final String f_RCP_WAY2; // 조리방법
  final String f_RCP_PAT2; // 요리종류
  final double f_INFO_WGT; // 중량(1인분)
  final double f_INFO_ENG; // 열량
  final double f_INFO_CAR; // 탄수화물
  final double f_INFO_PRO; // 단백질
  final double f_INFO_FAT; // 지방
  final double f_INFO_NA; // 나트륨
  final String f_HASH_TAG; // 해시태그
  final Image f_ATT_FILE_NO_MAIN; // 이미지경로(소)
  final Image f_ATT_MILE_NO_MK; // 이미지경로(대)
  final String f_RCP_PARTS_DTLS; // 재료정보
  final List<ProcessUnit> processes;

  Recipe(this.f_RCP_SEQ, this.f_RCP_NM, this.f_RCP_WAY2, this.f_RCP_PAT2, this.f_INFO_WGT, this.f_INFO_ENG, this.f_INFO_CAR, this.f_INFO_PRO, this.f_INFO_FAT, this.f_INFO_NA, this.f_HASH_TAG, this.f_ATT_FILE_NO_MAIN, this.f_ATT_MILE_NO_MK, this.f_RCP_PARTS_DTLS, this.processes);

  factory Recipe.fromJsonString(String jsonString) {
    JsonCodec codec = new JsonCodec();
    return Recipe.fromJson(codec.decode(jsonString));
  }

  static double parse(String target) {
    if(target == '') {
      return 0.0;
    } else return double.parse(target);
  }

  static Image getImage(String url) {
    Image errorImage = Image.asset('assets/white.png');
    if(url == null) return errorImage;
    if(url == '') return errorImage;
    if(!url.startsWith('http')) return errorImage;
    return Image.network(url, errorBuilder: (_, __, ___) => errorImage,);
  }

  factory Recipe.fromJson(dynamic json) {
    double wgt = parse(json['INFO_WGT']);
    double eng = parse(json['INFO_ENG']);
    double car = parse(json['INFO_CAR']);
    double pro = parse(json['INFO_PRO']);
    double fat = parse(json['INFO_FAT']);
    double na = parse(json['INFO_NA']);

    Image mainImage = getImage(json['ATT_FILE_NO_MAIN']);
    Image mkImage = getImage(json['ATT_FILE_NO_MK']);

    List<ProcessUnit> processes = [];
    for(int i=1; i<=20; i++) {
      String intFormat = i.toString();
      if(i < 10) intFormat = "0" + intFormat;

      String imageURL = json['MANUAL_IMG' + intFormat];
      String description = json['MANUAL' + intFormat];

      Image image;
      if(imageURL != '') {
        image = getImage(imageURL);
      }

      if(description != null && description != '') {
        processes.add(new ProcessUnit(image, description));
      }
    }

    return Recipe(json['RCP_SEQ'], json['RCP_NM'], json['RCP_WAY2'], json['RCP_PAT2'], wgt, eng, car, pro, fat, na, json['HASH_TAG'], mainImage, mkImage, json['RCP_PARTS_DTLS'], processes);
  }
}

class ProcessUnit {
  final Image image;
  final String description;
  ProcessUnit(this.image, this.description);
}