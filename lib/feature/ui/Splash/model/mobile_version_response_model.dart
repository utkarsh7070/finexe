import 'package:json_annotation/json_annotation.dart';
part 'mobile_version_response_model.g.dart';

@JsonSerializable()
class MobileVersionResponseModel {
  @JsonKey(name: "status")
  bool? status;
  @JsonKey(name: "subCode")
  int? subCode;
  @JsonKey(name: "message")
  String? message;
  @JsonKey(name: "error")
  String? error;
  @JsonKey(name: "items")
  Items? items;

  MobileVersionResponseModel({
    this.status,
    this.subCode,
    this.message,
    this.error,
    this.items,
  });

  factory MobileVersionResponseModel.fromJson(Map<String, dynamic> json) => _$MobileVersionResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$MobileVersionResponseModelToJson(this);
}

@JsonSerializable()
class Items {
  @JsonKey(name: "_id")
  String? id;
  @JsonKey(name: "version")
  String? version;
  @JsonKey(name: "apkUrl")
  String? apkUrl;
  @JsonKey(name: "status")
  String? status;
  @JsonKey(name: "createdAt")
  DateTime? createdAt;
  @JsonKey(name: "updatedAt")
  DateTime? updatedAt;
  @JsonKey(name: "__v")
  int? v;

  Items({
    this.id,
    this.version,
    this.apkUrl,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  factory Items.fromJson(Map<String, dynamic> json) => _$ItemsFromJson(json);

  Map<String, dynamic> toJson() => _$ItemsToJson(this);
}
