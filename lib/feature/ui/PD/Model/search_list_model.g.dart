// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'search_list_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SearchListModel _$SearchListModelFromJson(Map<String, dynamic> json) =>
    SearchListModel(
      status: json['status'] as bool,
      subCode: (json['subCode'] as num).toInt(),
      message: json['message'] as String,
      error: json['error'] as String,
      items: (json['items'] as List<dynamic>)
          .map((e) => SearchItems.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$SearchListModelToJson(SearchListModel instance) =>
    <String, dynamic>{
      'status': instance.status,
      'subCode': instance.subCode,
      'message': instance.message,
      'error': instance.error,
      'items': instance.items,
    };

SearchItems _$SearchItemsFromJson(Map<String, dynamic> json) => SearchItems(
      id: json['_id'] as String,
      customerId: json['customerId'] as String,
      externalVendorId: json['externalVendorId'] as String,
      partnerNameId: json['partnerNameId'] as String,
      creditPdId: json['creditPdId'] as String,
      pdfCreateByCreditPd: json['pdfCreateByCreditPd'] as String,
      remarkForCreditPd: json['remarkForCreditPd'] as String,
      statusByCreditPd: json['statusByCreditPd'] as String,
      remarkByCreditPd: json['remarkByCreditPd'] as String,
      branchDetails:
          BranchDetails.fromJson(json['branchDetails'] as Map<String, dynamic>),
      applicantDetails: ApplicantDetails.fromJson(
          json['applicantDetails'] as Map<String, dynamic>),
      customerFinId: json['customerFinId'] as String,
      customerName: json['customerName'] as String,
      customerMobileNo: (json['customerMobileNo'] as num).toInt(),
      customerFatherName: json['customerFatherName'] as String,
      customerPhoto: json['customerPhoto'] as String,
      customerAddress: json['customerAddress'] as String,
    );

Map<String, dynamic> _$SearchItemsToJson(SearchItems instance) =>
    <String, dynamic>{
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
      id: json['_id'] as String,
      fullName: json['fullName'] as String,
      email: json['email'] as String,
    );

Map<String, dynamic> _$ApplicantDetailsToJson(ApplicantDetails instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'fullName': instance.fullName,
      'email': instance.email,
    };

BranchDetails _$BranchDetailsFromJson(Map<String, dynamic> json) =>
    BranchDetails(
      id: json['_id'] as String,
      name: json['name'] as String,
    );

Map<String, dynamic> _$BranchDetailsToJson(BranchDetails instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'name': instance.name,
    };
