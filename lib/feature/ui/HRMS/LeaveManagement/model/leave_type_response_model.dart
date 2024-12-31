
import 'package:json_annotation/json_annotation.dart';
part 'leave_type_response_model.g.dart';

@JsonSerializable()
class LeaveTypeResponseModel {
  @JsonKey(name: "status")
  bool status;
  @JsonKey(name: "subCode")
  int subCode;
  @JsonKey(name: "message")
  String message;
  @JsonKey(name: "error")
  String error;
  @JsonKey(name: "items")
  List<Item> items;

  LeaveTypeResponseModel({
    required this.status,
    required this.subCode,
    required this.message,
    required this.error,
    required this.items,
  });

  factory LeaveTypeResponseModel.fromJson(Map<String, dynamic> json) => _$LeaveTypeResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$LeaveTypeResponseModelToJson(this);
}

@JsonSerializable()
class Item {
  @JsonKey(name: "_id")
  String id;
  @JsonKey(name: "leaveTypeName")
  String leaveType;


  Item({
    required this.id,
    required this.leaveType,
  });

  factory Item.fromJson(Map<String, dynamic> json) => _$ItemFromJson(json);

  Map<String, dynamic> toJson() => _$ItemToJson(this);
}
