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
  Items items;

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
class Items {
  @JsonKey(name: "employeId")
  String employeId;
  @JsonKey(name: "userName")
  var userName;
  @JsonKey(name: "roleName")
  List<String> roleName;
  @JsonKey(name: "token")
  String token;
  @JsonKey(name: "roamId")
  String roamId;
  @JsonKey(name: "trackingMode")
  String trackingMode;

  Items({
    required this.employeId,
    required this.userName,
    required this.roleName,
    required this.token,
      required this.roamId,
    required this.trackingMode,
  });

  factory Items.fromJson(Map<String, dynamic> json) => _$ItemsFromJson(json);

  Map<String, dynamic> toJson() => _$ItemsToJson(this);
}

