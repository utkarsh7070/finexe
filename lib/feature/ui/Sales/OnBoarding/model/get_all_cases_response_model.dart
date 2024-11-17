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

  GetAllCasesResponseModel copyWith({
    bool? status,
    int? subCode,
    String? message,
    String? error,
    List<Item>? items,
  }) =>
      GetAllCasesResponseModel(
        status: status ?? this.status,
        subCode: subCode ?? this.subCode,
        message: message ?? this.message,
        error: error ?? this.error,
        items: items ?? this.items,
      );

  factory GetAllCasesResponseModel.fromJson(Map<String, dynamic> json) => _$GetAllCasesResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$GetAllCasesResponseModelToJson(this);
}

@JsonSerializable()
class Item {
  @JsonKey(name: "_id")
  String id;
  @JsonKey(name: "employeId")
  String? employeId;
  @JsonKey(name: "cibilId")
  dynamic cibilId;
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
  @JsonKey(name: "statusByFinalApproval")
  String? statusByFinalApproval;
  @JsonKey(name: "statusByExternalManager")
  String statusByExternalManager;
  @JsonKey(name: "remarkByExternalManager")
  String? remarkByExternalManager;
  @JsonKey(name: "remarkByCreditPd")
  String remarkByCreditPd;
  @JsonKey(name: "statusByCreditPd")
  String statusByCreditPd;
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
  String? applicantImage;
  @JsonKey(name: "applicantEmail")
  String applicantEmail;
  @JsonKey(name: "externalvendorDetail")
  ExternalvendorDetail externalvendorDetail;
  @JsonKey(name: "remarkByPd")
  String? remarkByPd;
  @JsonKey(name: "statusByPd")
  String? statusByPd;
  @JsonKey(name: "remarkMessage")
  String? remarkMessage;
  @JsonKey(name: "currentStatus")
  String? currentStatus;

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
    this.statusByFinalApproval,
    required this.statusByExternalManager,
    this.remarkByExternalManager,
    required this.remarkByCreditPd,
    required this.statusByCreditPd,
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
    this.remarkByPd,
    this.statusByPd,
    this.remarkMessage,
    this.currentStatus,
  });

  Item copyWith({
    String? id,
    String? employeId,
    dynamic cibilId,
    dynamic tlPdId,
    String? creditPdId,
    String? customerId,
    bool? customerFormStart,
    bool? customerFormComplete,
    bool? applicantFormStart,
    bool? applicantFormComplete,
    bool? coApplicantFormStart,
    bool? coApplicantFormComplete,
    bool? guarantorFormStart,
    bool? guarantorFormComplete,
    bool? referenceFormStart,
    bool? referenceFormComplete,
    bool? bankDetailFormStart,
    bool? bankDetailFormComplete,
    bool? salesCaseDetailFormStart,
    bool? salesCaseDetailFormComplete,
    bool? cibilFormStart,
    bool? cibilFormComplete,
    String? remarkByCibil,
    String? statusByCibil,
    String? statusByFinalApproval,
    String? statusByExternalManager,
    String? remarkByExternalManager,
    String? remarkByCreditPd,
    String? statusByCreditPd,
    DateTime? createdAt,
    DateTime? updatedAt,
    String? customerName,
    String? customerFinId,
    dynamic mobileNo,
    String? productName,
    dynamic loanAmount,
    String? applicantImage,
    String? applicantEmail,
    ExternalvendorDetail? externalvendorDetail,
    String? remarkByPd,
    String? statusByPd,
    String? remarkMessage,
    String? currentStatus,
  }) =>
      Item(
        id: id ?? this.id,
        employeId: employeId ?? this.employeId,
        cibilId: cibilId ?? this.cibilId,
        tlPdId: tlPdId ?? this.tlPdId,
        creditPdId: creditPdId ?? this.creditPdId,
        customerId: customerId ?? this.customerId,
        customerFormStart: customerFormStart ?? this.customerFormStart,
        customerFormComplete: customerFormComplete ?? this.customerFormComplete,
        applicantFormStart: applicantFormStart ?? this.applicantFormStart,
        applicantFormComplete: applicantFormComplete ?? this.applicantFormComplete,
        coApplicantFormStart: coApplicantFormStart ?? this.coApplicantFormStart,
        coApplicantFormComplete: coApplicantFormComplete ?? this.coApplicantFormComplete,
        guarantorFormStart: guarantorFormStart ?? this.guarantorFormStart,
        guarantorFormComplete: guarantorFormComplete ?? this.guarantorFormComplete,
        referenceFormStart: referenceFormStart ?? this.referenceFormStart,
        referenceFormComplete: referenceFormComplete ?? this.referenceFormComplete,
        bankDetailFormStart: bankDetailFormStart ?? this.bankDetailFormStart,
        bankDetailFormComplete: bankDetailFormComplete ?? this.bankDetailFormComplete,
        salesCaseDetailFormStart: salesCaseDetailFormStart ?? this.salesCaseDetailFormStart,
        salesCaseDetailFormComplete: salesCaseDetailFormComplete ?? this.salesCaseDetailFormComplete,
        cibilFormStart: cibilFormStart ?? this.cibilFormStart,
        cibilFormComplete: cibilFormComplete ?? this.cibilFormComplete,
        remarkByCibil: remarkByCibil ?? this.remarkByCibil,
        statusByCibil: statusByCibil ?? this.statusByCibil,
        statusByFinalApproval: statusByFinalApproval ?? this.statusByFinalApproval,
        statusByExternalManager: statusByExternalManager ?? this.statusByExternalManager,
        remarkByExternalManager: remarkByExternalManager ?? this.remarkByExternalManager,
        remarkByCreditPd: remarkByCreditPd ?? this.remarkByCreditPd,
        statusByCreditPd: statusByCreditPd ?? this.statusByCreditPd,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        customerName: customerName ?? this.customerName,
        customerFinId: customerFinId ?? this.customerFinId,
        mobileNo: mobileNo ?? this.mobileNo,
        productName: productName ?? this.productName,
        loanAmount: loanAmount ?? this.loanAmount,
        applicantImage: applicantImage ?? this.applicantImage,
        applicantEmail: applicantEmail ?? this.applicantEmail,
        externalvendorDetail: externalvendorDetail ?? this.externalvendorDetail,
        remarkByPd: remarkByPd ?? this.remarkByPd,
        statusByPd: statusByPd ?? this.statusByPd,
        remarkMessage: remarkMessage ?? this.remarkMessage,
        currentStatus: currentStatus ?? this.currentStatus,
      );

  factory Item.fromJson(Map<String, dynamic> json) => _$ItemFromJson(json);

  Map<String, dynamic> toJson() => _$ItemToJson(this);
}

@JsonSerializable()
class CibilIdClass {
  @JsonKey(name: "\$oid")
  dynamic oid;

  CibilIdClass({
    required this.oid,
  });

  CibilIdClass copyWith({
    dynamic oid,
  }) =>
      CibilIdClass(
        oid: oid ?? this.oid,
      );

  factory CibilIdClass.fromJson(Map<String, dynamic> json) => _$CibilIdClassFromJson(json);

  Map<String, dynamic> toJson() => _$CibilIdClassToJson(this);
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

  ExternalvendorDetail copyWith({
    String? id,
    String? externalVendorId,
    List<Vendor>? vendors,
  }) =>
      ExternalvendorDetail(
        id: id ?? this.id,
        externalVendorId: externalVendorId ?? this.externalVendorId,
        vendors: vendors ?? this.vendors,
      );

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
  @JsonKey(name: "approverEmployeeId")
  dynamic approverEmployeeId;
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
    this.approverEmployeeId,
    required this.id,
  });

  Vendor copyWith({
    String? vendorType,
    String? vendorId,
    List<String>? assignDocuments,
    String? pdfRemark,
    String? externalVendorRemark,
    List<String>? uploadProperty,
    String? remarkByVendor,
    String? sendMail,
    String? statusByVendor,
    String? receiverName,
    String? vendorStatus,
    String? reason,
    List<String>? requirement,
    String? numberOfCattle,
    String? cattlesBreed,
    String? milkLitPerDay,
    String? areaOfLand,
    String? areaOfConstruction,
    String? fairMarketValue,
    String? vendorUploadDate,
    String? approverRemark,
    String? approverDate,
    String? assignDate,
    dynamic approverEmployeeId,
    String? id,
  }) =>
      Vendor(
        vendorType: vendorType ?? this.vendorType,
        vendorId: vendorId ?? this.vendorId,
        assignDocuments: assignDocuments ?? this.assignDocuments,
        pdfRemark: pdfRemark ?? this.pdfRemark,
        externalVendorRemark: externalVendorRemark ?? this.externalVendorRemark,
        uploadProperty: uploadProperty ?? this.uploadProperty,
        remarkByVendor: remarkByVendor ?? this.remarkByVendor,
        sendMail: sendMail ?? this.sendMail,
        statusByVendor: statusByVendor ?? this.statusByVendor,
        receiverName: receiverName ?? this.receiverName,
        vendorStatus: vendorStatus ?? this.vendorStatus,
        reason: reason ?? this.reason,
        requirement: requirement ?? this.requirement,
        numberOfCattle: numberOfCattle ?? this.numberOfCattle,
        cattlesBreed: cattlesBreed ?? this.cattlesBreed,
        milkLitPerDay: milkLitPerDay ?? this.milkLitPerDay,
        areaOfLand: areaOfLand ?? this.areaOfLand,
        areaOfConstruction: areaOfConstruction ?? this.areaOfConstruction,
        fairMarketValue: fairMarketValue ?? this.fairMarketValue,
        vendorUploadDate: vendorUploadDate ?? this.vendorUploadDate,
        approverRemark: approverRemark ?? this.approverRemark,
        approverDate: approverDate ?? this.approverDate,
        assignDate: assignDate ?? this.assignDate,
        approverEmployeeId: approverEmployeeId ?? this.approverEmployeeId,
        id: id ?? this.id,
      );

  factory Vendor.fromJson(Map<String, dynamic> json) => _$VendorFromJson(json);

  Map<String, dynamic> toJson() => _$VendorToJson(this);
}

