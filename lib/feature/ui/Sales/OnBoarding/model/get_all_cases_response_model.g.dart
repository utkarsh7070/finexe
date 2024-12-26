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
      noDataMessage: json['noDataMessage'] as String? ?? 'No data available',
    );

Map<String, dynamic> _$GetAllCasesResponseModelToJson(
        GetAllCasesResponseModel instance) =>
    <String, dynamic>{
      'status': instance.status,
      'subCode': instance.subCode,
      'message': instance.message,
      'error': instance.error,
      'items': instance.items,
      'noDataMessage': instance.noDataMessage,
    };

Item _$ItemFromJson(Map<String, dynamic> json) => Item(
      id: json['_id'] as String?,
      employeId: json['employeId'] as String?,
      cibilId: json['cibilId'] as String?,
      tlPdId: json['tlPdId'] as String? ?? 'N/A',
      creditPdId: json['creditPdId'] as String? ?? 'N/A',
      customerId: json['customerId'] as String?,
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
      remarkByCibil: json['remarkByCibil'] as String?,
      statusByCibil: json['statusByCibil'] as String?,
      statusByFinalApproval:
          json['statusByFinalApproval'] as String? ?? 'unknown',
      statusByExternalManager:
          json['statusByExternalManager'] as String? ?? 'unknown',
      remarkByExternalManager:
          json['remarkByExternalManager'] as String? ?? 'unknown',
      remarkByCreditPd: json['remarkByCreditPd'] as String?,
      statusByCreditPd: json['statusByCreditPd'] as String?,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
      customerName: json['customerName'] as String?,
      customerFinId: json['customerFinId'] as String?,
      mobileNo: json['mobileNo'],
      productName: json['productName'] as String?,
      loanAmount: json['loanAmount'],
      applicantImage: json['applicantImage'] as String?,
      applicantEmail: json['applicantEmail'] as String?,
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
      'remarkByPd': instance.remarkByPd,
      'statusByPd': instance.statusByPd,
      'remarkMessage': instance.remarkMessage,
      'currentStatus': instance.currentStatus,
    };
