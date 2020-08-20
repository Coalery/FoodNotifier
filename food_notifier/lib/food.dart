import 'dart:convert';

class Food {
  static final Food none = new Food(null, null, null, null, null, null, null, null, null, null, null, null);

  final String f_PRDLST_REPORT_NO; // 품목보고(신고)번호
  final String f_PRMS_DT; // 보고일(신고일)
  final String f_END_DT; // 생산중단일
  final String f_PRDLST_NM; // 제품명
  final DateTime f_POG_DAYCNT; // 유통기한
  final String f_PRDLST_DCNM; // 식품 유형
  final String f_BSSH_NM; // 제조사명
  final String f_INDUTY_NM; // 업종
  final String f_SITE_ADDR; // 주소
  final String f_CLSBIZ_DT; // 폐업일자
  final String f_BAR_CD; // 유통바코드

  final DateTime f_REGISTER_DATE; // 등록일

  Food(this.f_PRDLST_REPORT_NO, this.f_PRMS_DT, this.f_END_DT, this.f_PRDLST_NM, this.f_POG_DAYCNT, this.f_PRDLST_DCNM, this.f_BSSH_NM, this.f_INDUTY_NM, this.f_SITE_ADDR, this.f_CLSBIZ_DT, this.f_BAR_CD, this.f_REGISTER_DATE);

  factory Food.fromJsonString(String jsonString) {
    JsonCodec codec = new JsonCodec();
    return Food.fromJson(codec.decode(jsonString));
  }

  factory Food.fromJson(dynamic json) {
    DateTime today = DateTime.now();
    DateTime onlyDateToday = new DateTime(today.year, today.month, today.day);
    DateTime resultPog = new DateTime(today.year, today.month, today.day);

    String strPOG = json['POG_DAYCNT'];

    int dateValue = 0;

    if(strPOG.length == 0) {
      resultPog = resultPog.add(Duration(days: 30));
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
          resultPog = resultPog.add(Duration(days: dateValue));
        } else if(strPOG.contains('년')) {
          resultPog = resultPog.add(Duration(days: dateValue * 365));
        } else {
          resultPog = resultPog.add(Duration(days: dateValue * 30));
        }
      } else {
        resultPog = resultPog.add(Duration(days: 30));
      }
    }

    return Food(json['PRDLST_REPORT_NO'], json['PRMS_DT'], json['END_DT'], json['PRDLST_NM'], resultPog, json['PRDLST_DCNM'], json['BSSH_NM'], json['INDUTY_NM'], json['SITE_ADDR'], json['CLSBIZ_DT'], json['BAR_CD'], onlyDateToday);
  }
}