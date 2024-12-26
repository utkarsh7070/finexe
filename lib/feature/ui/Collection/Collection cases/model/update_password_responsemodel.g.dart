// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'update_password_responsemodel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UpdatePasswordResponseModel _$UpdatePasswordResponseModelFromJson(
        Map<String, dynamic> json) =>
    UpdatePasswordResponseModel(
      status: json['status'] as bool,
      subCode: (json['subCode'] as num).toInt(),
      message: json['message'] as String,
      error: json['error'] as String,
    );

Map<String, dynamic> _$UpdatePasswordResponseModelToJson(
        UpdatePasswordResponseModel instance) =>
    <String, dynamic>{
      'status': instance.status,
      'subCode': instance.subCode,
      'message': instance.message,
      'error': instance.error,
    };
