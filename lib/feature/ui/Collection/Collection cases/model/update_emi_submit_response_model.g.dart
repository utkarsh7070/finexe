// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'update_emi_submit_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UpdateEmiSubmitResponseModel _$UpdateEmiSubmitResponseModelFromJson(
        Map<String, dynamic> json) =>
    UpdateEmiSubmitResponseModel(
      status: json['status'] as bool,
      subCode: (json['subCode'] as num).toInt(),
      message: json['message'] as String,
      error: json['error'] as String,
      items: Items.fromJson(json['items'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$UpdateEmiSubmitResponseModelToJson(
        UpdateEmiSubmitResponseModel instance) =>
    <String, dynamic>{
      'status': instance.status,
      'subCode': instance.subCode,
      'message': instance.message,
      'error': instance.error,
      'items': instance.items,
    };

Items _$ItemsFromJson(Map<String, dynamic> json) => Items(
      ld: json['LD'] as String,
      collectedBy: json['collectedBy'] as String,
      customerName: json['customerName'] as String,
      mobileNo: (json['mobileNo'] as num).toInt(),
      receivedAmount: (json['receivedAmount'] as num).toInt(),
      transactionId: json['transactionId'] as String,
      transactionImage: json['transactionImage'] as String,
      customerEmail: json['customerEmail'] as String,
      modeOfCollectionId: json['modeOfCollectionId'] as String,
      commonId: json['commonId'] as String,
      partner: json['partner'] as String,
      emiReceivedDate: json['emiReceivedDate'] as String,
      emiReceivedTime: json['emiReceivedTime'],
      remarkByCollection: json['remarkByCollection'] as String,
      remarkByManager: json['remarkByManager'],
      status: json['status'] as String,
      pdf: json['pdf'] as String,
      receiptNo: (json['receiptNo'] as num).toInt(),
      reason: json['reason'] as String,
      id: json['_id'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
      v: (json['__v'] as num).toInt(),
    );

Map<String, dynamic> _$ItemsToJson(Items instance) => <String, dynamic>{
      'LD': instance.ld,
      'collectedBy': instance.collectedBy,
      'customerName': instance.customerName,
      'mobileNo': instance.mobileNo,
      'receivedAmount': instance.receivedAmount,
      'transactionId': instance.transactionId,
      'transactionImage': instance.transactionImage,
      'customerEmail': instance.customerEmail,
      'modeOfCollectionId': instance.modeOfCollectionId,
      'commonId': instance.commonId,
      'partner': instance.partner,
      'emiReceivedDate': instance.emiReceivedDate,
      'emiReceivedTime': instance.emiReceivedTime,
      'remarkByCollection': instance.remarkByCollection,
      'remarkByManager': instance.remarkByManager,
      'status': instance.status,
      'pdf': instance.pdf,
      'receiptNo': instance.receiptNo,
      'reason': instance.reason,
      '_id': instance.id,
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt.toIso8601String(),
      '__v': instance.v,
    };
