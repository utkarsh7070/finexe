import 'package:json_annotation/json_annotation.dart';
part 'pd_reject_response_model.g.dart';

@JsonSerializable()
class PdRejectResponseModel {
  @JsonKey(name: "status")
  bool status;
  @JsonKey(name: "subCode")
  int subCode;
  @JsonKey(name: "message")
  String message;
  @JsonKey(name: "error")
  String error;
  @JsonKey(name: "items")
  List<RejectItem> items;

  PdRejectResponseModel({
    required this.status,
    required this.subCode,
    required this.message,
    required this.error,
    required this.items,
  });

  factory PdRejectResponseModel.fromJson(Map<String, dynamic> json) => _$PdRejectResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$PdRejectResponseModelToJson(this);
}

@JsonSerializable()
class RejectItem {
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
  @JsonKey(name: "remarkByCreditPd")
  String? remarkByCreditPd;

  RejectItem({
    required this.id,
    required this.customerId,
    required this.externalVendorId,
    required this.partnerNameId,
    required this.creditPdId,
    required this.pdfCreateByCreditPd,
    required this.remarkForCreditPd,
    required this.statusByCreditPd,
    required this.branchDetails,
    required this.applicantDetails,
    required this.customerFinId,
    required this.customerName,
    required this.customerMobileNo,
    required this.customerFatherName,
    required this.customerPhoto,
    required this.customerAddress,
    this.remarkByCreditPd,
  });

  factory RejectItem.fromJson(Map<String, dynamic> json) => _$RejectItemFromJson(json);

  Map<String, dynamic> toJson() => _$RejectItemToJson(this);
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
    required this.id,
    required this.fullName,
    required this.email,
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
    required this.id,
    required this.name,
  });

  factory BranchDetails.fromJson(Map<String, dynamic> json) => _$BranchDetailsFromJson(json);

  Map<String, dynamic> toJson() => _$BranchDetailsToJson(this);
}
