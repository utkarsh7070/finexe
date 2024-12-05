import 'package:json_annotation/json_annotation.dart';
part 'pan_father_name_response_model.g.dart';


@JsonSerializable()
class PanFatherNameResponseModel {
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

  PanFatherNameResponseModel({
    required this.status,
    required this.subCode,
    required this.message,
    required this.error,
    required this.items,
  });

  factory PanFatherNameResponseModel.fromJson(Map<String, dynamic> json) => _$PanFatherNameResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$PanFatherNameResponseModelToJson(this);
}

@JsonSerializable()
class Items {
  @JsonKey(name: "msg")
  Msg? msg;
  @JsonKey(name: "status")
  int? status;
  @JsonKey(name: "tsTransId")
  String? tsTransId;

  Items({
    required this.msg,
    required this.status,
    required this.tsTransId,
  });

  factory Items.fromJson(Map<String, dynamic> json) => _$ItemsFromJson(json);

  Map<String, dynamic> toJson() => _$ItemsToJson(this);
}

@JsonSerializable()
class Msg {
  @JsonKey(name: "data")
  Data? data;
  @JsonKey(name: "message")
  dynamic message;
  @JsonKey(name: "message_code")
  String? messageCode;
  @JsonKey(name: "status_code")
  int? statusCode;
  @JsonKey(name: "success")
  bool? success;

  Msg({
    required this.data,
    required this.message,
    required this.messageCode,
    required this.statusCode,
    required this.success,
  });

  factory Msg.fromJson(Map<String, dynamic> json) => _$MsgFromJson(json);

  Map<String, dynamic> toJson() => _$MsgToJson(this);
}

@JsonSerializable()
class Data {
  @JsonKey(name: "additional_check")
  List<dynamic>? additionalCheck;
  @JsonKey(name: "category")
  String? category;
  @JsonKey(name: "client_id")
  String? clientId;
  @JsonKey(name: "dob")
  DateTime? dob;
  @JsonKey(name: "dob_check")
  bool? dobCheck;
  @JsonKey(name: "dob_verified")
  bool? dobVerified;
  @JsonKey(name: "father_name")
  String? fatherName;
  @JsonKey(name: "full_name")
  String? fullName;
  @JsonKey(name: "less_info")
  bool? lessInfo;
  @JsonKey(name: "pan_number")
  String? panNumber;

  Data({
    required this.additionalCheck,
    required this.category,
    required this.clientId,
    required this.dob,
    required this.dobCheck,
    required this.dobVerified,
    required this.fatherName,
    required this.fullName,
    required this.lessInfo,
    required this.panNumber,
  });

  factory Data.fromJson(Map<String, dynamic> json) => _$DataFromJson(json);

  Map<String, dynamic> toJson() => _$DataToJson(this);
}
