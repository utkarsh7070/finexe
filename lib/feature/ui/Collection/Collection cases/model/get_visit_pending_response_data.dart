import 'package:json_annotation/json_annotation.dart';
part 'get_visit_pending_response_data.g.dart';


@JsonSerializable()
class GetVisitPendingResponseData {
  @JsonKey(name: "status")
  bool status;
  @JsonKey(name: "subCode")
  int subCode;
  @JsonKey(name: "message")
  String message;
  @JsonKey(name: "error")
  String error;
  @JsonKey(name: "items")
  List<Map<String, String>> items;

  GetVisitPendingResponseData({
    required this.status,
    required this.subCode,
    required this.message,
    required this.error,
    required this.items,
  });

  factory GetVisitPendingResponseData.fromJson(Map<String, dynamic> json) => _$GetVisitPendingResponseDataFromJson(json);

  Map<String, dynamic> toJson() => _$GetVisitPendingResponseDataToJson(this);
}
