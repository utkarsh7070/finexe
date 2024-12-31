class ApplicantModel {
  bool? status;
  int? subCode;
  String? message;
  String? error;
  ApplicantItems? items;

  ApplicantModel(
      {this.status, this.subCode, this.message, this.error, this.items});

  ApplicantModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    subCode = json['subCode'];
    message = json['message'];
    error = json['error'];
    items = json['items'] != null
        ? new ApplicantItems.fromJson(json['items'])
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

class ApplicantItems {
  Applicant? applicant;
  String? remarkByPd;
  String? sId;
  String? customerId;
  String? pdId;
  String? pdType;
  String? videoUpload;
  String? rejectReason;
  String? pendingReason;
  String? applicantImage;
  String? guarantorImage;
  // List<String>? coApplicantImage;
  String? landmarkPhoto;
  String? latLongPhoto;
  List<String>? fourBoundaryPhotos;
  List<String>? workPhotos;
  List<String>? propertyOtherPhotos;
  String? selfiWithCustomer;
  String? photoWithLatLong;
  String? front;
  String? leftSide;
  String? rightSide;
  String? approachRoad;
  String? mainRoad;
  String? interiorRoad;
  String? selfieWithProperty;
  String? propertyPhoto;
  String? gasDiaryPhoto;
  String? sSSMPhoto;
  List<String>? familyMemberPhotos;
  String? otherDocUpload;
  String? residentType;
  int? residentCurrentSince;
  String? status;
  String? approvalRemarkCreditPd;
  String? pdfLink;
  String? remarkMessage;
  String? bdCompleteDate;
  String? createdAt;
  String? updatedAt;
  int? iV;

  ApplicantItems(
      {this.applicant,
      this.remarkByPd,
      this.sId,
      this.customerId,
      this.pdId,
      this.pdType,
      this.videoUpload,
      this.rejectReason,
      this.pendingReason,
      this.applicantImage,
      this.guarantorImage,
      // this.coApplicantImage,
      this.landmarkPhoto,
      this.latLongPhoto,
      this.fourBoundaryPhotos,
      this.workPhotos,
      this.propertyOtherPhotos,
      this.selfiWithCustomer,
      this.photoWithLatLong,
      this.front,
      this.leftSide,
      this.rightSide,
      this.approachRoad,
      this.mainRoad,
      this.interiorRoad,
      this.selfieWithProperty,
      this.propertyPhoto,
      this.gasDiaryPhoto,
      this.sSSMPhoto,
      this.familyMemberPhotos,
      this.otherDocUpload,
      this.residentType,
      this.residentCurrentSince,
      this.status,
      this.approvalRemarkCreditPd,
      this.pdfLink,
      this.remarkMessage,
      this.bdCompleteDate,
      this.createdAt,
      this.updatedAt,
      this.iV});

  ApplicantItems.fromJson(Map<String, dynamic> json) {
    applicant = json['applicant'] != null
        ? new Applicant.fromJson(json['applicant'])
        : null;
    remarkByPd = json['remarkByPd'];
    sId = json['_id'];
    customerId = json['customerId'];
    pdId = json['pdId'];
    pdType = json['pdType'];
    videoUpload = json['videoUpload'];
    rejectReason = json['rejectReason'];
    pendingReason = json['pendingReason'];
    applicantImage = json['applicantImage'];
    guarantorImage = json['guarantorImage'];
    // coApplicantImage = json['coApplicantImage'].cast<String>();
    landmarkPhoto = json['landmarkPhoto'];
    latLongPhoto = json['latLongPhoto'];
    fourBoundaryPhotos = json['fourBoundaryPhotos'].cast<String>();
    workPhotos = json['workPhotos'].cast<String>();
    propertyOtherPhotos = json['propertyOtherPhotos'].cast<String>();
    selfiWithCustomer = json['selfiWithCustomer'];
    photoWithLatLong = json['photoWithLatLong'];
    front = json['front'];
    leftSide = json['leftSide'];
    rightSide = json['rightSide'];
    approachRoad = json['approachRoad'];
    mainRoad = json['mainRoad'];
    interiorRoad = json['interiorRoad'];
    selfieWithProperty = json['selfieWithProperty'];
    propertyPhoto = json['propertyPhoto'];
    gasDiaryPhoto = json['gasDiaryPhoto'];
    sSSMPhoto = json['SSSMPhoto'];
    familyMemberPhotos = json['familyMemberPhotos'].cast<String>();
    otherDocUpload = json['otherDocUpload'];
    residentType = json['residentType'];
    residentCurrentSince = json['residentCurrentSince'];
    status = json['status'];
    approvalRemarkCreditPd = json['approvalRemarkCreditPd'];
    pdfLink = json['pdfLink'];
    remarkMessage = json['remarkMessage'];
    bdCompleteDate = json['bdCompleteDate'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.applicant != null) {
      data['applicant'] = this.applicant!.toJson();
    }
    data['remarkByPd'] = this.remarkByPd;
    data['_id'] = this.sId;
    data['customerId'] = this.customerId;
    data['pdId'] = this.pdId;
    data['pdType'] = this.pdType;
    data['videoUpload'] = this.videoUpload;
    data['rejectReason'] = this.rejectReason;
    data['pendingReason'] = this.pendingReason;
    data['applicantImage'] = this.applicantImage;
    data['guarantorImage'] = this.guarantorImage;
    // data['coApplicantImage'] = this.coApplicantImage;
    data['landmarkPhoto'] = this.landmarkPhoto;
    data['latLongPhoto'] = this.latLongPhoto;
    data['fourBoundaryPhotos'] = this.fourBoundaryPhotos;
    data['workPhotos'] = this.workPhotos;
    data['propertyOtherPhotos'] = this.propertyOtherPhotos;
    data['selfiWithCustomer'] = this.selfiWithCustomer;
    data['photoWithLatLong'] = this.photoWithLatLong;
    data['front'] = this.front;
    data['leftSide'] = this.leftSide;
    data['rightSide'] = this.rightSide;
    data['approachRoad'] = this.approachRoad;
    data['mainRoad'] = this.mainRoad;
    data['interiorRoad'] = this.interiorRoad;
    data['selfieWithProperty'] = this.selfieWithProperty;
    data['propertyPhoto'] = this.propertyPhoto;
    data['gasDiaryPhoto'] = this.gasDiaryPhoto;
    data['SSSMPhoto'] = this.sSSMPhoto;
    data['familyMemberPhotos'] = this.familyMemberPhotos;
    data['otherDocUpload'] = this.otherDocUpload;
    data['residentType'] = this.residentType;
    data['residentCurrentSince'] = this.residentCurrentSince;
    data['status'] = this.status;
    data['approvalRemarkCreditPd'] = this.approvalRemarkCreditPd;
    data['pdfLink'] = this.pdfLink;
    data['remarkMessage'] = this.remarkMessage;
    data['bdCompleteDate'] = this.bdCompleteDate;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['__v'] = this.iV;
    return data;
  }
}

class Applicant {
  String? applicantType;
  String? businessType;
  String? occupation;
  String? dOB;
  String? email;
  String? houseLandMark;
  String? alternateMobileNo;
  String? noOfyearsAtCurrentAddress;
  String? gender;
  String? religion;
  String? nationality;
  String? category;
  String? caste;
  String? maritalStatus;
  String? noOfDependentWithCustomer;
  String? educationalDetails;
  String? residenceType;

  Applicant(
      {this.applicantType,
      this.businessType,
      this.occupation,
      this.dOB,
      this.email,
      this.houseLandMark,
      this.alternateMobileNo,
      this.noOfyearsAtCurrentAddress,
      this.gender,
      this.religion,
      this.nationality,
      this.category,
      this.caste,
      this.maritalStatus,
      this.noOfDependentWithCustomer,
      this.educationalDetails,
      this.residenceType});

  Applicant.fromJson(Map<String, dynamic> json) {
    applicantType = json['applicantType'];
    businessType = json['businessType'];
    occupation = json['occupation'];
    dOB = json['DOB'];
    email = json['email'];
    houseLandMark = json['houseLandMark'];
    alternateMobileNo = json['alternateMobileNo'];
    noOfyearsAtCurrentAddress = json['noOfyearsAtCurrentAddress'];
    gender = json['gender'];
    religion = json['religion'];
    nationality = json['nationality'];
    category = json['category'];
    caste = json['caste'];
    maritalStatus = json['maritalStatus'];
    noOfDependentWithCustomer = json['noOfDependentWithCustomer'];
    educationalDetails = json['educationalDetails'];
    residenceType = json['residenceType'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['applicantType'] = this.applicantType;
    data['businessType'] = this.businessType;
    data['occupation'] = this.occupation;
    data['DOB'] = this.dOB;
    data['email'] = this.email;
    data['houseLandMark'] = this.houseLandMark;
    data['alternateMobileNo'] = this.alternateMobileNo;
    data['noOfyearsAtCurrentAddress'] = this.noOfyearsAtCurrentAddress;
    data['gender'] = this.gender;
    data['religion'] = this.religion;
    data['nationality'] = this.nationality;
    data['category'] = this.category;
    data['caste'] = this.caste;
    data['maritalStatus'] = this.maritalStatus;
    data['noOfDependentWithCustomer'] = this.noOfDependentWithCustomer;
    data['educationalDetails'] = this.educationalDetails;
    data['residenceType'] = this.residenceType;
    return data;
  }
}
