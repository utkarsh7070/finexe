// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pan_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PanResponseModel _$PanResponseModelFromJson(Map<String, dynamic> json) =>
    PanResponseModel(
      status: json['status'] as bool,
      subCode: (json['subCode'] as num).toInt(),
      message: json['message'] as String,
      error: json['error'] as String,
      items: Items.fromJson(json['items'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$PanResponseModelToJson(PanResponseModel instance) =>
    <String, dynamic>{
      'status': instance.status,
      'subCode': instance.subCode,
      'message': instance.message,
      'error': instance.error,
      'items': instance.items,
    };

Items _$ItemsFromJson(Map<String, dynamic> json) => Items(
      data: Data.fromJson(json['data'] as Map<String, dynamic>),
      message: json['message'] as String,
      messageCode: json['message_code'] as String,
      status: (json['status'] as num).toInt(),
      statusCode: (json['status_code'] as num).toInt(),
      success: json['success'] as bool,
      tsTransId: json['tsTransID'] as String,
    );

Map<String, dynamic> _$ItemsToJson(Items instance) => <String, dynamic>{
      'data': instance.data,
      'message': instance.message,
      'message_code': instance.messageCode,
      'status': instance.status,
      'status_code': instance.statusCode,
      'success': instance.success,
      'tsTransID': instance.tsTransId,
    };

Data _$DataFromJson(Map<String, dynamic> json) => Data(
      aadhaarLinked: json['aadhaar_linked'] as bool,
      address: Address.fromJson(json['address'] as Map<String, dynamic>),
      category: json['category'] as String,
      clientId: json['client_id'] as String,
      dob: DateTime.parse(json['dob'] as String),
      dobCheck: json['dob_check'] as bool,
      dobVerified: json['dob_verified'] as bool,
      email: json['email'] as String,
      fullName: json['full_name'] as String,
      fullNameSplit: (json['full_name_split'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      gender: json['gender'] as String,
      inputDob: json['input_dob'] as String,
      lessInfo: json['less_info'] as bool,
      maskedAadhaar: json['masked_aadhaar'] as String,
      panNumber: json['pan_number'] as String,
      phoneNumber: json['phone_number'] as String,
    );

Map<String, dynamic> _$DataToJson(Data instance) => <String, dynamic>{
      'aadhaar_linked': instance.aadhaarLinked,
      'address': instance.address,
      'category': instance.category,
      'client_id': instance.clientId,
      'dob': instance.dob.toIso8601String(),
      'dob_check': instance.dobCheck,
      'dob_verified': instance.dobVerified,
      'email': instance.email,
      'full_name': instance.fullName,
      'full_name_split': instance.fullNameSplit,
      'gender': instance.gender,
      'input_dob': instance.inputDob,
      'less_info': instance.lessInfo,
      'masked_aadhaar': instance.maskedAadhaar,
      'pan_number': instance.panNumber,
      'phone_number': instance.phoneNumber,
    };

Address _$AddressFromJson(Map<String, dynamic> json) => Address(
      city: json['city'] as String,
      country: json['country'] as String,
      full: json['full'] as String,
      line1: json['line_1'] as String,
      line2: json['line_2'] as String,
      state: json['state'] as String,
      streetName: json['street_name'] as String,
      zip: json['zip'] as String,
    );

Map<String, dynamic> _$AddressToJson(Address instance) => <String, dynamic>{
      'city': instance.city,
      'country': instance.country,
      'full': instance.full,
      'line_1': instance.line1,
      'line_2': instance.line2,
      'state': instance.state,
      'street_name': instance.streetName,
      'zip': instance.zip,
    };
