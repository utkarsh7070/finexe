
import 'package:json_annotation/json_annotation.dart';

part 'all_employee_list_model.g.dart';

@JsonSerializable()
class AllEmployeeResponseModel {
  @JsonKey(name: "status")
  final bool status;

  @JsonKey(name: "subCode")
  final int subCode;

  @JsonKey(name: "message")
  final String message;

  @JsonKey(name: "error")
  final String error;

  @JsonKey(name: "items")
  final List<Employee> items;

  AllEmployeeResponseModel({
    required this.status,
    required this.subCode,
    required this.message,
    required this.error,
    required this.items,
  });

  factory AllEmployeeResponseModel.fromJson(Map<String, dynamic> json) =>
      _$AllEmployeeResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$AllEmployeeResponseModelToJson(this);
}

@JsonSerializable()
class Employee {
  @JsonKey(name: "_id")
  final String? id;

  @JsonKey(name: "employeUniqueId")
  final String? employeUniqueId;

  @JsonKey(name: "employeName")
  final String? employeName;

  Employee({
    required this.id,
    required this.employeUniqueId,
    required this.employeName,
  });

  factory Employee.fromJson(Map<String, dynamic> json) =>
      _$EmployeeFromJson(json);

  Map<String, dynamic> toJson() => _$EmployeeToJson(this);
}
