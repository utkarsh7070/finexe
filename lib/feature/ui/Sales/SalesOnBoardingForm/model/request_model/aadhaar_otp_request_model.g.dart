// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'aadhaar_otp_request_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AadhaarOtpRequestModel _$AadhaarOtpRequestModelFromJson(
        Map<String, dynamic> json) =>
    AadhaarOtpRequestModel(
      transId: json['transId'] as String,
      otp: (json['otp'] as num).toInt(),
    );

Map<String, dynamic> _$AadhaarOtpRequestModelToJson(
        AadhaarOtpRequestModel instance) =>
    <String, dynamic>{
      'transId': instance.transId,
      'otp': instance.otp,
    };
