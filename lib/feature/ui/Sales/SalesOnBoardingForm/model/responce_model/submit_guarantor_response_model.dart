import 'package:json_annotation/json_annotation.dart';
part 'submit_guarantor_response_model.g.dart';

@JsonSerializable()
class SubmitGuarantorResponseModel {
  @JsonKey(name: "status")
  bool status;
  @JsonKey(name: "subCode")
  int subCode;
  @JsonKey(name: "message")
  String message;
  @JsonKey(name: "error")
  String error;
  @JsonKey(name: "items")
  GuarantorItems items;

  SubmitGuarantorResponseModel({
    required this.status,
    required this.subCode,
    required this.message,
    required this.error,
    required this.items,
  });

  factory SubmitGuarantorResponseModel.fromJson(Map<String, dynamic> json) => _$SubmitGuarantorResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$SubmitGuarantorResponseModelToJson(this);
}

@JsonSerializable()
class GuarantorItems {
  @JsonKey(name: "permanentAddress")
  Address permanentAddress;
  @JsonKey(name: "localAddress")
  Address localAddress;
  @JsonKey(name: "kycUpload")
  KycUpload kycUpload;
  @JsonKey(name: "_id")
  String id;
  @JsonKey(name: "employeId")
  String employeId;
  @JsonKey(name: "customerId")
  String customerId;
  @JsonKey(name: "aadharNo")
  String aadharNo;
  @JsonKey(name: "docType")
  String docType;
  @JsonKey(name: "docNo")
  String docNo;
  @JsonKey(name: "guarantorPhoto")
  String guarantorPhoto;
  @JsonKey(name: "ocrAadharFrontImage")
  String ocrAadharFrontImage;
  @JsonKey(name: "ocrAadharBackImage")
  String ocrAadharBackImage;
  @JsonKey(name: "fullName")
  String fullName;
  @JsonKey(name: "fatherName")
  String fatherName;
  @JsonKey(name: "motherName")
  String motherName;
  @JsonKey(name: "spouseName")
  String spouseName;
  @JsonKey(name: "maritalStatus")
  String maritalStatus;
  @JsonKey(name: "gender")
  String gender;
  @JsonKey(name: "email")
  String email;
  @JsonKey(name: "dob")
  String dob;
  @JsonKey(name: "religion")
  String religion;
  @JsonKey(name: "caste")
  String caste;
  @JsonKey(name: "education")
  String education;
  @JsonKey(name: "age")
  String age;
  @JsonKey(name: "mobileNo")
  int mobileNo;
  @JsonKey(name: "relationWithApplicant")
  String relationWithApplicant;
  @JsonKey(name: "status")
  String status;
  @JsonKey(name: "remarkMessage")
  String remarkMessage;
  @JsonKey(name: "createdAt")
  DateTime createdAt;
  @JsonKey(name: "updatedAt")
  DateTime updatedAt;
  @JsonKey(name: "__v")
  int v;

  GuarantorItems({
    required this.permanentAddress,
    required this.localAddress,
    required this.kycUpload,
    required this.id,
    required this.employeId,
    required this.customerId,
    required this.aadharNo,
    required this.docType,
    required this.docNo,
    required this.guarantorPhoto,
    required this.ocrAadharFrontImage,
    required this.ocrAadharBackImage,
    required this.fullName,
    required this.fatherName,
    required this.motherName,
    required this.spouseName,
    required this.maritalStatus,
    required this.gender,
    required this.email,
    required this.dob,
    required this.religion,
    required this.caste,
    required this.education,
    required this.age,
    required this.mobileNo,
    required this.relationWithApplicant,
    required this.status,
    required this.remarkMessage,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
  });

  factory GuarantorItems.fromJson(Map<String, dynamic> json) => _$GuarantorItemsFromJson(json);

  Map<String, dynamic> toJson() => _$GuarantorItemsToJson(this);
}

@JsonSerializable()
class KycUpload {
  @JsonKey(name: "aadharFrontImage")
  String aadharFrontImage;
  @JsonKey(name: "aadharBackImage")
  String aadharBackImage;
  @JsonKey(name: "docImage")
  String docImage;

  KycUpload({
    required this.aadharFrontImage,
    required this.aadharBackImage,
    required this.docImage,
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
