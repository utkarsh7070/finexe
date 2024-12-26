import 'package:json_annotation/json_annotation.dart';
part 'user_profile_response_model.g.dart';

@JsonSerializable()
class UserprofileResponseModel {
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

  UserprofileResponseModel({
    required this.status,
    required this.subCode,
    required this.message,
    required this.error,
    required this.items,
  });

  factory UserprofileResponseModel.fromJson(Map<String, dynamic> json) => _$UserprofileResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserprofileResponseModelToJson(this);
}

@JsonSerializable()
class Items {
  @JsonKey(name: "employeeDetail")
  EmployeeDetail employeeDetail;
  @JsonKey(name: "totalVisits")
  int totalVisits;
  @JsonKey(name: "totalNetDueAmount")
  int totalNetDueAmount;
  @JsonKey(name: "visitPendingForApproval")
  int visitPendingForApproval;
  @JsonKey(name: "visitAccepted")
  int visitAccepted;
  @JsonKey(name: "visitRejected")
  int visitRejected;
  @JsonKey(name: "collectionEmiAmountPendingForApproval")
  int collectionEmiAmountPendingForApproval;
  @JsonKey(name: "collectionAcceptAmount")
  int collectionAcceptAmount;
  @JsonKey(name: "collectionRejectAmount")
  int collectionRejectAmount;

  Items({
    required this.employeeDetail,
    required this.totalVisits,
    required this.totalNetDueAmount,
    required this.visitPendingForApproval,
    required this.visitAccepted,
    required this.visitRejected,
    required this.collectionEmiAmountPendingForApproval,
    required this.collectionAcceptAmount,
    required this.collectionRejectAmount,
  });

  factory Items.fromJson(Map<String, dynamic> json) => _$ItemsFromJson(json);

  Map<String, dynamic> toJson() => _$ItemsToJson(this);
}

@JsonSerializable()
class EmployeeDetail {
  @JsonKey(name: "location")
  Location? location;
  @JsonKey(name: "subDepartmentId")
  dynamic subDepartmentId;
  @JsonKey(name: "secondaryDepartmentId")
  dynamic secondaryDepartmentId;
  @JsonKey(name: "seconSubDepartmentId")
  dynamic seconSubDepartmentId;
  @JsonKey(name: "uanNumber")
  dynamic uanNumber;
  @JsonKey(name: "_id")
  String? id;
  @JsonKey(name: "employeName")
  String? employeName;
  @JsonKey(name: "userName")
  String? userName;
  @JsonKey(name: "email")
  String? email;
  @JsonKey(name: "workEmail")
  String? workEmail;
  @JsonKey(name: "mobileNo")
  int mobileNo;
  @JsonKey(name: "password")
  String? password;
  @JsonKey(name: "joiningDate")
  String? joiningDate;
  @JsonKey(name: "dateOfBirth")
  String? dateOfBirth;
  @JsonKey(name: "fatherName")
  String? fatherName;
  @JsonKey(name: "employeePhoto")
  String? employeePhoto;
  @JsonKey(name: "currentAddress")
  String? currentAddress;
  @JsonKey(name: "permanentAddress")
  String? permanentAddress;
  @JsonKey(name: "branchId")
  String? branchId;
  @JsonKey(name: "companyId")
  String? companyId;
  @JsonKey(name: "roleId")
  String? roleId;
  @JsonKey(name: "reportingManagerId")
  String? reportingManagerId;
  @JsonKey(name: "departmentId")
  String? departmentId;
  @JsonKey(name: "designationId")
  String? designationId;
  @JsonKey(name: "workLocationId")
  String? workLocationId;
  @JsonKey(name: "constCenterId")
  String? constCenterId;
  @JsonKey(name: "employementTypeId")
  String? employementTypeId;
  @JsonKey(name: "employeeTypeId")
  String? employeeTypeId;
  @JsonKey(name: "status")
  String? status;
  @JsonKey(name: "createdAt")
  String? createdAt;
  @JsonKey(name: "updatedAt")
  String? updatedAt;
  @JsonKey(name: "__v")
  int v;
  @JsonKey(name: "employeUniqueId")
  String? employeUniqueId;
  @JsonKey(name: "description")
  String? description;
  @JsonKey(name: "bankAccount")
  dynamic bankAccount;
  @JsonKey(name: "emergencyNumber")
  dynamic emergencyNumber;
  @JsonKey(name: "gender")
  String? gender;
  @JsonKey(name: "maritalStatus")
  String? maritalStatus;
  @JsonKey(name: "offerLetter")
  String? offerLetter;
  @JsonKey(name: "package")
  dynamic package;
  @JsonKey(name: "referedById")
  String? referedById;
  @JsonKey(name: "resume")
  String? resume;
  @JsonKey(name: "salutation")
  String? salutation;
  @JsonKey(name: "bankDetails")
  String? bankDetails;
  @JsonKey(name: "ifscCode")
  String? ifscCode;
  @JsonKey(name: "aadhar")
  String? aadhar;
  @JsonKey(name: "bankAccountProof")
  String? bankAccountProof;
  @JsonKey(name: "bankName")
  String? bankName;
  @JsonKey(name: "currentAddressCity")
  String? currentAddressCity;
  @JsonKey(name: "currentAddressPincode")
  dynamic currentAddressPincode;
  @JsonKey(name: "currentAddressState")
  String? currentAddressState;
  @JsonKey(name: "currentCTC")
  String? currentCtc;
  @JsonKey(name: "currentDesignation")
  String? currentDesignation;
  @JsonKey(name: "educationCertification")
  String? educationCertification;
  @JsonKey(name: "employmentProof")
  String? employmentProof;
  @JsonKey(name: "endDate")
  dynamic endDate;
  @JsonKey(name: "experienceLetter")
  String? experienceLetter;
  @JsonKey(name: "familyIncome")
  dynamic familyIncome;
  @JsonKey(name: "fathersMobileNo")
  dynamic fathersMobileNo;
  @JsonKey(name: "fathersOccupation")
  String? fathersOccupation;
  @JsonKey(name: "highestQualification")
  String? highestQualification;
  @JsonKey(name: "lastOrganization")
  String? lastOrganization;
  @JsonKey(name: "motherName")
  String? motherName;
  @JsonKey(name: "mothersMobileNo")
  dynamic mothersMobileNo;
  @JsonKey(name: "nameAsPerBank")
  String? nameAsPerBank;
  @JsonKey(name: "panCard")
  String? panCard;
  @JsonKey(name: "permanentAddressCity")
  String? permanentAddressCity;
  @JsonKey(name: "permanentAddressPincode")
  dynamic permanentAddressPincode;
  @JsonKey(name: "permanentAddressState")
  String? permanentAddressState;
  @JsonKey(name: "startDate")
  dynamic startDate;
  @JsonKey(name: "totalExperience")
  dynamic totalExperience;
  @JsonKey(name: "university")
  String? university;
  @JsonKey(name: "websiteListing")
  String? websiteListing;
  @JsonKey(name: "OnlineStatus")
  String? onlineStatus;
  @JsonKey(name: "socketId")
  String? socketId;
  @JsonKey(name: "esicNumber")
  String? esicNumber;

  EmployeeDetail({
    required this.location,
    required this.subDepartmentId,
    required this.secondaryDepartmentId,
    required this.seconSubDepartmentId,
    required this.uanNumber,
    required this.id,
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
    required this.employeUniqueId,
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
    required this.websiteListing,
    required this.onlineStatus,
    required this.socketId,
    required this.esicNumber,
  });

  factory EmployeeDetail.fromJson(Map<String, dynamic> json) => _$EmployeeDetailFromJson(json);

  Map<String, dynamic> toJson() => _$EmployeeDetailToJson(this);
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
