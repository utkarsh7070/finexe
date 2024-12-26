import 'package:json_annotation/json_annotation.dart';
import 'package:bson/bson.dart';
part 'update_emi_submit_request_model.g.dart';

@JsonSerializable()
class UpdateEmiSubmitRequestModel {
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
  @JsonKey(name: "fatherName")
  String fatherName;
  @JsonKey(name: "modeOfCollectionId")
  String modeOfCollectionId;
  @JsonKey(name: "commonId")
  ObjectId? commonId;
  @JsonKey(name: "bankName")
  String bankName;
  @JsonKey(name: "customerEmail")
  String customerEmail;
  @JsonKey(name: "emiReceivedDate")
  String emiReceivedDate;
  @JsonKey(name: "remarkByCollection")
  String remarkByCollection;
  @JsonKey(name: "partner")
  String partner;


  UpdateEmiSubmitRequestModel({
    required this.fatherName,
    required this.ld,
    required this.collectedBy,
    required this.customerName,
    required this.mobileNo,
    required this.receivedAmount,
    required this.transactionId,
    required this.transactionImage,
    required this.modeOfCollectionId,
    required this.commonId,
    required this.bankName,
    required this.customerEmail,
    required this.emiReceivedDate,
    required this.remarkByCollection,
    required this.partner,
  });

  factory UpdateEmiSubmitRequestModel.fromJson(Map<String, dynamic> json) => _$UpdateEmiSubmitRequestModelFromJson(json);

  Map<String, dynamic> toJson() => _$UpdateEmiSubmitRequestModelToJson(this);
}
