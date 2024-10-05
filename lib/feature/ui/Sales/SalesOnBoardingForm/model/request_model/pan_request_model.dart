import 'package:json_annotation/json_annotation.dart';
part 'pan_request_model.g.dart';

@JsonSerializable()
class PanRequestModel {
  @JsonKey(name: "transID")
  String transId;
  @JsonKey(name: "docType")
  int docType;
  @JsonKey(name: "PanNumber")
  String panNumber;

  PanRequestModel({
    required this.transId,
    required this.docType,
    required this.panNumber,
  });

  factory PanRequestModel.fromJson(Map<String, dynamic> json) => _$PanRequestModelFromJson(json);

  Map<String, dynamic> toJson() => _$PanRequestModelToJson(this);
}
