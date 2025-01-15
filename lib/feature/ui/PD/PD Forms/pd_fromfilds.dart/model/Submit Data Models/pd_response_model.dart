import 'package:json_annotation/json_annotation.dart';

part 'pd_response_model.g.dart';

@JsonSerializable()
class PdResponseModel {
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

  PdResponseModel({
    this.status,
    this.subCode,
    this.message,
    this.error,
    this.items,
  });

  factory PdResponseModel.fromJson(Map<String, dynamic> json) =>
      _$PdResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$PdResponseModelToJson(this);
}

@JsonSerializable()
class Items {
  @JsonKey(name: "applicant")
  PdApplicant? applicant;
  @JsonKey(name: "guarantor")
  PdApplicant? guarantor;
  @JsonKey(name: "policeStation")
  PoliceStation? policeStation;
  @JsonKey(name: "cibilAnalysis")
  CibilAnalysis? cibilAnalysis;
  @JsonKey(name: "property")
  Property? property;
  @JsonKey(name: "bankDetail")
  BankDetail? bankDetail;
  @JsonKey(name: "total")
  Total? total;
  @JsonKey(name: "totalIncomeDetails")
  TotalIncomeDetails? totalIncomeDetails;
  @JsonKey(name: "approveLoanDetails")
  ApproveLoanDetails? approveLoanDetails;
  @JsonKey(name: "samagraDetail")
  SamagraDetail? samagraDetail;
  @JsonKey(name: "hoId")
  dynamic hoId;
  @JsonKey(name: "udyamCertificate")
  String? udyamCertificate;
  @JsonKey(name: "reasonForReject")
  String? reasonForReject;
  @JsonKey(name: "PDdocuments")
  bool? pDdocuments;
  @JsonKey(name: "_id")
  String? id;
  @JsonKey(name: "customerId")
  String? customerId;
  @JsonKey(name: "pdId")
  String? pdId;
  @JsonKey(name: "pdType")
  String? pdType;
  @JsonKey(name: "videoUpload")
  dynamic videoUpload;
  @JsonKey(name: "rejectReason")
  String? rejectReason;
  @JsonKey(name: "pendingReason")
  String? pendingReason;
  @JsonKey(name: "applicantImage")
  String? applicantImage;
  @JsonKey(name: "guarantorImage")
  String? guarantorImage;
  @JsonKey(name: "coApplicantImage")
  List<String>? coApplicantImage;
  @JsonKey(name: "co_Applicant")
  List<PdApplicant>? coApplicant;
  @JsonKey(name: "familyMember")
  List<FamilyMember>? familyMember;
  @JsonKey(name: "referenceDetails")
  List<ReferenceDetail>? referenceDetails;
  @JsonKey(name: "landmarkPhoto")
  String? landmarkPhoto;
  @JsonKey(name: "latLongPhoto")
  String? latLongPhoto;
  @JsonKey(name: "fourBoundaryPhotos")
  List<dynamic>? fourBoundaryPhotos;
  @JsonKey(name: "workPhotos")
  List<dynamic>? workPhotos;
  @JsonKey(name: "houseInsidePhoto")
  List<dynamic>? houseInsidePhoto;
  @JsonKey(name: "propertyOtherPhotos")
  List<dynamic>? propertyOtherPhotos;
  @JsonKey(name: "selfiWithCustomer")
  String? selfiWithCustomer;
  @JsonKey(name: "photoWithLatLong")
  String? photoWithLatLong;
  @JsonKey(name: "front")
  String? front;
  @JsonKey(name: "leftSide")
  String? leftSide;
  @JsonKey(name: "rightSide")
  String? rightSide;
  @JsonKey(name: "approachRoad")
  String? approachRoad;
  @JsonKey(name: "mainRoad")
  String? mainRoad;
  @JsonKey(name: "interiorRoad")
  String? interiorRoad;
  @JsonKey(name: "selfieWithProperty")
  String? selfieWithProperty;
  @JsonKey(name: "propertyPhoto")
  String? propertyPhoto;
  @JsonKey(name: "assetDetails")
  List<AssetDetail>? assetDetails;
  @JsonKey(name: "gasDiaryPhoto")
  String? gasDiaryPhoto;
  @JsonKey(name: "meterPhoto")
  String? meterPhoto;
  @JsonKey(name: "electricityBillPhoto")
  String? electricityBillPhoto;
  @JsonKey(name: "SSSMPhoto")
  String? sssmPhoto;
  @JsonKey(name: "familyMemberPhotos")
  List<dynamic>? familyMemberPhotos;
  @JsonKey(name: "otherDocUpload")
  String? otherDocUpload;
  @JsonKey(name: "residentType")
  String? residentType;
  @JsonKey(name: "residentCurrentSince")
  int? residentCurrentSince;
  @JsonKey(name: "status")
  String? status;
  @JsonKey(name: "approvalRemarkCreditPd")
  String? approvalRemarkCreditPd;
  @JsonKey(name: "pdfLink")
  String? pdfLink;
  @JsonKey(name: "remarkMessage")
  String? remarkMessage;
  @JsonKey(name: "bdCompleteDate")
  String? bdCompleteDate;
  @JsonKey(name: "createdAt")
  DateTime? createdAt;
  @JsonKey(name: "updatedAt")
  DateTime? updatedAt;
  @JsonKey(name: "__v")
  int? v;
  @JsonKey(name: "incomeSource")
  List<dynamic>? incomeSource;
  @JsonKey(name: "remarkByPd")
  String? remarkByPd;
  @JsonKey(name: "pdFormDelete")
  bool? pdFormDelete;
  @JsonKey(name: "department_info")
  List<dynamic>? departmentInfo;

  Items({
    this.applicant,
    this.guarantor,
    this.policeStation,
    this.cibilAnalysis,
    this.property,
    this.bankDetail,
    this.total,
    this.totalIncomeDetails,
    this.approveLoanDetails,
    this.samagraDetail,
    this.hoId,
    this.udyamCertificate,
    this.reasonForReject,
    this.pDdocuments,
    this.id,
    this.customerId,
    this.pdId,
    this.pdType,
    this.videoUpload,
    this.rejectReason,
    this.pendingReason,
    this.applicantImage,
    this.guarantorImage,
    this.coApplicantImage,
    this.coApplicant,
    this.familyMember,
    this.referenceDetails,
    this.landmarkPhoto,
    this.latLongPhoto,
    this.fourBoundaryPhotos,
    this.workPhotos,
    this.houseInsidePhoto,
    this.propertyOtherPhotos,
    this.selfiWithCustomer,
    this.photoWithLatLong,
    this.front,
    this.leftSide,
    this.rightSide,
    this.approachRoad,
    this.mainRoad,
    this.interiorRoad,
    this.selfieWithProperty,
    this.propertyPhoto,
    this.assetDetails,
    this.gasDiaryPhoto,
    this.meterPhoto,
    this.electricityBillPhoto,
    this.sssmPhoto,
    this.familyMemberPhotos,
    this.otherDocUpload,
    this.residentType,
    this.residentCurrentSince,
    this.status,
    this.approvalRemarkCreditPd,
    this.pdfLink,
    this.remarkMessage,
    this.bdCompleteDate,
    this.createdAt,
    this.updatedAt,
    this.v,
    this.incomeSource,
    this.remarkByPd,
    this.pdFormDelete,
    this.departmentInfo,
  });

  factory Items.fromJson(Map<String, dynamic> json) => _$ItemsFromJson(json);

  Map<String, dynamic> toJson() => _$ItemsToJson(this);
}

@JsonSerializable()
class PdApplicant {
  @JsonKey(name: "applicantType")
  String? applicantType;
  @JsonKey(name: "businessType")
  String? businessType;
  @JsonKey(name: "occupation")
  String? occupation;
  @JsonKey(name: "DOB")
  String? dob;
  @JsonKey(name: "email")
  String? email;
  @JsonKey(name: "houseLandMark")
  String? houseLandMark;
  @JsonKey(name: "alternateMobileNo")
  String? alternateMobileNo;
  @JsonKey(name: "noOfyearsAtCurrentAddress")
  String? noOfyearsAtCurrentAddress;
  @JsonKey(name: "gender")
  String? gender;
  @JsonKey(name: "religion")
  String? religion;
  @JsonKey(name: "nationality")
  String? nationality;
  @JsonKey(name: "category")
  String? category;
  @JsonKey(name: "caste")
  String? caste;
  @JsonKey(name: "maritalStatus")
  String? maritalStatus;
  @JsonKey(name: "noOfDependentWithCustomer")
  String? noOfDependentWithCustomer;
  @JsonKey(name: "educationalDetails")
  String? educationalDetails;
  @JsonKey(name: "residenceType")
  String? residenceType;
  @JsonKey(name: "coApplicantType")
  String? coApplicantType;
  @JsonKey(name: "emailId")
  String? emailId;
  @JsonKey(name: "_id")
  String? id;
  @JsonKey(name: "guarantorType")
  String? guarantorType;

  PdApplicant({
    this.applicantType,
    this.businessType,
    this.occupation,
    this.dob,
    this.email,
    this.houseLandMark,
    this.alternateMobileNo,
    this.noOfyearsAtCurrentAddress,
    this.gender,
    this.religion,
    this.nationality,
    this.category,
    this.caste,
    this.maritalStatus,
    this.noOfDependentWithCustomer,
    this.educationalDetails,
    this.residenceType,
    this.coApplicantType,
    this.emailId,
    this.id,
    this.guarantorType,
  });

  factory PdApplicant.fromJson(Map<String, dynamic> json) =>
      _$PdApplicantFromJson(json);

  Map<String, dynamic> toJson() => _$PdApplicantToJson(this);
}

@JsonSerializable()
class ApproveLoanDetails {
  @JsonKey(name: "approvedAmount")
  int? approvedAmount;
  @JsonKey(name: "ROI")
  int? roi;
  @JsonKey(name: "Tenure")
  int? tenure;
  @JsonKey(name: "EMI")
  int? emi;
  @JsonKey(name: "demandLoanAmountByCustomer")
  String? demandLoanAmountByCustomer;
  @JsonKey(name: "finalDecision")
  String? finalDecision;
  @JsonKey(name: "endUseOfLoan")
  String? endUseOfLoan;

  ApproveLoanDetails({
    this.approvedAmount,
    this.roi,
    this.tenure,
    this.emi,
    this.demandLoanAmountByCustomer,
    this.finalDecision,
    this.endUseOfLoan,
  });

  factory ApproveLoanDetails.fromJson(Map<String, dynamic> json) =>
      _$ApproveLoanDetailsFromJson(json);

  Map<String, dynamic> toJson() => _$ApproveLoanDetailsToJson(this);
}

@JsonSerializable()
class AssetDetail {
  @JsonKey(name: "name")
  String? name;
  @JsonKey(name: "purchaseValue")
  String? purchaseValue;
  @JsonKey(name: "marketValue")
  String? marketValue;
  @JsonKey(name: "_id")
  String? id;

  AssetDetail({
    this.name,
    this.purchaseValue,
    this.marketValue,
    this.id,
  });

  AssetDetail copyWith({
    String? name,
    String? purchaseValue,
    String? marketValue,
    String? id,
  }) =>
      AssetDetail(
        name: name ?? this.name,
        purchaseValue: purchaseValue ?? this.purchaseValue,
        marketValue: marketValue ?? this.marketValue,
        id: id ?? this.id,
      );

  factory AssetDetail.fromJson(Map<String, dynamic> json) =>
      _$AssetDetailFromJson(json);

  Map<String, dynamic> toJson() => _$AssetDetailToJson(this);
}

@JsonSerializable()
class BankDetail {
  @JsonKey(name: "nameOfBank")
  String? nameOfBank;
  @JsonKey(name: "branchName")
  String? branchName;
  @JsonKey(name: "accountNo")
  String? accountNo;
  @JsonKey(name: "accountType")
  String? accountType;
  @JsonKey(name: "IFSCCode")
  String? ifscCode;
  @JsonKey(name: "accountHolderName")
  String? accountHolderName;

  BankDetail({
    this.nameOfBank,
    this.branchName,
    this.accountNo,
    this.accountType,
    this.ifscCode,
    this.accountHolderName,
  });

  factory BankDetail.fromJson(Map<String, dynamic> json) =>
      _$BankDetailFromJson(json);

  Map<String, dynamic> toJson() => _$BankDetailToJson(this);
}

@JsonSerializable()
class CibilAnalysis {
  @JsonKey(name: "TotalLoans")
  String? totalLoans;
  @JsonKey(name: "detailsOfCurrentLoans")
  String? detailsOfCurrentLoans;
  @JsonKey(name: "reasonforDPD")
  String? reasonforDpd;

  CibilAnalysis({
    this.totalLoans,
    this.detailsOfCurrentLoans,
    this.reasonforDpd,
  });

  factory CibilAnalysis.fromJson(Map<String, dynamic> json) =>
      _$CibilAnalysisFromJson(json);

  Map<String, dynamic> toJson() => _$CibilAnalysisToJson(this);
}

@JsonSerializable()
class FamilyMember {
  @JsonKey(name: "name")
  String? name;
  @JsonKey(name: "samagraMemberId")
  String? samagraMemberId;
  @JsonKey(name: "age")
  dynamic age;
  @JsonKey(name: "gender")
  String? gender;
  @JsonKey(name: "relation")
  String? relation;
  @JsonKey(name: "dependent")
  String? dependent;
  @JsonKey(name: "occupationType")
  String? occupationType;
  @JsonKey(name: "occupationTypeDetails")
  OccupationTypeDetails? occupationTypeDetails;
  @JsonKey(name: "_id")
  String? id;

  FamilyMember({
    this.name,
    this.samagraMemberId,
    this.age,
    this.gender,
    this.relation,
    this.dependent,
    this.occupationType,
    this.occupationTypeDetails,
    this.id,
  });

  factory FamilyMember.fromJson(Map<String, dynamic> json) =>
      _$FamilyMemberFromJson(json);

  Map<String, dynamic> toJson() => _$FamilyMemberToJson(this);
}

@JsonSerializable()
class OccupationTypeDetails {
  @JsonKey(name: "institutionName")
  String? institutionName;
  @JsonKey(name: "nameOfOrganization")
  String? nameOfOrganization;
  @JsonKey(name: "designation")
  String? designation;
  @JsonKey(name: "dateOfJoining")
  String? dateOfJoining;

  OccupationTypeDetails({
    this.institutionName,
    this.nameOfOrganization,
    this.designation,
    this.dateOfJoining,
  });

  factory OccupationTypeDetails.fromJson(Map<String, dynamic> json) =>
      _$OccupationTypeDetailsFromJson(json);

  Map<String, dynamic> toJson() => _$OccupationTypeDetailsToJson(this);
}

@JsonSerializable()
class PoliceStation {
  @JsonKey(name: "staionName")
  String? staionName;
  @JsonKey(name: "stationAdress")
  String? stationAdress;

  PoliceStation({
    this.staionName,
    this.stationAdress,
  });

  factory PoliceStation.fromJson(Map<String, dynamic> json) =>
      _$PoliceStationFromJson(json);

  Map<String, dynamic> toJson() => _$PoliceStationToJson(this);
}

@JsonSerializable()
class Property {
  @JsonKey(name: "collateralsDetails")
  CollateralsDetails? collateralsDetails;
  @JsonKey(name: "accommodationDetails")
  AccommodationDetails? accommodationDetails;
  @JsonKey(name: "howManyFloors")
  String? howManyFloors;
  @JsonKey(name: "pincode")
  String? pincode;
  @JsonKey(name: "TotalLandArea")
  String? totalLandArea;
  @JsonKey(name: "propertyOwnerName")
  String? propertyOwnerName;
  @JsonKey(name: "relationWithApplicant")
  String? relationWithApplicant;
  @JsonKey(name: "documentType")
  String? documentType;
  @JsonKey(name: "villageName")
  String? villageName;
  @JsonKey(name: "gramPanchayat")
  String? gramPanchayat;
  @JsonKey(name: "patwariHalkaNo")
  String? patwariHalkaNo;
  @JsonKey(name: "state")
  String? state;
  @JsonKey(name: "district")
  String? district;
  @JsonKey(name: "tehsil")
  String? tehsil;
  @JsonKey(name: "houseNo")
  String? houseNo;
  @JsonKey(name: "wardNo")
  String? wardNo;
  @JsonKey(name: "surveyNo")
  String? surveyNo;
  @JsonKey(name: "TotalBuilUpArea")
  String? totalBuilUpArea;
  @JsonKey(name: "qualityOfConstruction")
  String? qualityOfConstruction;
  @JsonKey(name: "ageOfProperty")
  String? ageOfProperty;
  @JsonKey(name: "MaintenanceOfTheProperty")
  String? maintenanceOfTheProperty;
  @JsonKey(name: "ProjectedLifeYear")
  String? projectedLifeYear;
  @JsonKey(name: "typeOfContruction")
  String? typeOfContruction;
  @JsonKey(name: "landRatePerSQFT")
  String? landRatePerSqft;
  @JsonKey(name: "totalConstruction")
  String? totalConstruction;
  @JsonKey(name: "fatherName")
  String? fatherName;
  @JsonKey(name: "latitudeOfTheProrty")
  String? latitudeOfTheProrty;
  @JsonKey(name: "longitudeOfTheProrty")
  String? longitudeOfTheProrty;
  @JsonKey(name: "doorsAndWindowsAreAvailable")
  String? doorsAndWindowsAreAvailable;
  @JsonKey(name: "kitchenAndLatBathAvailable")
  String? kitchenAndLatBathAvailable;
  @JsonKey(name: "assetSeenAtResidence")
  List<dynamic>? assetSeenAtResidence;

  Property({
    this.collateralsDetails,
    this.accommodationDetails,
    this.howManyFloors,
    this.pincode,
    this.totalLandArea,
    this.propertyOwnerName,
    this.relationWithApplicant,
    this.documentType,
    this.villageName,
    this.gramPanchayat,
    this.patwariHalkaNo,
    this.state,
    this.district,
    this.tehsil,
    this.houseNo,
    this.wardNo,
    this.surveyNo,
    this.totalBuilUpArea,
    this.qualityOfConstruction,
    this.ageOfProperty,
    this.maintenanceOfTheProperty,
    this.projectedLifeYear,
    this.typeOfContruction,
    this.landRatePerSqft,
    this.totalConstruction,
    this.fatherName,
    this.latitudeOfTheProrty,
    this.longitudeOfTheProrty,
    this.doorsAndWindowsAreAvailable,
    this.kitchenAndLatBathAvailable,
    this.assetSeenAtResidence,
  });

  factory Property.fromJson(Map<String, dynamic> json) =>
      _$PropertyFromJson(json);

  Map<String, dynamic> toJson() => _$PropertyToJson(this);
}

@JsonSerializable()
class AccommodationDetails {
  @JsonKey(name: "groundFloor")
  String? groundFloor;
  @JsonKey(name: "firstFloor")
  String? firstFloor;
  @JsonKey(name: "actualUsageOfProperty")
  String? actualUsageOfProperty;
  @JsonKey(name: "typeOfStructure")
  String? typeOfStructure;
  @JsonKey(name: "locationOfPlot")
  String? locationOfPlot;
  @JsonKey(name: "builtUpAreaSft")
  String? builtUpAreaSft;
  @JsonKey(name: "occupancy")
  String? occupancy;
  @JsonKey(name: "electricityAndGasConnection")
  String? electricityAndGasConnection;
  @JsonKey(name: "developmentOfSurroundingArea")
  String? developmentOfSurroundingArea;

  AccommodationDetails({
    this.groundFloor,
    this.firstFloor,
    this.actualUsageOfProperty,
    this.typeOfStructure,
    this.locationOfPlot,
    this.builtUpAreaSft,
    this.occupancy,
    this.electricityAndGasConnection,
    this.developmentOfSurroundingArea,
  });

  factory AccommodationDetails.fromJson(Map<String, dynamic> json) =>
      _$AccommodationDetailsFromJson(json);

  Map<String, dynamic> toJson() => _$AccommodationDetailsToJson(this);
}

@JsonSerializable()
class CollateralsDetails {
  @JsonKey(name: "nameOfTheDocumentHolder")
  String? nameOfTheDocumentHolder;
  @JsonKey(name: "documentsProvided")
  String? documentsProvided;
  @JsonKey(name: "propertyAddress")
  String? propertyAddress;
  @JsonKey(name: "landmark")
  String? landmark;
  @JsonKey(name: "locationZone")
  String? locationZone;
  @JsonKey(name: "availabilityOfLocalTransport")
  String? availabilityOfLocalTransport;
  @JsonKey(name: "classOfLocality")
  String? classOfLocality;
  @JsonKey(name: "typeOfLocality")
  String? typeOfLocality;
  @JsonKey(name: "asPerSite")
  String? asPerSite;
  @JsonKey(name: "boundariesMatching")
  String? boundariesMatching;
  @JsonKey(name: "statusOfTheLandFlat")
  String? statusOfTheLandFlat;
  @JsonKey(name: "typeOfProperty")
  String? typeOfProperty;
  @JsonKey(name: "boundariesEast")
  String? boundariesEast;
  @JsonKey(name: "boundariesWest")
  String? boundariesWest;
  @JsonKey(name: "boundariesNorth")
  String? boundariesNorth;
  @JsonKey(name: "boundariesSouth")
  String? boundariesSouth;

  CollateralsDetails({
    this.nameOfTheDocumentHolder,
    this.documentsProvided,
    this.propertyAddress,
    this.landmark,
    this.locationZone,
    this.availabilityOfLocalTransport,
    this.classOfLocality,
    this.typeOfLocality,
    this.asPerSite,
    this.boundariesMatching,
    this.statusOfTheLandFlat,
    this.typeOfProperty,
    this.boundariesEast,
    this.boundariesWest,
    this.boundariesNorth,
    this.boundariesSouth,
  });

  factory CollateralsDetails.fromJson(Map<String, dynamic> json) =>
      _$CollateralsDetailsFromJson(json);

  Map<String, dynamic> toJson() => _$CollateralsDetailsToJson(this);
}

@JsonSerializable()
class ReferenceDetail {
  @JsonKey(name: "name")
  String? name;
  @JsonKey(name: "address")
  String? address;
  @JsonKey(name: "relation")
  String? relation;
  @JsonKey(name: "mobileNumber")
  String? mobileNumber;
  @JsonKey(name: "_id")
  String? id;

  ReferenceDetail({
    this.name,
    this.address,
    this.relation,
    this.mobileNumber,
    this.id,
  });

  factory ReferenceDetail.fromJson(Map<String, dynamic> json) =>
      _$ReferenceDetailFromJson(json);

  Map<String, dynamic> toJson() => _$ReferenceDetailToJson(this);
}

@JsonSerializable()
class SamagraDetail {
  @JsonKey(name: "samagraFamilyIdNo")
  String? samagraFamilyIdNo;
  @JsonKey(name: "samagraIdHeadName")
  String? samagraIdHeadName;

  SamagraDetail({
    this.samagraFamilyIdNo,
    this.samagraIdHeadName,
  });

  factory SamagraDetail.fromJson(Map<String, dynamic> json) =>
      _$SamagraDetailFromJson(json);

  Map<String, dynamic> toJson() => _$SamagraDetailToJson(this);
}

@JsonSerializable()
class Total {
  @JsonKey(name: "totalPurchaseValue")
  int? totalPurchaseValue;
  @JsonKey(name: "totalMarketValue")
  int? totalMarketValue;

  Total({
    this.totalPurchaseValue,
    this.totalMarketValue,
  });

  factory Total.fromJson(Map<String, dynamic> json) => _$TotalFromJson(json);

  Map<String, dynamic> toJson() => _$TotalToJson(this);
}

@JsonSerializable()
class TotalIncomeDetails {
  @JsonKey(name: "totalYearlyIncome")
  String? totalYearlyIncome;
  @JsonKey(name: "totalMonthlyIncome")
  String? totalMonthlyIncome;
  @JsonKey(name: "totalExpensesYearly")
  String? totalExpensesYearly;
  @JsonKey(name: "totalExpensesMonthly")
  String? totalExpensesMonthly;

  TotalIncomeDetails({
    this.totalYearlyIncome,
    this.totalMonthlyIncome,
    this.totalExpensesYearly,
    this.totalExpensesMonthly,
  });

  factory TotalIncomeDetails.fromJson(Map<String, dynamic> json) =>
      _$TotalIncomeDetailsFromJson(json);

  Map<String, dynamic> toJson() => _$TotalIncomeDetailsToJson(this);
}


