import 'package:json_annotation/json_annotation.dart';
part 'update_password_responsemodel.g.dart';

@JsonSerializable()
class UpdatePasswordResponseModel {
  @JsonKey(name: "status")
  bool status;
  @JsonKey(name: "subCode")
  int subCode;
  @JsonKey(name: "message")
  String message;
  @JsonKey(name: "error")
  String error;

  UpdatePasswordResponseModel({
    required this.status,
    required this.subCode,
    required this.message,
    required this.error,
  });

  factory UpdatePasswordResponseModel.fromJson(Map<String, dynamic> json) => _$UpdatePasswordResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$UpdatePasswordResponseModelToJson(this);
}
