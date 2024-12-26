// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'update_status_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UpdateStatusResponseModel _$UpdateStatusResponseModelFromJson(
        Map<String, dynamic> json) =>
    UpdateStatusResponseModel(
      status: json['status'] as bool,
      subCode: (json['subCode'] as num).toInt(),
      message: json['message'] as String,
      error: json['error'] as String,
      items: Items.fromJson(json['items'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$UpdateStatusResponseModelToJson(
        UpdateStatusResponseModel instance) =>
    <String, dynamic>{
      'status': instance.status,
      'subCode': instance.subCode,
      'message': instance.message,
      'error': instance.error,
      'items': instance.items,
    };

Items _$ItemsFromJson(Map<String, dynamic> json) => Items(
      id: json['_id'] as String,
      employeeId: json['employeeId'] as String,
      task: json['task'] as String,
      description: json['description'] as String,
      startDate: json['startDate'] as String,
      endDate: json['endDate'] as String,
      managerBodStatus: json['managerBodStatus'] as String,
      managerEodStatus: json['managerEodStatus'] as String,
      status: json['status'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
      v: (json['__v'] as num).toInt(),
    );

Map<String, dynamic> _$ItemsToJson(Items instance) => <String, dynamic>{
      '_id': instance.id,
      'employeeId': instance.employeeId,
      'task': instance.task,
      'description': instance.description,
      'startDate': instance.startDate,
      'endDate': instance.endDate,
      'managerBodStatus': instance.managerBodStatus,
      'managerEodStatus': instance.managerEodStatus,
      'status': instance.status,
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt.toIso8601String(),
      '__v': instance.v,
    };
