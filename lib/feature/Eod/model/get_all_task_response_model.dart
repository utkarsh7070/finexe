import 'package:json_annotation/json_annotation.dart';
part 'get_all_task_response_model.g.dart';

@JsonSerializable()
class GetAllTaskResponseModel {
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

  GetAllTaskResponseModel({
    required this.status,
    required this.subCode,
    required this.message,
    required this.error,
    required this.items,
  });

  factory GetAllTaskResponseModel.fromJson(Map<String, dynamic> json) => _$GetAllTaskResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$GetAllTaskResponseModelToJson(this);
}

@JsonSerializable()
class Items {
  @JsonKey(name: "employeeDetail")
  EmployeeDetail employeeDetail;
  @JsonKey(name: "tasks")
  List<Task> tasks;

  Items({
    required this.employeeDetail,
    required this.tasks,
  });

  factory Items.fromJson(Map<String, dynamic> json) => _$ItemsFromJson(json);

  Map<String, dynamic> toJson() => _$ItemsToJson(this);
}

@JsonSerializable()
class EmployeeDetail {
  @JsonKey(name: "_id")
  String id;
  @JsonKey(name: "employeName")
  String employeName;
  @JsonKey(name: "userName")
  String userName;
  @JsonKey(name: "email")
  String email;
  @JsonKey(name: "workEmail")
  String workEmail;
  @JsonKey(name: "mobileNo")
  int mobileNo;
  @JsonKey(name: "joiningDate")
  DateTime joiningDate;
  @JsonKey(name: "dateOfBirth")
  DateTime dateOfBirth;

  EmployeeDetail({
    required this.id,
    required this.employeName,
    required this.userName,
    required this.email,
    required this.workEmail,
    required this.mobileNo,
    required this.joiningDate,
    required this.dateOfBirth,
  });

  factory EmployeeDetail.fromJson(Map<String, dynamic> json) => _$EmployeeDetailFromJson(json);

  Map<String, dynamic> toJson() => _$EmployeeDetailToJson(this);
}

@JsonSerializable()
class Task {
  @JsonKey(name: "_id")
  String id;
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
  @JsonKey(name: "createdAt")
  DateTime createdAt;
  @JsonKey(name: "updatedAt")
  DateTime updatedAt;

  Task({
    required this.id,
    required this.task,
    required this.description,
    required this.startDate,
    required this.endDate,
    required this.managerBodStatus,
    required this.managerEodStatus,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Task.fromJson(Map<String, dynamic> json) => _$TaskFromJson(json);

  Map<String, dynamic> toJson() => _$TaskToJson(this);
}
