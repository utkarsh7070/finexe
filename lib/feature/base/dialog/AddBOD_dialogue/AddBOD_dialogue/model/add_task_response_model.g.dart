// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'add_task_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AddTaskResponseModel _$AddTaskResponseModelFromJson(
        Map<String, dynamic> json) =>
    AddTaskResponseModel(
      status: json['status'] as bool,
      subCode: (json['subCode'] as num).toInt(),
      message: json['message'] as String,
      error: json['error'] as String,
      items: Items.fromJson(json['items'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$AddTaskResponseModelToJson(
        AddTaskResponseModel instance) =>
    <String, dynamic>{
      'status': instance.status,
      'subCode': instance.subCode,
      'message': instance.message,
      'error': instance.error,
      'items': instance.items,
    };

Items _$ItemsFromJson(Map<String, dynamic> json) => Items(
      employeeId: json['employeeId'] as String,
      task: json['task'] as String,
      description: json['description'] as String,
      startDate: json['startDate'] as String,
      endDate: json['endDate'] as String,
      managerBodStatus: json['managerBodStatus'] as String,
      managerEodStatus: json['managerEodStatus'] as String,
      status: json['status'] as String,
      id: json['_id'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
      v: (json['__v'] as num).toInt(),
    );

Map<String, dynamic> _$ItemsToJson(Items instance) => <String, dynamic>{
      'employeeId': instance.employeeId,
      'task': instance.task,
      'description': instance.description,
      'startDate': instance.startDate,
      'endDate': instance.endDate,
      'managerBodStatus': instance.managerBodStatus,
      'managerEodStatus': instance.managerEodStatus,
      'status': instance.status,
      '_id': instance.id,
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt.toIso8601String(),
      '__v': instance.v,
    };
