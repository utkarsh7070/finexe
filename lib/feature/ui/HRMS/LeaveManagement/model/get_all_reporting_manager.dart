
import 'package:json_annotation/json_annotation.dart';
part 'get_all_reporting_manager.g.dart';

/*@JsonSerializable()
class GetAllReportingManagerModel {
  @JsonKey(name: "status")
  bool status;
  @JsonKey(name: "subCode")
  int subCode;
  @JsonKey(name: "message")
  String message;
  @JsonKey(name: "error")
  String error;
  @JsonKey(name: "items")
  List<ReportingManager> items;

  GetAllReportingManagerModel({
    required this.status,
    required this.subCode,
    required this.message,
    required this.error,
    required this.items,
  });

  factory GetAllReportingManagerModel.fromJson(Map<String, dynamic> json) => _$GetAllReportingManagerModelFromJson(json);

  Map<String, dynamic> toJson() => _$GetAllReportingManagerModelToJson(this);
}

@JsonSerializable()
class ReportingManager {

  @JsonKey(name: "_id")
  String id;

  @JsonKey(name: "name")
  String name;

  ReportingManager({
    required this.id,
    required this.name,
  });

  factory ReportingManager.fromJson(Map<String, dynamic> json) => _$ReportingManagerFromJson(json);

  Map<String, dynamic> toJson() => _$ReportingManagerToJson(this);
}*/

@JsonSerializable()
class GetAllReportingManagerModel {
  @JsonKey(name: "status")
  bool status;

  @JsonKey(name: "subCode")
  int subCode;

  @JsonKey(name: "message")
  String message;

  @JsonKey(name: "error")
  String error;

  @JsonKey(name: "items")
  ReportingManagersData items;

  GetAllReportingManagerModel({
    required this.status,
    required this.subCode,
    required this.message,
    required this.error,
    required this.items,
  });

  factory GetAllReportingManagerModel.fromJson(Map<String, dynamic> json) =>
      _$GetAllReportingManagerModelFromJson(json);

  Map<String, dynamic> toJson() => _$GetAllReportingManagerModelToJson(this);
}

@JsonSerializable()
class ReportingManagersData {
  @JsonKey(name: "count")
  int count;

  @JsonKey(name: "managersData")
  List<ReportingManager> managersData;

  ReportingManagersData({
    required this.count,
    required this.managersData,
  });

  factory ReportingManagersData.fromJson(Map<String, dynamic> json) =>
      _$ReportingManagersDataFromJson(json);

  Map<String, dynamic> toJson() => _$ReportingManagersDataToJson(this);
}

@JsonSerializable()
class ReportingManager {
  @JsonKey(name: "_id")
  String id;

  @JsonKey(name: "employeName")
  String name;

  ReportingManager({
    required this.id,
    required this.name,
  });

  factory ReportingManager.fromJson(Map<String, dynamic> json) =>
      _$ReportingManagerFromJson(json);

  Map<String, dynamic> toJson() => _$ReportingManagerToJson(this);
}
