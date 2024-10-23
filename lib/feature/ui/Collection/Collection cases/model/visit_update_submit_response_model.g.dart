// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'visit_update_submit_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VisitUpdateSubmitResponseModel _$VisitUpdateSubmitResponseModelFromJson(
        Map<String, dynamic> json) =>
    VisitUpdateSubmitResponseModel(
      status: json['status'] as bool,
      subCode: (json['subCode'] as num).toInt(),
      message: json['message'] as String,
      error: json['error'] as String,
      items: Items.fromJson(json['items'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$VisitUpdateSubmitResponseModelToJson(
        VisitUpdateSubmitResponseModel instance) =>
    <String, dynamic>{
      'status': instance.status,
      'subCode': instance.subCode,
      'message': instance.message,
      'error': instance.error,
      'items': instance.items,
    };

Items _$ItemsFromJson(Map<String, dynamic> json) => Items(
      ld: json['LD'] as String,
      customerName: json['customerName'] as String,
      visitBy: json['visitBy'] as String,
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
      location: Location.fromJson(json['location'] as Map<String, dynamic>),
      status: json['status'] as String,
      reason: json['reason'] as String,
      id: json['_id'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
      v: (json['__v'] as num).toInt(),
    );

Map<String, dynamic> _$ItemsToJson(Items instance) => <String, dynamic>{
      'LD': instance.ld,
      'customerName': instance.customerName,
      'visitBy': instance.visitBy,
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
      'location': instance.location,
      'status': instance.status,
      'reason': instance.reason,
      '_id': instance.id,
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt.toIso8601String(),
      '__v': instance.v,
    };

Location _$LocationFromJson(Map<String, dynamic> json) => Location(
      coordinates: (json['coordinates'] as List<dynamic>)
          .map((e) => (e as num).toDouble())
          .toList(),
      type: json['type'] as String,
    );

Map<String, dynamic> _$LocationToJson(Location instance) => <String, dynamic>{
      'coordinates': instance.coordinates,
      'type': instance.type,
    };
