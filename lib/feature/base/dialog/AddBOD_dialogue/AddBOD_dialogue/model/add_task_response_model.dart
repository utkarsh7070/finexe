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
  Items items;

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
class Items {
  @JsonKey(name: "employeeId")
  String employeeId;
  @JsonKey(name: "task")
  String task;
  @JsonKey(name: "description")
  String description;
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
  @JsonKey(name: "createdAt")
  DateTime createdAt;
  @JsonKey(name: "updatedAt")
  DateTime updatedAt;
  @JsonKey(name: "__v")
  int v;

  Items({
    required this.employeeId,
    required this.task,
    required this.description,
    required this.startDate,
    required this.endDate,
    required this.managerBodStatus,
    required this.managerEodStatus,
    required this.status,
    required this.id,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
  });

  factory Items.fromJson(Map<String, dynamic> json) => _$ItemsFromJson(json);

  Map<String, dynamic> toJson() => _$ItemsToJson(this);
}
