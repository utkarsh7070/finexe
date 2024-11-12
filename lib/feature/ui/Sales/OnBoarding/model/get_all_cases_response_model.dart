import 'package:json_annotation/json_annotation.dart';
part 'get_all_cases_response_model.g.dart';

@JsonSerializable()
class GetAllCasesResponseModel {
  @JsonKey(name: "status")
  bool status;
  @JsonKey(name: "subCode")
  int subCode;
  @JsonKey(name: "message")
  dynamic message;
  @JsonKey(name: "error")
  dynamic error;
  @JsonKey(name: "items")
  List<Item> items;

  GetAllCasesResponseModel({
    required this.status,
    required this.subCode,
    required this.message,
    required this.error,
    required this.items,
  });

  factory GetAllCasesResponseModel.fromJson(Map<String, dynamic> json) => _$GetAllCasesResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$GetAllCasesResponseModelToJson(this);
}

@JsonSerializable()
class Item {
  @JsonKey(name: "_id")
  dynamic id;
  @JsonKey(name: "employeId")
  dynamic? employeId;
  @JsonKey(name: "cibilId")
  dynamic? cibilId;
  @JsonKey(name: "tlPdId")
  dynamic tlPdId;
  @JsonKey(name: "creditPdId")
  dynamic creditPdId;
  @JsonKey(name: "customerId")
  dynamic customerId;
  @JsonKey(name: "customerFormStart")
  bool customerFormStart;
  @JsonKey(name: "customerFormComplete")
  bool customerFormComplete;
  @JsonKey(name: "applicantFormStart")
  bool applicantFormStart;
  @JsonKey(name: "applicantFormComplete")
  bool applicantFormComplete;
  @JsonKey(name: "coApplicantFormStart")
  bool coApplicantFormStart;
  @JsonKey(name: "coApplicantFormComplete")
  bool coApplicantFormComplete;
  @JsonKey(name: "guarantorFormStart")
  bool guarantorFormStart;
  @JsonKey(name: "guarantorFormComplete")
  bool guarantorFormComplete;
  @JsonKey(name: "referenceFormStart")
  bool referenceFormStart;
  @JsonKey(name: "referenceFormComplete")
  bool referenceFormComplete;
  @JsonKey(name: "bankDetailFormStart")
  bool bankDetailFormStart;
  @JsonKey(name: "bankDetailFormComplete")
  bool bankDetailFormComplete;
  @JsonKey(name: "salesCaseDetailFormStart")
  bool salesCaseDetailFormStart;
  @JsonKey(name: "salesCaseDetailFormComplete")
  bool salesCaseDetailFormComplete;
  @JsonKey(name: "cibilFormStart")
  bool cibilFormStart;
  @JsonKey(name: "cibilFormComplete")
  bool cibilFormComplete;
  @JsonKey(name: "remarkByCibil")
  dynamic remarkByCibil;
  @JsonKey(name: "statusByCibil")
  dynamic statusByCibil;
  @JsonKey(name: "statusByExternalManager")
  dynamic statusByExternalManager;
  @JsonKey(name: "remarkByCreditPd")
  dynamic remarkByCreditPd;
  @JsonKey(name: "statusByCreditPd")
  dynamic statusByCreditPd;
  @JsonKey(name: "remarkByPd")
  dynamic? remarkByPd;
  @JsonKey(name: "statusByPd")
  dynamic? statusByPd;
  @JsonKey(name: "createdAt")
  DateTime createdAt;
  @JsonKey(name: "updatedAt")
  DateTime updatedAt;
  @JsonKey(name: "customerName")
  dynamic customerName;
  @JsonKey(name: "customerFinId")
  dynamic customerFinId;
  @JsonKey(name: "mobileNo")
  int mobileNo;
  @JsonKey(name: "productName")
  dynamic productName;
  @JsonKey(name: "loanAmount")
  int loanAmount;
  @JsonKey(name: "applicantImage")
  dynamic? applicantImage;
  @JsonKey(name: "applicantEmail")
  dynamic applicantEmail;
  @JsonKey(name: "externalvendorDetail")
  dynamic externalvendorDetail;
  @JsonKey(name: "remarkMessage")
  dynamic remarkMessage;
  @JsonKey(name: "currentStatus")
  dynamic currentStatus;
  @JsonKey(name: "statusByFinalApproval")
  dynamic? statusByFinalApproval;
  @JsonKey(name: "remarkByExternalManager")
  dynamic? remarkByExternalManager;

  Item({
    required this.id,
    required this.employeId,
    required this.cibilId,
    required this.tlPdId,
    required this.creditPdId,
    required this.customerId,
    required this.customerFormStart,
    required this.customerFormComplete,
    required this.applicantFormStart,
    required this.applicantFormComplete,
    required this.coApplicantFormStart,
    required this.coApplicantFormComplete,
    required this.guarantorFormStart,
    required this.guarantorFormComplete,
    required this.referenceFormStart,
    required this.referenceFormComplete,
    required this.bankDetailFormStart,
    required this.bankDetailFormComplete,
    required this.salesCaseDetailFormStart,
    required this.salesCaseDetailFormComplete,
    required this.cibilFormStart,
    required this.cibilFormComplete,
    required this.remarkByCibil,
    required this.statusByCibil,
    required this.statusByExternalManager,
    required this.remarkByCreditPd,
    required this.statusByCreditPd,
    this.remarkByPd,
    this.statusByPd,
    required this.createdAt,
    required this.updatedAt,
    required this.customerName,
    required this.customerFinId,
    required this.mobileNo,
    required this.productName,
    required this.loanAmount,
    required this.applicantImage,
    required this.applicantEmail,
    required this.externalvendorDetail,
    required this.remarkMessage,
    required this.currentStatus,
    this.statusByFinalApproval,
    this.remarkByExternalManager,
  });

  factory Item.fromJson(Map<String, dynamic> json) => _$ItemFromJson(json);

  Map<String, dynamic> toJson() => _$ItemToJson(this);
}


// @JsonSerializable()
// class ExternalvendorDetail {
//   @JsonKey(name: "_id")
//   dynamic? id;
//   @JsonKey(name: "externalVendorId")
//   dynamic? externalVendorId;
//   @JsonKey(name: "vendors")
//   List<Vendor>? vendors;
//
//   ExternalvendorDetail({
//     this.id,
//     this.externalVendorId,
//     this.vendors,
//   });
//
//   factory ExternalvendorDetail.fromJson(Map<dynamic, dynamic> json) => _$ExternalvendorDetailFromJson(json);
//
//   Map<dynamic, dynamic> toJson() => _$ExternalvendorDetailToJson(this);
// }
//
// @JsonSerializable()
// class Vendor {
//   @JsonKey(name: "vendorType")
//   dynamic vendorType;
//   @JsonKey(name: "vendorId")
//   dynamic vendorId;
//   @JsonKey(name: "assignDocuments")
//   List<dynamic> assignDocuments;
//   @JsonKey(name: "pdfRemark")
//   dynamic? pdfRemark;
//   @JsonKey(name: "externalVendorRemark")
//   dynamic? externalVendorRemark;
//   @JsonKey(name: "uploadProperty")
//   List<dynamic> uploadProperty;
//   @JsonKey(name: "remarkByVendor")
//   dynamic remarkByVendor;
//   @JsonKey(name: "sendMail")
//   dynamic sendMail;
//   @JsonKey(name: "statusByVendor")
//   dynamic statusByVendor;
//   @JsonKey(name: "receiverName")
//   dynamic? receiverName;
//   @JsonKey(name: "vendorStatus")
//   dynamic? vendorStatus;
//   @JsonKey(name: "reason")
//   dynamic reason;
//   @JsonKey(name: "requirement")
//   List<dynamic> requirement;
//   @JsonKey(name: "numberOfCattle")
//   dynamic? numberOfCattle;
//   @JsonKey(name: "cattlesBreed")
//   dynamic? cattlesBreed;
//   @JsonKey(name: "milkLitPerDay")
//   dynamic? milkLitPerDay;
//   @JsonKey(name: "areaOfLand")
//   dynamic? areaOfLand;
//   @JsonKey(name: "areaOfConstruction")
//   dynamic? areaOfConstruction;
//   @JsonKey(name: "fairMarketValue")
//   dynamic? fairMarketValue;
//   @JsonKey(name: "vendorUploadDate")
//   dynamic? vendorUploadDate;
//   @JsonKey(name: "approverRemark")
//   dynamic? approverRemark;
//   @JsonKey(name: "approverDate")
//   dynamic? approverDate;
//   @JsonKey(name: "assignDate")
//   dynamic? assignDate;
//   @JsonKey(name: "_id")
//   dynamic id;
//
//   Vendor({
//     required this.vendorType,
//     required this.vendorId,
//     required this.assignDocuments,
//     this.pdfRemark,
//     this.externalVendorRemark,
//     required this.uploadProperty,
//     required this.remarkByVendor,
//     required this.sendMail,
//     required this.statusByVendor,
//     this.receiverName,
//     this.vendorStatus,
//     required this.reason,
//     required this.requirement,
//     this.numberOfCattle,
//     this.cattlesBreed,
//     this.milkLitPerDay,
//     this.areaOfLand,
//     this.areaOfConstruction,
//     this.fairMarketValue,
//     this.vendorUploadDate,
//     this.approverRemark,
//     this.approverDate,
//     this.assignDate,
//     required this.id,
//   });
//
//   factory Vendor.fromJson(Map<dynamic, dynamic> json) => _$VendorFromJson(json);
//
//   Map<dynamic, dynamic> toJson() => _$VendorToJson(this);
// }
