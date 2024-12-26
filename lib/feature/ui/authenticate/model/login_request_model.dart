import 'package:json_annotation/json_annotation.dart';
part 'login_request_model.g.dart';

@JsonSerializable()
class LoginRequestModel {
  @JsonKey(name: "userName")
  String userName;
  @JsonKey(name: "password")
  String password;
  @JsonKey(name: "employeeRole")
  String employeeRole;

  LoginRequestModel({
    required this.userName,
    required this.password,
    required this.employeeRole,
  });

  factory LoginRequestModel.fromJson(Map<String, dynamic> json) => _$LoginRequestModelFromJson(json);

  Map<String, dynamic> toJson() => _$LoginRequestModelToJson(this);
}
