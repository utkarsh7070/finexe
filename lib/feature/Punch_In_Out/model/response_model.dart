import 'package:json_annotation/json_annotation.dart';
part 'response_model.g.dart';

@JsonSerializable()
class PunchInModel{
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

  PunchInModel({
    required this.status,
    required this.subCode,
    required this.message,
    required this.error,
    required this.items,
  });

  factory PunchInModel.fromJson(Map<String, dynamic> json) => _$PunchInModelFromJson(json);

  Map<String, dynamic> toJson() => _$PunchInModelToJson(this);
}

@JsonSerializable()
class Items {
  @JsonKey(name: "employeeId")
  String employeeId;
  @JsonKey(name: "date")
  DateTime date;
  @JsonKey(name: "punchInTime")
  DateTime punchInTime;
  @JsonKey(name: "_id")
  String id;
  @JsonKey(name: "createdAt")
  DateTime createdAt;
  @JsonKey(name: "updatedAt")
  DateTime updatedAt;
  @JsonKey(name: "__v")
  int v;

  Items({
    required this.employeeId,
    required this.date,
    required this.punchInTime,
    required this.id,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
  });

  factory Items.fromJson(Map<String, dynamic> json) => _$ItemsFromJson(json);

  Map<String, dynamic> toJson() => _$ItemsToJson(this);
}
