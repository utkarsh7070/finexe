import 'package:json_annotation/json_annotation.dart';
part 'check_attendance_responce_model.g.dart';

@JsonSerializable()
class CheckAttendanceResponceModel {
  @JsonKey(name: "status")
  bool status;
  @JsonKey(name: "subCode")
  int subCode;
  @JsonKey(name: "message")
  String message;
  @JsonKey(name: "error")
  String error;
  @JsonKey(name: "items")
  Item items;

  CheckAttendanceResponceModel({
    required this.status,
    required this.subCode,
    required this.message,
    required this.error,
    required this.items,
  });

  factory CheckAttendanceResponceModel.fromJson(Map<String, dynamic> json) => _$CheckAttendanceResponceModelFromJson(json);

  Map<String, dynamic> toJson() => _$CheckAttendanceResponceModelToJson(this);
}

@JsonSerializable()
class Item {
  @JsonKey(name: "allowed")
  bool allowed;
  @JsonKey(name: "viewButton")
  bool viewButton;

  Item({
    required this.allowed,
    required this.viewButton,
  });

  factory Item.fromJson(Map<String, dynamic> json) => _$ItemFromJson(json);

  Map<String, dynamic> toJson() => _$ItemToJson(this);
}
