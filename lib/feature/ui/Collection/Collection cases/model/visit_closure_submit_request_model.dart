import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';
part 'visit_closure_submit_request_model.g.dart';



  @JsonSerializable()
  class VisitClosureSubmitRequestModel {
  @JsonKey(name: "LD")
  String ld;
  @JsonKey(name: "customerName")
  String customerName;
  @JsonKey(name: "mobileNo")
  int mobileNo;
  @JsonKey(name: "amountToBeReceivedFromCustomer")
  int amountToBeReceivedFromCustomer;
  @JsonKey(name: "dateOfDeposit")
  String dateOfDeposit;
  @JsonKey(name: "settlementForReason")
  String settlementForReason;

  VisitClosureSubmitRequestModel({
  required this.ld,
  required this.customerName,
  required this.mobileNo,
  required this.amountToBeReceivedFromCustomer,
  required this.dateOfDeposit,
  required this.settlementForReason,
  });

  factory VisitClosureSubmitRequestModel.fromJson(Map<String, dynamic> json) => _$VisitClosureSubmitRequestModelFromJson(json);

  Map<String, dynamic> toJson() => _$VisitClosureSubmitRequestModelToJson(this);
  }

