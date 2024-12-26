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
      items: (json['items'] as List<dynamic>)
          .map((e) => Item.fromJson(e as Map<String, dynamic>))
          .toList(),
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

Item _$ItemFromJson(Map<String, dynamic> json) => Item(
      employeeId: json['employeeId'] as String,
      assignBy: json['assignBy'] as String,
      task: json['task'] as String,
      description: json['description'] as String,
      remark: json['remark'] as String,
      startDate: json['startDate'] as String,
      endDate: json['endDate'] as String,
      managerBodStatus: json['managerBodStatus'] as String,
      managerEodStatus: json['managerEodStatus'] as String,
      status: json['status'] as String,
      id: json['_id'] as String,
      v: (json['__v'] as num).toInt(),
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
    );

Map<String, dynamic> _$ItemToJson(Item instance) => <String, dynamic>{
      'employeeId': instance.employeeId,
      'assignBy': instance.assignBy,
      'task': instance.task,
      'description': instance.description,
      'remark': instance.remark,
      'startDate': instance.startDate,
      'endDate': instance.endDate,
      'managerBodStatus': instance.managerBodStatus,
      'managerEodStatus': instance.managerEodStatus,
      'status': instance.status,
      '_id': instance.id,
      '__v': instance.v,
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt.toIso8601String(),
    };
