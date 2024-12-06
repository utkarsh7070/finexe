// import 'package:json_annotation/json_annotation.dart';

// part 'coapplicant_model.g.dart';

// @JsonSerializable(explicitToJson: true)
// class CoApplicantResponseModel {
//   final bool status;
//   final int subCode;
//   final String message;
//   final String error;
//   final Items? items;

//   CoApplicantResponseModel({
//     required this.status,
//     required this.subCode,
//     required this.message,
//     required this.error,
//     this.items,
//   });

//   factory CoApplicantResponseModel.fromJson(Map<String, dynamic> json) =>
//       _$CoApplicantResponseModelFromJson(json);

//   Map<String, dynamic> toJson() => _$CoApplicantResponseModelToJson(this);
// }

// @JsonSerializable(explicitToJson: true)
// class Items {
//   @JsonKey(name: '_id')
//   final String id;
//   final String customerId;
//   final String pdId;
//   final List<String> coApplicantImage;
//   final List<CoApplicant> coApplicant;

//   Items({
//     required this.id,
//     required this.customerId,
//     required this.pdId,
//     required this.coApplicantImage,
//     required this.coApplicant,
//   });

//   factory Items.fromJson(Map<String, dynamic> json) => _$ItemsFromJson(json);

//   Map<String, dynamic> toJson() => _$ItemsToJson(this);
// }

// @JsonSerializable()
// class CoApplicant {
//   @JsonKey(name: '_id')
//   final String id;
//   final String coApplicantType;
//   final String businessType;
//   final String occupation;
//   final String dob;
//   final String emailId;
//   final String houseLandMark;
//   final String alternateMobileNo;
//   final String noOfYearsAtCurrentAddress;
//   final String gender;
//   final String religion;
//   final String nationality;
//   final String category;
//   final String caste;
//   final String maritalStatus;
//   final String educationalDetails;
//   final String residenceType;

//   CoApplicant({
//     required this.id,
//     required this.coApplicantType,
//     required this.businessType,
//     required this.occupation,
//     required this.dob,
//     required this.emailId,
//     required this.houseLandMark,
//     required this.alternateMobileNo,
//     required this.noOfYearsAtCurrentAddress,
//     required this.gender,
//     required this.religion,
//     required this.nationality,
//     required this.category,
//     required this.caste,
//     required this.maritalStatus,
//     required this.educationalDetails,
//     required this.residenceType,
//   });

//   factory CoApplicant.fromJson(Map<String, dynamic> json) =>
//       _$CoApplicantFromJson(json);

//   Map<String, dynamic> toJson() => _$CoApplicantToJson(this);
// }

//************************************************ */

class PDCoApplicantSubmitFormModel {
  bool? status;
  int? subCode;
  String? message;
  String? error;
  CoItems? items;

  PDCoApplicantSubmitFormModel(
      {this.status, this.subCode, this.message, this.error, this.items});

  PDCoApplicantSubmitFormModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    subCode = json['subCode'];
    message = json['message'];
    error = json['error'];
    items = json['items'] != null ? new CoItems.fromJson(json['items']) : null;
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

class CoItems {
  String? sId;
  String? customerId;
  String? pdId;
  String? pdType;
  List<String>? coApplicantImage;
  List<CoApplicant>? coApplicant;

  CoItems(
      {this.sId,
      this.customerId,
      this.pdId,
      this.pdType,
      this.coApplicantImage,
      this.coApplicant});

  CoItems.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    customerId = json['customerId'];
    pdId = json['pdId'];
    pdType = json['pdType'];
    coApplicantImage = json['coApplicantImage'].cast<String>();
    if (json['co_Applicant'] != null) {
      coApplicant = <CoApplicant>[];
      json['co_Applicant'].forEach((v) {
        coApplicant!.add(new CoApplicant.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['customerId'] = this.customerId;
    data['pdId'] = this.pdId;
    data['pdType'] = this.pdType;
    data['coApplicantImage'] = this.coApplicantImage;
    if (this.coApplicant != null) {
      data['co_Applicant'] = this.coApplicant!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class CoApplicant {
  String? coApplicantType;
  String? businessType;
  String? occupation;
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
  String? residenceType;
  String? sId;

  CoApplicant(
      {this.coApplicantType,
      this.businessType,
      this.occupation,
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
      this.educationalDetails,
      this.residenceType,
      this.sId});

  CoApplicant.fromJson(Map<String, dynamic> json) {
    coApplicantType = json['coApplicantType'];
    businessType = json['businessType'];
    occupation = json['occupation'];
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
    residenceType = json['residenceType'];
    sId = json['_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['coApplicantType'] = this.coApplicantType;
    data['businessType'] = this.businessType;
    data['occupation'] = this.occupation;
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
    data['residenceType'] = this.residenceType;
    data['_id'] = this.sId;
    return data;
  }
}
