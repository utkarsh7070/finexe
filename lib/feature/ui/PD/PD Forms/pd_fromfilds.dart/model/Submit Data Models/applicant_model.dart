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
        ? ApplicantItems.fromJson(json['items'])
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
        ? Applicant.fromJson(json['applicant'])
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
    final Map<String, dynamic> data = <String, dynamic>{};
    if (applicant != null) {
      data['applicant'] = applicant!.toJson();
    }
    data['remarkByPd'] = remarkByPd;
    data['_id'] = sId;
    data['customerId'] = customerId;
    data['pdId'] = pdId;
    data['pdType'] = pdType;
    data['videoUpload'] = videoUpload;
    data['rejectReason'] = rejectReason;
    data['pendingReason'] = pendingReason;
    data['applicantImage'] = applicantImage;
    data['guarantorImage'] = guarantorImage;
    // data['coApplicantImage'] = this.coApplicantImage;
    data['landmarkPhoto'] = landmarkPhoto;
    data['latLongPhoto'] = latLongPhoto;
    data['fourBoundaryPhotos'] = fourBoundaryPhotos;
    data['workPhotos'] = workPhotos;
    data['propertyOtherPhotos'] = propertyOtherPhotos;
    data['selfiWithCustomer'] = selfiWithCustomer;
    data['photoWithLatLong'] = photoWithLatLong;
    data['front'] = front;
    data['leftSide'] = leftSide;
    data['rightSide'] = rightSide;
    data['approachRoad'] = approachRoad;
    data['mainRoad'] = mainRoad;
    data['interiorRoad'] = interiorRoad;
    data['selfieWithProperty'] = selfieWithProperty;
    data['propertyPhoto'] = propertyPhoto;
    data['gasDiaryPhoto'] = gasDiaryPhoto;
    data['SSSMPhoto'] = sSSMPhoto;
    data['familyMemberPhotos'] = familyMemberPhotos;
    data['otherDocUpload'] = otherDocUpload;
    data['residentType'] = residentType;
    data['residentCurrentSince'] = residentCurrentSince;
    data['status'] = status;
    data['approvalRemarkCreditPd'] = approvalRemarkCreditPd;
    data['pdfLink'] = pdfLink;
    data['remarkMessage'] = remarkMessage;
    data['bdCompleteDate'] = bdCompleteDate;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['__v'] = iV;
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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['applicantType'] = applicantType;
    data['businessType'] = businessType;
    data['occupation'] = occupation;
    data['DOB'] = dOB;
    data['email'] = email;
    data['houseLandMark'] = houseLandMark;
    data['alternateMobileNo'] = alternateMobileNo;
    data['noOfyearsAtCurrentAddress'] = noOfyearsAtCurrentAddress;
    data['gender'] = gender;
    data['religion'] = religion;
    data['nationality'] = nationality;
    data['category'] = category;
    data['caste'] = caste;
    data['maritalStatus'] = maritalStatus;
    data['noOfDependentWithCustomer'] = noOfDependentWithCustomer;
    data['educationalDetails'] = educationalDetails;
    data['residenceType'] = residenceType;
    return data;
  }
}
