import 'package:json_annotation/json_annotation.dart';
part 'submit_applicant_response_model.g.dart';

@JsonSerializable()
class SubmitApplicantResponseModel {
  @JsonKey(name: "status")
  bool status;
  @JsonKey(name: "subCode")
  int subCode;
  @JsonKey(name: "message")
  String message;
  @JsonKey(name: "error")
  String error;
  @JsonKey(name: "items")
  ApplicantItems items;

  SubmitApplicantResponseModel({
    required this.status,
    required this.subCode,
    required this.message,
    required this.error,
    required this.items,
  });

  factory SubmitApplicantResponseModel.fromJson(Map<String, dynamic> json) => _$SubmitApplicantResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$SubmitApplicantResponseModelToJson(this);
}

@JsonSerializable()
class ApplicantItems {
  @JsonKey(name: "employeId")
  String employeId;
  @JsonKey(name: "customerId")
  String customerId;
  @JsonKey(name: "aadharNo")
  String aadharNo;
  @JsonKey(name: "panNo")
  String panNo;
  @JsonKey(name: "ocrAadharFrontImage")
  String ocrAadharFrontImage;
  @JsonKey(name: "ocrAadharBackImage")
  String ocrAadharBackImage;
  @JsonKey(name: "applicantPhoto")
  String applicantPhoto;
  @JsonKey(name: "fullName")
  String fullName;
  @JsonKey(name: "fatherName")
  String fatherName;
  @JsonKey(name: "motherName")
  String motherName;
  @JsonKey(name: "spouseName")
  String spouseName;
  @JsonKey(name: "gender")
  String gender;
  @JsonKey(name: "mobileNo")
  int mobileNo;
  @JsonKey(name: "maritalStatus")
  String maritalStatus;
  @JsonKey(name: "email")
  String email;
  @JsonKey(name: "dob")
  String dob;
  @JsonKey(name: "age")
  String age;
  @JsonKey(name: "religion")
  String religion;
  @JsonKey(name: "education")
  String education;
  @JsonKey(name: "caste")
  String caste;
  @JsonKey(name: "voterIdNo")
  String voterIdNo;
  @JsonKey(name: "drivingLicenceNo")
  String drivingLicenceNo;
  @JsonKey(name: "permanentAddress")
  Address permanentAddress;
  @JsonKey(name: "localAddress")
  Address localAddress;
  @JsonKey(name: "kycUpload")
  KycUpload kycUpload;
  @JsonKey(name: "status")
  String status;
  @JsonKey(name: "remarkMessage")
  String remarkMessage;
  @JsonKey(name: "_id")
  String id;
  @JsonKey(name: "createdAt")
  DateTime createdAt;
  @JsonKey(name: "updatedAt")
  DateTime updatedAt;
  @JsonKey(name: "__v")
  int v;

  ApplicantItems({
    required this.employeId,
    required this.customerId,
    required this.aadharNo,
    required this.panNo,
    required this.ocrAadharFrontImage,
    required this.ocrAadharBackImage,
    required this.applicantPhoto,
    required this.fullName,
    required this.fatherName,
    required this.motherName,
    required this.spouseName,
    required this.gender,
    required this.mobileNo,
    required this.maritalStatus,
    required this.email,
    required this.dob,
    required this.age,
    required this.religion,
    required this.education,
    required this.caste,
    required this.voterIdNo,
    required this.drivingLicenceNo,
    required this.permanentAddress,
    required this.localAddress,
    required this.kycUpload,
    required this.status,
    required this.remarkMessage,
    required this.id,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
  });

  factory ApplicantItems.fromJson(Map<String, dynamic> json) => _$ApplicantItemsFromJson(json);

  Map<String, dynamic> toJson() => _$ApplicantItemsToJson(this);
}

@JsonSerializable()
class KycUpload {
  @JsonKey(name: "aadharFrontImage")
  String aadharFrontImage;
  @JsonKey(name: "aadharBackImage")
  String aadharBackImage;
  @JsonKey(name: "panFrontImage")
  String panFrontImage;
  @JsonKey(name: "drivingLicenceImage")
  String drivingLicenceImage;
  @JsonKey(name: "voterIdImage")
  String voterIdImage;

  KycUpload({
    required this.aadharFrontImage,
    required this.aadharBackImage,
    required this.panFrontImage,
    required this.drivingLicenceImage,
    required this.voterIdImage,
  });

  factory KycUpload.fromJson(Map<String, dynamic> json) => _$KycUploadFromJson(json);

  Map<String, dynamic> toJson() => _$KycUploadToJson(this);
}

@JsonSerializable()
class Address {
  @JsonKey(name: "addressLine1")
  String addressLine1;
  @JsonKey(name: "addressLine2")
  String addressLine2;
  @JsonKey(name: "city")
  String city;
  @JsonKey(name: "state")
  String state;
  @JsonKey(name: "district")
  String district;
  @JsonKey(name: "pinCode")
  String pinCode;

  Address({
    required this.addressLine1,
    required this.addressLine2,
    required this.city,
    required this.state,
    required this.district,
    required this.pinCode,
  });

  factory Address.fromJson(Map<String, dynamic> json) => _$AddressFromJson(json);

  Map<String, dynamic> toJson() => _$AddressToJson(this);
}
