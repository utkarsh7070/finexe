import 'package:json_annotation/json_annotation.dart';
part 'visit_update_upload_image_responce_model.g.dart';

@JsonSerializable()
class VisitUpdateUploadImageResponseModel {
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

  VisitUpdateUploadImageResponseModel({
    required this.status,
    required this.subCode,
    required this.message,
    required this.error,
    required this.items,
  });

  factory VisitUpdateUploadImageResponseModel.fromJson(Map<String, dynamic> json) => _$VisitUpdateUploadImageResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$VisitUpdateUploadImageResponseModelToJson(this);
}

@JsonSerializable()
class Items {
  @JsonKey(name: "image")
  String image;

  Items({
    required this.image,
  });

  factory Items.fromJson(Map<String, dynamic> json) => _$ItemsFromJson(json);

  Map<String, dynamic> toJson() => _$ItemsToJson(this);
}
