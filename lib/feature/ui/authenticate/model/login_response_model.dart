import 'package:json_annotation/json_annotation.dart';
part 'login_response_model.g.dart';

@JsonSerializable()
class LoginResponseModel {
  @JsonKey(name: "status")
  bool status;
  @JsonKey(name: "subCode")
  int subCode;
  @JsonKey(name: "message")
  String message;
  @JsonKey(name: "error")
  String error;
  @JsonKey(name: "items")
  LoginItem items;

  LoginResponseModel({
    required this.status,
    required this.subCode,
    required this.message,
    required this.error,
    required this.items,
  });

  factory LoginResponseModel.fromJson(Map<String, dynamic> json) => _$LoginResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$LoginResponseModelToJson(this);
}

@JsonSerializable()
class LoginItem {
  @JsonKey(name: "employeId")
  String employeId;
  @JsonKey(name: "userName")
  String userName;
  @JsonKey(name: "roleName")
  String roleName;
  @JsonKey(name: "token")
  String token;

  LoginItem({
    required this.employeId,
    required this.userName,
    required this.roleName,
    required this.token,
  });

  factory LoginItem.fromJson(Map<String, dynamic> json) => _$LoginItemFromJson(json);

  Map<String, dynamic> toJson() => _$LoginItemToJson(this);
}
