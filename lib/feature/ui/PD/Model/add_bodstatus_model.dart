import 'package:json_annotation/json_annotation.dart';
part 'add_bodstatus_model.g.dart';

@JsonSerializable()
class BodStatusResponse {
  final bool status;
  final int subCode;
  final String message;
  final String error;
  final bool? data;

  BodStatusResponse({
    required this.status,
    required this.subCode,
    required this.message,
    required this.error,
    required this.data,
  });

  // factory BodStatusResponse.fromJson(Map<String, dynamic> json) {
  //   return BodStatusResponse(
  //     status: json['status'] ?? false,
  //     subCode: json['subCode'] ?? 0,
  //     message: json['message'] ?? '',
  //     error: json['error'] ?? '',
  //     data: json['items']['data'] ?? false,
  //   );
  // }

  factory BodStatusResponse.fromJson(Map<String, dynamic> json) =>
      _$BodStatusResponseFromJson(json);

  Map<String, dynamic> toJason() => _$BodStatusResponseToJson(this);
}
