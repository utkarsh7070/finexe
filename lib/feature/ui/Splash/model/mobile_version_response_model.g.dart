// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mobile_version_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MobileVersionResponseModel _$MobileVersionResponseModelFromJson(Map<String, dynamic> json) => MobileVersionResponseModel(
      status: json['status'] as bool?,
      subCode: (json['subCode'] as num?)?.toInt(),
      message: json['message'] as String?,
      error: json['error'] as String?,
      items: json['items'] == null
          ? null
          : Items.fromJson(json['items'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$MobileVersionResponseModelToJson(MobileVersionResponseModel instance) => <String, dynamic>{
      'status': instance.status,
      'subCode': instance.subCode,
      'message': instance.message,
      'error': instance.error,
      'items': instance.items,
    };

Items _$ItemsFromJson(Map<String, dynamic> json) => Items(
      id: json['_id'] as String?,
      version: json['version'] as String?,
      apkUrl: json['apkUrl'] as String?,
      status: json['status'] as String?,
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      updatedAt: json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
      v: (json['__v'] as num?)?.toInt(),
    );

Map<String, dynamic> _$ItemsToJson(Items instance) => <String, dynamic>{
      '_id': instance.id,
      'version': instance.version,
      'apkUrl': instance.apkUrl,
      'status': instance.status,
      'createdAt': instance.createdAt?.toIso8601String(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
      '__v': instance.v,
    };
