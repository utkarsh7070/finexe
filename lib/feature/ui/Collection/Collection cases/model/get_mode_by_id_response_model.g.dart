// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_mode_by_id_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetModeByIdResponseModel _$GetModeByIdResponseModelFromJson(
        Map<String, dynamic> json) =>
    GetModeByIdResponseModel(
      status: json['status'] as bool,
      subCode: (json['subCode'] as num).toInt(),
      message: json['message'] as String,
      error: json['error'] as String,
      items: Items.fromJson(json['items'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$GetModeByIdResponseModelToJson(
        GetModeByIdResponseModel instance) =>
    <String, dynamic>{
      'status': instance.status,
      'subCode': instance.subCode,
      'message': instance.message,
      'error': instance.error,
      'items': instance.items,
    };

Items _$ItemsFromJson(Map<String, dynamic> json) => Items(
      modeDetail:
          ModeDetail.fromJson(json['modeDetail'] as Map<String, dynamic>),
      dropdownDetail: DropdownDetail.fromJson(
          json['dropdownDetail'] as Map<String, dynamic>),
      detail: (json['detail'] as List<dynamic>)
          .map((e) => Detail.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ItemsToJson(Items instance) => <String, dynamic>{
      'modeDetail': instance.modeDetail,
      'dropdownDetail': instance.dropdownDetail,
      'detail': instance.detail,
    };

Detail _$DetailFromJson(Map<String, dynamic> json) => Detail(
      id: json['_id'] as String?,
      title: json['title'] as String?,
      bankName: json['bankName'] as String?,
      bankAcNo: json['bankAcNo'] as String?,
      bankIfscCode: json['bankIFSCCode'] as String?,
      bankAcHolderName: json['bankAcHolderName'] as String?,
      bankBranch: json['bankBranch'] as String?,
      status: json['status'] as String?,
      createdAt: json['createdAt'] as String?,
      updatedAt: json['updatedAt'] as String?,
      v: (json['__v'] as num).toInt(),
    );

Map<String, dynamic> _$DetailToJson(Detail instance) => <String, dynamic>{
      '_id': instance.id,
      'title': instance.title,
      'bankName': instance.bankName,
      'bankAcNo': instance.bankAcNo,
      'bankIFSCCode': instance.bankIfscCode,
      'bankAcHolderName': instance.bankAcHolderName,
      'bankBranch': instance.bankBranch,
      'status': instance.status,
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
      '__v': instance.v,
    };

DropdownDetail _$DropdownDetailFromJson(Map<String, dynamic> json) =>
    DropdownDetail(
      id: json['_id'] as String,
      title: json['title'] as String,
      modelName: json['modelName'] as String,
      status: json['status'] as String,
      createdAt: json['createdAt'] as String,
      updatedAt: json['updatedAt'] as String,
      v: (json['__v'] as num).toInt(),
    );

Map<String, dynamic> _$DropdownDetailToJson(DropdownDetail instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'title': instance.title,
      'modelName': instance.modelName,
      'status': instance.status,
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
      '__v': instance.v,
    };

ModeDetail _$ModeDetailFromJson(Map<String, dynamic> json) => ModeDetail(
      id: json['_id'] as String,
      title: json['title'] as String,
      extraForm: json['extraForm'] as bool,
      email: json['email'] as bool,
      dropdownId: json['dropdownId'] as String,
      status: json['status'] as String,
      createdAt: json['createdAt'] as String,
      updatedAt: json['updatedAt'] as String,
      v: (json['__v'] as num).toInt(),
    );

Map<String, dynamic> _$ModeDetailToJson(ModeDetail instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'title': instance.title,
      'extraForm': instance.extraForm,
      'email': instance.email,
      'dropdownId': instance.dropdownId,
      'status': instance.status,
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
      '__v': instance.v,
    };
