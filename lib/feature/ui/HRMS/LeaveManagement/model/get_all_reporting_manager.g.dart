// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_all_reporting_manager.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetAllReportingManagerModel _$GetAllReportingManagerModelFromJson(
        Map<String, dynamic> json) =>
    GetAllReportingManagerModel(
      status: json['status'] as bool,
      subCode: (json['subCode'] as num).toInt(),
      message: json['message'] as String,
      error: json['error'] as String,
      items:
          ReportingManagersData.fromJson(json['items'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$GetAllReportingManagerModelToJson(
        GetAllReportingManagerModel instance) =>
    <String, dynamic>{
      'status': instance.status,
      'subCode': instance.subCode,
      'message': instance.message,
      'error': instance.error,
      'items': instance.items,
    };

ReportingManagersData _$ReportingManagersDataFromJson(
        Map<String, dynamic> json) =>
    ReportingManagersData(
      count: (json['count'] as num).toInt(),
      managersData: (json['managersData'] as List<dynamic>)
          .map((e) => ReportingManager.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ReportingManagersDataToJson(
        ReportingManagersData instance) =>
    <String, dynamic>{
      'count': instance.count,
      'managersData': instance.managersData,
    };

ReportingManager _$ReportingManagerFromJson(Map<String, dynamic> json) =>
    ReportingManager(
      id: json['_id'] as String,
      name: json['employeName'] as String,
    );

Map<String, dynamic> _$ReportingManagerToJson(ReportingManager instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'employeName': instance.name,
    };
