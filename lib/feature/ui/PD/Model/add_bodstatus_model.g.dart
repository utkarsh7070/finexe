// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'add_bodstatus_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BodStatusResponse _$BodStatusResponseFromJson(Map<String, dynamic> json) =>
    BodStatusResponse(
      status: json['status'] ?? false,
      subCode: json['subCode'] ?? 0,
      message: json['message'] ?? '',
      error: json['error'] ?? '',
      data: json['items']['data'] ?? false,
    );

Map<String, dynamic> _$BodStatusResponseToJson(BodStatusResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'subCode': instance.subCode,
      'message': instance.message,
      'error': instance.error,
      'data': instance.data,
    };
