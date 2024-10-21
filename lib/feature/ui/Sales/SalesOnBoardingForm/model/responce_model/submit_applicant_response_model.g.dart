// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'submit_applicant_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SubmitApplicantResponseModel _$SubmitApplicantResponseModelFromJson(
        Map<String, dynamic> json) =>
    SubmitApplicantResponseModel(
      status: json['status'] as bool,
      subCode: (json['subCode'] as num).toInt(),
      message: json['message'] as String,
      error: json['error'] as String,
      items: ApplicantItems.fromJson(json['items'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$SubmitApplicantResponseModelToJson(
        SubmitApplicantResponseModel instance) =>
    <String, dynamic>{
      'status': instance.status,
      'subCode': instance.subCode,
      'message': instance.message,
      'error': instance.error,
      'items': instance.items,
    };

ApplicantItems _$ApplicantItemsFromJson(Map<String, dynamic> json) =>
    ApplicantItems(
      employeId: json['employeId'] as String,
      customerId: json['customerId'] as String,
      aadharNo: json['aadharNo'] as String,
      panNo: json['panNo'] as String,
      ocrAadharFrontImage: json['ocrAadharFrontImage'] as String,
      ocrAadharBackImage: json['ocrAadharBackImage'] as String,
      applicantPhoto: json['applicantPhoto'] as String,
      fullName: json['fullName'] as String,
      fatherName: json['fatherName'] as String,
      motherName: json['motherName'] as String,
      spouseName: json['spouseName'] as String,
      gender: json['gender'] as String,
      mobileNo: (json['mobileNo'] as num).toInt(),
      maritalStatus: json['maritalStatus'] as String,
      email: json['email'] as String,
      dob: json['dob'] as String,
      age: json['age'] as String,
      religion: json['religion'] as String,
      education: json['education'] as String,
      caste: json['caste'] as String,
      voterIdNo: json['voterIdNo'] as String,
      drivingLicenceNo: json['drivingLicenceNo'] as String,
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

Map<String, dynamic> _$ApplicantItemsToJson(ApplicantItems instance) =>
    <String, dynamic>{
      'employeId': instance.employeId,
      'customerId': instance.customerId,
      'aadharNo': instance.aadharNo,
      'panNo': instance.panNo,
      'ocrAadharFrontImage': instance.ocrAadharFrontImage,
      'ocrAadharBackImage': instance.ocrAadharBackImage,
      'applicantPhoto': instance.applicantPhoto,
      'fullName': instance.fullName,
      'fatherName': instance.fatherName,
      'motherName': instance.motherName,
      'spouseName': instance.spouseName,
      'gender': instance.gender,
      'mobileNo': instance.mobileNo,
      'maritalStatus': instance.maritalStatus,
      'email': instance.email,
      'dob': instance.dob,
      'age': instance.age,
      'religion': instance.religion,
      'education': instance.education,
      'caste': instance.caste,
      'voterIdNo': instance.voterIdNo,
      'drivingLicenceNo': instance.drivingLicenceNo,
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
      panFrontImage: json['panFrontImage'] as String,
      drivingLicenceImage: json['drivingLicenceImage'] as String,
      voterIdImage: json['voterIdImage'] as String,
    );

Map<String, dynamic> _$KycUploadToJson(KycUpload instance) => <String, dynamic>{
      'aadharFrontImage': instance.aadharFrontImage,
      'aadharBackImage': instance.aadharBackImage,
      'panFrontImage': instance.panFrontImage,
      'drivingLicenceImage': instance.drivingLicenceImage,
      'voterIdImage': instance.voterIdImage,
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
