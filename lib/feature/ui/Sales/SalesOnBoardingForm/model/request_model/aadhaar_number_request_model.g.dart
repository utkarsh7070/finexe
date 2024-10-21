// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'aadhaar_number_request_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AadhaarNumberRequestModel _$AadhaarNumberRequestModelFromJson(
        Map<String, dynamic> json) =>
    AadhaarNumberRequestModel(
      aadharNo: json['aadharNo'] as String,
      transId: json['transId'] as String,
      docType: json['docType'] as String,
      formName: json['formName'] as String,
    );

Map<String, dynamic> _$AadhaarNumberRequestModelToJson(
        AadhaarNumberRequestModel instance) =>
    <String, dynamic>{
      'aadharNo': instance.aadharNo,
      'transId': instance.transId,
      'docType': instance.docType,
      'formName': instance.formName,
    };
