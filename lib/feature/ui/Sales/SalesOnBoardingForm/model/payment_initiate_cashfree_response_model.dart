import 'package:json_annotation/json_annotation.dart';
part 'payment_initiate_cashfree_response_model.g.dart';


@JsonSerializable()
class PaymentInitiateCashFreeResponseModel {
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

  PaymentInitiateCashFreeResponseModel({
    required this.status,
    required this.subCode,
    required this.message,
    required this.error,
    required this.items,
  });

  factory PaymentInitiateCashFreeResponseModel.fromJson(Map<String, dynamic> json) => _$PaymentInitiateCashFreeResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$PaymentInitiateCashFreeResponseModelToJson(this);
}

@JsonSerializable()
class Items {
  @JsonKey(name: "payment_url")
  String paymentUrl;
  @JsonKey(name: "session_id")
  String sessionId;
  @JsonKey(name: "orderId")
  String orderId;
  @JsonKey(name: "amount")
  int amount;

  Items({
    required this.paymentUrl,
    required this.sessionId,
    required this.orderId,
    required this.amount,
  });

  factory Items.fromJson(Map<String, dynamic> json) => _$ItemsFromJson(json);

  Map<String, dynamic> toJson() => _$ItemsToJson(this);
}
