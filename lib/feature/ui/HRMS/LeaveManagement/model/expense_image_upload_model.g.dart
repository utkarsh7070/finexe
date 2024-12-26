// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'expense_image_upload_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ExpenseImageUploadResponseModel _$ExpenseImageUploadResponseModelFromJson(
        Map<String, dynamic> json) =>
    ExpenseImageUploadResponseModel(
      status: json['status'] as bool,
      subCode: (json['subCode'] as num).toInt(),
      message: json['message'] as String,
      error: json['error'] as String,
      items: Items.fromJson(json['items'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ExpenseImageUploadResponseModelToJson(
        ExpenseImageUploadResponseModel instance) =>
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
