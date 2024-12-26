import 'package:json_annotation/json_annotation.dart';
part 'update_emi_submit_response_model.g.dart';

@JsonSerializable()
class UpdateEmiSubmitResponseModel {
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

  UpdateEmiSubmitResponseModel({
    required this.status,
    required this.subCode,
    required this.message,
    required this.error,
    required this.items,
  });

  factory UpdateEmiSubmitResponseModel.fromJson(Map<String, dynamic> json) => _$UpdateEmiSubmitResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$UpdateEmiSubmitResponseModelToJson(this);
}

@JsonSerializable()
class Items {
  @JsonKey(name: "LD")
  String ld;
  @JsonKey(name: "collectedBy")
  String collectedBy;
  @JsonKey(name: "customerName")
  String customerName;
  @JsonKey(name: "mobileNo")
  int mobileNo;
  @JsonKey(name: "receivedAmount")
  int receivedAmount;
  @JsonKey(name: "transactionId")
  String transactionId;
  @JsonKey(name: "transactionImage")
  String transactionImage;
  @JsonKey(name: "customerEmail")
  String customerEmail;
  @JsonKey(name: "modeOfCollectionId")
  String modeOfCollectionId;
  @JsonKey(name: "commonId")
  String commonId;
  @JsonKey(name: "partner")
  String partner;
  @JsonKey(name: "emiReceivedDate")
  String emiReceivedDate;
  @JsonKey(name: "emiReceivedTime")
  dynamic emiReceivedTime;
  @JsonKey(name: "remarkByCollection")
  String remarkByCollection;
  @JsonKey(name: "remarkByManager")
  dynamic remarkByManager;
  @JsonKey(name: "status")
  String status;
  @JsonKey(name: "pdf")
  String pdf;
  @JsonKey(name: "receiptNo")
  int receiptNo;
  @JsonKey(name: "reason")
  String reason;
  @JsonKey(name: "_id")
  String id;
  @JsonKey(name: "createdAt")
  DateTime createdAt;
  @JsonKey(name: "updatedAt")
  DateTime updatedAt;
  @JsonKey(name: "__v")
  int v;

  Items({
    required this.ld,
    required this.collectedBy,
    required this.customerName,
    required this.mobileNo,
    required this.receivedAmount,
    required this.transactionId,
    required this.transactionImage,
    required this.customerEmail,
    required this.modeOfCollectionId,
    required this.commonId,
    required this.partner,
    required this.emiReceivedDate,
    required this.emiReceivedTime,
    required this.remarkByCollection,
    required this.remarkByManager,
    required this.status,
    required this.pdf,
    required this.receiptNo,
    required this.reason,
    required this.id,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
  });

  factory Items.fromJson(Map<String, dynamic> json) => _$ItemsFromJson(json);

  Map<String, dynamic> toJson() => _$ItemsToJson(this);
}
