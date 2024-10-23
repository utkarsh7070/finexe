// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'visit_update_submit_request_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VisitUpdateSubmitRequestModel _$VisitUpdateSubmitRequestModelFromJson(
        Map<String, dynamic> json) =>
    VisitUpdateSubmitRequestModel(
      ld: json['LD'] as String,
      customerName: json['customerName'] as String,
      visitDate: json['visitDate'] as String,
      revisitDate: json['revisitDate'] as String,
      newContactNumber: (json['newContactNumber'] as num).toInt(),
      customerResponse: json['customerResponse'] as String,
      paymentAmount: (json['paymentAmount'] as num).toInt(),
      reasonForNotPay: json['reasonForNotPay'] as String,
      solution: json['solution'] as String,
      reasonForCustomerNotContactable:
          json['reasonForCustomerNotContactable'] as String,
      visitSelfie: json['visitSelfie'] as String,
      address: json['address'] as String,
      latitude: (json['latitude'] as num).toDouble(),
      longitude: (json['longitude'] as num).toDouble(),
    );

Map<String, dynamic> _$VisitUpdateSubmitRequestModelToJson(
        VisitUpdateSubmitRequestModel instance) =>
    <String, dynamic>{
      'LD': instance.ld,
      'customerName': instance.customerName,
      'visitDate': instance.visitDate,
      'revisitDate': instance.revisitDate,
      'newContactNumber': instance.newContactNumber,
      'customerResponse': instance.customerResponse,
      'paymentAmount': instance.paymentAmount,
      'reasonForNotPay': instance.reasonForNotPay,
      'solution': instance.solution,
      'reasonForCustomerNotContactable':
          instance.reasonForCustomerNotContactable,
      'visitSelfie': instance.visitSelfie,
      'address': instance.address,
      'latitude': instance.latitude,
      'longitude': instance.longitude,
    };
