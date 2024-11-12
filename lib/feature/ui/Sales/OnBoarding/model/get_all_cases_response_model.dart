import 'package:json_annotation/json_annotation.dart';
part 'get_all_cases_response_model.g.dart';

@JsonSerializable()
class GetAllCasesResponseModel {
  @JsonKey(name: "status")
  bool status;
  @JsonKey(name: "subCode")
  int subCode;
  @JsonKey(name: "message")
  String message;
  @JsonKey(name: "error")
  String error;
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
  String id;
  @JsonKey(name: "employeId")
  String employeId;
  @JsonKey(name: "cibilId")
  String? cibilId;
  @JsonKey(name: "tlPdId")
  dynamic tlPdId;
  @JsonKey(name: "creditPdId")
  String? creditPdId;
  @JsonKey(name: "customerId")
  String customerId;
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
  String remarkByCibil;
  @JsonKey(name: "statusByCibil")
  String statusByCibil;
  @JsonKey(name: "statusByExternalManager")
  String statusByExternalManager;
  @JsonKey(name: "remarkByCreditPd")
  String remarkByCreditPd;
  @JsonKey(name: "statusByCreditPd")
  String statusByCreditPd;
  @JsonKey(name: "remarkByPd")
  String? remarkByPd;
  @JsonKey(name: "statusByPd")
  String? statusByPd;
  @JsonKey(name: "createdAt")
  DateTime createdAt;
  @JsonKey(name: "updatedAt")
  DateTime updatedAt;
  @JsonKey(name: "customerName")
  String customerName;
  @JsonKey(name: "customerFinId")
  String customerFinId;
  @JsonKey(name: "mobileNo")
  dynamic mobileNo;
  @JsonKey(name: "productName")
  String productName;
  @JsonKey(name: "loanAmount")
  dynamic loanAmount;
  @JsonKey(name: "applicantImage")
  String applicantImage;
  @JsonKey(name: "applicantEmail")
  String applicantEmail;
  @JsonKey(name: "externalvendorDetail")
  ExternalvendorDetail externalvendorDetail;
  @JsonKey(name: "remarkMessage")
  String remarkMessage;
  @JsonKey(name: "currentStatus")
  String currentStatus;
  @JsonKey(name: "statusByFinalApproval")
  String? statusByFinalApproval;
  @JsonKey(name: "remarkByExternalManager")
  String? remarkByExternalManager;

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

@JsonSerializable()
class ExternalvendorDetail {
  @JsonKey(name: "_id")
  String? id;
  @JsonKey(name: "externalVendorId")
  String? externalVendorId;
  @JsonKey(name: "vendors")
  List<Vendor>? vendors;

  ExternalvendorDetail({
    this.id,
    this.externalVendorId,
    this.vendors,
  });

  factory ExternalvendorDetail.fromJson(Map<String, dynamic> json) => _$ExternalvendorDetailFromJson(json);

  Map<String, dynamic> toJson() => _$ExternalvendorDetailToJson(this);
}

@JsonSerializable()
class Vendor {
  @JsonKey(name: "vendorType")
  String vendorType;
  @JsonKey(name: "vendorId")
  String? vendorId;
  @JsonKey(name: "assignDocuments")
  List<String> assignDocuments;
  @JsonKey(name: "pdfRemark")
  String? pdfRemark;
  @JsonKey(name: "externalVendorRemark")
  String? externalVendorRemark;
  @JsonKey(name: "uploadProperty")
  List<String> uploadProperty;
  @JsonKey(name: "remarkByVendor")
  String remarkByVendor;
  @JsonKey(name: "sendMail")
  String sendMail;
  @JsonKey(name: "statusByVendor")
  String statusByVendor;
  @JsonKey(name: "receiverName")
  String? receiverName;
  @JsonKey(name: "vendorStatus")
  String? vendorStatus;
  @JsonKey(name: "reason")
  String reason;
  @JsonKey(name: "requirement")
  List<String> requirement;
  @JsonKey(name: "numberOfCattle")
  String? numberOfCattle;
  @JsonKey(name: "cattlesBreed")
  String? cattlesBreed;
  @JsonKey(name: "milkLitPerDay")
  String? milkLitPerDay;
  @JsonKey(name: "areaOfLand")
  String? areaOfLand;
  @JsonKey(name: "areaOfConstruction")
  String? areaOfConstruction;
  @JsonKey(name: "fairMarketValue")
  String? fairMarketValue;
  @JsonKey(name: "vendorUploadDate")
  String? vendorUploadDate;
  @JsonKey(name: "approverRemark")
  String? approverRemark;
  @JsonKey(name: "approverDate")
  String? approverDate;
  @JsonKey(name: "assignDate")
  String? assignDate;
  @JsonKey(name: "_id")
  String id;

  Vendor({
    required this.vendorType,
    required this.vendorId,
    required this.assignDocuments,
    this.pdfRemark,
    this.externalVendorRemark,
    required this.uploadProperty,
    required this.remarkByVendor,
    required this.sendMail,
    required this.statusByVendor,
    this.receiverName,
    this.vendorStatus,
    required this.reason,
    required this.requirement,
    this.numberOfCattle,
    this.cattlesBreed,
    this.milkLitPerDay,
    this.areaOfLand,
    this.areaOfConstruction,
    this.fairMarketValue,
    this.vendorUploadDate,
    this.approverRemark,
    this.approverDate,
    this.assignDate,
    required this.id,
  });

  factory Vendor.fromJson(Map<String, dynamic> json) => _$VendorFromJson(json);

  Map<String, dynamic> toJson() => _$VendorToJson(this);
}
