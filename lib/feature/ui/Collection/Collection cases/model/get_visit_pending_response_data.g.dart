// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_visit_pending_response_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetVisitPendingResponseData _$GetVisitPendingResponseDataFromJson(
        Map<dynamic, dynamic> json) =>
    GetVisitPendingResponseData(
      status: json['status'] as bool,
      subCode: (json['subCode'] as num).toInt(),
      message: json['message'] as String,
      error: json['error'] as String,
      items: (json['items'] as List<dynamic>)
          .map((e) => Map<dynamic, dynamic>.from(e as Map))
          .toList(),
    );

Map<dynamic, dynamic> _$GetVisitPendingResponseDataToJson(
        GetVisitPendingResponseData instance) =>
    <dynamic, dynamic>{
      'status': instance.status,
      'subCode': instance.subCode,
      'message': instance.message,
      'error': instance.error,
      'items': instance.items,
    };
