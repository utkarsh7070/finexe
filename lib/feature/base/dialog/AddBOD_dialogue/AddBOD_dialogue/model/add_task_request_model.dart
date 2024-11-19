import 'package:json_annotation/json_annotation.dart';
part 'add_task_request_model.g.dart';

@JsonSerializable()
class AddTaskRequestModel {
  @JsonKey(name: "employeeId")
  String employeeId;
  @JsonKey(name: "task")
  String task;
  @JsonKey(name: "description")
  String description;

  AddTaskRequestModel({
    required this.employeeId,
    required this.task,
    required this.description,
  });

  factory AddTaskRequestModel.fromJson(Map<String, dynamic> json) => _$AddTaskRequestModelFromJson(json);

  Map<String, dynamic> toJson() => _$AddTaskRequestModelToJson(this);
}
