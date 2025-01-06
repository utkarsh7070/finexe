class GauranterFormModel {
  bool? status;
  int? subCode;
  String? message;
  String? error;
  GauranterItems? items;

  GauranterFormModel(
      {this.status, this.subCode, this.message, this.error, this.items});

  GauranterFormModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    subCode = json['subCode'];
    message = json['message'];
    error = json['error'];
    items = json['items'] != null
        ? GauranterItems.fromJson(json['items'])
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

class GauranterItems {
  String? sId;
  String? customerId;
  String? pdId;
  String? pdType;
  String? guarantorImage;
  Guarantor? guarantor;

  GauranterItems(
      {this.sId,
      this.customerId,
      this.pdId,
      this.pdType,
      this.guarantor,
      this.guarantorImage});

  GauranterItems.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    customerId = json['customerId'];
    pdId = json['pdId'];
    pdType = json['pdType'];
    guarantor = json['guarantor'] != null
        ? Guarantor.fromJson(json['guarantor'])
        : null;
    guarantorImage = json['guarantorImage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['customerId'] = customerId;
    data['pdId'] = pdId;
    data['pdType'] = pdType;
    if (guarantor != null) {
      data['guarantor'] = guarantor!.toJson();
    }
    data['guarantorImage'] = guarantorImage;
    return data;
  }
}

class Guarantor {
  String? guarantorType;
  String? businessType;
  String? occupation;
  String? residenceType;
  String? dOB;
  String? emailId;
  String? houseLandMark;
  String? alternateMobileNo;
  String? noOfyearsAtCurrentAddress;
  String? gender;
  String? religion;
  String? nationality;
  String? category;
  String? caste;
  String? maritalStatus;
  String? educationalDetails;

  Guarantor(
      {this.guarantorType,
      this.businessType,
      this.occupation,
      this.residenceType,
      this.dOB,
      this.emailId,
      this.houseLandMark,
      this.alternateMobileNo,
      this.noOfyearsAtCurrentAddress,
      this.gender,
      this.religion,
      this.nationality,
      this.category,
      this.caste,
      this.maritalStatus,
      this.educationalDetails});

  Guarantor.fromJson(Map<String, dynamic> json) {
    guarantorType = json['guarantorType'];
    businessType = json['businessType'];
    occupation = json['occupation'];
    residenceType = json['residenceType'];
    dOB = json['DOB'];
    emailId = json['emailId'];
    houseLandMark = json['houseLandMark'];
    alternateMobileNo = json['alternateMobileNo'];
    noOfyearsAtCurrentAddress = json['noOfyearsAtCurrentAddress'];
    gender = json['gender'];
    religion = json['religion'];
    nationality = json['nationality'];
    category = json['category'];
    caste = json['caste'];
    maritalStatus = json['maritalStatus'];
    educationalDetails = json['educationalDetails'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['guarantorType'] = guarantorType;
    data['businessType'] = businessType;
    data['occupation'] = occupation;
    data['residenceType'] = residenceType;
    data['DOB'] = dOB;
    data['emailId'] = emailId;
    data['houseLandMark'] = houseLandMark;
    data['alternateMobileNo'] = alternateMobileNo;
    data['noOfyearsAtCurrentAddress'] = noOfyearsAtCurrentAddress;
    data['gender'] = gender;
    data['religion'] = religion;
    data['nationality'] = nationality;
    data['category'] = category;
    data['caste'] = caste;
    data['maritalStatus'] = maritalStatus;
    data['educationalDetails'] = educationalDetails;
    return data;
  }
}
