// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'all_employee_list_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AllEmployeeResponseModel _$AllEmployeeResponseModelFromJson(
        Map<String, dynamic> json) =>
    AllEmployeeResponseModel(
      status: json['status'] as bool,
      subCode: (json['subCode'] as num).toInt(),
      message: json['message'] as String,
      error: json['error'] as String,
      items: (json['items'] as List<dynamic>)
          .map((e) => Employee.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$AllEmployeeResponseModelToJson(
        AllEmployeeResponseModel instance) =>
    <String, dynamic>{
      'status': instance.status,
      'subCode': instance.subCode,
      'message': instance.message,
      'error': instance.error,
      'items': instance.items,
    };

Employee _$EmployeeFromJson(Map<String, dynamic> json) => Employee(
      id: json['_id'] as String?,
      employeUniqueId: json['employeUniqueId'] as String?,
      employeName: json['employeName'] as String?,
    );

Map<String, dynamic> _$EmployeeToJson(Employee instance) => <String, dynamic>{
      '_id': instance.id,
      'employeUniqueId': instance.employeUniqueId,
      'employeName': instance.employeName,
    };
