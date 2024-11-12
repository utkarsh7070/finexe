import 'package:json_annotation/json_annotation.dart';
part 'payment_initiate_response_model.g.dart';

@JsonSerializable()
class PaymentInitiateResponseModel {
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

  PaymentInitiateResponseModel({
    required this.status,
    required this.subCode,
    required this.message,
    required this.error,
    required this.items,
  });

  factory PaymentInitiateResponseModel.fromJson(Map<String, dynamic> json) => _$PaymentInitiateResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$PaymentInitiateResponseModelToJson(this);
}

@JsonSerializable()
class Items {
  @JsonKey(name: "customerDetail")
  CustomerDetail customerDetail;
  @JsonKey(name: "payment")
  dynamic payment;

  Items({
    required this.customerDetail,
    required this.payment,
  });

  factory Items.fromJson(Map<String, dynamic> json) => _$ItemsFromJson(json);

  Map<String, dynamic> toJson() => _$ItemsToJson(this);
}

@JsonSerializable()
class CustomerDetail {
  @JsonKey(name: "_id")
  String id;
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
  String branch;
  @JsonKey(name: "nearestBranchId")
  dynamic nearestBranchId;
  @JsonKey(name: "loanAmount")
  int loanAmount;
  @JsonKey(name: "roi")
  int roi;
  @JsonKey(name: "tenure")
  int tenure;
  @JsonKey(name: "emi")
  double emi;
  @JsonKey(name: "paymentImage")
  String paymentImage;
  @JsonKey(name: "transactionId")
  String transactionId;
  @JsonKey(name: "paymentStatus")
  String paymentStatus;
  @JsonKey(name: "createdAt")
  DateTime createdAt;
  @JsonKey(name: "updatedAt")
  DateTime updatedAt;
  @JsonKey(name: "__v")
  int v;

  CustomerDetail({
    required this.id,
    required this.employeId,
    required this.productId,
    required this.customerFinId,
    required this.loginFees,
    required this.orderId,
    required this.mobileNo,
    required this.executiveName,
    required this.branch,
    required this.nearestBranchId,
    required this.loanAmount,
    required this.roi,
    required this.tenure,
    required this.emi,
    required this.paymentImage,
    required this.transactionId,
    required this.paymentStatus,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
  });

  factory CustomerDetail.fromJson(Map<String, dynamic> json) => _$CustomerDetailFromJson(json);

  Map<String, dynamic> toJson() => _$CustomerDetailToJson(this);
}
