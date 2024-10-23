// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'check_attendance_responce_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CheckAttendanceResponceModel _$CheckAttendanceResponceModelFromJson(
        Map<String, dynamic> json) =>
    CheckAttendanceResponceModel(
      status: json['status'] as bool,
      subCode: (json['subCode'] as num).toInt(),
      message: json['message'] as String,
      error: json['error'] as String,
      items: Item.fromJson(json['items'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$CheckAttendanceResponceModelToJson(
        CheckAttendanceResponceModel instance) =>
    <String, dynamic>{
      'status': instance.status,
      'subCode': instance.subCode,
      'message': instance.message,
      'error': instance.error,
      'items': instance.items,
    };

Item _$ItemFromJson(Map<String, dynamic> json) => Item(
      allowed: json['allowed'] as bool,
      viewButton: json['viewButton'] as bool,
    );

Map<String, dynamic> _$ItemToJson(Item instance) => <String, dynamic>{
      'allowed': instance.allowed,
      'viewButton': instance.viewButton,
    };
