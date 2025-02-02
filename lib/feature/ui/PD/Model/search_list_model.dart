import 'package:json_annotation/json_annotation.dart';
part 'search_list_model.g.dart';


@JsonSerializable()
class SearchListModel {
  @JsonKey(name: "status")
  bool status;
  @JsonKey(name: "subCode")
  int subCode;
  @JsonKey(name: "message")
  String message;
  @JsonKey(name: "error")
  String error;
  @JsonKey(name: "items")
  List<SearchItems> items;

  SearchListModel({
    required this.status,
    required this.subCode,
    required this.message,
    required this.error,
    required this.items,
  });

  factory SearchListModel.fromJson(Map<String, dynamic> json) => _$SearchListModelFromJson(json);

  Map<String, dynamic> toJson() => _$SearchListModelToJson(this);
}

@JsonSerializable()
class SearchItems {
  @JsonKey(name: "_id")
  String id;
  @JsonKey(name: "customerId")
  String customerId;
  @JsonKey(name: "externalVendorId")
  String externalVendorId;
  @JsonKey(name: "partnerNameId")
  String partnerNameId;
  @JsonKey(name: "creditPdId")
  String creditPdId;
  @JsonKey(name: "pdfCreateByCreditPd")
  String pdfCreateByCreditPd;
  @JsonKey(name: "remarkForCreditPd")
  String remarkForCreditPd;
  @JsonKey(name: "statusByCreditPd")
  String statusByCreditPd;
  @JsonKey(name: "remarkByCreditPd")
  String remarkByCreditPd;
  @JsonKey(name: "branchDetails")
  BranchDetails branchDetails;
  @JsonKey(name: "applicantDetails")
  ApplicantDetails applicantDetails;
  @JsonKey(name: "customerFinId")
  String customerFinId;
  @JsonKey(name: "customerName")
  String customerName;
  @JsonKey(name: "customerMobileNo")
  int customerMobileNo;
  @JsonKey(name: "customerFatherName")
  String customerFatherName;
  @JsonKey(name: "customerPhoto")
  String customerPhoto;
  @JsonKey(name: "customerAddress")
  String customerAddress;

  SearchItems({
    required this.id,
    required this.customerId,
    required this.externalVendorId,
    required this.partnerNameId,
    required this.creditPdId,
    required this.pdfCreateByCreditPd,
    required this.remarkForCreditPd,
    required this.statusByCreditPd,
    required this.remarkByCreditPd,
    required this.branchDetails,
    required this.applicantDetails,
    required this.customerFinId,
    required this.customerName,
    required this.customerMobileNo,
    required this.customerFatherName,
    required this.customerPhoto,
    required this.customerAddress,
  });

  factory SearchItems.fromJson(Map<String, dynamic> json) => _$SearchItemsFromJson(json);

  Map<String, dynamic> toJson() => _$SearchItemsToJson(this);
}

@JsonSerializable()
class ApplicantDetails {
  @JsonKey(name: "_id")
  String id;
  @JsonKey(name: "fullName")
  String fullName;
  @JsonKey(name: "email")
  String email;

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
  String id;
  @JsonKey(name: "name")
  String name;

  BranchDetails({
    required this.id,
    required this.name,
  });

  factory BranchDetails.fromJson(Map<String, dynamic> json) => _$BranchDetailsFromJson(json);

  Map<String, dynamic> toJson() => _$BranchDetailsToJson(this);
}
