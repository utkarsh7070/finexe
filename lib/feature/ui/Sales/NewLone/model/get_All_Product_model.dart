import 'package:json_annotation/json_annotation.dart';
part 'get_All_Product_model.g.dart';

@JsonSerializable()
class GetAllProductModel {
  @JsonKey(name: "status")
  bool status;
  @JsonKey(name: "subCode")
  int subCode;
  @JsonKey(name: "message")
  String message;
  @JsonKey(name: "error")
  String error;
  @JsonKey(name: "items")
  List<Item> items;

  GetAllProductModel({
    required this.status,
    required this.subCode,
    required this.message,
    required this.error,
    required this.items,
  });

  factory GetAllProductModel.fromJson(Map<String, dynamic> json) => _$GetAllProductModelFromJson(json);

  Map<String, dynamic> toJson() => _$GetAllProductModelToJson(this);
}

@JsonSerializable()
class Item {
  @JsonKey(name: "loanAmount")
  LoanAmount loanAmount;
  @JsonKey(name: "roi")
  LoanAmount roi;
  @JsonKey(name: "tenure")
  LoanAmount tenure;
  @JsonKey(name: "_id")
  String id;
  @JsonKey(name: "productName")
  String productName;
  @JsonKey(name: "loginFees")
  int loginFees;
  @JsonKey(name: "status")
  String status;
  @JsonKey(name: "createdAt")
  DateTime createdAt;
  @JsonKey(name: "updatedAt")
  DateTime updatedAt;
  @JsonKey(name: "__v")
  int v;
  @JsonKey(name: "permissionFormId")
  String permissionFormId;
  @JsonKey(name: "productFinId")
  String productFinId;

  Item({
    required this.loanAmount,
    required this.roi,
    required this.tenure,
    required this.id,
    required this.productName,
    required this.loginFees,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
    required this.permissionFormId,
    required this.productFinId,
  });

  factory Item.fromJson(Map<String, dynamic> json) => _$ItemFromJson(json);

  Map<String, dynamic> toJson() => _$ItemToJson(this);
}

@JsonSerializable()
class LoanAmount {
  @JsonKey(name: "min")
  int min;
  @JsonKey(name: "max")
  int max;

  LoanAmount({
    required this.min,
    required this.max,
  });

  factory LoanAmount.fromJson(Map<String, dynamic> json) => _$LoanAmountFromJson(json);

  Map<String, dynamic> toJson() => _$LoanAmountToJson(this);
}
