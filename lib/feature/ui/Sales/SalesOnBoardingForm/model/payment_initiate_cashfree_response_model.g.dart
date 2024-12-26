// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'payment_initiate_cashfree_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PaymentInitiateCashFreeResponseModel
    _$PaymentInitiateCashFreeResponseModelFromJson(Map<String, dynamic> json) =>
        PaymentInitiateCashFreeResponseModel(
          status: json['status'] as bool,
          subCode: (json['subCode'] as num).toInt(),
          message: json['message'] as String,
          error: json['error'] as String,
          items: Items.fromJson(json['items'] as Map<String, dynamic>),
        );

Map<String, dynamic> _$PaymentInitiateCashFreeResponseModelToJson(
        PaymentInitiateCashFreeResponseModel instance) =>
    <String, dynamic>{
      'status': instance.status,
      'subCode': instance.subCode,
      'message': instance.message,
      'error': instance.error,
      'items': instance.items,
    };

Items _$ItemsFromJson(Map<String, dynamic> json) => Items(
      paymentUrl: json['payment_url'] as String,
      sessionId: json['session_id'] as String,
      orderId: json['orderId'] as String,
      amount: (json['amount'] as num).toInt(),
    );

Map<String, dynamic> _$ItemsToJson(Items instance) => <String, dynamic>{
      'payment_url': instance.paymentUrl,
      'session_id': instance.sessionId,
      'orderId': instance.orderId,
      'amount': instance.amount,
    };
