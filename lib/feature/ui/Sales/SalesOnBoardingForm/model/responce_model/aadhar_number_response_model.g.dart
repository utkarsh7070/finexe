// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'aadhar_number_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AadhaarNumberResponseModel _$AadhaarNumberResponseModelFromJson(
        Map<String, dynamic> json) =>
    AadhaarNumberResponseModel(
      status: json['status'] as bool,
      subCode: (json['subCode'] as num).toInt(),
      message: json['message'] as String,
      error: json['error'] as String,
      items: AadhaarItems.fromJson(json['items'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$AadhaarNumberResponseModelToJson(
        AadhaarNumberResponseModel instance) =>
    <String, dynamic>{
      'status': instance.status,
      'subCode': instance.subCode,
      'message': instance.message,
      'error': instance.error,
      'items': instance.items,
    };

AadhaarItems _$AadhaarItemsFromJson(Map<String, dynamic> json) => AadhaarItems(
      msg: json['msg'] as String,
      status: (json['status'] as num).toInt(),
      tsTransId: json['tsTransId'] as String,
    );

Map<String, dynamic> _$AadhaarItemsToJson(AadhaarItems instance) =>
    <String, dynamic>{
      'msg': instance.msg,
      'status': instance.status,
      'tsTransId': instance.tsTransId,
    };
