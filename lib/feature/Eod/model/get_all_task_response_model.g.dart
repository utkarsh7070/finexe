// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_all_task_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetAllTaskResponseModel _$GetAllTaskResponseModelFromJson(
        Map<String, dynamic> json) =>
    GetAllTaskResponseModel(
      status: json['status'] as bool,
      subCode: (json['subCode'] as num).toInt(),
      message: json['message'] as String,
      error: json['error'] as String,
      items: Items.fromJson(json['items'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$GetAllTaskResponseModelToJson(
        GetAllTaskResponseModel instance) =>
    <String, dynamic>{
      'status': instance.status,
      'subCode': instance.subCode,
      'message': instance.message,
      'error': instance.error,
      'items': instance.items,
    };

Items _$ItemsFromJson(Map<String, dynamic> json) => Items(
      employeeDetail: EmployeeDetail.fromJson(
          json['employeeDetail'] as Map<String, dynamic>),
      tasks: (json['tasks'] as List<dynamic>)
          .map((e) => Task.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ItemsToJson(Items instance) => <String, dynamic>{
      'employeeDetail': instance.employeeDetail,
      'tasks': instance.tasks,
    };

EmployeeDetail _$EmployeeDetailFromJson(Map<String, dynamic> json) =>
    EmployeeDetail(
      id: json['_id'] as String,
      employeName: json['employeName'] as String,
      userName: json['userName'] as String,
      email: json['email'] as String,
      workEmail: json['workEmail'] as String,
      mobileNo: (json['mobileNo'] as num).toInt(),
      joiningDate: DateTime.parse(json['joiningDate'] as String),
      dateOfBirth: DateTime.parse(json['dateOfBirth'] as String),
    );

Map<String, dynamic> _$EmployeeDetailToJson(EmployeeDetail instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'employeName': instance.employeName,
      'userName': instance.userName,
      'email': instance.email,
      'workEmail': instance.workEmail,
      'mobileNo': instance.mobileNo,
      'joiningDate': instance.joiningDate.toIso8601String(),
      'dateOfBirth': instance.dateOfBirth.toIso8601String(),
    };

Task _$TaskFromJson(Map<String, dynamic> json) => Task(
      id: json['_id'] as String,
      task: json['task'] as String,
      description: json['description'] as String,
      startDate: json['startDate'] as String,
      endDate: json['endDate'] as String,
      managerBodStatus: json['managerBodStatus'] as String,
      managerEodStatus: json['managerEodStatus'] as String,
      status: json['status'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
    );

Map<String, dynamic> _$TaskToJson(Task instance) => <String, dynamic>{
      '_id': instance.id,
      'task': instance.task,
      'description': instance.description,
      'startDate': instance.startDate,
      'endDate': instance.endDate,
      'managerBodStatus': instance.managerBodStatus,
      'managerEodStatus': instance.managerEodStatus,
      'status': instance.status,
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt.toIso8601String(),
    };
