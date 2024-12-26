import 'package:json_annotation/json_annotation.dart';
part 'refuse_case_response_model.g.dart';

@JsonSerializable()
class RefuseCaseResponseModel {
  @JsonKey(name: "status")
  bool? status;
  @JsonKey(name: "subCode")
  int? subCode;
  @JsonKey(name: "message")
  String? message;
  @JsonKey(name: "error")
  String? error;
  @JsonKey(name: "items")
  List<RefuseItem>? items;

  RefuseCaseResponseModel({
    this.status,
    this.subCode,
    this.message,
    this.error,
    this.items,
  });

  factory RefuseCaseResponseModel.fromJson(Map<String, dynamic> json) => _$RefuseCaseResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$RefuseCaseResponseModelToJson(this);
}

@JsonSerializable()
class RefuseItem {
  @JsonKey(name: "_id")
  String? id;
  @JsonKey(name: "customerId")
  String? customerId;
  @JsonKey(name: "externalVendorId")
  String? externalVendorId;
  @JsonKey(name: "partnerNameId")
  String? partnerNameId;
  @JsonKey(name: "creditPdId")
  String? creditPdId;
  @JsonKey(name: "pdfCreateByCreditPd")
  String? pdfCreateByCreditPd;
  @JsonKey(name: "remarkForCreditPd")
  String? remarkForCreditPd;
  @JsonKey(name: "statusByCreditPd")
  String? statusByCreditPd;
  @JsonKey(name: "branchDetails")
  BranchDetails? branchDetails;
  @JsonKey(name: "applicantDetails")
  ApplicantDetails? applicantDetails;
  @JsonKey(name: "customerFinId")
  String? customerFinId;
  @JsonKey(name: "customerName")
  String? customerName;
  @JsonKey(name: "customerMobileNo")
  int? customerMobileNo;
  @JsonKey(name: "customerFatherName")
  String? customerFatherName;
  @JsonKey(name: "customerPhoto")
  String? customerPhoto;
  @JsonKey(name: "customerAddress")
  String? customerAddress;

  RefuseItem({
    this.id,
    this.customerId,
    this.externalVendorId,
    this.partnerNameId,
    this.creditPdId,
    this.pdfCreateByCreditPd,
    this.remarkForCreditPd,
    this.statusByCreditPd,
    this.branchDetails,
    this.applicantDetails,
    this.customerFinId,
    this.customerName,
    this.customerMobileNo,
    this.customerFatherName,
    this.customerPhoto,
    this.customerAddress,
  });

  factory RefuseItem.fromJson(Map<String, dynamic> json) => _$RefuseItemFromJson(json);

  Map<String, dynamic> toJson() => _$RefuseItemToJson(this);
}

@JsonSerializable()
class ApplicantDetails {
  @JsonKey(name: "_id")
  String? id;
  @JsonKey(name: "fullName")
  String? fullName;
  @JsonKey(name: "email")
  String? email;

  ApplicantDetails({
    this.id,
    this.fullName,
    this.email,
  });

  factory ApplicantDetails.fromJson(Map<String, dynamic> json) => _$ApplicantDetailsFromJson(json);

  Map<String, dynamic> toJson() => _$ApplicantDetailsToJson(this);
}

@JsonSerializable()
class BranchDetails {
  @JsonKey(name: "_id")
  String? id;
  @JsonKey(name: "name")
  String? name;

  BranchDetails({
    this.id,
    this.name,
  });

  factory BranchDetails.fromJson(Map<String, dynamic> json) => _$BranchDetailsFromJson(json);

  Map<String, dynamic> toJson() => _$BranchDetailsToJson(this);
}
