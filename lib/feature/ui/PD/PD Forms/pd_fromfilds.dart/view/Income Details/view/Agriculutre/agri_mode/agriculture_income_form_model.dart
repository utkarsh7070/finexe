class AgricultureDataModel {
  final String incomeSourceType;
  final AgricultureData data;

  AgricultureDataModel({
    required this.incomeSourceType,
    required this.data,
  });

  Map<String, dynamic> toJson() => {
    'incomeSourceType': incomeSourceType,
    'data': data.toJson(),
  };
}

class AgricultureData {
  final String haveYouFaced;
  final List<String> nameOfAgriOwner;
  final String relationOfApplicant;
  final String kasraSurveyNo;
  final String agriLandInBigha;
  final String otherName;
  final String otherRelation;
  final String otherRemark;
  final String villageName;
  final String detailOfLastCorp;
  final String howMuchCropSoldInAmt;
  final List<String> agriculturePhotos;
  final List<String> whichCropIsPlanted;
  final String agriDoingFromNoOfYears;
  final String addressAsPerPawti;
  final String districtName;
  final String agriLandSurveyNo;
  final String fertilizerShopOwnerName;
  final String fertilizerShopOwnerContactNumber;
  final String irrigationMethod;
  final String significantChallengesThisSeason;
  final String agriIncomeYearly;
  final String ifCropDestroyedHowToPayEMI;

  AgricultureData({
    required this.haveYouFaced,
    required this.nameOfAgriOwner,
    required this.relationOfApplicant,
    required this.kasraSurveyNo,
    required this.agriLandInBigha,
    required this.otherName,
    required this.otherRelation,
    required this.otherRemark,
    required this.villageName,
    required this.detailOfLastCorp,
    required this.howMuchCropSoldInAmt,
    required this.agriculturePhotos,
    required this.whichCropIsPlanted,
    required this.agriDoingFromNoOfYears,
    required this.addressAsPerPawti,
    required this.districtName,
    required this.agriLandSurveyNo,
    required this.fertilizerShopOwnerName,
    required this.fertilizerShopOwnerContactNumber,
    required this.irrigationMethod,
    required this.significantChallengesThisSeason,
    required this.agriIncomeYearly,
    required this.ifCropDestroyedHowToPayEMI,
  });

  factory AgricultureData.fromJson(Map<String, dynamic> json) {
    return AgricultureData(
      haveYouFaced: json['haveYouFaced'] ?? '',
      nameOfAgriOwner: List<String>.from(json['nameOfAgriOwner'] ?? []),
      relationOfApplicant: json['relationOfApplicant'] ?? '',
      kasraSurveyNo: json['kasraSurveyNo'] ?? '',
      agriLandInBigha: json['agriLandInBigha'] ?? '',
      otherName: json['otherName'] ?? '',
      otherRelation: json['otherRelation'] ?? '',
      otherRemark: json['otherRemark'] ?? '',
      villageName: json['villageName'] ?? '',
      detailOfLastCorp: json['detailOfLastCorp'] ?? '',
      howMuchCropSoldInAmt: json['howmuchcorpsoldInAmt'] ?? '',
      agriculturePhotos: List<String>.from(json['agriculturePhotos'] ?? []),
      whichCropIsPlanted: List<String>.from(json['whichCropIsPlanted'] ?? []),
      agriDoingFromNoOfYears: json['agriDoingFromNoOfYears'] ?? '',
      addressAsPerPawti: json['addressAsPerPawti'] ?? '',
      districtName: json['districtName'] ?? '',
      agriLandSurveyNo: json['agriLandSurveyNo'] ?? '',
      fertilizerShopOwnerName: json['fertilizerShopOwnerName'] ?? '',
      fertilizerShopOwnerContactNumber: json['fertilizerShopOwnerContactNumber'] ?? '',
      irrigationMethod: json['WhatTypeOfIrrigationMethod'] ?? '',
      significantChallengesThisSeason: json['significantChallengesThisSeason'] ?? '',
      agriIncomeYearly: json['agriIncomeYearly'] ?? '',
      ifCropDestroyedHowToPayEMI: json['ifCropDestroyedHowToPayEMI'] ?? '',
    );
  }

  get howmuchcorpsoldInAmt => null;

  Map<String, dynamic> toJson() => {
    'haveYouFaced': haveYouFaced,
    'nameOfAgriOwner': nameOfAgriOwner,
    'relationOfApplicant': relationOfApplicant,
    'kasraSurveyNo': kasraSurveyNo,
    'agriLandInBigha': agriLandInBigha,
    'otherName': otherName,
    'otherRelation': otherRelation,
    'otherRemark': otherRemark,
    'villageName': villageName,
    'detailOfLastCorp': detailOfLastCorp,
    'howmuchcorpsoldInAmt': howMuchCropSoldInAmt,
    'agriculturePhotos': agriculturePhotos,
    'whichCropIsPlanted': whichCropIsPlanted,
    'agriDoingFromNoOfYears': agriDoingFromNoOfYears,
    'addressAsPerPawti': addressAsPerPawti,
    'districtName': districtName,
    'agriLandSurveyNo': agriLandSurveyNo,
    'fertilizerShopOwnerName': fertilizerShopOwnerName,
    'fertilizerShopOwnerContactNumber': fertilizerShopOwnerContactNumber,
    'WhatTypeOfIrrigationMethod': irrigationMethod,
    'significantChallengesThisSeason': significantChallengesThisSeason,
    'agriIncomeYearly': agriIncomeYearly,
    'ifCropDestroyedHowToPayEMI': ifCropDestroyedHowToPayEMI,
  };
}


// ----------other drop down----------
class OtherDropData {
  final List<String> otherdrop;
  OtherDropData({
    required this.otherdrop
});

  factory OtherDropData.fromJson(Map<String, dynamic> json){
    return OtherDropData(
      otherdrop: List<String>.from(json['nameOfAgriOwner'] ?? [])
    );
  }
  Map<String, dynamic> toJson() =>
      {
        'OtherDropData': OtherDropData,
      };
}