// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'submit_new_loan_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SubmitNewLoanResponseModel _$SubmitNewLoanResponseModelFromJson(
        Map<String, dynamic> json) =>
    SubmitNewLoanResponseModel(
      status: json['status'] as bool,
      subCode: (json['subCode'] as num).toInt(),
      message: json['message'] as String,
      error: json['error'] as String,
      items: NewLoanItem.fromJson(json['items'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$SubmitNewLoanResponseModelToJson(
        SubmitNewLoanResponseModel instance) =>
    <String, dynamic>{
      'status': instance.status,
      'subCode': instance.subCode,
      'message': instance.message,
      'error': instance.error,
      'items': instance.items,
    };

NewLoanItem _$NewLoanItemFromJson(Map<String, dynamic> json) => NewLoanItem(
      employeId: json['employeId'] as String,
      productId: json['productId'] as String,
      customerFinId: json['customerFinId'] as String,
      loginFees: (json['loginFees'] as num).toInt(),
      orderId: json['orderId'] as String,
      mobileNo: (json['mobileNo'] as num).toInt(),
      executiveName: json['executiveName'] as String,
      branch: json['branch'],
      loanAmount: (json['loanAmount'] as num).toInt(),
      roi: (json['roi'] as num).toInt(),
      tenure: (json['tenure'] as num).toInt(),
      emi: (json['emi'] as num).toInt(),
      paymentImage: json['paymentImage'] as String,
      transactionId: json['transactionId'] as String,
      paymentStatus: json['paymentStatus'] as String,
      id: json['_id'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
      v: (json['__v'] as num).toInt(),
    );

Map<String, dynamic> _$NewLoanItemToJson(NewLoanItem instance) =>
    <String, dynamic>{
      'employeId': instance.employeId,
      'productId': instance.productId,
      'customerFinId': instance.customerFinId,
      'loginFees': instance.loginFees,
      'orderId': instance.orderId,
      'mobileNo': instance.mobileNo,
      'executiveName': instance.executiveName,
      'branch': instance.branch,
      'loanAmount': instance.loanAmount,
      'roi': instance.roi,
      'tenure': instance.tenure,
      'emi': instance.emi,
      'paymentImage': instance.paymentImage,
      'transactionId': instance.transactionId,
      'paymentStatus': instance.paymentStatus,
      '_id': instance.id,
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt.toIso8601String(),
      '__v': instance.v,
    };
