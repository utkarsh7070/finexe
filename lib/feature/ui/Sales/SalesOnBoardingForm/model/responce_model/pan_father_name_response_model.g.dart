// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pan_father_name_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PanFatherNameResponseModel _$PanFatherNameResponseModelFromJson(
        Map<String, dynamic> json) =>
    PanFatherNameResponseModel(
      status: json['status'] as bool,
      subCode: (json['subCode'] as num).toInt(),
      message: json['message'] as String,
      error: json['error'] as String,
      items: Items.fromJson(json['items'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$PanFatherNameResponseModelToJson(
        PanFatherNameResponseModel instance) =>
    <String, dynamic>{
      'status': instance.status,
      'subCode': instance.subCode,
      'message': instance.message,
      'error': instance.error,
      'items': instance.items,
    };

Items _$ItemsFromJson(Map<String, dynamic> json) => Items(
      msg: json['msg'] == null
          ? null
          : Msg.fromJson(json['msg'] as Map<String, dynamic>),
      status: (json['status'] as num?)?.toInt(),
      tsTransId: json['tsTransId'] as String?,
    );

Map<String, dynamic> _$ItemsToJson(Items instance) => <String, dynamic>{
      'msg': instance.msg,
      'status': instance.status,
      'tsTransId': instance.tsTransId,
    };

Msg _$MsgFromJson(Map<String, dynamic> json) => Msg(
      data: json['data'] == null
          ? null
          : Data.fromJson(json['data'] as Map<String, dynamic>),
      message: json['message'],
      messageCode: json['message_code'] as String?,
      statusCode: (json['status_code'] as num?)?.toInt(),
      success: json['success'] as bool?,
    );

Map<String, dynamic> _$MsgToJson(Msg instance) => <String, dynamic>{
      'data': instance.data,
      'message': instance.message,
      'message_code': instance.messageCode,
      'status_code': instance.statusCode,
      'success': instance.success,
    };

Data _$DataFromJson(Map<String, dynamic> json) => Data(
      additionalCheck: json['additional_check'] as List<dynamic>?,
      category: json['category'] as String?,
      clientId: json['client_id'] as String?,
      dob: json['dob'] == null ? null : DateTime.parse(json['dob'] as String),
      dobCheck: json['dob_check'] as bool?,
      dobVerified: json['dob_verified'] as bool?,
      fatherName: json['father_name'] as String?,
      fullName: json['full_name'] as String?,
      lessInfo: json['less_info'] as bool?,
      panNumber: json['pan_number'] as String?,
    );

Map<String, dynamic> _$DataToJson(Data instance) => <String, dynamic>{
      'additional_check': instance.additionalCheck,
      'category': instance.category,
      'client_id': instance.clientId,
      'dob': instance.dob?.toIso8601String(),
      'dob_check': instance.dobCheck,
      'dob_verified': instance.dobVerified,
      'father_name': instance.fatherName,
      'full_name': instance.fullName,
      'less_info': instance.lessInfo,
      'pan_number': instance.panNumber,
    };
