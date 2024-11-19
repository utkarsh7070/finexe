// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'update_status_request_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UpdateStatusRequestModel _$UpdateStatusRequestModelFromJson(
        Map<String, dynamic> json) =>
    UpdateStatusRequestModel(
      taskId: json['taskId'] as String,
      status: json['status'] as String,
    );

Map<String, dynamic> _$UpdateStatusRequestModelToJson(
        UpdateStatusRequestModel instance) =>
    <String, dynamic>{
      'taskId': instance.taskId,
      'status': instance.status,
    };
