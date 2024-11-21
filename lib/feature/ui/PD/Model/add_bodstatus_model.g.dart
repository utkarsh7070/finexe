// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'add_bodstatus_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BodStatusResponse _$BodStatusResponseFromJson(Map<String, dynamic> json) =>
    BodStatusResponse(
      status: json['status'] as bool,
      subCode: (json['subCode'] as num).toInt(),
      message: json['message'] as String,
      error: json['error'] as String,
      data: json['data'] as bool?,
    );

Map<String, dynamic> _$BodStatusResponseToJson(BodStatusResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'subCode': instance.subCode,
      'message': instance.message,
      'error': instance.error,
      'data': instance.data,
    };
