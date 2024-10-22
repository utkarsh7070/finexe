import 'package:json_annotation/json_annotation.dart';
part 'visit_update_submit_response_model.g.dart';

@JsonSerializable()
class VisitUpdateSubmitResponseModel {
  @JsonKey(name: "status")
  bool status;
  @JsonKey(name: "subCode")
  int subCode;
  @JsonKey(name: "message")
  String message;
  @JsonKey(name: "error")
  String error;
  @JsonKey(name: "items")
  Items items;

  VisitUpdateSubmitResponseModel({
    required this.status,
    required this.subCode,
    required this.message,
    required this.error,
    required this.items,
  });

  factory VisitUpdateSubmitResponseModel.fromJson(Map<String, dynamic> json) => _$VisitUpdateSubmitResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$VisitUpdateSubmitResponseModelToJson(this);
}

@JsonSerializable()
class Items {
  @JsonKey(name: "LD")
  String ld;
  @JsonKey(name: "customerName")
  String customerName;
  @JsonKey(name: "visitBy")
  String visitBy;
  @JsonKey(name: "visitDate")
  String visitDate;
  @JsonKey(name: "revisitDate")
  String revisitDate;
  @JsonKey(name: "newContactNumber")
  int newContactNumber;
  @JsonKey(name: "customerResponse")
  String customerResponse;
  @JsonKey(name: "paymentAmount")
  int paymentAmount;
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
  @JsonKey(name: "location")
  Location location;
  @JsonKey(name: "status")
  String status;
  @JsonKey(name: "reason")
  String reason;
  @JsonKey(name: "_id")
  String id;
  @JsonKey(name: "createdAt")
  DateTime createdAt;
  @JsonKey(name: "updatedAt")
  DateTime updatedAt;
  @JsonKey(name: "__v")
  int v;

  Items({
    required this.ld,
    required this.customerName,
    required this.visitBy,
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
    required this.location,
    required this.status,
    required this.reason,
    required this.id,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
  });

  factory Items.fromJson(Map<String, dynamic> json) => _$ItemsFromJson(json);

  Map<String, dynamic> toJson() => _$ItemsToJson(this);
}

@JsonSerializable()
class Location {
  @JsonKey(name: "coordinates")
  List<double> coordinates;
  @JsonKey(name: "type")
  String type;

  Location({
    required this.coordinates,
    required this.type,
  });

  factory Location.fromJson(Map<String, dynamic> json) => _$LocationFromJson(json);

  Map<String, dynamic> toJson() => _$LocationToJson(this);
}
