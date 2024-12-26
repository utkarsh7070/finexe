import 'package:json_annotation/json_annotation.dart';
part 'update_password_request_model.g.dart';

@JsonSerializable()
class UpdatePasswordRequestModel {
  @JsonKey(name: "oldPassword")
  String oldPassword;
  @JsonKey(name: "newPassword")
  String newPassword;

  UpdatePasswordRequestModel({
    required this.oldPassword,
    required this.newPassword,
  });

  factory UpdatePasswordRequestModel.fromJson(Map<String, dynamic> json) => _$UpdatePasswordRequestModelFromJson(json);

  Map<String, dynamic> toJson() => _$UpdatePasswordRequestModelToJson(this);
}
