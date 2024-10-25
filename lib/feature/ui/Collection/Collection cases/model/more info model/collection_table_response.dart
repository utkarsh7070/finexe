import 'package:json_annotation/json_annotation.dart';
part 'collection_table_response.g.dart';


@JsonSerializable()
class CollectionTableResponse {
  @JsonKey(name: "status")
  bool status;
  @JsonKey(name: "subCode")
  int subCode;
  @JsonKey(name: "message")
  String message;
  @JsonKey(name: "error")
  String error;
  @JsonKey(name: "items")
  List<Item> items;

  CollectionTableResponse({
    required this.status,
    required this.subCode,
    required this.message,
    required this.error,
    required this.items,
  });

  factory CollectionTableResponse.fromJson(Map<String, dynamic> json) => _$CollectionTableResponseFromJson(json);

  Map<String, dynamic> toJson() => _$CollectionTableResponseToJson(this);
}

@JsonSerializable()
class Item {
  @JsonKey(name: "_id")
  String id;
  @JsonKey(name: "LD")
  Ld ld;
  @JsonKey(name: "collectedBy")
  CollectedBy collectedBy;
  @JsonKey(name: "customerName")
  CustomerName customerName;
  @JsonKey(name: "mobileNo")
  int mobileNo;
  @JsonKey(name: "receivedAmount")
  int receivedAmount;
  @JsonKey(name: "transactionId")
  String transactionId;
  @JsonKey(name: "transactionImage")
  String transactionImage;
  @JsonKey(name: "customerEmail")
  String? customerEmail;
  @JsonKey(name: "modeOfCollectionId")
  ModeOfCollectionId modeOfCollectionId;
  @JsonKey(name: "commonId")
  String? commonId;
  @JsonKey(name: "partner")
  String partner;
  @JsonKey(name: "emiReceivedDate")
  DateTime emiReceivedDate;
  @JsonKey(name: "emiReceivedTime")
  dynamic emiReceivedTime;
  @JsonKey(name: "remarkByCollection")
  String remarkByCollection;
  @JsonKey(name: "remarkByManager")
  dynamic remarkByManager;
  @JsonKey(name: "status")
  String status;
  @JsonKey(name: "pdf")
  String pdf;
  @JsonKey(name: "receiptNo")
  int receiptNo;
  @JsonKey(name: "createdAt")
  DateTime createdAt;
  @JsonKey(name: "updatedAt")
  DateTime updatedAt;
  @JsonKey(name: "__v")
  int v;
  @JsonKey(name: "modeOfCollectionDetail")
  List<ModeOfCollectionDetail> modeOfCollectionDetail;
  @JsonKey(name: "bankNameDetail")
  List<BankNameDetail> bankNameDetail;
  @JsonKey(name: "okCreditDetail")
  List<OkCreditDetail> okCreditDetail;
  @JsonKey(name: "employeDetail")
  List<EmployeDetail> employeDetail;
  @JsonKey(name: "partnerDetail")
  List<dynamic> partnerDetail;
  @JsonKey(name: "reason")
  String? reason;

  Item({
    required this.id,
    required this.ld,
    required this.collectedBy,
    required this.customerName,
    required this.mobileNo,
    required this.receivedAmount,
    required this.transactionId,
    required this.transactionImage,
    required this.customerEmail,
    required this.modeOfCollectionId,
    required this.commonId,
    required this.partner,
    required this.emiReceivedDate,
    required this.emiReceivedTime,
    required this.remarkByCollection,
    required this.remarkByManager,
    required this.status,
    required this.pdf,
    required this.receiptNo,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
    required this.modeOfCollectionDetail,
    required this.bankNameDetail,
    required this.okCreditDetail,
    required this.employeDetail,
    required this.partnerDetail,
    this.reason,
  });

  factory Item.fromJson(Map<String, dynamic> json) => _$ItemFromJson(json);

  Map<String, dynamic> toJson() => _$ItemToJson(this);
}

@JsonSerializable()
class BankNameDetail {
  @JsonKey(name: "_id")
  String id;
  @JsonKey(name: "title")
  String title;
  @JsonKey(name: "bankName")
  String bankName;
  @JsonKey(name: "bankAcNo")
  String bankAcNo;
  @JsonKey(name: "bankIFSCCode")
  String bankIfscCode;
  @JsonKey(name: "bankAcHolderName")
  String bankAcHolderName;
  @JsonKey(name: "bankBranch")
  String bankBranch;
  @JsonKey(name: "status")
  WebsiteListingEnum status;

  BankNameDetail({
    required this.id,
    required this.title,
    required this.bankName,
    required this.bankAcNo,
    required this.bankIfscCode,
    required this.bankAcHolderName,
    required this.bankBranch,
    required this.status,
  });

  factory BankNameDetail.fromJson(Map<String, dynamic> json) => _$BankNameDetailFromJson(json);

  Map<String, dynamic> toJson() => _$BankNameDetailToJson(this);
}

enum WebsiteListingEnum {
  @JsonValue("active")
  ACTIVE
}

enum CollectedBy {
  @JsonValue("nikit Sir-C171")
  NIKIT_SIR_C171
}

enum CustomerName {
  @JsonValue("LAKHAN")
  LAKHAN
}

@JsonSerializable()
class EmployeDetail {
  @JsonKey(name: "_id")
  String id;
  @JsonKey(name: "employeUniqueId")
  String employeUniqueId;
  @JsonKey(name: "employeName")
  String employeName;
  @JsonKey(name: "userName")
  String userName;
  @JsonKey(name: "email")
  String email;
  @JsonKey(name: "workEmail")
  String workEmail;
  @JsonKey(name: "mobileNo")
  int mobileNo;
  @JsonKey(name: "password")
  String password;
  @JsonKey(name: "joiningDate")
  DateTime joiningDate;
  @JsonKey(name: "dateOfBirth")
  DateTime dateOfBirth;
  @JsonKey(name: "fatherName")
  String fatherName;
  @JsonKey(name: "employeePhoto")
  dynamic employeePhoto;
  @JsonKey(name: "currentAddress")
  String currentAddress;
  @JsonKey(name: "permanentAddress")
  String permanentAddress;
  @JsonKey(name: "branchId")
  String? branchId;
  @JsonKey(name: "companyId")
  String companyId;
  @JsonKey(name: "roleId")
  String roleId;
  @JsonKey(name: "reportingManagerId")
  String reportingManagerId;
  @JsonKey(name: "departmentId")
  String? departmentId;
  @JsonKey(name: "designationId")
  String? designationId;
  @JsonKey(name: "workLocationId")
  String? workLocationId;
  @JsonKey(name: "constCenterId")
  String constCenterId;
  @JsonKey(name: "employementTypeId")
  String employementTypeId;
  @JsonKey(name: "employeeTypeId")
  String employeeTypeId;
  @JsonKey(name: "status")
  WebsiteListingEnum status;
  @JsonKey(name: "createdAt")
  DateTime createdAt;
  @JsonKey(name: "updatedAt")
  DateTime updatedAt;
  @JsonKey(name: "__v")
  int v;
  @JsonKey(name: "description")
  String description;
  @JsonKey(name: "bankAccount")
  int? bankAccount;
  @JsonKey(name: "emergencyNumber")
  int? emergencyNumber;
  @JsonKey(name: "gender")
  String gender;
  @JsonKey(name: "maritalStatus")
  String maritalStatus;
  @JsonKey(name: "offerLetter")
  dynamic offerLetter;
  @JsonKey(name: "package")
  String package;
  @JsonKey(name: "referedById")
  String referedById;
  @JsonKey(name: "resume")
  dynamic resume;
  @JsonKey(name: "salutation")
  String salutation;
  @JsonKey(name: "bankDetails")
  dynamic bankDetails;
  @JsonKey(name: "ifscCode")
  String ifscCode;
  @JsonKey(name: "aadhar")
  dynamic aadhar;
  @JsonKey(name: "bankAccountProof")
  String bankAccountProof;
  @JsonKey(name: "bankName")
  String bankName;
  @JsonKey(name: "currentAddressCity")
  String currentAddressCity;
  @JsonKey(name: "currentAddressPincode")
  int? currentAddressPincode;
  @JsonKey(name: "currentAddressState")
  String currentAddressState;
  @JsonKey(name: "currentCTC")
  String currentCtc;
  @JsonKey(name: "currentDesignation")
  String currentDesignation;
  @JsonKey(name: "educationCertification")
  dynamic educationCertification;
  @JsonKey(name: "employmentProof")
  dynamic employmentProof;
  @JsonKey(name: "endDate")
  DateTime? endDate;
  @JsonKey(name: "experienceLetter")
  dynamic experienceLetter;
  @JsonKey(name: "familyIncome")
  int? familyIncome;
  @JsonKey(name: "fathersMobileNo")
  int? fathersMobileNo;
  @JsonKey(name: "fathersOccupation")
  String fathersOccupation;
  @JsonKey(name: "highestQualification")
  String highestQualification;
  @JsonKey(name: "lastOrganization")
  String lastOrganization;
  @JsonKey(name: "motherName")
  String motherName;
  @JsonKey(name: "mothersMobileNo")
  int? mothersMobileNo;
  @JsonKey(name: "nameAsPerBank")
  String nameAsPerBank;
  @JsonKey(name: "panCard")
  dynamic panCard;
  @JsonKey(name: "permanentAddressCity")
  String permanentAddressCity;
  @JsonKey(name: "permanentAddressPincode")
  String? permanentAddressPincode;
  @JsonKey(name: "permanentAddressState")
  String permanentAddressState;
  @JsonKey(name: "startDate")
  DateTime? startDate;
  @JsonKey(name: "totalExperience")
  int? totalExperience;
  @JsonKey(name: "university")
  String university;
  @JsonKey(name: "location")
  Location location;
  @JsonKey(name: "websiteListing")
  WebsiteListingEnum websiteListing;
  @JsonKey(name: "company")
  String? company;
  @JsonKey(name: "esicNumber")
  String? esicNumber;
  @JsonKey(name: "seconSubDepartmentId")
  dynamic seconSubDepartmentId;
  @JsonKey(name: "secondaryDepartmentId")
  dynamic secondaryDepartmentId;
  @JsonKey(name: "subDepartmentId")
  dynamic subDepartmentId;
  @JsonKey(name: "uanNumber")
  int? uanNumber;

  EmployeDetail({
    required this.id,
    required this.employeUniqueId,
    required this.employeName,
    required this.userName,
    required this.email,
    required this.workEmail,
    required this.mobileNo,
    required this.password,
    required this.joiningDate,
    required this.dateOfBirth,
    required this.fatherName,
    required this.employeePhoto,
    required this.currentAddress,
    required this.permanentAddress,
    required this.branchId,
    required this.companyId,
    required this.roleId,
    required this.reportingManagerId,
    required this.departmentId,
    required this.designationId,
    required this.workLocationId,
    required this.constCenterId,
    required this.employementTypeId,
    required this.employeeTypeId,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
    required this.description,
    required this.bankAccount,
    required this.emergencyNumber,
    required this.gender,
    required this.maritalStatus,
    required this.offerLetter,
    required this.package,
    required this.referedById,
    required this.resume,
    required this.salutation,
    required this.bankDetails,
    required this.ifscCode,
    required this.aadhar,
    required this.bankAccountProof,
    required this.bankName,
    required this.currentAddressCity,
    required this.currentAddressPincode,
    required this.currentAddressState,
    required this.currentCtc,
    required this.currentDesignation,
    required this.educationCertification,
    required this.employmentProof,
    required this.endDate,
    required this.experienceLetter,
    required this.familyIncome,
    required this.fathersMobileNo,
    required this.fathersOccupation,
    required this.highestQualification,
    required this.lastOrganization,
    required this.motherName,
    required this.mothersMobileNo,
    required this.nameAsPerBank,
    required this.panCard,
    required this.permanentAddressCity,
    required this.permanentAddressPincode,
    required this.permanentAddressState,
    required this.startDate,
    required this.totalExperience,
    required this.university,
    required this.location,
    required this.websiteListing,
    this.company,
    this.esicNumber,
    this.seconSubDepartmentId,
    this.secondaryDepartmentId,
    this.subDepartmentId,
    this.uanNumber,
  });

  factory EmployeDetail.fromJson(Map<String, dynamic> json) => _$EmployeDetailFromJson(json);

  Map<String, dynamic> toJson() => _$EmployeDetailToJson(this);
}

@JsonSerializable()
class Location {
  @JsonKey(name: "type")
  String type;
  @JsonKey(name: "coordinates")
  List<double> coordinates;

  Location({
    required this.type,
    required this.coordinates,
  });

  factory Location.fromJson(Map<String, dynamic> json) => _$LocationFromJson(json);

  Map<String, dynamic> toJson() => _$LocationToJson(this);
}

enum Ld {
  @JsonValue("FINC940")
  FINC940
}

@JsonSerializable()
class ModeOfCollectionDetail {
  @JsonKey(name: "_id")
  ModeOfCollectionId id;
  @JsonKey(name: "title")
  Title title;
  @JsonKey(name: "extraForm")
  bool extraForm;
  @JsonKey(name: "email")
  bool email;
  @JsonKey(name: "dropdownId")
  DropdownId dropdownId;
  @JsonKey(name: "status")
  WebsiteListingEnum status;

  ModeOfCollectionDetail({
    required this.id,
    required this.title,
    required this.extraForm,
    required this.email,
    required this.dropdownId,
    required this.status,
  });

  factory ModeOfCollectionDetail.fromJson(Map<String, dynamic> json) => _$ModeOfCollectionDetailFromJson(json);

  Map<String, dynamic> toJson() => _$ModeOfCollectionDetailToJson(this);
}

enum DropdownId {
  @JsonValue("66cf05a969cf52741ec374b1")
  THE_66_CF05_A969_CF52741_EC374_B1,
  @JsonValue("66cf05b969cf52741ec374b3")
  THE_66_CF05_B969_CF52741_EC374_B3
}

enum ModeOfCollectionId {
  @JsonValue("66d94ffce7dd309f59c54d3b")
  THE_66_D94_FFCE7_DD309_F59_C54_D3_B,
  @JsonValue("66d95023e7dd309f59c54d3f")
  THE_66_D95023_E7_DD309_F59_C54_D3_F,
  @JsonValue("66d95058e7dd309f59c54d47")
  THE_66_D95058_E7_DD309_F59_C54_D47
}

enum Title {
  @JsonValue("okcredit")
  OKCREDIT,
  @JsonValue("online")
  ONLINE,
  @JsonValue("partner")
  PARTNER
}

@JsonSerializable()
class OkCreditDetail {
  @JsonKey(name: "_id")
  String id;
  @JsonKey(name: "employeeId")
  String employeeId;
  @JsonKey(name: "creditNo")
  int creditNo;
  @JsonKey(name: "status")
  WebsiteListingEnum status;
  @JsonKey(name: "__v")
  int v;
  @JsonKey(name: "createdAt")
  DateTime createdAt;
  @JsonKey(name: "updatedAt")
  DateTime updatedAt;

  OkCreditDetail({
    required this.id,
    required this.employeeId,
    required this.creditNo,
    required this.status,
    required this.v,
    required this.createdAt,
    required this.updatedAt,
  });

  factory OkCreditDetail.fromJson(Map<String, dynamic> json) => _$OkCreditDetailFromJson(json);

  Map<String, dynamic> toJson() => _$OkCreditDetailToJson(this);
}

// enum Partner {
//   @JsonValue("UGRO")
//   UGRO
// }
//
// enum Pdf {
//   @JsonValue("")
//   EMPTY,
//   @JsonValue("uploads/pdf/LAKHAN-FINC940-1729507360525.pdf")
//   UPLOADS_PDF_LAKHAN_FINC940_1729507360525_PDF,
//   @JsonValue("uploads/pdf/LAKHAN-FINC940-1729677016321.pdf")
//   UPLOADS_PDF_LAKHAN_FINC940_1729677016321_PDF
// }
//
// enum ItemStatus {
//   @JsonValue("accept")
//   ACCEPT,
//   @JsonValue("initiate")
//   INITIATE,
//   @JsonValue("pending")
//   PENDING
// }
