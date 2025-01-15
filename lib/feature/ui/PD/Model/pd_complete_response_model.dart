import 'package:json_annotation/json_annotation.dart';
part 'pd_complete_response_model.g.dart';

@JsonSerializable()
class PdCompleteResponseModel {
  @JsonKey(name: "status")
  bool? status;
  @JsonKey(name: "subCode")
  int? subCode;
  @JsonKey(name: "message")
  String? message;
  @JsonKey(name: "error")
  String? error;
  @JsonKey(name: "items")
  Items? items;

  PdCompleteResponseModel({
    this.status,
    this.subCode,
    this.message,
    this.error,
    this.items,
  });

  factory PdCompleteResponseModel.fromJson(Map<String, dynamic> json) => _$PdCompleteResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$PdCompleteResponseModelToJson(this);
}

@JsonSerializable()
class Items {
  @JsonKey(name: "count")
  int? count;
  @JsonKey(name: "items")
  List<Item>? items;
  @JsonKey(name: "pagination")
  Pagination? pagination;

  Items({
    this.count,
    this.items,
    this.pagination,
  });

  factory Items.fromJson(Map<String, dynamic> json) => _$ItemsFromJson(json);

  Map<String, dynamic> toJson() => _$ItemsToJson(this);
}

@JsonSerializable()
class Item {
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
  @JsonKey(name: "creditPdRejectPhoto")
  List<String>? creditPdRejectPhoto;
  @JsonKey(name: "pdfCreateByCreditPd")
  String? pdfCreateByCreditPd;
  @JsonKey(name: "remarkForCreditPd")
  String? remarkForCreditPd;
  @JsonKey(name: "statusByCreditPd")
  String? statusByCreditPd;
  @JsonKey(name: "remarkByCreditPd")
  String? remarkByCreditPd;
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
  @JsonKey(name: "reasonForReject")
  String? reasonForReject;

  Item({
    this.id,
    this.customerId,
    this.externalVendorId,
    this.partnerNameId,
    this.creditPdId,
    this.creditPdRejectPhoto,
    this.pdfCreateByCreditPd,
    this.remarkForCreditPd,
    this.statusByCreditPd,
    this.remarkByCreditPd,
    this.branchDetails,
    this.applicantDetails,
    this.customerFinId,
    this.customerName,
    this.customerMobileNo,
    this.customerFatherName,
    this.customerPhoto,
    this.customerAddress,
    this.reasonForReject,
  });

  factory Item.fromJson(Map<String, dynamic> json) => _$ItemFromJson(json);

  Map<String, dynamic> toJson() => _$ItemToJson(this);
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

@JsonSerializable()
class Pagination {
  @JsonKey(name: "currentPage")
  int? currentPage;
  @JsonKey(name: "totalPages")
  int? totalPages;
  @JsonKey(name: "totalItems")
  int? totalItems;
  @JsonKey(name: "itemsPerPage")
  int? itemsPerPage;

  Pagination({
    this.currentPage,
    this.totalPages,
    this.totalItems,
    this.itemsPerPage,
  });

  factory Pagination.fromJson(Map<String, dynamic> json) => _$PaginationFromJson(json);

  Map<String, dynamic> toJson() => _$PaginationToJson(this);
}
