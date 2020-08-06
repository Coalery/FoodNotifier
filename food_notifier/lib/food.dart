class Food {
  final String f_PRDLST_REPORT_NO; // 품목보고(신고)번호
  final String f_PRMS_DT; // 보고일(신고일)
  final String f_END_DT; // 생산중단일
  final String f_PRDLST_NM; // 제품명
  final String f_POG_DAYCNT; // 유통기한
  final String f_PRDLST_DCNM; // 식품 유형
  final String f_BSSH_NM; // 제조사명
  final String f_INDUTY_NM; // 업종
  final String f_SITE_ADDR; // 주소
  final String f_CLSBIZ_DT; // 폐업일자
  final String f_BAR_CD; // 유통바코드

  final DateTime f_REGISTER_DATE; // 등록일

  Food(this.f_PRDLST_REPORT_NO, this.f_PRMS_DT, this.f_END_DT, this.f_PRDLST_NM, this.f_POG_DAYCNT, this.f_PRDLST_DCNM, this.f_BSSH_NM, this.f_INDUTY_NM, this.f_SITE_ADDR, this.f_CLSBIZ_DT, this.f_BAR_CD, this.f_REGISTER_DATE);

  factory Food.byMap(Map<String, dynamic> map) {
    return Food(map['PRDLST_REPORT_NO'], map['PRMS_DT'], map['END_DT'], map['PRDLST_NM'], map['POG_DAYCNT'], map['PRDLST_DCNM'], map['BSSH_NM'], map['INDUTY_NM'], map['SITE_ADDR'], map['CLSBIZ_DT'], map['BAR_CD'], new DateTime(2020, 8, 7));
  }
}