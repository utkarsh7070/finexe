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
      message: json['message'],
      error: json['error'],
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
      id: json['_id'],
      employeId: json['employeId'],
      cibilId: json['cibilId'],
      tlPdId: json['tlPdId'],
      creditPdId: json['creditPdId'],
      customerId: json['customerId'],
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
      remarkByCibil: json['remarkByCibil'],
      statusByCibil: json['statusByCibil'],
      statusByExternalManager: json['statusByExternalManager'],
      remarkByCreditPd: json['remarkByCreditPd'],
      statusByCreditPd: json['statusByCreditPd'],
      remarkByPd: json['remarkByPd'],
      statusByPd: json['statusByPd'],
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
      customerName: json['customerName'],
      customerFinId: json['customerFinId'],
      mobileNo: (json['mobileNo'] as num).toInt(),
      productName: json['productName'],
      loanAmount: (json['loanAmount'] as num).toInt(),
      applicantImage: json['applicantImage'],
      applicantEmail: json['applicantEmail'],
      externalvendorDetail: json['externalvendorDetail'],
      remarkMessage: json['remarkMessage'],
      currentStatus: json['currentStatus'],
      statusByFinalApproval: json['statusByFinalApproval'],
      remarkByExternalManager: json['remarkByExternalManager'],
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
      'statusByExternalManager': instance.statusByExternalManager,
      'remarkByCreditPd': instance.remarkByCreditPd,
      'statusByCreditPd': instance.statusByCreditPd,
      'remarkByPd': instance.remarkByPd,
      'statusByPd': instance.statusByPd,
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
      'remarkMessage': instance.remarkMessage,
      'currentStatus': instance.currentStatus,
      'statusByFinalApproval': instance.statusByFinalApproval,
      'remarkByExternalManager': instance.remarkByExternalManager,
    };
