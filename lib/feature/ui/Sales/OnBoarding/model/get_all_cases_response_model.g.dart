// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_all_cases_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetAllCasesResponseModel _$GetAllCasesResponseModelFromJson(
        Map<String, dynamic> json) =>
    GetAllCasesResponseModel(
      status: json['status'] as bool,
      subCode: (json['subCode'] as num).toInt(),
      message: json['message'] as String,
      error: json['error'] as String,
      items: (json['items'] as List<dynamic>)
          .map((e) => Item.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$GetAllCasesResponseModelToJson(
        GetAllCasesResponseModel instance) =>
    <String, dynamic>{
      'status': instance.status,
      'subCode': instance.subCode,
      'message': instance.message,
      'error': instance.error,
      'items': instance.items,
    };

Item _$ItemFromJson(Map<String, dynamic> json) => Item(
      id: json['_id'] as String,
      employeId: json['employeId'] as String?,
      cibilId: json['cibilId'],
      tlPdId: json['tlPdId'],
      creditPdId: json['creditPdId'] as String?,
      customerId: json['customerId'] as String,
      customerFormStart: json['customerFormStart'] as bool,
      customerFormComplete: json['customerFormComplete'] as bool,
      applicantFormStart: json['applicantFormStart'] as bool,
      applicantFormComplete: json['applicantFormComplete'] as bool,
      coApplicantFormStart: json['coApplicantFormStart'] as bool,
      coApplicantFormComplete: json['coApplicantFormComplete'] as bool,
      guarantorFormStart: json['guarantorFormStart'] as bool,
      guarantorFormComplete: json['guarantorFormComplete'] as bool,
      referenceFormStart: json['referenceFormStart'] as bool,
      referenceFormComplete: json['referenceFormComplete'] as bool,
      bankDetailFormStart: json['bankDetailFormStart'] as bool,
      bankDetailFormComplete: json['bankDetailFormComplete'] as bool,
      salesCaseDetailFormStart: json['salesCaseDetailFormStart'] as bool,
      salesCaseDetailFormComplete: json['salesCaseDetailFormComplete'] as bool,
      cibilFormStart: json['cibilFormStart'] as bool,
      cibilFormComplete: json['cibilFormComplete'] as bool,
      remarkByCibil: json['remarkByCibil'] as String,
      statusByCibil: json['statusByCibil'] as String,
      statusByFinalApproval: json['statusByFinalApproval'] as String?,
      statusByExternalManager: json['statusByExternalManager'] as String,
      remarkByExternalManager: json['remarkByExternalManager'] as String?,
      remarkByCreditPd: json['remarkByCreditPd'] as String,
      statusByCreditPd: json['statusByCreditPd'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
      customerName: json['customerName'] as String,
      customerFinId: json['customerFinId'] as String,
      mobileNo: json['mobileNo'],
      productName: json['productName'] as String,
      loanAmount: json['loanAmount'],
      applicantImage: json['applicantImage'] as String?,
      applicantEmail: json['applicantEmail'] as String,
      externalvendorDetail: ExternalvendorDetail.fromJson(
          json['externalvendorDetail'] as Map<String, dynamic>),
      remarkByPd: json['remarkByPd'] as String?,
      statusByPd: json['statusByPd'] as String?,
      remarkMessage: json['remarkMessage'] as String?,
      currentStatus: json['currentStatus'] as String?,
    );

Map<String, dynamic> _$ItemToJson(Item instance) => <String, dynamic>{
      '_id': instance.id,
      'employeId': instance.employeId,
      'cibilId': instance.cibilId,
      'tlPdId': instance.tlPdId,
      'creditPdId': instance.creditPdId,
      'customerId': instance.customerId,
      'customerFormStart': instance.customerFormStart,
      'customerFormComplete': instance.customerFormComplete,
      'applicantFormStart': instance.applicantFormStart,
      'applicantFormComplete': instance.applicantFormComplete,
      'coApplicantFormStart': instance.coApplicantFormStart,
      'coApplicantFormComplete': instance.coApplicantFormComplete,
      'guarantorFormStart': instance.guarantorFormStart,
      'guarantorFormComplete': instance.guarantorFormComplete,
      'referenceFormStart': instance.referenceFormStart,
      'referenceFormComplete': instance.referenceFormComplete,
      'bankDetailFormStart': instance.bankDetailFormStart,
      'bankDetailFormComplete': instance.bankDetailFormComplete,
      'salesCaseDetailFormStart': instance.salesCaseDetailFormStart,
      'salesCaseDetailFormComplete': instance.salesCaseDetailFormComplete,
      'cibilFormStart': instance.cibilFormStart,
      'cibilFormComplete': instance.cibilFormComplete,
      'remarkByCibil': instance.remarkByCibil,
      'statusByCibil': instance.statusByCibil,
      'statusByFinalApproval': instance.statusByFinalApproval,
      'statusByExternalManager': instance.statusByExternalManager,
      'remarkByExternalManager': instance.remarkByExternalManager,
      'remarkByCreditPd': instance.remarkByCreditPd,
      'statusByCreditPd': instance.statusByCreditPd,
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt.toIso8601String(),
      'customerName': instance.customerName,
      'customerFinId': instance.customerFinId,
      'mobileNo': instance.mobileNo,
      'productName': instance.productName,
      'loanAmount': instance.loanAmount,
      'applicantImage': instance.applicantImage,
      'applicantEmail': instance.applicantEmail,
      'externalvendorDetail': instance.externalvendorDetail,
      'remarkByPd': instance.remarkByPd,
      'statusByPd': instance.statusByPd,
      'remarkMessage': instance.remarkMessage,
      'currentStatus': instance.currentStatus,
    };

CibilIdClass _$CibilIdClassFromJson(Map<String, dynamic> json) => CibilIdClass(
      oid: json[r'$oid'],
    );

Map<String, dynamic> _$CibilIdClassToJson(CibilIdClass instance) =>
    <String, dynamic>{
      r'$oid': instance.oid,
    };

ExternalvendorDetail _$ExternalvendorDetailFromJson(
        Map<String, dynamic> json) =>
    ExternalvendorDetail(
      id: json['_id'] as String?,
      externalVendorId: json['externalVendorId'] as String?,
      vendors: (json['vendors'] as List<dynamic>?)
          ?.map((e) => Vendor.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ExternalvendorDetailToJson(
        ExternalvendorDetail instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'externalVendorId': instance.externalVendorId,
      'vendors': instance.vendors,
    };

Vendor _$VendorFromJson(Map<String, dynamic> json) => Vendor(
      vendorType: json['vendorType'] as String,
      vendorId: json['vendorId'] as String?,
      assignDocuments: (json['assignDocuments'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      pdfRemark: json['pdfRemark'] as String?,
      externalVendorRemark: json['externalVendorRemark'] as String?,
      uploadProperty: (json['uploadProperty'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      remarkByVendor: json['remarkByVendor'] as String,
      sendMail: json['sendMail'] as String,
      statusByVendor: json['statusByVendor'] as String,
      receiverName: json['receiverName'] as String?,
      vendorStatus: json['vendorStatus'] as String?,
      reason: json['reason'] as String,
      requirement: (json['requirement'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      numberOfCattle: json['numberOfCattle'] as String?,
      cattlesBreed: json['cattlesBreed'] as String?,
      milkLitPerDay: json['milkLitPerDay'] as String?,
      areaOfLand: json['areaOfLand'] as String?,
      areaOfConstruction: json['areaOfConstruction'] as String?,
      fairMarketValue: json['fairMarketValue'] as String?,
      vendorUploadDate: json['vendorUploadDate'] as String?,
      approverRemark: json['approverRemark'] as String?,
      approverDate: json['approverDate'] as String?,
      assignDate: json['assignDate'] as String?,
      approverEmployeeId: json['approverEmployeeId'],
      id: json['_id'] as String,
    );

Map<String, dynamic> _$VendorToJson(Vendor instance) => <String, dynamic>{
      'vendorType': instance.vendorType,
      'vendorId': instance.vendorId,
      'assignDocuments': instance.assignDocuments,
      'pdfRemark': instance.pdfRemark,
      'externalVendorRemark': instance.externalVendorRemark,
      'uploadProperty': instance.uploadProperty,
      'remarkByVendor': instance.remarkByVendor,
      'sendMail': instance.sendMail,
      'statusByVendor': instance.statusByVendor,
      'receiverName': instance.receiverName,
      'vendorStatus': instance.vendorStatus,
      'reason': instance.reason,
      'requirement': instance.requirement,
      'numberOfCattle': instance.numberOfCattle,
      'cattlesBreed': instance.cattlesBreed,
      'milkLitPerDay': instance.milkLitPerDay,
      'areaOfLand': instance.areaOfLand,
      'areaOfConstruction': instance.areaOfConstruction,
      'fairMarketValue': instance.fairMarketValue,
      'vendorUploadDate': instance.vendorUploadDate,
      'approverRemark': instance.approverRemark,
      'approverDate': instance.approverDate,
      'assignDate': instance.assignDate,
      'approverEmployeeId': instance.approverEmployeeId,
      '_id': instance.id,
    };
