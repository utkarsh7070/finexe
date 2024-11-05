// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'update_password_request_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UpdatePasswordRequestModel _$UpdatePasswordRequestModelFromJson(
        Map<String, dynamic> json) =>
    UpdatePasswordRequestModel(
      oldPassword: json['oldPassword'] as String,
      newPassword: json['newPassword'] as String,
    );

Map<String, dynamic> _$UpdatePasswordRequestModelToJson(
        UpdatePasswordRequestModel instance) =>
    <String, dynamic>{
      'oldPassword': instance.oldPassword,
      'newPassword': instance.newPassword,
    };
