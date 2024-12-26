import 'package:json_annotation/json_annotation.dart';
part 'submit_new_loan_response_model.g.dart';

@JsonSerializable()
class SubmitNewLoanResponseModel {
  @JsonKey(name: "status")
  bool status;
  @JsonKey(name: "subCode")
  int subCode;
  @JsonKey(name: "message")
  String message;
  @JsonKey(name: "error")
  String error;
  @JsonKey(name: "items")
  NewLoanItem items;

  SubmitNewLoanResponseModel({
    required this.status,
    required this.subCode,
    required this.message,
    required this.error,
    required this.items,
  });

  factory SubmitNewLoanResponseModel.fromJson(Map<String, dynamic> json) => _$SubmitNewLoanResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$SubmitNewLoanResponseModelToJson(this);
}

@JsonSerializable()
class NewLoanItem {
  @JsonKey(name: "employeId")
  String employeId;
  @JsonKey(name: "productId")
  String productId;
  @JsonKey(name: "customerFinId")
  String customerFinId;
  @JsonKey(name: "loginFees")
  int loginFees;
  @JsonKey(name: "orderId")
  String orderId;
  @JsonKey(name: "mobileNo")
  int mobileNo;
  @JsonKey(name: "executiveName")
  String executiveName;
  @JsonKey(name: "branch")
  dynamic branch;
  @JsonKey(name: "loanAmount")
  int loanAmount;
  @JsonKey(name: "roi")
  int roi;
  @JsonKey(name: "tenure")
  int tenure;
  @JsonKey(name: "emi")
  int emi;
  @JsonKey(name: "paymentImage")
  String paymentImage;
  @JsonKey(name: "transactionId")
  String transactionId;
  @JsonKey(name: "paymentStatus")
  String paymentStatus;
  @JsonKey(name: "_id")
  String id;
  @JsonKey(name: "createdAt")
  DateTime createdAt;
  @JsonKey(name: "updatedAt")
  DateTime updatedAt;
  @JsonKey(name: "__v")
  int v;

  @JsonKey(name: "PaymentGateway")
  String PaymentGateway;

  NewLoanItem({
    required this.employeId,
    required this.productId,
    required this.customerFinId,
    required this.loginFees,
    required this.orderId,
    required this.mobileNo,
    required this.executiveName,
    required this.branch,
    required this.loanAmount,
    required this.roi,
    required this.tenure,
    required this.emi,
    required this.paymentImage,
    required this.transactionId,
    required this.paymentStatus,
    required this.id,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
    required this.PaymentGateway,
  });

  factory NewLoanItem.fromJson(Map<String, dynamic> json) => _$NewLoanItemFromJson(json);

  Map<String, dynamic> toJson() => _$NewLoanItemToJson(this);
}
