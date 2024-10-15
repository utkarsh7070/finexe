import 'package:json_annotation/json_annotation.dart';
part 'submit_co_applicant_response_model.g.dart';

@JsonSerializable()
class SubmitCoApplicantResponseModel {
  @JsonKey(name: "status")
  bool status;
  @JsonKey(name: "subCode")
  int subCode;
  @JsonKey(name: "message")
  String message;
  @JsonKey(name: "error")
  String error;
  @JsonKey(name: "items")
  CoApplicantItems items;

  SubmitCoApplicantResponseModel({
    required this.status,
    required this.subCode,
    required this.message,
    required this.error,
    required this.items,
  });

  factory SubmitCoApplicantResponseModel.fromJson(Map<String, dynamic> json) => _$SubmitCoApplicantResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$SubmitCoApplicantResponseModelToJson(this);
}

@JsonSerializable()
class CoApplicantItems {
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
  @JsonKey(name: "coApplicantPhoto")
  String coApplicantPhoto;
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
  @JsonKey(name: "relationWithApplicant")
  String relationWithApplicant;
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
  @JsonKey(name: "gender")
  String gender;
  @JsonKey(name: "mobileNo")
  int mobileNo;
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

  CoApplicantItems({
    required this.employeId,
    required this.customerId,
    required this.aadharNo,
    required this.docType,
    required this.docNo,
    required this.coApplicantPhoto,
    required this.ocrAadharFrontImage,
    required this.ocrAadharBackImage,
    required this.fullName,
    required this.fatherName,
    required this.motherName,
    required this.spouseName,
    required this.maritalStatus,
    required this.relationWithApplicant,
    required this.email,
    required this.dob,
    required this.religion,
    required this.caste,
    required this.education,
    required this.age,
    required this.gender,
    required this.mobileNo,
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

  factory CoApplicantItems.fromJson(Map<String, dynamic> json) => _$CoApplicantItemsFromJson(json);

  Map<String, dynamic> toJson() => _$CoApplicantItemsToJson(this);
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
