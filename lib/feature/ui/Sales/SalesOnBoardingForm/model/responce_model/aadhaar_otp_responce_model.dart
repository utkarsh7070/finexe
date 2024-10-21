import 'package:json_annotation/json_annotation.dart';
part 'aadhaar_otp_responce_model.g.dart';

@JsonSerializable()
class  AadhaarOtpResponseModel{
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

  AadhaarOtpResponseModel({
    required this.status,
    required this.subCode,
    required this.message,
    required this.error,
    required this.items,
  });

  factory AadhaarOtpResponseModel.fromJson(Map<String, dynamic> json) => _$AadhaarOtpResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$AadhaarOtpResponseModelToJson(this);
}

@JsonSerializable()
class Items {
  @JsonKey(name: "msg")
  Msg msg;
  @JsonKey(name: "status")
  int status;

  Items({
    required this.msg,
    required this.status,
  });

  factory Items.fromJson(Map<String, dynamic> json) => _$ItemsFromJson(json);

  Map<String, dynamic> toJson() => _$ItemsToJson(this);
}

@JsonSerializable()
class Msg {
  @JsonKey(name: "Aadhar No")
  String aadharNo;
  @JsonKey(name: "Address")
  String address;
  @JsonKey(name: "Careof")
  String careof;
  @JsonKey(name: "Country")
  String country;
  @JsonKey(name: "DOB")
  String dob;
  @JsonKey(name: "District")
  String district;
  @JsonKey(name: "Document link")
  String documentLink;
  @JsonKey(name: "Gender")
  String gender;
  @JsonKey(name: "House")
  String house;
  @JsonKey(name: "Image")
  String image;
  @JsonKey(name: "Landmark")
  String landmark;
  @JsonKey(name: "Locality")
  String locality;
  @JsonKey(name: "Name")
  String name;
  @JsonKey(name: "Pincode")
  String pincode;
  @JsonKey(name: "Post Office")
  String postOffice;
  @JsonKey(name: "Relatationship type")
  String relatationshipType;
  @JsonKey(name: "Relative Name")
  String relativeName;
  @JsonKey(name: "Share Code")
  String shareCode;
  @JsonKey(name: "State")
  String state;
  @JsonKey(name: "Street")
  String street;
  @JsonKey(name: "Sub District")
  String subDistrict;
  @JsonKey(name: "Village/Town/City")
  String villageTownCity;

  Msg({
    required this.aadharNo,
    required this.address,
    required this.careof,
    required this.country,
    required this.dob,
    required this.district,
    required this.documentLink,
    required this.gender,
    required this.house,
    required this.image,
    required this.landmark,
    required this.locality,
    required this.name,
    required this.pincode,
    required this.postOffice,
    required this.relatationshipType,
    required this.relativeName,
    required this.shareCode,
    required this.state,
    required this.street,
    required this.subDistrict,
    required this.villageTownCity,
  });

  factory Msg.fromJson(Map<String, dynamic> json) => _$MsgFromJson(json);

  Map<String, dynamic> toJson() => _$MsgToJson(this);
}
