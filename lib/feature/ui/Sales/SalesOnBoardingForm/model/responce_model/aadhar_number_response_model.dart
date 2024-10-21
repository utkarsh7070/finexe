import 'package:json_annotation/json_annotation.dart';
part 'aadhar_number_response_model.g.dart';

@JsonSerializable()
class AadhaarNumberResponseModel {
  @JsonKey(name: "status")
  bool status;
  @JsonKey(name: "subCode")
  int subCode;
  @JsonKey(name: "message")
  String message;
  @JsonKey(name: "error")
  String error;
  @JsonKey(name: "items")
  AadhaarItems items;

  AadhaarNumberResponseModel({
    required this.status,
    required this.subCode,
    required this.message,
    required this.error,
    required this.items,
  });

  factory AadhaarNumberResponseModel.fromJson(Map<String, dynamic> json) => _$AadhaarNumberResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$AadhaarNumberResponseModelToJson(this);
}

@JsonSerializable()
class AadhaarItems {
  @JsonKey(name: "msg")
  String msg;
  @JsonKey(name: "status")
  int status;
  @JsonKey(name: "tsTransId")
  String tsTransId;

  AadhaarItems({
    required this.msg,
    required this.status,
    required this.tsTransId,
  });

  factory AadhaarItems.fromJson(Map<String, dynamic> json) => _$AadhaarItemsFromJson(json);

  Map<String, dynamic> toJson() => _$AadhaarItemsToJson(this);
}
