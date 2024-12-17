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
        ? new SamagraDetailsItems.fromJson(json['items'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['subCode'] = this.subCode;
    data['message'] = this.message;
    data['error'] = this.error;
    if (this.items != null) {
      data['items'] = this.items!.toJson();
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
      this.samagraDetail});

  SamagraDetailsItems.fromJson(Map<String, dynamic> json) {
    pdType = json['pdType'];
    sSSMPhoto = json['SSSMPhoto'];
    gasDiaryPhoto = json['gasDiaryPhoto'];
    sId = json['_id'];
    customerId = json['customerId'];
    pdId = json['pdId'];
    if (json['familyMember'] != null) {
      familyMember = <FamilyMember>[];
      json['familyMember'].forEach((v) {
        familyMember!.add(new FamilyMember.fromJson(v));
      });
    }
    samagraDetail = json['samagraDetail'] != null
        ? new SamagraDetail.fromJson(json['samagraDetail'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['pdType'] = this.pdType;
    data['SSSMPhoto'] = this.sSSMPhoto;
    data['gasDiaryPhoto'] = this.gasDiaryPhoto;
    data['_id'] = this.sId;
    data['customerId'] = this.customerId;
    data['pdId'] = this.pdId;
    if (this.familyMember != null) {
      data['familyMember'] = this.familyMember!.map((v) => v.toJson()).toList();
    }
    if (this.samagraDetail != null) {
      data['samagraDetail'] = this.samagraDetail!.toJson();
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
        ? new OccupationTypeDetails.fromJson(json['occupationTypeDetails'])
        : null;
    name = json['name'];
    age = json['age'];
    relation = json['relation'];
    dependent = json['dependent'];
    occupationType = json['occupationType'];
    sId = json['_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.occupationTypeDetails != null) {
      data['occupationTypeDetails'] = this.occupationTypeDetails!.toJson();
    }
    data['name'] = this.name;
    data['age'] = this.age;
    data['relation'] = this.relation;
    data['dependent'] = this.dependent;
    data['occupationType'] = this.occupationType;
    data['_id'] = this.sId;
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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['nameOfOrganization'] = this.nameOfOrganization;
    data['designation'] = this.designation;
    data['dateOfJoining'] = this.dateOfJoining;
    data['institutionName'] = this.institutionName;
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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['samagraFamilyIdNo'] = this.samagraFamilyIdNo;
    data['samagraIdHeadName'] = this.samagraIdHeadName;
    return data;
  }
}
