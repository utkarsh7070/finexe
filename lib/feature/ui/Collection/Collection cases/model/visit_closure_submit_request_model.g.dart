// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'visit_closure_submit_request_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VisitClosureSubmitRequestModel _$VisitClosureSubmitRequestModelFromJson(
        Map<String, dynamic> json) =>
    VisitClosureSubmitRequestModel(
      ld: json['LD'] as String,
      customerName: json['customerName'] as String,
      mobileNo: (json['mobileNo'] as num).toInt(),
      amountToBeReceivedFromCustomer:
          (json['amountToBeReceivedFromCustomer'] as num).toInt(),
      dateOfDeposit: json['dateOfDeposit'] as String,
      settlementForReason: json['settlementForReason'] as String,
    );

Map<String, dynamic> _$VisitClosureSubmitRequestModelToJson(
        VisitClosureSubmitRequestModel instance) =>
    <String, dynamic>{
      'LD': instance.ld,
      'customerName': instance.customerName,
      'mobileNo': instance.mobileNo,
      'amountToBeReceivedFromCustomer': instance.amountToBeReceivedFromCustomer,
      'dateOfDeposit': instance.dateOfDeposit,
      'settlementForReason': instance.settlementForReason,
    };
