import 'package:json_annotation/json_annotation.dart';
part 'add_task_response_model.g.dart';

@JsonSerializable()
class AddTaskResponseModel {
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

  AddTaskResponseModel({
    required this.status,
    required this.subCode,
    required this.message,
    required this.error,
    required this.items,
  });

  factory AddTaskResponseModel.fromJson(Map<String, dynamic> json) => _$AddTaskResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$AddTaskResponseModelToJson(this);
}

@JsonSerializable()
class Item {
  @JsonKey(name: "employeeId")
  String employeeId;
  @JsonKey(name: "assignBy")
  String assignBy;
  @JsonKey(name: "task")
  String task;
  @JsonKey(name: "description")
  String description;
  @JsonKey(name: "remark")
  String remark;
  @JsonKey(name: "startDate")
  String startDate;
  @JsonKey(name: "endDate")
  String endDate;
  @JsonKey(name: "managerBodStatus")
  String managerBodStatus;
  @JsonKey(name: "managerEodStatus")
  String managerEodStatus;
  @JsonKey(name: "status")
  String status;
  @JsonKey(name: "_id")
  String id;
  @JsonKey(name: "__v")
  int v;
  @JsonKey(name: "createdAt")
  DateTime createdAt;
  @JsonKey(name: "updatedAt")
  DateTime updatedAt;

  Item({
    required this.employeeId,
    required this.assignBy,
    required this.task,
    required this.description,
    required this.remark,
    required this.startDate,
    required this.endDate,
    required this.managerBodStatus,
    required this.managerEodStatus,
    required this.status,
    required this.id,
    required this.v,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Item.fromJson(Map<String, dynamic> json) => _$ItemFromJson(json);

  Map<String, dynamic> toJson() => _$ItemToJson(this);
}

