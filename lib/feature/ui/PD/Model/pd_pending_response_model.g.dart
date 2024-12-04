// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pd_pending_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PdPendingResponseModel _$PdPendingResponseModelFromJson(
        Map<String, dynamic> json) =>
    PdPendingResponseModel(
      status: json['status'] as bool,
      subCode: (json['subCode'] as num).toInt(),
      message: json['message'] as String,
      error: json['error'] as String,
      items: (json['items'] as List<dynamic>)
          .map((e) => Item.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$PdPendingResponseModelToJson(
        PdPendingResponseModel instance) =>
    <String, dynamic>{
      'status': instance.status,
      'subCode': instance.subCode,
      'message': instance.message,
      'error': instance.error,
      'items': instance.items,
    };

Item _$ItemFromJson(Map<String, dynamic> json) => Item(
      id: json['_id'] as String?,
      customerId: json['customerId'] as String?,
      externalVendorId: json['externalVendorId'] as String?,
      partnerNameId: json['partnerNameId'] as String?,
      creditPdId: json['creditPdId'] as String?,
      pdfCreateByCreditPd: json['pdfCreateByCreditPd'] as String?,
      remarkForCreditPd: json['remarkForCreditPd'] as String?,
      statusByCreditPd: json['statusByCreditPd'] as String?,
      remarkByCreditPd: json['remarkByCreditPd'] as String?,
      branchDetails: json['branchDetails'] == null
          ? null
          : BranchDetails.fromJson(
              json['branchDetails'] as Map<String, dynamic>),
      applicantDetails: json['applicantDetails'] == null
          ? null
          : ApplicantDetails.fromJson(
              json['applicantDetails'] as Map<String, dynamic>),
      customerFinId: json['customerFinId'] as String?,
      customerName: json['customerName'] as String?,
      customerMobileNo: (json['customerMobileNo'] as num?)?.toInt(),
      customerFatherName: json['customerFatherName'] as String?,
      customerPhoto: json['customerPhoto'] as String?,
      customerAddress: json['customerAddress'] as String?,
    );

Map<String, dynamic> _$ItemToJson(Item instance) => <String, dynamic>{
      '_id': instance.id,
      'customerId': instance.customerId,
      'externalVendorId': instance.externalVendorId,
      'partnerNameId': instance.partnerNameId,
      'creditPdId': instance.creditPdId,
      'pdfCreateByCreditPd': instance.pdfCreateByCreditPd,
      'remarkForCreditPd': instance.remarkForCreditPd,
      'statusByCreditPd': instance.statusByCreditPd,
      'remarkByCreditPd': instance.remarkByCreditPd,
      'branchDetails': instance.branchDetails,
      'applicantDetails': instance.applicantDetails,
      'customerFinId': instance.customerFinId,
      'customerName': instance.customerName,
      'customerMobileNo': instance.customerMobileNo,
      'customerFatherName': instance.customerFatherName,
      'customerPhoto': instance.customerPhoto,
      'customerAddress': instance.customerAddress,
    };

ApplicantDetails _$ApplicantDetailsFromJson(Map<String, dynamic> json) =>
    ApplicantDetails(
      id: json['_id'] as String?,
      fullName: json['fullName'] as String?,
      email: json['email'] as String?,
    );

Map<String, dynamic> _$ApplicantDetailsToJson(ApplicantDetails instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'fullName': instance.fullName,
      'email': instance.email,
    };

BranchDetails _$BranchDetailsFromJson(Map<String, dynamic> json) =>
    BranchDetails(
      id: json['_id'] as String?,
      name: json['name'] as String?,
    );

Map<String, dynamic> _$BranchDetailsToJson(BranchDetails instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'name': instance.name,
    };
