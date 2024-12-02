// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_request_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LoginRequestModel _$LoginRequestModelFromJson(Map<String, dynamic> json) =>
    LoginRequestModel(
      userName: json['userName'] as String,
      password: json['password'] as String,
      employeeRole: json['employeeRole'] as String,
    );

Map<String, dynamic> _$LoginRequestModelToJson(LoginRequestModel instance) =>
    <String, dynamic>{
      'userName': instance.userName,
      'password': instance.password,
      'employeeRole': instance.employeeRole,
    };
