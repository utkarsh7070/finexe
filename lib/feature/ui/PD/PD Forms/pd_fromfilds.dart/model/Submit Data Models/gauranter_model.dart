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
        ? new GauranterItems.fromJson(json['items'])
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
        ? new Guarantor.fromJson(json['guarantor'])
        : null;
    guarantorImage = json['guarantorImage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['customerId'] = this.customerId;
    data['pdId'] = this.pdId;
    data['pdType'] = this.pdType;
    if (this.guarantor != null) {
      data['guarantor'] = this.guarantor!.toJson();
    }
    data['guarantorImage'] = this.guarantorImage;
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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['guarantorType'] = this.guarantorType;
    data['businessType'] = this.businessType;
    data['occupation'] = this.occupation;
    data['residenceType'] = this.residenceType;
    data['DOB'] = this.dOB;
    data['emailId'] = this.emailId;
    data['houseLandMark'] = this.houseLandMark;
    data['alternateMobileNo'] = this.alternateMobileNo;
    data['noOfyearsAtCurrentAddress'] = this.noOfyearsAtCurrentAddress;
    data['gender'] = this.gender;
    data['religion'] = this.religion;
    data['nationality'] = this.nationality;
    data['category'] = this.category;
    data['caste'] = this.caste;
    data['maritalStatus'] = this.maritalStatus;
    data['educationalDetails'] = this.educationalDetails;
    return data;
  }
}
