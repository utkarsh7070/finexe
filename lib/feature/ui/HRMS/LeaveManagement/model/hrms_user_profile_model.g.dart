// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hrms_user_profile_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HRMSUserProfileResponseModel _$HRMSUserProfileResponseModelFromJson(
        Map<String, dynamic> json) =>
    HRMSUserProfileResponseModel(
      status: json['status'] as bool?,
      subCode: (json['subCode'] as num?)?.toInt(),
      message: json['message'] as String?,
      error: json['error'] as String?,
      items: json['items'] == null
          ? null
          : HrmsItems.fromJson(json['items'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$HRMSUserProfileResponseModelToJson(
        HRMSUserProfileResponseModel instance) =>
    <String, dynamic>{
      'status': instance.status,
      'subCode': instance.subCode,
      'message': instance.message,
      'error': instance.error,
      'items': instance.items,
    };

HrmsItems _$HrmsItemsFromJson(Map<String, dynamic> json) => HrmsItems(
      location: json['location'] == null
          ? null
          : Location.fromJson(json['location'] as Map<String, dynamic>),
      identityMark: json['identityMark'] as String?,
      height: json['height'],
      caste: json['caste'] as String?,
      category: json['category'] as String?,
      religion: json['religion'] as String?,
      bloodGroup: json['bloodGroup'] as String?,
      homeDistrict: json['homeDistrict'] as String?,
      homeState: json['homeState'] as String?,
      nearestRailwaySt: json['nearestRailwaySt'] as String?,
      aadhaarNo: json['aadhaarNo'],
      panNo: json['panNo'] as String?,
      relievingLetterFincooper: json['relievingLetterFincooper'] as String?,
      experienceLetterFincooper: json['experienceLetterFincooper'] as String?,
      subDepartmentId: json['subDepartmentId'],
      secondaryDepartmentId: json['secondaryDepartmentId'],
      seconSubDepartmentId: json['seconSubDepartmentId'],
      uanNumber: json['uanNumber'],
      esicNumber: json['esicNumber'] as String?,
      id: json['_id'] as String?,
      employeName: json['employeName'] as String?,
      userName: json['userName'] as String?,
      email: json['email'] as String?,
      workEmail: json['workEmail'] as String?,
      mobileNo: (json['mobileNo'] as num?)?.toInt(),
      password: json['password'] as String?,
      joiningDate: json['joiningDate'] == null
          ? null
          : DateTime.parse(json['joiningDate'] as String),
      dateOfBirth: json['dateOfBirth'] == null
          ? null
          : DateTime.parse(json['dateOfBirth'] as String),
      fatherName: json['fatherName'] as String?,
      employeePhoto: json['employeePhoto'],
      currentAddress: json['currentAddress'] as String?,
      permanentAddress: json['permanentAddress'] as String?,
      branchId: json['branchId'] == null
          ? null
          : BranchIdClass.fromJson(json['branchId'] as Map<String, dynamic>),
      companyId: json['companyId'] as String?,
      roleId: (json['roleId'] as List<dynamic>?)
          ?.map((e) => RoleId.fromJson(e as Map<String, dynamic>))
          .toList(),
      reportingManagerId: json['reportingManagerId'] == null
          ? null
          : ReportingManagerId.fromJson(
              json['reportingManagerId'] as Map<String, dynamic>),
      departmentId: json['departmentId'],
      designationId: json['designationId'] == null
          ? null
          : BranchIdClass.fromJson(
          json['designationId'] as Map<String, dynamic>),
      workLocationId: json['workLocationId'] == null
          ? null
          : BranchIdClass.fromJson(
              json['workLocationId'] as Map<String, dynamic>),
      constCenterId: json['constCenterId'] == null
          ? null
          : ConstCenterIdClass.fromJson(
              json['constCenterId'] as Map<String, dynamic>),
      employementTypeId: json['employementTypeId'] == null
          ? null
          : ConstCenterIdClass.fromJson(
              json['employementTypeId'] as Map<String, dynamic>),
      employeeTypeId: json['employeeTypeId'] == null
          ? null
          : ConstCenterIdClass.fromJson(
              json['employeeTypeId'] as Map<String, dynamic>),
      status: json['status'] as String?,
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      updatedAt: json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
      v: (json['__v'] as num?)?.toInt(),
      employeUniqueId: json['employeUniqueId'] as String?,
      description: json['description'] as String?,
      bankAccount: json['bankAccount'],
      emergencyNumber: json['emergencyNumber'],
      gender: json['gender'] as String?,
      maritalStatus: json['maritalStatus'] as String?,
      offerLetter: json['offerLetter'] as String?,
      package: json['package'],
      referedById: json['referedById'],
      resume: json['resume'] as String?,
      salutation: json['salutation'] as String?,
      bankDetails: json['bankDetails'] as String?,
      ifscCode: json['ifscCode'] as String?,
      aadhar: json['aadhar'] as String?,
      bankAccountProof: json['bankAccountProof'] as String?,
      bankName: json['bankName'] as String?,
      currentAddressCity: json['currentAddressCity'] as String?,
      currentAddressPincode: json['currentAddressPincode'],
      currentAddressState: json['currentAddressState'] as String?,
      currentCtc: json['currentCTC'] as String?,
      currentDesignation: json['currentDesignation'] as String?,
      educationCertification: json['educationCertification'] as String?,
      employmentProof: json['employmentProof'] as String?,
      endDate: json['endDate'],
      experienceLetter: json['experienceLetter'] as String?,
      familyIncome: json['familyIncome'],
      fathersMobileNo: json['fathersMobileNo'],
      fathersOccupation: json['fathersOccupation'] as String?,
      highestQualification: json['highestQualification'] as String?,
      lastOrganization: json['lastOrganization'] as String?,
      motherName: json['motherName'] as String?,
      mothersMobileNo: json['mothersMobileNo'],
      nameAsPerBank: json['nameAsPerBank'] as String?,
      panCard: json['panCard'] as String?,
      permanentAddressCity: json['permanentAddressCity'] as String?,
      permanentAddressPincode: json['permanentAddressPincode'],
      permanentAddressState: json['permanentAddressState'] as String?,
      startDate: json['startDate'],
      totalExperience: json['totalExperience'],
      university: json['university'] as String?,
      websiteListing: json['websiteListing'] as String?,
      locationRoamId: json['locationRoamId'] as String?,
      onboardingStatus: json['onboardingStatus'] as String?,
      employeementHistory: (json['employeementHistory'] as List<dynamic>?)
          ?.map((e) => EmployeementHistory.fromJson(e as Map<String, dynamic>))
          .toList(),
      educationDetails: json['educationDetails'] as List<dynamic>?,
      nominee: json['nominee'] as List<dynamic>?,
      activeInactiveReason: json['activeInactiveReason'] as List<dynamic>?,
      employeeTarget: json['employeeTarget'] as List<dynamic>?,
    );

Map<String, dynamic> _$HrmsItemsToJson(HrmsItems instance) => <String, dynamic>{
      'location': instance.location,
      'identityMark': instance.identityMark,
      'height': instance.height,
      'caste': instance.caste,
      'category': instance.category,
      'religion': instance.religion,
      'bloodGroup': instance.bloodGroup,
      'homeDistrict': instance.homeDistrict,
      'homeState': instance.homeState,
      'nearestRailwaySt': instance.nearestRailwaySt,
      'aadhaarNo': instance.aadhaarNo,
      'panNo': instance.panNo,
      'relievingLetterFincooper': instance.relievingLetterFincooper,
      'experienceLetterFincooper': instance.experienceLetterFincooper,
      'subDepartmentId': instance.subDepartmentId,
      'secondaryDepartmentId': instance.secondaryDepartmentId,
      'seconSubDepartmentId': instance.seconSubDepartmentId,
      'uanNumber': instance.uanNumber,
      'esicNumber': instance.esicNumber,
      '_id': instance.id,
      'employeName': instance.employeName,
      'userName': instance.userName,
      'email': instance.email,
      'workEmail': instance.workEmail,
      'mobileNo': instance.mobileNo,
      'password': instance.password,
      'joiningDate': instance.joiningDate?.toIso8601String(),
      'dateOfBirth': instance.dateOfBirth?.toIso8601String(),
      'fatherName': instance.fatherName,
      'employeePhoto': instance.employeePhoto,
      'currentAddress': instance.currentAddress,
      'permanentAddress': instance.permanentAddress,
      'branchId': instance.branchId,
      'companyId': instance.companyId,
      'roleId': instance.roleId,
      'reportingManagerId': instance.reportingManagerId,
      'departmentId': instance.departmentId,
      'designationId': instance.designationId,
      'workLocationId': instance.workLocationId,
      'constCenterId': instance.constCenterId,
      'employementTypeId': instance.employementTypeId,
      'employeeTypeId': instance.employeeTypeId,
      'status': instance.status,
      'createdAt': instance.createdAt?.toIso8601String(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
      '__v': instance.v,
      'employeUniqueId': instance.employeUniqueId,
      'description': instance.description,
      'bankAccount': instance.bankAccount,
      'emergencyNumber': instance.emergencyNumber,
      'gender': instance.gender,
      'maritalStatus': instance.maritalStatus,
      'offerLetter': instance.offerLetter,
      'package': instance.package,
      'referedById': instance.referedById,
      'resume': instance.resume,
      'salutation': instance.salutation,
      'bankDetails': instance.bankDetails,
      'ifscCode': instance.ifscCode,
      'aadhar': instance.aadhar,
      'bankAccountProof': instance.bankAccountProof,
      'bankName': instance.bankName,
      'currentAddressCity': instance.currentAddressCity,
      'currentAddressPincode': instance.currentAddressPincode,
      'currentAddressState': instance.currentAddressState,
      'currentCTC': instance.currentCtc,
      'currentDesignation': instance.currentDesignation,
      'educationCertification': instance.educationCertification,
      'employmentProof': instance.employmentProof,
      'endDate': instance.endDate,
      'experienceLetter': instance.experienceLetter,
      'familyIncome': instance.familyIncome,
      'fathersMobileNo': instance.fathersMobileNo,
      'fathersOccupation': instance.fathersOccupation,
      'highestQualification': instance.highestQualification,
      'lastOrganization': instance.lastOrganization,
      'motherName': instance.motherName,
      'mothersMobileNo': instance.mothersMobileNo,
      'nameAsPerBank': instance.nameAsPerBank,
      'panCard': instance.panCard,
      'permanentAddressCity': instance.permanentAddressCity,
      'permanentAddressPincode': instance.permanentAddressPincode,
      'permanentAddressState': instance.permanentAddressState,
      'startDate': instance.startDate,
      'totalExperience': instance.totalExperience,
      'university': instance.university,
      'websiteListing': instance.websiteListing,
      'locationRoamId': instance.locationRoamId,
      'onboardingStatus': instance.onboardingStatus,
      'employeementHistory': instance.employeementHistory,
      'educationDetails': instance.educationDetails,
      'nominee': instance.nominee,
      'activeInactiveReason': instance.activeInactiveReason,
      'employeeTarget': instance.employeeTarget,
    };

BranchIdClass _$BranchIdClassFromJson(Map<String, dynamic> json) =>
    BranchIdClass(
      id: json['_id'] as String?,
      name: json['name'] as String?,
    );

Map<String, dynamic> _$BranchIdClassToJson(BranchIdClass instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'name': instance.name,
    };

ConstCenterIdClass _$ConstCenterIdClassFromJson(Map<String, dynamic> json) =>
    ConstCenterIdClass(
      id: json['_id'] as String?,
      title: json['title'] as String?,
    );

Map<String, dynamic> _$ConstCenterIdClassToJson(ConstCenterIdClass instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'title': instance.title,
    };

EmployeementHistory _$EmployeementHistoryFromJson(Map<String, dynamic> json) =>
    EmployeementHistory(
      totalExperience: json['totalExperience'],
      address: json['address'] as String?,
      startDate: json['startDate'] == null
          ? null
          : DateTime.parse(json['startDate'] as String),
      endDate: json['endDate'] == null
          ? null
          : DateTime.parse(json['endDate'] as String),
      currentDesignation: json['currentDesignation'] as String?,
      lastOrganization: json['lastOrganization'] as String?,
      currentCtc: json['currentCTC'],
      grossSalary: json['grossSalary'] as String?,
    );

Map<String, dynamic> _$EmployeementHistoryToJson(
        EmployeementHistory instance) =>
    <String, dynamic>{
      'totalExperience': instance.totalExperience,
      'address': instance.address,
      'startDate': instance.startDate?.toIso8601String(),
      'endDate': instance.endDate?.toIso8601String(),
      'currentDesignation': instance.currentDesignation,
      'lastOrganization': instance.lastOrganization,
      'currentCTC': instance.currentCtc,
      'grossSalary': instance.grossSalary,
    };

Location _$LocationFromJson(Map<String, dynamic> json) => Location(
      type: json['type'] as String?,
      coordinates: (json['coordinates'] as List<dynamic>?)
          ?.map((e) => (e as num).toDouble())
          .toList(),
    );

Map<String, dynamic> _$LocationToJson(Location instance) => <String, dynamic>{
      'type': instance.type,
      'coordinates': instance.coordinates,
    };

ReportingManagerId _$ReportingManagerIdFromJson(Map<String, dynamic> json) =>
    ReportingManagerId(
      id: json['_id'] as String?,
      employeName: json['employeName'] as String?,
    );

Map<String, dynamic> _$ReportingManagerIdToJson(ReportingManagerId instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'employeName': instance.employeName,
    };

RoleId _$RoleIdFromJson(Map<String, dynamic> json) => RoleId(
      id: json['_id'] as String?,
      roleName: json['roleName'] as String?,
    );

Map<String, dynamic> _$RoleIdToJson(RoleId instance) => <String, dynamic>{
      '_id': instance.id,
      'roleName': instance.roleName,
    };
