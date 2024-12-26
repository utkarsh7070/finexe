// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'payment_initiate_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PaymentInitiateResponseModel _$PaymentInitiateResponseModelFromJson(
        Map<String, dynamic> json) =>
    PaymentInitiateResponseModel(
      status: json['status'] as bool,
      subCode: (json['subCode'] as num).toInt(),
      message: json['message'] as String,
      error: json['error'] as String,
      items: Items.fromJson(json['items'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$PaymentInitiateResponseModelToJson(
        PaymentInitiateResponseModel instance) =>
    <String, dynamic>{
      'status': instance.status,
      'subCode': instance.subCode,
      'message': instance.message,
      'error': instance.error,
      'items': instance.items,
    };

Items _$ItemsFromJson(Map<String, dynamic> json) => Items(
      customerDetail: CustomerDetail.fromJson(
          json['customerDetail'] as Map<String, dynamic>),
      payment: json['payment'],
    );

Map<String, dynamic> _$ItemsToJson(Items instance) => <String, dynamic>{
      'customerDetail': instance.customerDetail,
      'payment': instance.payment,
    };

CustomerDetail _$CustomerDetailFromJson(Map<String, dynamic> json) =>
    CustomerDetail(
      id: json['_id'] as String,
      employeId: json['employeId'] as String,
      productId: json['productId'] as String,
      customerFinId: json['customerFinId'] as String,
      loginFees: (json['loginFees'] as num).toInt(),
      orderId: json['orderId'] as String,
      mobileNo: (json['mobileNo'] as num).toInt(),
      executiveName: json['executiveName'] as String,
      branch: json['branch'] as String,
      nearestBranchId: json['nearestBranchId'],
      loanAmount: (json['loanAmount'] as num).toInt(),
      roi: (json['roi'] as num).toInt(),
      tenure: (json['tenure'] as num).toInt(),
      emi: (json['emi'] as num).toDouble(),
      paymentImage: json['paymentImage'] as String,
      transactionId: json['transactionId'] as String,
      paymentStatus: json['paymentStatus'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
      v: (json['__v'] as num).toInt(),
    );

Map<String, dynamic> _$CustomerDetailToJson(CustomerDetail instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'employeId': instance.employeId,
      'productId': instance.productId,
      'customerFinId': instance.customerFinId,
      'loginFees': instance.loginFees,
      'orderId': instance.orderId,
      'mobileNo': instance.mobileNo,
      'executiveName': instance.executiveName,
      'branch': instance.branch,
      'nearestBranchId': instance.nearestBranchId,
      'loanAmount': instance.loanAmount,
      'roi': instance.roi,
      'tenure': instance.tenure,
      'emi': instance.emi,
      'paymentImage': instance.paymentImage,
      'transactionId': instance.transactionId,
      'paymentStatus': instance.paymentStatus,
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt.toIso8601String(),
      '__v': instance.v,
    };
