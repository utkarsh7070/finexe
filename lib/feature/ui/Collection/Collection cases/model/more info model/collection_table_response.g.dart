// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'collection_table_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CollectionTableResponse _$CollectionTableResponseFromJson(
        Map<String, dynamic> json) =>
    CollectionTableResponse(
      status: json['status'] as bool,
      subCode: (json['subCode'] as num).toInt(),
      message: json['message'] as String,
      error: json['error'] as String,
      items: (json['items'] as List<dynamic>)
          .map((e) => Item.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$CollectionTableResponseToJson(
        CollectionTableResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'subCode': instance.subCode,
      'message': instance.message,
      'error': instance.error,
      'items': instance.items,
    };

Item _$ItemFromJson(Map<String, dynamic> json) => Item(
      id: json['_id'] as String,
      ld: $enumDecode(_$LdEnumMap, json['LD']),
      collectedBy: $enumDecode(_$CollectedByEnumMap, json['collectedBy']),
      customerName: $enumDecode(_$CustomerNameEnumMap, json['customerName']),
      mobileNo: (json['mobileNo'] as num).toInt(),
      receivedAmount: (json['receivedAmount'] as num).toInt(),
      transactionId: json['transactionId'] as String,
      transactionImage: json['transactionImage'] as String,
      customerEmail: json['customerEmail'] as String?,
      modeOfCollectionId:
          $enumDecode(_$ModeOfCollectionIdEnumMap, json['modeOfCollectionId']),
      commonId: json['commonId'] as String?,
      partner: json['partner'] as String,
      emiReceivedDate: DateTime.parse(json['emiReceivedDate'] as String),
      emiReceivedTime: json['emiReceivedTime'],
      remarkByCollection: json['remarkByCollection'] as String,
      remarkByManager: json['remarkByManager'],
      status: json['status'] as String,
      pdf: json['pdf'] as String,
      receiptNo: (json['receiptNo'] as num).toInt(),
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
      v: (json['__v'] as num).toInt(),
      modeOfCollectionDetail: (json['modeOfCollectionDetail'] as List<dynamic>)
          .map(
              (e) => ModeOfCollectionDetail.fromJson(e as Map<String, dynamic>))
          .toList(),
      bankNameDetail: (json['bankNameDetail'] as List<dynamic>)
          .map((e) => BankNameDetail.fromJson(e as Map<String, dynamic>))
          .toList(),
      okCreditDetail: (json['okCreditDetail'] as List<dynamic>)
          .map((e) => OkCreditDetail.fromJson(e as Map<String, dynamic>))
          .toList(),
      employeDetail: (json['employeDetail'] as List<dynamic>)
          .map((e) => EmployeDetail.fromJson(e as Map<String, dynamic>))
          .toList(),
      partnerDetail: json['partnerDetail'] as List<dynamic>,
      reason: json['reason'] as String?,
    );

Map<String, dynamic> _$ItemToJson(Item instance) => <String, dynamic>{
      '_id': instance.id,
      'LD': _$LdEnumMap[instance.ld]!,
      'collectedBy': _$CollectedByEnumMap[instance.collectedBy]!,
      'customerName': _$CustomerNameEnumMap[instance.customerName]!,
      'mobileNo': instance.mobileNo,
      'receivedAmount': instance.receivedAmount,
      'transactionId': instance.transactionId,
      'transactionImage': instance.transactionImage,
      'customerEmail': instance.customerEmail,
      'modeOfCollectionId':
          _$ModeOfCollectionIdEnumMap[instance.modeOfCollectionId]!,
      'commonId': instance.commonId,
      'partner': instance.partner,
      'emiReceivedDate': instance.emiReceivedDate.toIso8601String(),
      'emiReceivedTime': instance.emiReceivedTime,
      'remarkByCollection': instance.remarkByCollection,
      'remarkByManager': instance.remarkByManager,
      'status': instance.status,
      'pdf': instance.pdf,
      'receiptNo': instance.receiptNo,
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt.toIso8601String(),
      '__v': instance.v,
      'modeOfCollectionDetail': instance.modeOfCollectionDetail,
      'bankNameDetail': instance.bankNameDetail,
      'okCreditDetail': instance.okCreditDetail,
      'employeDetail': instance.employeDetail,
      'partnerDetail': instance.partnerDetail,
      'reason': instance.reason,
    };

const _$LdEnumMap = {
  Ld.FINC940: 'FINC940',
};

const _$CollectedByEnumMap = {
  CollectedBy.NIKIT_SIR_C171: 'nikit Sir-C171',
};

const _$CustomerNameEnumMap = {
  CustomerName.LAKHAN: 'LAKHAN',
};

const _$ModeOfCollectionIdEnumMap = {
  ModeOfCollectionId.THE_66_D94_FFCE7_DD309_F59_C54_D3_B:
      '66d94ffce7dd309f59c54d3b',
  ModeOfCollectionId.THE_66_D95023_E7_DD309_F59_C54_D3_F:
      '66d95023e7dd309f59c54d3f',
  ModeOfCollectionId.THE_66_D95058_E7_DD309_F59_C54_D47:
      '66d95058e7dd309f59c54d47',
};

BankNameDetail _$BankNameDetailFromJson(Map<String, dynamic> json) =>
    BankNameDetail(
      id: json['_id'] as String,
      title: json['title'] as String,
      bankName: json['bankName'] as String,
      bankAcNo: json['bankAcNo'] as String,
      bankIfscCode: json['bankIFSCCode'] as String,
      bankAcHolderName: json['bankAcHolderName'] as String,
      bankBranch: json['bankBranch'] as String,
      status: $enumDecode(_$WebsiteListingEnumEnumMap, json['status']),
    );

Map<String, dynamic> _$BankNameDetailToJson(BankNameDetail instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'title': instance.title,
      'bankName': instance.bankName,
      'bankAcNo': instance.bankAcNo,
      'bankIFSCCode': instance.bankIfscCode,
      'bankAcHolderName': instance.bankAcHolderName,
      'bankBranch': instance.bankBranch,
      'status': _$WebsiteListingEnumEnumMap[instance.status]!,
    };

const _$WebsiteListingEnumEnumMap = {
  WebsiteListingEnum.ACTIVE: 'active',
};

EmployeDetail _$EmployeDetailFromJson(Map<String, dynamic> json) =>
    EmployeDetail(
      id: json['_id'] as String,
      employeUniqueId: json['employeUniqueId'] as String,
      employeName: json['employeName'] as String,
      userName: json['userName'] as String,
      email: json['email'] as String,
      workEmail: json['workEmail'] as String,
      mobileNo: (json['mobileNo'] as num).toInt(),
      password: json['password'] as String,
      joiningDate: DateTime.parse(json['joiningDate'] as String),
      dateOfBirth: DateTime.parse(json['dateOfBirth'] as String),
      fatherName: json['fatherName'] as String,
      employeePhoto: json['employeePhoto'],
      currentAddress: json['currentAddress'] as String,
      permanentAddress: json['permanentAddress'] as String,
      branchId: json['branchId'] as String?,
      companyId: json['companyId'] as String,
      roleId: json['roleId'] as String,
      reportingManagerId: json['reportingManagerId'] as String,
      departmentId: json['departmentId'] as String?,
      designationId: json['designationId'] as String?,
      workLocationId: json['workLocationId'] as String?,
      constCenterId: json['constCenterId'] as String,
      employementTypeId: json['employementTypeId'] as String,
      employeeTypeId: json['employeeTypeId'] as String,
      status: $enumDecode(_$WebsiteListingEnumEnumMap, json['status']),
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
      v: (json['__v'] as num).toInt(),
      description: json['description'] as String,
      bankAccount: (json['bankAccount'] as num?)?.toInt(),
      emergencyNumber: (json['emergencyNumber'] as num?)?.toInt(),
      gender: json['gender'] as String,
      maritalStatus: json['maritalStatus'] as String,
      offerLetter: json['offerLetter'],
      package: json['package'] as String,
      referedById: json['referedById'] as String,
      resume: json['resume'],
      salutation: json['salutation'] as String,
      bankDetails: json['bankDetails'],
      ifscCode: json['ifscCode'] as String,
      aadhar: json['aadhar'],
      bankAccountProof: json['bankAccountProof'] as String,
      bankName: json['bankName'] as String,
      currentAddressCity: json['currentAddressCity'] as String,
      currentAddressPincode: (json['currentAddressPincode'] as num?)?.toInt(),
      currentAddressState: json['currentAddressState'] as String,
      currentCtc: json['currentCTC'] as String,
      currentDesignation: json['currentDesignation'] as String,
      educationCertification: json['educationCertification'],
      employmentProof: json['employmentProof'],
      endDate: json['endDate'] == null
          ? null
          : DateTime.parse(json['endDate'] as String),
      experienceLetter: json['experienceLetter'],
      familyIncome: (json['familyIncome'] as num?)?.toInt(),
      fathersMobileNo: (json['fathersMobileNo'] as num?)?.toInt(),
      fathersOccupation: json['fathersOccupation'] as String,
      highestQualification: json['highestQualification'] as String,
      lastOrganization: json['lastOrganization'] as String,
      motherName: json['motherName'] as String,
      mothersMobileNo: (json['mothersMobileNo'] as num?)?.toInt(),
      nameAsPerBank: json['nameAsPerBank'] as String,
      panCard: json['panCard'],
      permanentAddressCity: json['permanentAddressCity'] as String,
      permanentAddressPincode: json['permanentAddressPincode'] as String?,
      permanentAddressState: json['permanentAddressState'] as String,
      startDate: json['startDate'] == null
          ? null
          : DateTime.parse(json['startDate'] as String),
      totalExperience: (json['totalExperience'] as num?)?.toInt(),
      university: json['university'] as String,
      location: Location.fromJson(json['location'] as Map<String, dynamic>),
      websiteListing:
          $enumDecode(_$WebsiteListingEnumEnumMap, json['websiteListing']),
      company: json['company'] as String?,
      esicNumber: json['esicNumber'] as String?,
      seconSubDepartmentId: json['seconSubDepartmentId'],
      secondaryDepartmentId: json['secondaryDepartmentId'],
      subDepartmentId: json['subDepartmentId'],
      uanNumber: (json['uanNumber'] as num?)?.toInt(),
    );

Map<String, dynamic> _$EmployeDetailToJson(EmployeDetail instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'employeUniqueId': instance.employeUniqueId,
      'employeName': instance.employeName,
      'userName': instance.userName,
      'email': instance.email,
      'workEmail': instance.workEmail,
      'mobileNo': instance.mobileNo,
      'password': instance.password,
      'joiningDate': instance.joiningDate.toIso8601String(),
      'dateOfBirth': instance.dateOfBirth.toIso8601String(),
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
      'status': _$WebsiteListingEnumEnumMap[instance.status]!,
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt.toIso8601String(),
      '__v': instance.v,
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
      'endDate': instance.endDate?.toIso8601String(),
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
      'startDate': instance.startDate?.toIso8601String(),
      'totalExperience': instance.totalExperience,
      'university': instance.university,
      'location': instance.location,
      'websiteListing': _$WebsiteListingEnumEnumMap[instance.websiteListing]!,
      'company': instance.company,
      'esicNumber': instance.esicNumber,
      'seconSubDepartmentId': instance.seconSubDepartmentId,
      'secondaryDepartmentId': instance.secondaryDepartmentId,
      'subDepartmentId': instance.subDepartmentId,
      'uanNumber': instance.uanNumber,
    };

Location _$LocationFromJson(Map<String, dynamic> json) => Location(
      type: json['type'] as String,
      coordinates: (json['coordinates'] as List<dynamic>)
          .map((e) => (e as num).toDouble())
          .toList(),
    );

Map<String, dynamic> _$LocationToJson(Location instance) => <String, dynamic>{
      'type': instance.type,
      'coordinates': instance.coordinates,
    };

ModeOfCollectionDetail _$ModeOfCollectionDetailFromJson(
        Map<String, dynamic> json) =>
    ModeOfCollectionDetail(
      id: $enumDecode(_$ModeOfCollectionIdEnumMap, json['_id']),
      title: $enumDecode(_$TitleEnumMap, json['title']),
      extraForm: json['extraForm'] as bool,
      email: json['email'] as bool,
      dropdownId: $enumDecode(_$DropdownIdEnumMap, json['dropdownId']),
      status: $enumDecode(_$WebsiteListingEnumEnumMap, json['status']),
    );

Map<String, dynamic> _$ModeOfCollectionDetailToJson(
        ModeOfCollectionDetail instance) =>
    <String, dynamic>{
      '_id': _$ModeOfCollectionIdEnumMap[instance.id]!,
      'title': _$TitleEnumMap[instance.title]!,
      'extraForm': instance.extraForm,
      'email': instance.email,
      'dropdownId': _$DropdownIdEnumMap[instance.dropdownId]!,
      'status': _$WebsiteListingEnumEnumMap[instance.status]!,
    };

const _$TitleEnumMap = {
  Title.OKCREDIT: 'okcredit',
  Title.ONLINE: 'online',
  Title.PARTNER: 'partner',
};

const _$DropdownIdEnumMap = {
  DropdownId.THE_66_CF05_A969_CF52741_EC374_B1: '66cf05a969cf52741ec374b1',
  DropdownId.THE_66_CF05_B969_CF52741_EC374_B3: '66cf05b969cf52741ec374b3',
};

OkCreditDetail _$OkCreditDetailFromJson(Map<String, dynamic> json) =>
    OkCreditDetail(
      id: json['_id'] as String,
      employeeId: json['employeeId'] as String,
      creditNo: (json['creditNo'] as num).toInt(),
      status: $enumDecode(_$WebsiteListingEnumEnumMap, json['status']),
      v: (json['__v'] as num).toInt(),
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
    );

Map<String, dynamic> _$OkCreditDetailToJson(OkCreditDetail instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'employeeId': instance.employeeId,
      'creditNo': instance.creditNo,
      'status': _$WebsiteListingEnumEnumMap[instance.status]!,
      '__v': instance.v,
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt.toIso8601String(),
    };
