import 'dart:convert';

import 'package:flutter/material.dart';

class Recipe {
  static final Recipe none = new Recipe(null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

  final String f_RCP_SEQ; // 일련번호
  final String f_RCP_NM; // 메뉴명
  final String f_RCP_WAY2; // 조리방법
  final String f_RCP_PAT2; // 요리종류
  final int f_INFO_WGT; // 중량(1인분)
  final int f_INFO_ENG; // 열량
  final int f_INFO_CAR; // 탄수화물
  final int f_INFO_PRO; // 단백질
  final int f_INFO_FAT; // 지방
  final int f_INFO_NA; // 나트륨
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

  factory Recipe.fromJson(dynamic json) {
    int wgt = int.parse(json['INFO_WGT']);
    int eng = int.parse(json['INFO_ENG']);
    int car = int.parse(json['INFO_CAR']);
    int pro = int.parse(json['INFO_PRO']);
    int fat = int.parse(json['INFO_FAT']);
    int na = int.parse(json['INFO_NA']);

    Image mainImage = Image.network(json['ATT_FILE_NO_MAIN']);
    Image mkImage = Image.network(json['ATT_FILE_NO_MK']);

    List<ProcessUnit> processes = [];
    for(int i=1; i<=20; i++) {
      String intFormat = i.toString();
      if(i < 10) intFormat = "0" + intFormat;

      String imageURL = json['MANUAL_IMG' + intFormat];
      String description = json['MANUAL' + intFormat];

      Image image;
      if(imageURL != '') {
        image = Image.network(imageURL);
      }

      ProcessUnit pUnit = new ProcessUnit(image, description);

      processes.add(pUnit);
    }

    return Recipe(json['RCP_SEQ'], json['RCP_NM'], json['RCP_WAY2'], json['RCP_PAT2'], wgt, eng, car, pro, fat, na, json['HASH_TAG'], mainImage, mkImage, json['RCP_PARTS_DTLS'], processes);
  }
}

class ProcessUnit {
  final Image image;
  final String description;
  ProcessUnit(this.image, this.description);
}