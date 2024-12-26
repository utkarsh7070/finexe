import 'package:json_annotation/json_annotation.dart';
part 'pan_response_model.g.dart';

@JsonSerializable()
class PanResponseModel {
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

  PanResponseModel({
    required this.status,
    required this.subCode,
    required this.message,
    required this.error,
    required this.items,
  });

  factory PanResponseModel.fromJson(Map<String, dynamic> json) => _$PanResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$PanResponseModelToJson(this);
}

@JsonSerializable()
class Items {
  @JsonKey(name: "data")
  Data data;
  @JsonKey(name: "message")
  String message;
  @JsonKey(name: "message_code")
  String messageCode;
  @JsonKey(name: "status")
  int status;
  @JsonKey(name: "status_code")
  int statusCode;
  @JsonKey(name: "success")
  bool success;
  @JsonKey(name: "tsTransID")
  String tsTransId;

  Items({
    required this.data,
    required this.message,
    required this.messageCode,
    required this.status,
    required this.statusCode,
    required this.success,
    required this.tsTransId,
  });

  factory Items.fromJson(Map<String, dynamic> json) => _$ItemsFromJson(json);

  Map<String, dynamic> toJson() => _$ItemsToJson(this);
}

@JsonSerializable()
class Data {
  @JsonKey(name: "aadhaar_linked")
  bool aadhaarLinked;
  @JsonKey(name: "address")
  Address address;
  @JsonKey(name: "category")
  String category;
  @JsonKey(name: "client_id")
  String clientId;
  @JsonKey(name: "dob")
  DateTime dob;
  @JsonKey(name: "dob_check")
  bool dobCheck;
  @JsonKey(name: "dob_verified")
  bool dobVerified;
  @JsonKey(name: "email")
  String email;
  @JsonKey(name: "full_name")
  String fullName;
  @JsonKey(name: "full_name_split")
  List<String> fullNameSplit;
  @JsonKey(name: "gender")
  String gender;
  @JsonKey(name: "input_dob")
  String inputDob;
  @JsonKey(name: "less_info")
  bool lessInfo;
  @JsonKey(name: "masked_aadhaar")
  String maskedAadhaar;
  @JsonKey(name: "pan_number")
  String panNumber;
  @JsonKey(name: "phone_number")
  String phoneNumber;

  Data({
    required this.aadhaarLinked,
    required this.address,
    required this.category,
    required this.clientId,
    required this.dob,
    required this.dobCheck,
    required this.dobVerified,
    required this.email,
    required this.fullName,
    required this.fullNameSplit,
    required this.gender,
    required this.inputDob,
    required this.lessInfo,
    required this.maskedAadhaar,
    required this.panNumber,
    required this.phoneNumber,
  });

  factory Data.fromJson(Map<String, dynamic> json) => _$DataFromJson(json);

  Map<String, dynamic> toJson() => _$DataToJson(this);
}

@JsonSerializable()
class Address {
  @JsonKey(name: "city")
  String city;
  @JsonKey(name: "country")
  String country;
  @JsonKey(name: "full")
  String full;
  @JsonKey(name: "line_1")
  String line1;
  @JsonKey(name: "line_2")
  String line2;
  @JsonKey(name: "state")
  String state;
  @JsonKey(name: "street_name")
  String streetName;
  @JsonKey(name: "zip")
  String zip;

  Address({
    required this.city,
    required this.country,
    required this.full,
    required this.line1,
    required this.line2,
    required this.state,
    required this.streetName,
    required this.zip,
  });

  factory Address.fromJson(Map<String, dynamic> json) => _$AddressFromJson(json);

  Map<String, dynamic> toJson() => _$AddressToJson(this);
}
