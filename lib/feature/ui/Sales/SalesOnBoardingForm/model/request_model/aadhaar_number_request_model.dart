import 'package:json_annotation/json_annotation.dart';
part 'aadhaar_number_request_model.g.dart';

@JsonSerializable()
class AadhaarNumberRequestModel {
  @JsonKey(name: "aadharNo")
  String aadharNo;
  @JsonKey(name: "transId")
  String transId;
  @JsonKey(name: "docType")
  String docType;
  @JsonKey(name: "formName")
  String formName;

  AadhaarNumberRequestModel({
    required this.aadharNo,
    required this.transId,
    required this.docType,
    required this.formName,
  });

  factory AadhaarNumberRequestModel.fromJson(Map<String, dynamic> json) => _$AadhaarNumberRequestModelFromJson(json);

  Map<String, dynamic> toJson() => _$AadhaarNumberRequestModelToJson(this);
}
