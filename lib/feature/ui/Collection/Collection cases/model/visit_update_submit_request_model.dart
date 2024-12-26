import 'package:json_annotation/json_annotation.dart';
part 'visit_update_submit_request_model.g.dart';

@JsonSerializable()
class VisitUpdateSubmitRequestModel {
  @JsonKey(name: "LD")
  String ld;
  @JsonKey(name: "customerName")
  String customerName;
  @JsonKey(name: "visitDate")
  String visitDate;
  @JsonKey(name: "revisitDate")
  String revisitDate;
  @JsonKey(name: "newContactNumber")
  String newContactNumber;
  @JsonKey(name: "customerResponse")
  String customerResponse;
  @JsonKey(name: "paymentAmount")
  String paymentAmount;
  @JsonKey(name: "reasonForNotPay")
  String reasonForNotPay;
  @JsonKey(name: "solution")
  String solution;
  @JsonKey(name: "reasonForCustomerNotContactable")
  String reasonForCustomerNotContactable;
  @JsonKey(name: "visitSelfie")
  String visitSelfie;
  @JsonKey(name: "address")
  String address;
  // @JsonKey(name: "latitude")
  // double latitude;
  // @JsonKey(name: "longitude")
  // double longitude;

  VisitUpdateSubmitRequestModel({
    required this.ld,
    required this.customerName,
    required this.visitDate,
    required this.revisitDate,
    required this.newContactNumber,
    required this.customerResponse,
    required this.paymentAmount,
    required this.reasonForNotPay,
    required this.solution,
    required this.reasonForCustomerNotContactable,
    required this.visitSelfie,
    required this.address,
    // required this.latitude,
    // required this.longitude,
  });

  factory VisitUpdateSubmitRequestModel.fromJson(Map<String, dynamic> json) => _$VisitUpdateSubmitRequestModelFromJson(json);

  Map<String, dynamic> toJson() => _$VisitUpdateSubmitRequestModelToJson(this);
}
