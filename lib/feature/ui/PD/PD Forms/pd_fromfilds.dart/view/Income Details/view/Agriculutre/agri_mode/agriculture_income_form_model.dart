class AgricultureDataModel {
  bool? status;
  int? subCode;
  String? message;
  String? error;
  AgricultreItems? items;

  AgricultureDataModel({this.status, this.subCode, this.message, this.error, this.items});

  AgricultureDataModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    subCode = json['subCode'];
    message = json['message'];
    error = json['error'];
    items = json['items'] != null ? AgricultreItems.fromJson(json['items']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['subCode'] = subCode;
    data['message'] = message;
    data['error'] = error;
    if (items != null) {
      data['items'] = items!.toJson();
    }
    return data;
  }
}



class AgricultreItems {
  String? incomeSourceType;
  AgricultureData? agricultureData;

  AgricultreItems({
    this.incomeSourceType,
    this.agricultureData,
  });

  factory AgricultreItems.fromJson(Map<String, dynamic> json) {
    return AgricultreItems(
      incomeSourceType: json['incomeSourceType'],
      agricultureData: json['data'] != null
          ? AgricultureData.fromJson(json['agricultureBusiness'])
          : null,
    );
  }

  Map<String, dynamic> toJson() => {
    'incomeSourceType': incomeSourceType,
    'data': agricultureData?.toJson(),
  };
}


class AgricultureData {
  String? haveYouFaced;
  List<String>? nameOfAgriOwner;
  String? relationOfApplicant;
  String? kasraSurveyNo;
  String? agriLandInBigha;
  String? otherName;
  String? otherRelation;
  String? otherRemark;
  String? villageName;
  String? detailOfLastCorp;
  String? howMuchCropSoldInAmt;
  List<String>? agriculturePhotos;
  List<String>? whichCropIsPlanted;
  String? agriDoingFromNoOfYears;
  String? addressAsPerPawti;
  String? districtName;
  String? agriLandSurveyNo;
  String? fertilizerShopOwnerName;
  String? fertilizerShopOwnerContactNumber;
  String? irrigationMethod;
  String? significantChallengesThisSeason;
  String? agriIncomeYearly;
  String? ifCropDestroyedHowToPayEMI;

  AgricultureData({
    this.haveYouFaced,
    this.nameOfAgriOwner,
    this.relationOfApplicant,
    this.kasraSurveyNo,
    this.agriLandInBigha,
    this.otherName,
    this.otherRelation,
    this.otherRemark,
    this.villageName,
    this.detailOfLastCorp,
    this.howMuchCropSoldInAmt,
    this.agriculturePhotos,
    this.whichCropIsPlanted,
    this.agriDoingFromNoOfYears,
    this.addressAsPerPawti,
    this.districtName,
    this.agriLandSurveyNo,
    this.fertilizerShopOwnerName,
    this.fertilizerShopOwnerContactNumber,
    this.irrigationMethod,
    this.significantChallengesThisSeason,
    this.agriIncomeYearly,
    this.ifCropDestroyedHowToPayEMI,
  });

  factory AgricultureData.fromJson(Map<String, dynamic> json) {
    return AgricultureData(
      haveYouFaced: json['haveYouFaced'],
      nameOfAgriOwner: (json['nameOfAgriOwner'] as List?)?.cast<String>(),
      relationOfApplicant: json['relationOfApplicant'],
      kasraSurveyNo: json['kasraSurveyNo'],
      agriLandInBigha: json['agriLandInBigha'],
      otherName: json['otherName'],
      otherRelation: json['otherRelation'],
      otherRemark: json['otherRemark'],
      villageName: json['villageName'],
      detailOfLastCorp: json['detailOfLastCorp'],
      howMuchCropSoldInAmt: json['howmuchcorpsoldInAmt'],
      agriculturePhotos: (json['agriculturePhotos'] as List?)?.cast<String>(),
      whichCropIsPlanted: (json['whichCropIsPlanted'] as List?)?.cast<String>(),
      agriDoingFromNoOfYears: json['agriDoingFromNoOfYears'],
      addressAsPerPawti: json['addressAsPerPawti'],
      districtName: json['districtName'],
      agriLandSurveyNo: json['agriLandSurveyNo'],
      fertilizerShopOwnerName: json['fertilizerShopOwnerName'],
      fertilizerShopOwnerContactNumber: json['fertilizerShopOwnerContactNumber'],
      irrigationMethod: json['WhatTypeOfIrrigationMethod'],
      significantChallengesThisSeason: json['significantChallengesThisSeason'],
      agriIncomeYearly: json['agriIncomeYearly'],
      ifCropDestroyedHowToPayEMI: json['ifCropDestroyedHowToPayEMI'],
    );
  }

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

class OtherDropData {
  List<String>? otherdrop;

  OtherDropData({this.otherdrop});

  factory OtherDropData.fromJson(Map<String, dynamic> json) {
    return OtherDropData(
      otherdrop: (json['nameOfAgriOwner'] as List?)?.cast<String>(),
    );
  }

  Map<String, dynamic> toJson() => {
    'OtherDropData': otherdrop,
  };
}
