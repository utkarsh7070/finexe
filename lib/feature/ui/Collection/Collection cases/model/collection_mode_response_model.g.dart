// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'collection_mode_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CollectionModeResponseModel _$CollectionModeResponseModelFromJson(
        Map<String, dynamic> json) =>
    CollectionModeResponseModel(
      status: json['status'] as bool?,
      subCode: (json['subCode'] as num?)?.toInt(),
      message: json['message'] as String?,
      error: json['error'] as String?,
      items: (json['items'] as List<dynamic>)
          .map((e) => ModeItem.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$CollectionModeResponseModelToJson(
        CollectionModeResponseModel instance) =>
    <String, dynamic>{
      'status': instance.status,
      'subCode': instance.subCode,
      'message': instance.message,
      'error': instance.error,
      'items': instance.items,
    };

ModeItem _$ModeItemFromJson(Map<String, dynamic> json) => ModeItem(
      id: json['_id'] as String?,
      title: json['title'] as String,
      extraForm: json['extraForm'] as bool?,
      email: json['email'] as bool,
      dropdownId: json['dropdownId'] as String?,
      status: json['status'] as String?,
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      updatedAt: json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
      v: (json['__v'] as num).toInt(),
      dropdownDetail: json['dropdownDetail'] == null
          ? null
          : DropdownDetail.fromJson(
              json['dropdownDetail'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ModeItemToJson(ModeItem instance) => <String, dynamic>{
      '_id': instance.id,
      'title': instance.title,
      'extraForm': instance.extraForm,
      'email': instance.email,
      'dropdownId': instance.dropdownId,
      'status': instance.status,
      'createdAt': instance.createdAt?.toIso8601String(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
      '__v': instance.v,
      'dropdownDetail': instance.dropdownDetail,
    };

DropdownDetail _$DropdownDetailFromJson(Map<String, dynamic> json) =>
    DropdownDetail(
      id: json['_id'] as String?,
      title: json['title'] as String?,
      modelName: json['modelName'] as String?,
      status: json['status'] as String?,
    );

Map<String, dynamic> _$DropdownDetailToJson(DropdownDetail instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'title': instance.title,
      'modelName': instance.modelName,
      'status': instance.status,
    };
