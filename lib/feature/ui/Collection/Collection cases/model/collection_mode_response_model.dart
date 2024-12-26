import 'package:json_annotation/json_annotation.dart';
part 'collection_mode_response_model.g.dart';

@JsonSerializable()
class CollectionModeResponseModel {
  @JsonKey(name: "status")
  bool? status;
  @JsonKey(name: "subCode")
  int? subCode;
  @JsonKey(name: "message")
  String? message;
  @JsonKey(name: "error")
  String? error;
  @JsonKey(name: "items")
  List<ModeItem> items;

  CollectionModeResponseModel({
    required this.status,
    required this.subCode,
    required this.message,
    required this.error,
    required this.items,
  });

  factory CollectionModeResponseModel.fromJson(Map<String, dynamic> json) => _$CollectionModeResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$CollectionModeResponseModelToJson(this);
}

@JsonSerializable()
class ModeItem {
  @JsonKey(name: "_id")
  String? id;
  @JsonKey(name: "title")
  String title;
  @JsonKey(name: "extraForm")
  bool? extraForm;
  @JsonKey(name: "email")
  bool email;
  @JsonKey(name: "dropdownId")
  String? dropdownId;
  @JsonKey(name: "status")
  String? status;
  @JsonKey(name: "createdAt")
  DateTime? createdAt;
  @JsonKey(name: "updatedAt")
  DateTime? updatedAt;
  @JsonKey(name: "__v")
  int v;
  @JsonKey(name: "dropdownDetail")
  DropdownDetail? dropdownDetail;

  ModeItem({
    required this.id,
    required this.title,
    required this.extraForm,
    required this.email,
    required this.dropdownId,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
    required this.dropdownDetail,
  });

  factory ModeItem.fromJson(Map<String, dynamic> json) => _$ModeItemFromJson(json);

  Map<String, dynamic> toJson() => _$ModeItemToJson(this);
}

@JsonSerializable()
class DropdownDetail {
  @JsonKey(name: "_id")
  String? id;
  @JsonKey(name: "title")
  String? title;
  @JsonKey(name: "modelName")
  String? modelName;
  @JsonKey(name: "status")
  String? status;

  DropdownDetail({
    required this.id,
    required this.title,
    required this.modelName,
    required this.status,
  });

  factory DropdownDetail.fromJson(Map<String, dynamic> json) => _$DropdownDetailFromJson(json);

  Map<String, dynamic> toJson() => _$DropdownDetailToJson(this);
}
