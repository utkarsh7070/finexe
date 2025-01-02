// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'leave_type_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LeaveTypeResponseModel _$LeaveTypeResponseModelFromJson(
        Map<String, dynamic> json) =>
    LeaveTypeResponseModel(
      status: json['status'] as bool,
      subCode: (json['subCode'] as num).toInt(),
      message: json['message'] as String,
      error: json['error'] as String,
      items: (json['items'] as List<dynamic>)
          .map((e) => Item.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$LeaveTypeResponseModelToJson(
        LeaveTypeResponseModel instance) =>
    <String, dynamic>{
      'status': instance.status,
      'subCode': instance.subCode,
      'message': instance.message,
      'error': instance.error,
      'items': instance.items,
    };

Item _$ItemFromJson(Map<String, dynamic> json) => Item(
      id: json['_id'] as String,
      leaveType: json['leaveTypeName'] as String,
    );

Map<String, dynamic> _$ItemToJson(Item instance) => <String, dynamic>{
      '_id': instance.id,
      'leaveTypeName': instance.leaveType,
    };
