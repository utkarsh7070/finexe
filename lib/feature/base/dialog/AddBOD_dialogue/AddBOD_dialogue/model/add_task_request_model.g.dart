// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'add_task_request_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AddTaskRequestModel _$AddTaskRequestModelFromJson(Map<String, dynamic> json) =>
    AddTaskRequestModel(
      employeeId: json['employeeId'] as String,
      task: json['task'] as String,
      description: json['description'] as String,
    );

Map<String, dynamic> _$AddTaskRequestModelToJson(
        AddTaskRequestModel instance) =>
    <String, dynamic>{
      'employeeId': instance.employeeId,
      'task': instance.task,
      'description': instance.description,
    };
