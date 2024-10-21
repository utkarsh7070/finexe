// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'aadhaar_otp_responce_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AadhaarOtpResponseModel _$AadhaarOtpResponseModelFromJson(
        Map<String, dynamic> json) =>
    AadhaarOtpResponseModel(
      status: json['status'] as bool,
      subCode: (json['subCode'] as num).toInt(),
      message: json['message'] as String,
      error: json['error'] as String,
      items: Items.fromJson(json['items'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$AadhaarOtpResponseModelToJson(
        AadhaarOtpResponseModel instance) =>
    <String, dynamic>{
      'status': instance.status,
      'subCode': instance.subCode,
      'message': instance.message,
      'error': instance.error,
      'items': instance.items,
    };

Items _$ItemsFromJson(Map<String, dynamic> json) => Items(
      msg: Msg.fromJson(json['msg'] as Map<String, dynamic>),
      status: (json['status'] as num).toInt(),
    );

Map<String, dynamic> _$ItemsToJson(Items instance) => <String, dynamic>{
      'msg': instance.msg,
      'status': instance.status,
    };

Msg _$MsgFromJson(Map<String, dynamic> json) => Msg(
      aadharNo: json['Aadhar No'] as String,
      address: json['Address'] as String,
      careof: json['Careof'] as String,
      country: json['Country'] as String,
      dob: json['DOB'] as String,
      district: json['District'] as String,
      documentLink: json['Document link'] as String,
      gender: json['Gender'] as String,
      house: json['House'] as String,
      image: json['Image'] as String,
      landmark: json['Landmark'] as String,
      locality: json['Locality'] as String,
      name: json['Name'] as String,
      pincode: json['Pincode'] as String,
      postOffice: json['Post Office'] as String,
      relatationshipType: json['Relatationship type'] as String,
      relativeName: json['Relative Name'] as String,
      shareCode: json['Share Code'] as String,
      state: json['State'] as String,
      street: json['Street'] as String,
      subDistrict: json['Sub District'] as String,
      villageTownCity: json['Village/Town/City'] as String,
    );

Map<String, dynamic> _$MsgToJson(Msg instance) => <String, dynamic>{
      'Aadhar No': instance.aadharNo,
      'Address': instance.address,
      'Careof': instance.careof,
      'Country': instance.country,
      'DOB': instance.dob,
      'District': instance.district,
      'Document link': instance.documentLink,
      'Gender': instance.gender,
      'House': instance.house,
      'Image': instance.image,
      'Landmark': instance.landmark,
      'Locality': instance.locality,
      'Name': instance.name,
      'Pincode': instance.pincode,
      'Post Office': instance.postOffice,
      'Relatationship type': instance.relatationshipType,
      'Relative Name': instance.relativeName,
      'Share Code': instance.shareCode,
      'State': instance.state,
      'Street': instance.street,
      'Sub District': instance.subDistrict,
      'Village/Town/City': instance.villageTownCity,
    };
