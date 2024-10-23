// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'visit_update_upload_image_responce_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VisitUpdateUploadImageResponseModel
    _$VisitUpdateUploadImageResponseModelFromJson(Map<String, dynamic> json) =>
        VisitUpdateUploadImageResponseModel(
          status: json['status'] as bool,
          subCode: (json['subCode'] as num).toInt(),
          message: json['message'] as String,
          error: json['error'] as String,
          items: Items.fromJson(json['items'] as Map<String, dynamic>),
        );

Map<String, dynamic> _$VisitUpdateUploadImageResponseModelToJson(
        VisitUpdateUploadImageResponseModel instance) =>
    <String, dynamic>{
      'status': instance.status,
      'subCode': instance.subCode,
      'message': instance.message,
      'error': instance.error,
      'items': instance.items,
    };

Items _$ItemsFromJson(Map<String, dynamic> json) => Items(
      image: json['image'] as String,
    );

Map<String, dynamic> _$ItemsToJson(Items instance) => <String, dynamic>{
      'image': instance.image,
    };
