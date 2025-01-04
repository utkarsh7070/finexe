// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'update_emi_submit_request_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UpdateEmiSubmitRequestModel _$UpdateEmiSubmitRequestModelFromJson(
        Map<String, dynamic> json) =>
    UpdateEmiSubmitRequestModel(
      fatherName: json['fatherName'] as String,
      ld: json['LD'] as String,
      collectedBy: json['collectedBy'] as String,
      customerName: json['customerName'] as String,
      mobileNo: (json['mobileNo'] as num).toInt(),
      receivedAmount: (json['receivedAmount'] as num).toInt(),
      transactionId: json['transactionId'] as String,
      transactionImage: json['transactionImage'] as String,
      modeOfCollectionId: json['modeOfCollectionId'] as String,
      commonId: json['commonId'] as ObjectId?,
      bankName: json['bankName'] as String,
      customerEmail: json['customerEmail'] as String?,
      emiReceivedDate: json['emiReceivedDate'] as String,
      remarkByCollection: json['remarkByCollection'] as String,
      partner: json['partner'] as String,
    );

Map<String, dynamic> _$UpdateEmiSubmitRequestModelToJson(
        UpdateEmiSubmitRequestModel instance) =>
    <String, dynamic>{
      'LD': instance.ld,
      'collectedBy': instance.collectedBy,
      'customerName': instance.customerName,
      'mobileNo': instance.mobileNo,
      'receivedAmount': instance.receivedAmount,
      'transactionId': instance.transactionId,
      'transactionImage': instance.transactionImage,
      'fatherName': instance.fatherName,
      'modeOfCollectionId': instance.modeOfCollectionId,
      'commonId': instance.commonId,
      'bankName': instance.bankName,
      'customerEmail': instance.customerEmail,
      'emiReceivedDate': instance.emiReceivedDate,
      'remarkByCollection': instance.remarkByCollection,
      'partner': instance.partner,
    };
