// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'check_attendance_responce_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CheckAttendanceResponseModel _$CheckAttendanceResponseModelFromJson(
        Map<String, dynamic> json) =>
    CheckAttendanceResponseModel(
      status: json['status'] as bool,
      subCode: (json['subCode'] as num).toInt(),
      message: json['message'] as String,
      error: json['error'] as String,
      items: Items.fromJson(json['items'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$CheckAttendanceResponseModelToJson(
        CheckAttendanceResponseModel instance) =>
    <String, dynamic>{
      'status': instance.status,
      'subCode': instance.subCode,
      'message': instance.message,
      'error': instance.error,
      'items': instance.items,
    };

Items _$ItemsFromJson(Map<String, dynamic> json) => Items(
      allowed: json['allowed'] as bool,
      viewButton: json['viewButton'] as bool,
      punchIn: json['punchIn'] as bool,
      punchOut: json['punchOut'] as bool,
      punchInTime: json['punchInTime'] as String,
      punchOutTime: json['punchOutTime'] as String?,
    );

Map<String, dynamic> _$ItemsToJson(Items instance) => <String, dynamic>{
      'allowed': instance.allowed,
      'viewButton': instance.viewButton,
      'punchIn': instance.punchIn,
      'punchOut': instance.punchOut,
      'punchInTime': instance.punchInTime,
      'punchOutTime': instance.punchOutTime,
    };
