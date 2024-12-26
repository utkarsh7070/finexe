// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_all_branch_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetAllBranchModel _$GetAllBranchModelFromJson(Map<String, dynamic> json) =>
    GetAllBranchModel(
      status: json['status'] as bool,
      subCode: (json['subCode'] as num).toInt(),
      message: json['message'] as String,
      error: json['error'] as String,
      items: (json['items'] as List<dynamic>)
          .map((e) => Branch.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$GetAllBranchModelToJson(GetAllBranchModel instance) =>
    <String, dynamic>{
      'status': instance.status,
      'subCode': instance.subCode,
      'message': instance.message,
      'error': instance.error,
      'items': instance.items,
    };

Branch _$BranchFromJson(Map<String, dynamic> json) => Branch(
      id: json['_id'] as String,
      name: json['name'] as String,
    );

Map<String, dynamic> _$BranchToJson(Branch instance) => <String, dynamic>{
      '_id': instance.id,
      'name': instance.name,
    };
