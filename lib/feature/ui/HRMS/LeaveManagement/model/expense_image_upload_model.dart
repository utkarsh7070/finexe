


import 'package:json_annotation/json_annotation.dart';
part 'expense_image_upload_model.g.dart';

@JsonSerializable()
class ExpenseImageUploadResponseModel {
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

  ExpenseImageUploadResponseModel({
    required this.status,
    required this.subCode,
    required this.message,
    required this.error,
    required this.items,
  });

  factory ExpenseImageUploadResponseModel.fromJson(Map<String, dynamic> json) => _$ExpenseImageUploadResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$ExpenseImageUploadResponseModelToJson(this);
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
