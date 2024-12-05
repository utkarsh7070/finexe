import 'package:json_annotation/json_annotation.dart';

part 'get_mode_by_id_response_model.g.dart';
//
// @JsonSerializable()
// class GetModeByIdResponseModel {
//   bool status;
//   int subCode;
//   String message;
//   String error;
//   Items? items;
//
//   GetModeByIdResponseModel({
//     required this.status,
//     required this.subCode,
//     required this.message,
//     required this.error,
//     this.items,
//   });
//
//   factory GetModeByIdResponseModel.fromJson(Map<String, dynamic> json) =>
//       _$GetModeByIdResponseModelFromJson(json);
//
//   Map<String, dynamic> toJson() => _$GetModeByIdResponseModelToJson(this);
// }
//
// @JsonSerializable()
// class Items {
//   ModeDetail? modeDetail;
//   DropdownDetail? dropdownDetail;
//   List<Detail>? detail;
//
//   Items({this.modeDetail, this.dropdownDetail, this.detail});
//
//   factory Items.fromJson(Map<String, dynamic> json) => _$ItemsFromJson(json);
//
//   Map<String, dynamic> toJson() => _$ItemsToJson(this);
// }
//
// @JsonSerializable()
// class Detail {
//   String? id;
//   String? title;
//   String? bankName;
//   String? bankAcNo;
//   String? bankIFSCCode;
//   String? bankAcHolderName;
//   String? bankBranch;
//   String? status;
//   String? createdAt;
//   String? updatedAt;
//   int? v;
//
//   Detail({
//     this.id,
//     this.title,
//     this.bankName,
//     this.bankAcNo,
//     this.bankIFSCCode,
//     this.bankAcHolderName,
//     this.bankBranch,
//     this.status,
//     this.createdAt,
//     this.updatedAt,
//     this.v,
//   });
//
//   factory Detail.fromJson(Map<String, dynamic> json) => _$DetailFromJson(json);
//
//   Map<String, dynamic> toJson() => _$DetailToJson(this);
// }



@JsonSerializable()
class GetModeByIdResponseModel {
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

  GetModeByIdResponseModel({
    required this.status,
    required this.subCode,
    required this.message,
    required this.error,
    required this.items,
  });

  factory GetModeByIdResponseModel.fromJson(Map<String, dynamic> json) => _$GetModeByIdResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$GetModeByIdResponseModelToJson(this);
}

@JsonSerializable()
class Items {
  @JsonKey(name: "modeDetail")
  ModeDetail modeDetail;
  @JsonKey(name: "dropdownDetail")
  DropdownDetail? dropdownDetail;
  @JsonKey(name: "detail")
  List<Detail>? detail;

  Items({
    required this.modeDetail,
    required this.dropdownDetail,
    required this.detail,
  });

  factory Items.fromJson(Map<String, dynamic> json) => _$ItemsFromJson(json);

  Map<String, dynamic> toJson() => _$ItemsToJson(this);
}

@JsonSerializable()
class Detail {
  @JsonKey(name: "_id")
  String? id;
  @JsonKey(name: "title")
  String? title;
  @JsonKey(name: "bankName")
  String? bankName;
  @JsonKey(name: "bankAcNo")
  String? bankAcNo;
  @JsonKey(name: "bankIFSCCode")
  String? bankIfscCode;
  @JsonKey(name: "bankAcHolderName")
  String? bankAcHolderName;
  @JsonKey(name: "bankBranch")
  String? bankBranch;
  @JsonKey(name: "status")
  String? status;
  @JsonKey(name: "createdAt")
  String? createdAt;
  @JsonKey(name: "updatedAt")
  String? updatedAt;
  @JsonKey(name: "__v")
  int v;

  Detail({
    required this.id,
    required this.title,
    required this.bankName,
    required this.bankAcNo,
    required this.bankIfscCode,
    required this.bankAcHolderName,
    required this.bankBranch,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
  });

  factory Detail.fromJson(Map<String, dynamic> json) => _$DetailFromJson(json);

  Map<String, dynamic> toJson() => _$DetailToJson(this);
}

@JsonSerializable()
class DropdownDetail {
  @JsonKey(name: "_id")
  String id;
  @JsonKey(name: "title")
  String title;
  @JsonKey(name: "modelName")
  String modelName;
  @JsonKey(name: "status")
  String status;
  @JsonKey(name: "createdAt")
  String createdAt;
  @JsonKey(name: "updatedAt")
  String updatedAt;
  @JsonKey(name: "__v")
  int v;

  DropdownDetail({
    required this.id,
    required this.title,
    required this.modelName,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
  });

  factory DropdownDetail.fromJson(Map<String, dynamic> json) => _$DropdownDetailFromJson(json);

  Map<String, dynamic> toJson() => _$DropdownDetailToJson(this);
}

@JsonSerializable()
class ModeDetail {
  @JsonKey(name: "_id")
  String? id;
  @JsonKey(name: "title")
  String? title;
  @JsonKey(name: "extraForm")
  bool extraForm;
  @JsonKey(name: "email")
  bool email;
  @JsonKey(name: "dropdownId")
  String? dropdownId;
  @JsonKey(name: "status")
  String status;
  @JsonKey(name: "createdAt")
  String createdAt;
  @JsonKey(name: "updatedAt")
  String updatedAt;
  @JsonKey(name: "__v")
  int? v;
  @JsonKey(name: "transactionId")
  bool transactionId;
  @JsonKey(name: "transactionImage")
  bool transactionImage;

  ModeDetail({
    required this.id,
    required this.title,
    required this.extraForm,
    required this.email,
    required this.dropdownId,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
    required this.transactionId,
    required this.transactionImage,
  });

  factory ModeDetail.fromJson(Map<String, dynamic> json) => _$ModeDetailFromJson(json);

  Map<String, dynamic> toJson() => _$ModeDetailToJson(this);
}

