class SamagraDetailsModel {
  bool? status;
  int? subCode;
  String? message;
  String? error;
  SamagraDetailsItems? items;

  SamagraDetailsModel(
      {this.status, this.subCode, this.message, this.error, this.items});

  SamagraDetailsModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    subCode = json['subCode'];
    message = json['message'];
    error = json['error'];
    items = json['items'] != null
        ? SamagraDetailsItems.fromJson(json['items'])
        : null;
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

class SamagraDetailsItems {
  String? pdType;
  String? sSSMPhoto;
  String? gasDiaryPhoto;
  String? sId;
  String? customerId;
  String? pdId;
  String? meterPhoto;
  String? electricityBillPhoto;
  List<FamilyMember>? familyMember;
  SamagraDetail? samagraDetail;

  SamagraDetailsItems(
      {this.pdType,
      this.sSSMPhoto,
      this.gasDiaryPhoto,
      this.sId,
      this.customerId,
      this.pdId,
      this.familyMember,
      this.samagraDetail,
        this.meterPhoto, this.electricityBillPhoto
      });

  SamagraDetailsItems.fromJson(Map<String, dynamic> json) {
    pdType = json['pdType'];
    sSSMPhoto = json['SSSMPhoto'];
    gasDiaryPhoto = json['gasDiaryPhoto'];
    sId = json['_id'];
    customerId = json['customerId'];
    pdId = json['pdId'];
    meterPhoto = json['meterPhoto'];
    electricityBillPhoto = json['electricityBillPhoto'];
    if (json['familyMember'] != null) {
      familyMember = <FamilyMember>[];
      json['familyMember'].forEach((v) {
        familyMember!.add(FamilyMember.fromJson(v));
      });
    }
    samagraDetail = json['samagraDetail'] != null
        ? SamagraDetail.fromJson(json['samagraDetail'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['pdType'] = pdType;
    data['SSSMPhoto'] = sSSMPhoto;
    data['gasDiaryPhoto'] = gasDiaryPhoto;
    data['_id'] = sId;
    data['customerId'] = customerId;
    data['pdId'] = pdId;
    data['meterPhoto'] = meterPhoto;
    data['electricityBillPhoto'] = electricityBillPhoto;
    if (familyMember != null) {
      data['familyMember'] = familyMember!.map((v) => v.toJson()).toList();
    }
    if (samagraDetail != null) {
      data['samagraDetail'] = samagraDetail!.toJson();
    }
    return data;
  }
}

class FamilyMember {
  OccupationTypeDetails? occupationTypeDetails;
  String? name;
  int? age;
  String? relation;
  String? dependent;
  String? occupationType;
  String? sId;

  FamilyMember(
      {this.occupationTypeDetails,
      this.name,
      this.age,
      this.relation,
      this.dependent,
      this.occupationType,
      this.sId});

  FamilyMember.fromJson(Map<String, dynamic> json) {
    occupationTypeDetails = json['occupationTypeDetails'] != null
        ? OccupationTypeDetails.fromJson(json['occupationTypeDetails'])
        : null;
    name = json['name'];
    age = json['age'];
    relation = json['relation'];
    dependent = json['dependent'];
    occupationType = json['occupationType'];
    sId = json['_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (occupationTypeDetails != null) {
      data['occupationTypeDetails'] = occupationTypeDetails!.toJson();
    }
    data['name'] = name;
    data['age'] = age;
    data['relation'] = relation;
    data['dependent'] = dependent;
    data['occupationType'] = occupationType;
    data['_id'] = sId;
    return data;
  }
}

class OccupationTypeDetails {
  String? nameOfOrganization;
  String? designation;
  String? dateOfJoining;
  String? institutionName;

  OccupationTypeDetails(
      {this.nameOfOrganization,
      this.designation,
      this.dateOfJoining,
      this.institutionName});

  OccupationTypeDetails.fromJson(Map<String, dynamic> json) {
    nameOfOrganization = json['nameOfOrganization'];
    designation = json['designation'];
    dateOfJoining = json['dateOfJoining'];
    institutionName = json['institutionName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['nameOfOrganization'] = nameOfOrganization;
    data['designation'] = designation;
    data['dateOfJoining'] = dateOfJoining;
    data['institutionName'] = institutionName;
    return data;
  }
}

class SamagraDetail {
  String? samagraFamilyIdNo;
  String? samagraIdHeadName;

  SamagraDetail({this.samagraFamilyIdNo, this.samagraIdHeadName});

  SamagraDetail.fromJson(Map<String, dynamic> json) {
    samagraFamilyIdNo = json['samagraFamilyIdNo'];
    samagraIdHeadName = json['samagraIdHeadName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['samagraFamilyIdNo'] = samagraFamilyIdNo;
    data['samagraIdHeadName'] = samagraIdHeadName;
    return data;
  }
}
