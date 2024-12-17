// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LoginResponseModel _$LoginResponseModelFromJson(Map<String, dynamic> json) =>
    LoginResponseModel(
      status: json['status'] as bool,
      subCode: (json['subCode'] as num).toInt(),
      message: json['message'] as String,
      error: json['error'] as String,
      items: Items.fromJson(json['items'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$LoginResponseModelToJson(LoginResponseModel instance) =>
    <String, dynamic>{
      'status': instance.status,
      'subCode': instance.subCode,
      'message': instance.message,
      'error': instance.error,
      'items': instance.items,
    };

Items _$ItemsFromJson(Map<String, dynamic> json) => Items(
      employeId: json['employeId'] as String,
      userName: json['userName'] as String,
      roleName:
          (json['roleName'] as List<dynamic>).map((e) => e as String).toList(),
      token: json['token'] as String,
  roamId: json['roamId'] as String,
  trackingMode: json['trackingMode'] as String,
    );

Map<String, dynamic> _$ItemsToJson(Items instance) => <String, dynamic>{
      'employeId': instance.employeId,
      'userName': instance.userName,
      'roleName': instance.roleName,
      'token': instance.token,
      'roamId': instance.roamId,
      'trackingMode': instance.trackingMode,
    };
