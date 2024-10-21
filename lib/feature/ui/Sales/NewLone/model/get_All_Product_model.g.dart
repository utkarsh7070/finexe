// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_All_Product_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetAllProductModel _$GetAllProductModelFromJson(Map<String, dynamic> json) =>
    GetAllProductModel(
      status: json['status'] as bool,
      subCode: (json['subCode'] as num).toInt(),
      message: json['message'] as String,
      error: json['error'] as String,
      items: (json['items'] as List<dynamic>)
          .map((e) => Item.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$GetAllProductModelToJson(GetAllProductModel instance) =>
    <String, dynamic>{
      'status': instance.status,
      'subCode': instance.subCode,
      'message': instance.message,
      'error': instance.error,
      'items': instance.items,
    };

Item _$ItemFromJson(Map<String, dynamic> json) => Item(
      loanAmount:
          LoanAmount.fromJson(json['loanAmount'] as Map<String, dynamic>),
      roi: LoanAmount.fromJson(json['roi'] as Map<String, dynamic>),
      tenure: LoanAmount.fromJson(json['tenure'] as Map<String, dynamic>),
      id: json['_id'] as String,
      productName: json['productName'] as String,
      loginFees: (json['loginFees'] as num).toInt(),
      status: json['status'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
      v: (json['__v'] as num).toInt(),
      permissionFormId: json['permissionFormId'] as String,
      productFinId: json['productFinId'] as String,
    );

Map<String, dynamic> _$ItemToJson(Item instance) => <String, dynamic>{
      'loanAmount': instance.loanAmount,
      'roi': instance.roi,
      'tenure': instance.tenure,
      '_id': instance.id,
      'productName': instance.productName,
      'loginFees': instance.loginFees,
      'status': instance.status,
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt.toIso8601String(),
      '__v': instance.v,
      'permissionFormId': instance.permissionFormId,
      'productFinId': instance.productFinId,
    };

LoanAmount _$LoanAmountFromJson(Map<String, dynamic> json) => LoanAmount(
      min: (json['min'] as num).toInt(),
      max: (json['max'] as num).toInt(),
    );

Map<String, dynamic> _$LoanAmountToJson(LoanAmount instance) =>
    <String, dynamic>{
      'min': instance.min,
      'max': instance.max,
    };
