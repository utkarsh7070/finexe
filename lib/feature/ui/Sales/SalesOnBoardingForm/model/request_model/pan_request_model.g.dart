// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pan_request_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PanRequestModel _$PanRequestModelFromJson(Map<String, dynamic> json) =>
    PanRequestModel(
      transId: json['transID'] as String,
      docType: (json['docType'] as num).toInt(),
      panNumber: json['PanNumber'] as String,
      formName: json['formName'] as String,
    );

Map<String, dynamic> _$PanRequestModelToJson(PanRequestModel instance) =>
    <String, dynamic>{
      'transID': instance.transId,
      'docType': instance.docType,
      'PanNumber': instance.panNumber,
      'formName': instance.formName,
    };
