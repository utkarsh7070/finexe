import 'package:json_annotation/json_annotation.dart';
part 'check_attendance_responce_model.g.dart';


@JsonSerializable()
class CheckAttendanceResponseModel {
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

  CheckAttendanceResponseModel({
    required this.status,
    required this.subCode,
    required this.message,
    required this.error,
    required this.items,
  });

  factory CheckAttendanceResponseModel.fromJson(Map<String, dynamic> json) => _$CheckAttendanceResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$CheckAttendanceResponseModelToJson(this);
}

@JsonSerializable()
class Items {
  @JsonKey(name: "allowed")
  bool allowed;
  @JsonKey(name: "viewButton")
  bool viewButton;
  @JsonKey(name: "punchIn")
  bool punchIn;
  @JsonKey(name: "punchOut")
  bool punchOut;
  @JsonKey(name: "punchInTime")
  DateTime punchInTime;
  @JsonKey(name: "punchOutTime")
  DateTime punchOutTime;

  Items({
    required this.allowed,
    required this.viewButton,
    required this.punchIn,
    required this.punchOut,
    required this.punchInTime,
    required this.punchOutTime,
  });

  factory Items.fromJson(Map<String, dynamic> json) => _$ItemsFromJson(json);

  Map<String, dynamic> toJson() => _$ItemsToJson(this);
}


