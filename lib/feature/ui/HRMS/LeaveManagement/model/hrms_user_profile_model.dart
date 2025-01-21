

import 'package:json_annotation/json_annotation.dart';
part 'hrms_user_profile_model.g.dart';

@JsonSerializable()
class HRMSUserProfileResponseModel {
  @JsonKey(name: "status")
  bool? status;
  @JsonKey(name: "subCode")
  int? subCode;
  @JsonKey(name: "message")
  String? message;
  @JsonKey(name: "error")
  String? error;
  @JsonKey(name: "items")
  HrmsItems? items;

  HRMSUserProfileResponseModel({
    this.status,
    this.subCode,
    this.message,
    this.error,
    this.items,
  });

  factory HRMSUserProfileResponseModel.fromJson(Map<String, dynamic> json) => _$HRMSUserProfileResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$HRMSUserProfileResponseModelToJson(this);
}

@JsonSerializable()
class HrmsItems {
  @JsonKey(name: "location")
  Location? location;
  @JsonKey(name: "identityMark")
  String? identityMark;
  @JsonKey(name: "height")
  dynamic height;
  @JsonKey(name: "caste")
  String? caste;
  @JsonKey(name: "category")
  String? category;
  @JsonKey(name: "religion")
  String? religion;
  @JsonKey(name: "bloodGroup")
  String? bloodGroup;
  @JsonKey(name: "homeDistrict")
  String? homeDistrict;
  @JsonKey(name: "homeState")
  String? homeState;
  @JsonKey(name: "nearestRailwaySt")
  String? nearestRailwaySt;
  @JsonKey(name: "aadhaarNo")
  dynamic aadhaarNo;
  @JsonKey(name: "panNo")
  String? panNo;
  @JsonKey(name: "relievingLetterFincooper")
  String? relievingLetterFincooper;
  @JsonKey(name: "experienceLetterFincooper")
  String? experienceLetterFincooper;
  @JsonKey(name: "subDepartmentId")
  dynamic subDepartmentId;
  @JsonKey(name: "secondaryDepartmentId")
  dynamic secondaryDepartmentId;
  @JsonKey(name: "seconSubDepartmentId")
  dynamic seconSubDepartmentId;
  @JsonKey(name: "uanNumber")
  dynamic uanNumber;
  @JsonKey(name: "esicNumber")
  String? esicNumber;
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
  int? mobileNo;
  @JsonKey(name: "password")
  String? password;
  @JsonKey(name: "joiningDate")
  DateTime? joiningDate;
  @JsonKey(name: "dateOfBirth")
  DateTime? dateOfBirth;
  @JsonKey(name: "fatherName")
  String? fatherName;
  @JsonKey(name: "employeePhoto")
  dynamic employeePhoto;
  @JsonKey(name: "currentAddress")
  String? currentAddress;
  @JsonKey(name: "permanentAddress")
  String? permanentAddress;
  @JsonKey(name: "branchId")
  BranchIdClass? branchId;
  @JsonKey(name: "companyId")
  String? companyId;
  @JsonKey(name: "roleId")
  List<RoleId>? roleId;
  @JsonKey(name: "reportingManagerId")
  ReportingManagerId? reportingManagerId;
  @JsonKey(name: "departmentId")
  dynamic departmentId;
  @JsonKey(name: "designationId")
  BranchIdClass? designationId;
  @JsonKey(name: "workLocationId")
  BranchIdClass? workLocationId;
  @JsonKey(name: "constCenterId")
  ConstCenterIdClass? constCenterId;
  @JsonKey(name: "employementTypeId")
  ConstCenterIdClass? employementTypeId;
  @JsonKey(name: "employeeTypeId")
  ConstCenterIdClass? employeeTypeId;
  @JsonKey(name: "status")
  String? status;
  @JsonKey(name: "createdAt")
  DateTime? createdAt;
  @JsonKey(name: "updatedAt")
  DateTime? updatedAt;
  @JsonKey(name: "__v")
  int? v;
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
  dynamic referedById;
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
  @JsonKey(name: "locationRoamId")
  String? locationRoamId;
  @JsonKey(name: "onboardingStatus")
  String? onboardingStatus;
  @JsonKey(name: "employeementHistory")
  List<EmployeementHistory>? employeementHistory;
  @JsonKey(name: "educationDetails")
  List<dynamic>? educationDetails;
  @JsonKey(name: "nominee")
  List<dynamic>? nominee;
  @JsonKey(name: "activeInactiveReason")
  List<dynamic>? activeInactiveReason;
  @JsonKey(name: "employeeTarget")
  List<dynamic>? employeeTarget;

  HrmsItems({
    this.location,
    this.identityMark,
    this.height,
    this.caste,
    this.category,
    this.religion,
    this.bloodGroup,
    this.homeDistrict,
    this.homeState,
    this.nearestRailwaySt,
    this.aadhaarNo,
    this.panNo,
    this.relievingLetterFincooper,
    this.experienceLetterFincooper,
    this.subDepartmentId,
    this.secondaryDepartmentId,
    this.seconSubDepartmentId,
    this.uanNumber,
    this.esicNumber,
    this.id,
    this.employeName,
    this.userName,
    this.email,
    this.workEmail,
    this.mobileNo,
    this.password,
    this.joiningDate,
    this.dateOfBirth,
    this.fatherName,
    this.employeePhoto,
    this.currentAddress,
    this.permanentAddress,
    this.branchId,
    this.companyId,
    this.roleId,
    this.reportingManagerId,
    this.departmentId,
    this.designationId,
    this.workLocationId,
    this.constCenterId,
    this.employementTypeId,
    this.employeeTypeId,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.v,
    this.employeUniqueId,
    this.description,
    this.bankAccount,
    this.emergencyNumber,
    this.gender,
    this.maritalStatus,
    this.offerLetter,
    this.package,
    this.referedById,
    this.resume,
    this.salutation,
    this.bankDetails,
    this.ifscCode,
    this.aadhar,
    this.bankAccountProof,
    this.bankName,
    this.currentAddressCity,
    this.currentAddressPincode,
    this.currentAddressState,
    this.currentCtc,
    this.currentDesignation,
    this.educationCertification,
    this.employmentProof,
    this.endDate,
    this.experienceLetter,
    this.familyIncome,
    this.fathersMobileNo,
    this.fathersOccupation,
    this.highestQualification,
    this.lastOrganization,
    this.motherName,
    this.mothersMobileNo,
    this.nameAsPerBank,
    this.panCard,
    this.permanentAddressCity,
    this.permanentAddressPincode,
    this.permanentAddressState,
    this.startDate,
    this.totalExperience,
    this.university,
    this.websiteListing,
    this.locationRoamId,
    this.onboardingStatus,
    this.employeementHistory,
    this.educationDetails,
    this.nominee,
    this.activeInactiveReason,
    this.employeeTarget,
  });

  factory HrmsItems.fromJson(Map<String, dynamic> json) => _$HrmsItemsFromJson(json);

  Map<String, dynamic> toJson() => _$HrmsItemsToJson(this);
}

@JsonSerializable()
class BranchIdClass {
  @JsonKey(name: "_id")
  String? id;
  @JsonKey(name: "name")
  String? name;

  BranchIdClass({
    this.id,
    this.name,
  });

  factory BranchIdClass.fromJson(Map<String, dynamic> json) => _$BranchIdClassFromJson(json);

  Map<String, dynamic> toJson() => _$BranchIdClassToJson(this);
}

@JsonSerializable()
class ConstCenterIdClass {
  @JsonKey(name: "_id")
  String? id;
  @JsonKey(name: "title")
  String? title;

  ConstCenterIdClass({
    this.id,
    this.title,
  });

  factory ConstCenterIdClass.fromJson(Map<String, dynamic> json) => _$ConstCenterIdClassFromJson(json);

  Map<String, dynamic> toJson() => _$ConstCenterIdClassToJson(this);
}

@JsonSerializable()
class EmployeementHistory {
  @JsonKey(name: "totalExperience")
  dynamic totalExperience;
  @JsonKey(name: "address")
  String? address;
  @JsonKey(name: "startDate")
  DateTime? startDate;
  @JsonKey(name: "endDate")
  DateTime? endDate;
  @JsonKey(name: "currentDesignation")
  String? currentDesignation;
  @JsonKey(name: "lastOrganization")
  String? lastOrganization;
  @JsonKey(name: "currentCTC")
  dynamic currentCtc;
  @JsonKey(name: "grossSalary")
  String? grossSalary;

  EmployeementHistory({
    this.totalExperience,
    this.address,
    this.startDate,
    this.endDate,
    this.currentDesignation,
    this.lastOrganization,
    this.currentCtc,
    this.grossSalary,
  });

  factory EmployeementHistory.fromJson(Map<String, dynamic> json) => _$EmployeementHistoryFromJson(json);

  Map<String, dynamic> toJson() => _$EmployeementHistoryToJson(this);
}

@JsonSerializable()
class Location {
  @JsonKey(name: "type")
  String? type;
  @JsonKey(name: "coordinates")
  List<double>? coordinates;

  Location({
    this.type,
    this.coordinates,
  });

  factory Location.fromJson(Map<String, dynamic> json) => _$LocationFromJson(json);

  Map<String, dynamic> toJson() => _$LocationToJson(this);
}

@JsonSerializable()
class ReportingManagerId {
  @JsonKey(name: "_id")
  String? id;
  @JsonKey(name: "employeName")
  String? employeName;

  ReportingManagerId({
    this.id,
    this.employeName,
  });

  factory ReportingManagerId.fromJson(Map<String, dynamic> json) => _$ReportingManagerIdFromJson(json);

  Map<String, dynamic> toJson() => _$ReportingManagerIdToJson(this);
}

@JsonSerializable()
class RoleId {
  @JsonKey(name: "_id")
  String? id;
  @JsonKey(name: "roleName")
  String? roleName;

  RoleId({
    this.id,
    this.roleName,
  });

  factory RoleId.fromJson(Map<String, dynamic> json) => _$RoleIdFromJson(json);

  Map<String, dynamic> toJson() => _$RoleIdToJson(this);
}


// user_profile.dart
class HRMSUserProfile {
  final String employeeId;
  final String employeName;
  final String email;
  final int mobileNo;
  final String joiningDate;
  final String dateOfBirth;
  final String fatherName;
  final String employeePhoto;
  final String employeUniqueId;
  final String punchInTime;
  final String punchOutTime;
  final String designationId;


  HRMSUserProfile({
    required this.punchInTime,
    required this.punchOutTime,
    required this.employeeId,
    required this.employeName,
    required this.email,
    required this.mobileNo,
    required this.joiningDate,
    required this.dateOfBirth,
    required this.fatherName,
    required this.employeePhoto,
    required this.employeUniqueId,
    required this.designationId
  });

  factory HRMSUserProfile.fromJson(Map<String, dynamic> json) {
    return HRMSUserProfile(
      punchInTime: json['punchInTime'] ?? '',
      punchOutTime: json['punchOutTime'] ?? '',
      employeeId: json['_id'] ?? '',
      employeName: json['employeName'] ?? '',
      email: json['workEmail'] ?? '',
      mobileNo: json['mobileNo'] ?? 0,
      joiningDate: json['joiningDate'] ?? '',
      dateOfBirth: json['dateOfBirth'] ?? '',
      fatherName: json['fatherName'] ?? '',
      employeePhoto: json['employeePhoto'] ?? '',
      employeUniqueId: json['employeUniqueId'] ?? '',
      designationId: json['designationId'] ?? '',
    );
  }

  String get fullName => '$employeName $fatherName';
}

// class BranchIdClass {
//   final String? id;
//   final String? name;
//
//   BranchIdClass({
//     this.id,
//     this.name,
//   });
//
//   factory BranchIdClass.fromJson(Map<String, dynamic> json) {
//     return BranchIdClass(
//       id: json['_id'] ?? '',
//       name: json['name'] ?? '',
//     );
//   }
// }