// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'submit_co_applicant_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SubmitCoApplicantResponseModel _$SubmitCoApplicantResponseModelFromJson(
        Map<String, dynamic> json) =>
    SubmitCoApplicantResponseModel(
      status: json['status'] as bool,
      subCode: (json['subCode'] as num).toInt(),
      message: json['message'] as String,
      error: json['error'] as String,
      items: CoApplicantItems.fromJson(json['items'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$SubmitCoApplicantResponseModelToJson(
        SubmitCoApplicantResponseModel instance) =>
    <String, dynamic>{
      'status': instance.status,
      'subCode': instance.subCode,
      'message': instance.message,
      'error': instance.error,
      'items': instance.items,
    };

CoApplicantItems _$CoApplicantItemsFromJson(Map<String, dynamic> json) =>
    CoApplicantItems(
      employeId: json['employeId'] as String,
      customerId: json['customerId'] as String,
      aadharNo: json['aadharNo'] as String,
      docType: json['docType'] as String,
      docNo: json['docNo'] as String,
      coApplicantPhoto: json['coApplicantPhoto'] as String,
      ocrAadharFrontImage: json['ocrAadharFrontImage'] as String,
      ocrAadharBackImage: json['ocrAadharBackImage'] as String,
      fullName: json['fullName'] as String,
      fatherName: json['fatherName'] as String,
      motherName: json['motherName'] as String,
      spouseName: json['spouseName'] as String,
      maritalStatus: json['maritalStatus'] as String,
      relationWithApplicant: json['relationWithApplicant'] as String,
      email: json['email'] as String,
      dob: json['dob'] as String,
      religion: json['religion'] as String,
      caste: json['caste'] as String,
      education: json['education'] as String,
      age: json['age'] as String,
      gender: json['gender'] as String,
      mobileNo: (json['mobileNo'] as num).toInt(),
      permanentAddress:
          Address.fromJson(json['permanentAddress'] as Map<String, dynamic>),
      localAddress:
          Address.fromJson(json['localAddress'] as Map<String, dynamic>),
      kycUpload: KycUpload.fromJson(json['kycUpload'] as Map<String, dynamic>),
      status: json['status'] as String,
      remarkMessage: json['remarkMessage'] as String,
      id: json['_id'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
      v: (json['__v'] as num).toInt(),
    );

Map<String, dynamic> _$CoApplicantItemsToJson(CoApplicantItems instance) =>
    <String, dynamic>{
      'employeId': instance.employeId,
      'customerId': instance.customerId,
      'aadharNo': instance.aadharNo,
      'docType': instance.docType,
      'docNo': instance.docNo,
      'coApplicantPhoto': instance.coApplicantPhoto,
      'ocrAadharFrontImage': instance.ocrAadharFrontImage,
      'ocrAadharBackImage': instance.ocrAadharBackImage,
      'fullName': instance.fullName,
      'fatherName': instance.fatherName,
      'motherName': instance.motherName,
      'spouseName': instance.spouseName,
      'maritalStatus': instance.maritalStatus,
      'relationWithApplicant': instance.relationWithApplicant,
      'email': instance.email,
      'dob': instance.dob,
      'religion': instance.religion,
      'caste': instance.caste,
      'education': instance.education,
      'age': instance.age,
      'gender': instance.gender,
      'mobileNo': instance.mobileNo,
      'permanentAddress': instance.permanentAddress,
      'localAddress': instance.localAddress,
      'kycUpload': instance.kycUpload,
      'status': instance.status,
      'remarkMessage': instance.remarkMessage,
      '_id': instance.id,
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt.toIso8601String(),
      '__v': instance.v,
    };

KycUpload _$KycUploadFromJson(Map<String, dynamic> json) => KycUpload(
      aadharFrontImage: json['aadharFrontImage'] as String,
      aadharBackImage: json['aadharBackImage'] as String,
      docImage: json['docImage'] as String,
    );

Map<String, dynamic> _$KycUploadToJson(KycUpload instance) => <String, dynamic>{
      'aadharFrontImage': instance.aadharFrontImage,
      'aadharBackImage': instance.aadharBackImage,
      'docImage': instance.docImage,
    };

Address _$AddressFromJson(Map<String, dynamic> json) => Address(
      addressLine1: json['addressLine1'] as String,
      addressLine2: json['addressLine2'] as String,
      city: json['city'] as String,
      state: json['state'] as String,
      district: json['district'] as String,
      pinCode: json['pinCode'] as String,
    );

Map<String, dynamic> _$AddressToJson(Address instance) => <String, dynamic>{
      'addressLine1': instance.addressLine1,
      'addressLine2': instance.addressLine2,
      'city': instance.city,
      'state': instance.state,
      'district': instance.district,
      'pinCode': instance.pinCode,
    };
