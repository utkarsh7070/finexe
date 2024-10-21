import 'package:json_annotation/json_annotation.dart';
part 'aadhaar_otp_request_model.g.dart';

@JsonSerializable()
class AadhaarOtpRequestModel {
  @JsonKey(name: "transId")
  String transId;
  @JsonKey(name: "otp")
  int otp;

  AadhaarOtpRequestModel({
    required this.transId,
    required this.otp,
  });

  factory AadhaarOtpRequestModel.fromJson(Map<String, dynamic> json) => _$AadhaarOtpRequestModelFromJson(json);

  Map<String, dynamic> toJson() => _$AadhaarOtpRequestModelToJson(this);
}
