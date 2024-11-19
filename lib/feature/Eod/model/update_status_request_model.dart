import 'package:json_annotation/json_annotation.dart';
part 'update_status_request_model.g.dart';

@JsonSerializable()
class UpdateStatusRequestModel {
  @JsonKey(name: "taskId")
  String taskId;
  @JsonKey(name: "status")
  String status;

  UpdateStatusRequestModel({
    required this.taskId,
    required this.status,
  });

  factory UpdateStatusRequestModel.fromJson(Map<String, dynamic> json) => _$UpdateStatusRequestModelFromJson(json);

  Map<String, dynamic> toJson() => _$UpdateStatusRequestModelToJson(this);
}
