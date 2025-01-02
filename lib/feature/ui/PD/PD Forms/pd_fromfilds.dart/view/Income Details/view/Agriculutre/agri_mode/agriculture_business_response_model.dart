// import 'package:json_annotation/json_annotation.dart';
// part 'agriculture_business_response_model.g.dart';
//
// @JsonSerializable()
// class AgricultureBusinessResponseModel {
//   @JsonKey(name: "status")
//   bool? status;
//   @JsonKey(name: "subCode")
//   int? subCode;
//   @JsonKey(name: "message")
//   String? message;
//   @JsonKey(name: "error")
//   String? error;
//   @JsonKey(name: "items")
//   Items? items;
//
//   AgricultureBusinessResponseModel({
//     this.status,
//     this.subCode,
//     this.message,
//     this.error,
//     this.items,
//   });
//
//   factory AgricultureBusinessResponseModel.fromJson(Map<String, dynamic> json) => _$AgricultureBusinessResponseModelFromJson(json);
//
//   Map<String, dynamic> toJson() => _$AgricultureBusinessResponseModelToJson(this);
// }
//
// @JsonSerializable()
// class Items {
//   @JsonKey(name: "applicant")
//   Applicant? applicant;
//   @JsonKey(name: "guarantor")
//   Guarantor? guarantor;
//   @JsonKey(name: "policeStation")
//   PoliceStation? policeStation;
//   @JsonKey(name: "cibilAnalysis")
//   CibilAnalysis? cibilAnalysis;
//   @JsonKey(name: "property")
//   Property? property;
//   @JsonKey(name: "bankDetail")
//   BankDetail? bankDetail;
//   @JsonKey(name: "total")
//   Total? total;
//   @JsonKey(name: "totalIncomeDetails")
//   TotalIncomeDetails? totalIncomeDetails;
//   @JsonKey(name: "approveLoanDetails")
//   ApproveLoanDetails? approveLoanDetails;
//   @JsonKey(name: "samagraDetail")
//   SamagraDetail? samagraDetail;
//   @JsonKey(name: "pdfLink")
//   String? pdfLink;
//   @JsonKey(name: "_id")
//   String? id;
//   @JsonKey(name: "customerId")
//   String? customerId;
//   @JsonKey(name: "pdId")
//   String? pdId;
//   @JsonKey(name: "coApplicantImage")
//   List<String>? coApplicantImage;
//   @JsonKey(name: "co_Applicant")
//   List<CoApplicant>? coApplicant;
//   @JsonKey(name: "familyMember")
//   List<FamilyMember>? familyMember;
//   @JsonKey(name: "incomeSource")
//   List<IncomeSource>? incomeSource;
//   @JsonKey(name: "referenceDetails")
//   List<ReferenceDetail>? referenceDetails;
//   @JsonKey(name: "fourBoundaryPhotos")
//   List<String>? fourBoundaryPhotos;
//   @JsonKey(name: "workPhotos")
//   List<String>? workPhotos;
//   @JsonKey(name: "propertyOtherPhotos")
//   List<String>? propertyOtherPhotos;
//   @JsonKey(name: "assetDetails")
//   List<AssetDetail>? assetDetails;
//   @JsonKey(name: "familyMemberPhotos")
//   List<String>? familyMemberPhotos;
//   @JsonKey(name: "otherDocUpload")
//   String? otherDocUpload;
//   @JsonKey(name: "remarkByPd")
//   String? remarkByPd;
//   @JsonKey(name: "status")
//   String? status;
//   @JsonKey(name: "remarkMessage")
//   String? remarkMessage;
//   @JsonKey(name: "pdType")
//   String? pdType;
//   @JsonKey(name: "createdAt")
//   DateTime? createdAt;
//   @JsonKey(name: "updatedAt")
//   DateTime? updatedAt;
//   @JsonKey(name: "__v")
//   int? v;
//   @JsonKey(name: "approvalRemarkCreditPd")
//   String? approvalRemarkCreditPd;
//   @JsonKey(name: "applicantImage")
//   String? applicantImage;
//   @JsonKey(name: "guarantorImage")
//   String? guarantorImage;
//   @JsonKey(name: "landmarkPhoto")
//   String? landmarkPhoto;
//   @JsonKey(name: "latLongPhoto")
//   String? latLongPhoto;
//   @JsonKey(name: "videoUpload")
//   String? videoUpload;
//   @JsonKey(name: "bdCompleteDate")
//   String? bdCompleteDate;
//   @JsonKey(name: "SSSMPhoto")
//   String? sssmPhoto;
//   @JsonKey(name: "gasDiaryPhoto")
//   String? gasDiaryPhoto;
//   @JsonKey(name: "approachRoad")
//   String? approachRoad;
//   @JsonKey(name: "front")
//   String? front;
//   @JsonKey(name: "interiorRoad")
//   String? interiorRoad;
//   @JsonKey(name: "leftSide")
//   String? leftSide;
//   @JsonKey(name: "mainRoad")
//   String? mainRoad;
//   @JsonKey(name: "photoWithLatLong")
//   String? photoWithLatLong;
//   @JsonKey(name: "rightSide")
//   String? rightSide;
//   @JsonKey(name: "selfiWithCustomer")
//   String? selfiWithCustomer;
//   @JsonKey(name: "pendingReason")
//   String? pendingReason;
//   @JsonKey(name: "propertyPhoto")
//   String? propertyPhoto;
//   @JsonKey(name: "rejectReason")
//   String? rejectReason;
//   @JsonKey(name: "residentCurrentSince")
//   int? residentCurrentSince;
//   @JsonKey(name: "residentType")
//   String? residentType;
//   @JsonKey(name: "selfieWithProperty")
//   String? selfieWithProperty;
//
//   Items({
//     this.applicant,
//     this.guarantor,
//     this.policeStation,
//     this.cibilAnalysis,
//     this.property,
//     this.bankDetail,
//     this.total,
//     this.totalIncomeDetails,
//     this.approveLoanDetails,
//     this.samagraDetail,
//     this.pdfLink,
//     this.id,
//     this.customerId,
//     this.pdId,
//     this.coApplicantImage,
//     this.coApplicant,
//     this.familyMember,
//     this.incomeSource,
//     this.referenceDetails,
//     this.fourBoundaryPhotos,
//     this.workPhotos,
//     this.propertyOtherPhotos,
//     this.assetDetails,
//     this.familyMemberPhotos,
//     this.otherDocUpload,
//     this.remarkByPd,
//     this.status,
//     this.remarkMessage,
//     this.pdType,
//     this.createdAt,
//     this.updatedAt,
//     this.v,
//     this.approvalRemarkCreditPd,
//     this.applicantImage,
//     this.guarantorImage,
//     this.landmarkPhoto,
//     this.latLongPhoto,
//     this.videoUpload,
//     this.bdCompleteDate,
//     this.sssmPhoto,
//     this.gasDiaryPhoto,
//     this.approachRoad,
//     this.front,
//     this.interiorRoad,
//     this.leftSide,
//     this.mainRoad,
//     this.photoWithLatLong,
//     this.rightSide,
//     this.selfiWithCustomer,
//     this.pendingReason,
//     this.propertyPhoto,
//     this.rejectReason,
//     this.residentCurrentSince,
//     this.residentType,
//     this.selfieWithProperty,
//   });
//
//   factory Items.fromJson(Map<String, dynamic> json) => _$ItemsFromJson(json);
//
//   Map<String, dynamic> toJson() => _$ItemsToJson(this);
// }
//
// @JsonSerializable()
// class Applicant {
//   @JsonKey(name: "applicantType")
//   String? applicantType;
//   @JsonKey(name: "businessType")
//   String? businessType;
//   @JsonKey(name: "occupation")
//   String? occupation;
//   @JsonKey(name: "DOB")
//   dynamic dob;
//   @JsonKey(name: "email")
//   String? email;
//   @JsonKey(name: "houseLandMark")
//   String? houseLandMark;
//   @JsonKey(name: "alternateMobileNo")
//   String? alternateMobileNo;
//   @JsonKey(name: "noOfyearsAtCurrentAddress")
//   String? noOfyearsAtCurrentAddress;
//   @JsonKey(name: "gender")
//   dynamic gender;
//   @JsonKey(name: "religion")
//   String? religion;
//   @JsonKey(name: "nationality")
//   String? nationality;
//   @JsonKey(name: "category")
//   String? category;
//   @JsonKey(name: "caste")
//   String? caste;
//   @JsonKey(name: "maritalStatus")
//   dynamic maritalStatus;
//   @JsonKey(name: "noOfDependentWithCustomer")
//   String? noOfDependentWithCustomer;
//   @JsonKey(name: "educationalDetails")
//   String? educationalDetails;
//   @JsonKey(name: "residenceType")
//   String? residenceType;
//
//   Applicant({
//     this.applicantType,
//     this.businessType,
//     this.occupation,
//     this.dob,
//     this.email,
//     this.houseLandMark,
//     this.alternateMobileNo,
//     this.noOfyearsAtCurrentAddress,
//     this.gender,
//     this.religion,
//     this.nationality,
//     this.category,
//     this.caste,
//     this.maritalStatus,
//     this.noOfDependentWithCustomer,
//     this.educationalDetails,
//     this.residenceType,
//   });
//
//   factory Applicant.fromJson(Map<String, dynamic> json) => _$ApplicantFromJson(json);
//
//   Map<String, dynamic> toJson() => _$ApplicantToJson(this);
// }
//
// @JsonSerializable()
// class ApproveLoanDetails {
//   @JsonKey(name: "approvedAmount")
//   int? approvedAmount;
//   @JsonKey(name: "ROI")
//   double? roi;
//   @JsonKey(name: "Tenure")
//   int? tenure;
//   @JsonKey(name: "EMI")
//   int? emi;
//   @JsonKey(name: "demandLoanAmountByCustomer")
//   String? demandLoanAmountByCustomer;
//   @JsonKey(name: "finalDecision")
//   int? finalDecision;
//   @JsonKey(name: "endUseOfLoan")
//   String? endUseOfLoan;
//
//   ApproveLoanDetails({
//     this.approvedAmount,
//     this.roi,
//     this.tenure,
//     this.emi,
//     this.demandLoanAmountByCustomer,
//     this.finalDecision,
//     this.endUseOfLoan,
//   });
//
//   factory ApproveLoanDetails.fromJson(Map<String, dynamic> json) => _$ApproveLoanDetailsFromJson(json);
//
//   Map<String, dynamic> toJson() => _$ApproveLoanDetailsToJson(this);
// }
//
// @JsonSerializable()
// class AssetDetail {
//   @JsonKey(name: "name")
//   String? name;
//   @JsonKey(name: "purchaseValue")
//   String? purchaseValue;
//   @JsonKey(name: "marketValue")
//   String? marketValue;
//   @JsonKey(name: "_id")
//   String? id;
//
//   AssetDetail({
//     this.name,
//     this.purchaseValue,
//     this.marketValue,
//     this.id,
//   });
//
//   factory AssetDetail.fromJson(Map<String, dynamic> json) => _$AssetDetailFromJson(json);
//
//   Map<String, dynamic> toJson() => _$AssetDetailToJson(this);
// }
//
// @JsonSerializable()
// class BankDetail {
//   @JsonKey(name: "nameOfBank")
//   String? nameOfBank;
//   @JsonKey(name: "branchName")
//   String? branchName;
//   @JsonKey(name: "accountNo")
//   String? accountNo;
//   @JsonKey(name: "accountType")
//   String? accountType;
//   @JsonKey(name: "IFSCCode")
//   String? ifscCode;
//   @JsonKey(name: "accountHolderName")
//   String? accountHolderName;
//
//   BankDetail({
//     this.nameOfBank,
//     this.branchName,
//     this.accountNo,
//     this.accountType,
//     this.ifscCode,
//     this.accountHolderName,
//   });
//
//   factory BankDetail.fromJson(Map<String, dynamic> json) => _$BankDetailFromJson(json);
//
//   Map<String, dynamic> toJson() => _$BankDetailToJson(this);
// }
//
// @JsonSerializable()
// class CibilAnalysis {
//   @JsonKey(name: "TotalLoans")
//   String? totalLoans;
//   @JsonKey(name: "detailsOfCurrentLoans")
//   String? detailsOfCurrentLoans;
//   @JsonKey(name: "reasonforDPD")
//   String? reasonforDpd;
//
//   CibilAnalysis({
//     this.totalLoans,
//     this.detailsOfCurrentLoans,
//     this.reasonforDpd,
//   });
//
//   factory CibilAnalysis.fromJson(Map<String, dynamic> json) => _$CibilAnalysisFromJson(json);
//
//   Map<String, dynamic> toJson() => _$CibilAnalysisToJson(this);
// }
//
// @JsonSerializable()
// class CoApplicant {
//   @JsonKey(name: "coApplicantType")
//   String? coApplicantType;
//   @JsonKey(name: "businessType")
//   String? businessType;
//   @JsonKey(name: "occupation")
//   String? occupation;
//   @JsonKey(name: "DOB")
//   dynamic dob;
//   @JsonKey(name: "emailId")
//   dynamic emailId;
//   @JsonKey(name: "houseLandMark")
//   String? houseLandMark;
//   @JsonKey(name: "alternateMobileNo")
//   String? alternateMobileNo;
//   @JsonKey(name: "noOfyearsAtCurrentAddress")
//   dynamic noOfyearsAtCurrentAddress;
//   @JsonKey(name: "gender")
//   dynamic gender;
//   @JsonKey(name: "religion")
//   String? religion;
//   @JsonKey(name: "nationality")
//   String? nationality;
//   @JsonKey(name: "category")
//   String? category;
//   @JsonKey(name: "caste")
//   String? caste;
//   @JsonKey(name: "maritalStatus")
//   dynamic maritalStatus;
//   @JsonKey(name: "educationalDetails")
//   String? educationalDetails;
//   @JsonKey(name: "residenceType")
//   String? residenceType;
//   @JsonKey(name: "_id")
//   dynamic id;
//
//   CoApplicant({
//     this.coApplicantType,
//     this.businessType,
//     this.occupation,
//     this.dob,
//     this.emailId,
//     this.houseLandMark,
//     this.alternateMobileNo,
//     this.noOfyearsAtCurrentAddress,
//     this.gender,
//     this.religion,
//     this.nationality,
//     this.category,
//     this.caste,
//     this.maritalStatus,
//     this.educationalDetails,
//     this.residenceType,
//     this.id,
//   });
//
//   factory CoApplicant.fromJson(Map<String, dynamic> json) => _$CoApplicantFromJson(json);
//
//   Map<String, dynamic> toJson() => _$CoApplicantToJson(this);
// }
//
// @JsonSerializable()
// class FamilyMember {
//   @JsonKey(name: "occupationTypeDetails")
//   OccupationTypeDetails? occupationTypeDetails;
//   @JsonKey(name: "name")
//   String? name;
//   @JsonKey(name: "age")
//   int? age;
//   @JsonKey(name: "relation")
//   String? relation;
//   @JsonKey(name: "dependent")
//   String? dependent;
//   @JsonKey(name: "_id")
//   String? id;
//
//   FamilyMember({
//     this.occupationTypeDetails,
//     this.name,
//     this.age,
//     this.relation,
//     this.dependent,
//     this.id,
//   });
//
//   factory FamilyMember.fromJson(Map<String, dynamic> json) => _$FamilyMemberFromJson(json);
//
//   Map<String, dynamic> toJson() => _$FamilyMemberToJson(this);
// }
//
// @JsonSerializable()
// class OccupationTypeDetails {
//   @JsonKey(name: "institutionName")
//   String? institutionName;
//   @JsonKey(name: "nameOfOrganization")
//   String? nameOfOrganization;
//   @JsonKey(name: "designation")
//   String? designation;
//   @JsonKey(name: "dateOfJoining")
//   String? dateOfJoining;
//
//   OccupationTypeDetails({
//     this.institutionName,
//     this.nameOfOrganization,
//     this.designation,
//     this.dateOfJoining,
//   });
//
//   factory OccupationTypeDetails.fromJson(Map<String, dynamic> json) => _$OccupationTypeDetailsFromJson(json);
//
//   Map<String, dynamic> toJson() => _$OccupationTypeDetailsToJson(this);
// }
//
// @JsonSerializable()
// class Guarantor {
//   @JsonKey(name: "guarantorType")
//   String? guarantorType;
//   @JsonKey(name: "businessType")
//   String? businessType;
//   @JsonKey(name: "occupation")
//   String? occupation;
//   @JsonKey(name: "residenceType")
//   String? residenceType;
//   @JsonKey(name: "DOB")
//   dynamic dob;
//   @JsonKey(name: "emailId")
//   String? emailId;
//   @JsonKey(name: "houseLandMark")
//   String? houseLandMark;
//   @JsonKey(name: "alternateMobileNo")
//   String? alternateMobileNo;
//   @JsonKey(name: "noOfyearsAtCurrentAddress")
//   String? noOfyearsAtCurrentAddress;
//   @JsonKey(name: "gender")
//   dynamic gender;
//   @JsonKey(name: "religion")
//   String? religion;
//   @JsonKey(name: "nationality")
//   String? nationality;
//   @JsonKey(name: "category")
//   String? category;
//   @JsonKey(name: "caste")
//   String? caste;
//   @JsonKey(name: "maritalStatus")
//   dynamic maritalStatus;
//   @JsonKey(name: "educationalDetails")
//   String? educationalDetails;
//
//   Guarantor({
//     this.guarantorType,
//     this.businessType,
//     this.occupation,
//     this.residenceType,
//     this.dob,
//     this.emailId,
//     this.houseLandMark,
//     this.alternateMobileNo,
//     this.noOfyearsAtCurrentAddress,
//     this.gender,
//     this.religion,
//     this.nationality,
//     this.category,
//     this.caste,
//     this.maritalStatus,
//     this.educationalDetails,
//   });
//
//   factory Guarantor.fromJson(Map<String, dynamic> json) => _$GuarantorFromJson(json);
//
//   Map<String, dynamic> toJson() => _$GuarantorToJson(this);
// }
//
// @JsonSerializable()
// class IncomeSource {
//   @JsonKey(name: "agricultureBusiness")
//   AgricultureBusiness? agricultureBusiness;
//   @JsonKey(name: "milkBusiness")
//   MilkBusiness? milkBusiness;
//   @JsonKey(name: "salaryIncome")
//   SalaryIncome? salaryIncome;
//   @JsonKey(name: "other")
//   Other? other;
//   @JsonKey(name: "incomeSourceType")
//   String? incomeSourceType;
//   @JsonKey(name: "_id")
//   String? id;
//
//   IncomeSource({
//     this.agricultureBusiness,
//     this.milkBusiness,
//     this.salaryIncome,
//     this.other,
//     this.incomeSourceType,
//     this.id,
//   });
//
//   factory IncomeSource.fromJson(Map<String, dynamic> json) => _$IncomeSourceFromJson(json);
//
//   Map<String, dynamic> toJson() => _$IncomeSourceToJson(this);
// }
//
// @JsonSerializable()
// class AgricultureBusiness {
//   @JsonKey(name: "haveYouFaced")
//   String? haveYouFaced;
//   @JsonKey(name: "nameOfAgriOwner")
//   List<String>? nameOfAgriOwner;
//   @JsonKey(name: "relationOfApplicant")
//   String? relationOfApplicant;
//   @JsonKey(name: "kasraSurveyNo")
//   String? kasraSurveyNo;
//   @JsonKey(name: "agriLandInBigha")
//   String? agriLandInBigha;
//   @JsonKey(name: "otherName")
//   String? otherName;
//   @JsonKey(name: "otherRelation")
//   String? otherRelation;
//   @JsonKey(name: "otherRemark")
//   String? otherRemark;
//   @JsonKey(name: "villageName")
//   String? villageName;
//   @JsonKey(name: "detailOfLastCorp")
//   String? detailOfLastCorp;
//   @JsonKey(name: "howmuchcorpsoldInAmt")
//   String? howmuchcorpsoldInAmt;
//   @JsonKey(name: "agriculturePhotos")
//   List<String>? agriculturePhotos;
//   @JsonKey(name: "whichCropIsPlanted")
//   List<String>? whichCropIsPlanted;
//   @JsonKey(name: "agriDoingFromNoOfYears")
//   String? agriDoingFromNoOfYears;
//   @JsonKey(name: "addressAsPerPawti")
//   String? addressAsPerPawti;
//   @JsonKey(name: "districtName")
//   String? districtName;
//   @JsonKey(name: "agriLandSurveyNo")
//   String? agriLandSurveyNo;
//   @JsonKey(name: "fertilizerShopOwnerName")
//   String? fertilizerShopOwnerName;
//   @JsonKey(name: "fertilizerShopOwnerContactNumber")
//   String? fertilizerShopOwnerContactNumber;
//   @JsonKey(name: "WhatTypeOfIrrigationMethod")
//   String? whatTypeOfIrrigationMethod;
//   @JsonKey(name: "significantChallengesThisSeason")
//   String? significantChallengesThisSeason;
//   @JsonKey(name: "agriIncomeYearly")
//   String? agriIncomeYearly;
//   @JsonKey(name: "ifCropDestroyedHowToPayEMI")
//   String? ifCropDestroyedHowToPayEmi;
//
//   AgricultureBusiness({
//     this.haveYouFaced,
//     this.nameOfAgriOwner,
//     this.relationOfApplicant,
//     this.kasraSurveyNo,
//     this.agriLandInBigha,
//     this.otherName,
//     this.otherRelation,
//     this.otherRemark,
//     this.villageName,
//     this.detailOfLastCorp,
//     this.howmuchcorpsoldInAmt,
//     this.agriculturePhotos,
//     this.whichCropIsPlanted,
//     this.agriDoingFromNoOfYears,
//     this.addressAsPerPawti,
//     this.districtName,
//     this.agriLandSurveyNo,
//     this.fertilizerShopOwnerName,
//     this.fertilizerShopOwnerContactNumber,
//     this.whatTypeOfIrrigationMethod,
//     this.significantChallengesThisSeason,
//     this.agriIncomeYearly,
//     this.ifCropDestroyedHowToPayEmi,
//   });
//
//   factory AgricultureBusiness.fromJson(Map<String, dynamic> json) => _$AgricultureBusinessFromJson(json);
//
//   Map<String, dynamic> toJson() => _$AgricultureBusinessToJson(this);
// }
//
// @JsonSerializable()
// class MilkBusiness {
//   @JsonKey(name: "numberOfCattrels")
//   String? numberOfCattrels;
//   @JsonKey(name: "noOfMilkGivingCattles")
//   String? noOfMilkGivingCattles;
//   @JsonKey(name: "doingFromNoOfYears")
//   String? doingFromNoOfYears;
//   @JsonKey(name: "totalMilkSupplyPerDay")
//   String? totalMilkSupplyPerDay;
//   @JsonKey(name: "nameOfDairy")
//   String? nameOfDairy;
//   @JsonKey(name: "dairyOwnerMobNo")
//   String? dairyOwnerMobNo;
//   @JsonKey(name: "dairyAddress")
//   String? dairyAddress;
//   @JsonKey(name: "milkprovideFromSinceYear")
//   String? milkprovideFromSinceYear;
//   @JsonKey(name: "expensesOfMilkBusiness")
//   String? expensesOfMilkBusiness;
//   @JsonKey(name: "monthlyIncomeMilkBusiness")
//   String? monthlyIncomeMilkBusiness;
//   @JsonKey(name: "milkPhotos")
//   List<dynamic>? milkPhotos;
//   @JsonKey(name: "animalPhotos")
//   List<dynamic>? animalPhotos;
//   @JsonKey(name: "currentMilkUtilization")
//   String? currentMilkUtilization;
//   @JsonKey(name: "breedOfCattles")
//   List<dynamic>? breedOfCattles;
//   @JsonKey(name: "ifCropDestroyedHowToPayEMI")
//   String? ifCropDestroyedHowToPayEmi;
//   @JsonKey(name: "observedDesignatedCattleTyingArea")
//   String? observedDesignatedCattleTyingArea;
//
//   MilkBusiness({
//     this.numberOfCattrels,
//     this.noOfMilkGivingCattles,
//     this.doingFromNoOfYears,
//     this.totalMilkSupplyPerDay,
//     this.nameOfDairy,
//     this.dairyOwnerMobNo,
//     this.dairyAddress,
//     this.milkprovideFromSinceYear,
//     this.expensesOfMilkBusiness,
//     this.monthlyIncomeMilkBusiness,
//     this.milkPhotos,
//     this.animalPhotos,
//     this.currentMilkUtilization,
//     this.breedOfCattles,
//     this.ifCropDestroyedHowToPayEmi,
//     this.observedDesignatedCattleTyingArea,
//   });
//
//   factory MilkBusiness.fromJson(Map<String, dynamic> json) => _$MilkBusinessFromJson(json);
//
//   Map<String, dynamic> toJson() => _$MilkBusinessToJson(this);
// }
//
// @JsonSerializable()
// class Other {
//   @JsonKey(name: "bussinessFromSinceYear")
//   String? bussinessFromSinceYear;
//   @JsonKey(name: "natureOfBusiness")
//   String? natureOfBusiness;
//   @JsonKey(name: "monthlyIncome")
//   int? monthlyIncome;
//   @JsonKey(name: "yearlyIncome")
//   int? yearlyIncome;
//   @JsonKey(name: "discriptionOfBusiness")
//   String? discriptionOfBusiness;
//   @JsonKey(name: "incomeOtherImages")
//   List<dynamic>? incomeOtherImages;
//
//   Other({
//     this.bussinessFromSinceYear,
//     this.natureOfBusiness,
//     this.monthlyIncome,
//     this.yearlyIncome,
//     this.discriptionOfBusiness,
//     this.incomeOtherImages,
//   });
//
//   factory Other.fromJson(Map<String, dynamic> json) => _$OtherFromJson(json);
//
//   Map<String, dynamic> toJson() => _$OtherToJson(this);
// }
//
// @JsonSerializable()
// class SalaryIncome {
//   @JsonKey(name: "numberOfCattrels")
//   String? numberOfCattrels;
//   @JsonKey(name: "companyName")
//   String? companyName;
//   @JsonKey(name: "addressOfSalaryProvider")
//   String? addressOfSalaryProvider;
//   @JsonKey(name: "MobNoOfSalaryProvider")
//   String? mobNoOfSalaryProvider;
//   @JsonKey(name: "doingFromNoYears")
//   String? doingFromNoYears;
//   @JsonKey(name: "salaryPaidThrouch")
//   String? salaryPaidThrouch;
//   @JsonKey(name: "monthlyNetSalary")
//   String? monthlyNetSalary;
//   @JsonKey(name: "salaryCredited6Month")
//   String? salaryCredited6Month;
//   @JsonKey(name: "last3MonthSalarySlipPhotos")
//   List<dynamic>? last3MonthSalarySlipPhotos;
//   @JsonKey(name: "bankStatementPhoto")
//   String? bankStatementPhoto;
//   @JsonKey(name: "salaryPhotos")
//   List<dynamic>? salaryPhotos;
//
//   SalaryIncome({
//     this.numberOfCattrels,
//     this.companyName,
//     this.addressOfSalaryProvider,
//     this.mobNoOfSalaryProvider,
//     this.doingFromNoYears,
//     this.salaryPaidThrouch,
//     this.monthlyNetSalary,
//     this.salaryCredited6Month,
//     this.last3MonthSalarySlipPhotos,
//     this.bankStatementPhoto,
//     this.salaryPhotos,
//   });
//
//   factory SalaryIncome.fromJson(Map<String, dynamic> json) => _$SalaryIncomeFromJson(json);
//
//   Map<String, dynamic> toJson() => _$SalaryIncomeToJson(this);
// }
//
// @JsonSerializable()
// class PoliceStation {
//   @JsonKey(name: "staionName")
//   String? staionName;
//   @JsonKey(name: "stationAdress")
//   String? stationAdress;
//
//   PoliceStation({
//     this.staionName,
//     this.stationAdress,
//   });
//
//   factory PoliceStation.fromJson(Map<String, dynamic> json) => _$PoliceStationFromJson(json);
//
//   Map<String, dynamic> toJson() => _$PoliceStationToJson(this);
// }
//
// @JsonSerializable()
// class Property {
//   @JsonKey(name: "collateralsDetails")
//   CollateralsDetails? collateralsDetails;
//   @JsonKey(name: "accommodationDetails")
//   AccommodationDetails? accommodationDetails;
//   @JsonKey(name: "propertyOwnerName")
//   dynamic propertyOwnerName;
//   @JsonKey(name: "relationWithApplicant")
//   String? relationWithApplicant;
//   @JsonKey(name: "villageName")
//   String? villageName;
//   @JsonKey(name: "gramPanchayat")
//   String? gramPanchayat;
//   @JsonKey(name: "patwariHalkaNo")
//   String? patwariHalkaNo;
//   @JsonKey(name: "state")
//   String? state;
//   @JsonKey(name: "district")
//   String? district;
//   @JsonKey(name: "tehsil")
//   String? tehsil;
//   @JsonKey(name: "houseNo")
//   String? houseNo;
//   @JsonKey(name: "wardNo")
//   String? wardNo;
//   @JsonKey(name: "surveyNo")
//   String? surveyNo;
//   @JsonKey(name: "TotalBuilUpArea")
//   String? totalBuilUpArea;
//   @JsonKey(name: "qualityOfConstruction")
//   String? qualityOfConstruction;
//   @JsonKey(name: "ageOfProperty")
//   String? ageOfProperty;
//   @JsonKey(name: "MaintenanceOfTheProperty")
//   String? maintenanceOfTheProperty;
//   @JsonKey(name: "ProjectedLifeYear")
//   String? projectedLifeYear;
//   @JsonKey(name: "typeOfContruction")
//   String? typeOfContruction;
//   @JsonKey(name: "landRatePerSQFT")
//   String? landRatePerSqft;
//   @JsonKey(name: "totalConstruction")
//   String? totalConstruction;
//   @JsonKey(name: "fatherName")
//   String? fatherName;
//   @JsonKey(name: "latitudeOfTheProrty")
//   String? latitudeOfTheProrty;
//   @JsonKey(name: "longitudeOfTheProrty")
//   String? longitudeOfTheProrty;
//   @JsonKey(name: "doorsAndWindowsAreAvailable")
//   String? doorsAndWindowsAreAvailable;
//   @JsonKey(name: "kitchenAndLatBathAvailable")
//   String? kitchenAndLatBathAvailable;
//   @JsonKey(name: "assetSeenAtResidence")
//   dynamic assetSeenAtResidence;
//
//   Property({
//     this.collateralsDetails,
//     this.accommodationDetails,
//     this.propertyOwnerName,
//     this.relationWithApplicant,
//     this.villageName,
//     this.gramPanchayat,
//     this.patwariHalkaNo,
//     this.state,
//     this.district,
//     this.tehsil,
//     this.houseNo,
//     this.wardNo,
//     this.surveyNo,
//     this.totalBuilUpArea,
//     this.qualityOfConstruction,
//     this.ageOfProperty,
//     this.maintenanceOfTheProperty,
//     this.projectedLifeYear,
//     this.typeOfContruction,
//     this.landRatePerSqft,
//     this.totalConstruction,
//     this.fatherName,
//     this.latitudeOfTheProrty,
//     this.longitudeOfTheProrty,
//     this.doorsAndWindowsAreAvailable,
//     this.kitchenAndLatBathAvailable,
//     this.assetSeenAtResidence,
//   });
//
//   factory Property.fromJson(Map<String, dynamic> json) => _$PropertyFromJson(json);
//
//   Map<String, dynamic> toJson() => _$PropertyToJson(this);
// }
//
// @JsonSerializable()
// class AccommodationDetails {
//   @JsonKey(name: "groundFloor")
//   String? groundFloor;
//   @JsonKey(name: "firstFloor")
//   String? firstFloor;
//   @JsonKey(name: "actualUsageOfProperty")
//   dynamic actualUsageOfProperty;
//   @JsonKey(name: "typeOfStructure")
//   String? typeOfStructure;
//   @JsonKey(name: "locationOfPlot")
//   String? locationOfPlot;
//   @JsonKey(name: "builtUpAreaSft")
//   String? builtUpAreaSft;
//   @JsonKey(name: "occupancy")
//   String? occupancy;
//   @JsonKey(name: "electricityAndGasConnection")
//   String? electricityAndGasConnection;
//   @JsonKey(name: "developmentOfSurroundingArea")
//   String? developmentOfSurroundingArea;
//
//   AccommodationDetails({
//     this.groundFloor,
//     this.firstFloor,
//     this.actualUsageOfProperty,
//     this.typeOfStructure,
//     this.locationOfPlot,
//     this.builtUpAreaSft,
//     this.occupancy,
//     this.electricityAndGasConnection,
//     this.developmentOfSurroundingArea,
//   });
//
//   factory AccommodationDetails.fromJson(Map<String, dynamic> json) => _$AccommodationDetailsFromJson(json);
//
//   Map<String, dynamic> toJson() => _$AccommodationDetailsToJson(this);
// }
//
// @JsonSerializable()
// class CollateralsDetails {
//   @JsonKey(name: "nameOfTheDocumentHolder")
//   String? nameOfTheDocumentHolder;
//   @JsonKey(name: "documentsProvided")
//   String? documentsProvided;
//   @JsonKey(name: "propertyAddress")
//   String? propertyAddress;
//   @JsonKey(name: "landmark")
//   String? landmark;
//   @JsonKey(name: "locationZone")
//   String? locationZone;
//   @JsonKey(name: "availabilityOfLocalTransport")
//   String? availabilityOfLocalTransport;
//   @JsonKey(name: "classOfLocality")
//   String? classOfLocality;
//   @JsonKey(name: "typeOfLocality")
//   String? typeOfLocality;
//   @JsonKey(name: "asPerSite")
//   dynamic asPerSite;
//   @JsonKey(name: "boundariesMatching")
//   String? boundariesMatching;
//   @JsonKey(name: "statusOfTheLandFlat")
//   String? statusOfTheLandFlat;
//   @JsonKey(name: "typeOfProperty")
//   String? typeOfProperty;
//   @JsonKey(name: "boundariesEast")
//   String? boundariesEast;
//   @JsonKey(name: "boundariesWest")
//   String? boundariesWest;
//   @JsonKey(name: "boundariesNorth")
//   String? boundariesNorth;
//   @JsonKey(name: "boundariesSouth")
//   String? boundariesSouth;
//
//   CollateralsDetails({
//     this.nameOfTheDocumentHolder,
//     this.documentsProvided,
//     this.propertyAddress,
//     this.landmark,
//     this.locationZone,
//     this.availabilityOfLocalTransport,
//     this.classOfLocality,
//     this.typeOfLocality,
//     this.asPerSite,
//     this.boundariesMatching,
//     this.statusOfTheLandFlat,
//     this.typeOfProperty,
//     this.boundariesEast,
//     this.boundariesWest,
//     this.boundariesNorth,
//     this.boundariesSouth,
//   });
//
//   factory CollateralsDetails.fromJson(Map<String, dynamic> json) => _$CollateralsDetailsFromJson(json);
//
//   Map<String, dynamic> toJson() => _$CollateralsDetailsToJson(this);
// }
//
// @JsonSerializable()
// class ReferenceDetail {
//   @JsonKey(name: "name")
//   String? name;
//   @JsonKey(name: "address")
//   String? address;
//   @JsonKey(name: "relation")
//   String? relation;
//   @JsonKey(name: "mobileNumber")
//   String? mobileNumber;
//   @JsonKey(name: "_id")
//   String? id;
//
//   ReferenceDetail({
//     this.name,
//     this.address,
//     this.relation,
//     this.mobileNumber,
//     this.id,
//   });
//
//   factory ReferenceDetail.fromJson(Map<String, dynamic> json) => _$ReferenceDetailFromJson(json);
//
//   Map<String, dynamic> toJson() => _$ReferenceDetailToJson(this);
// }
//
// @JsonSerializable()
// class SamagraDetail {
//   @JsonKey(name: "samagraFamilyIdNo")
//   String? samagraFamilyIdNo;
//   @JsonKey(name: "samagraIdHeadName")
//   String? samagraIdHeadName;
//
//   SamagraDetail({
//     this.samagraFamilyIdNo,
//     this.samagraIdHeadName,
//   });
//
//   factory SamagraDetail.fromJson(Map<String, dynamic> json) => _$SamagraDetailFromJson(json);
//
//   Map<String, dynamic> toJson() => _$SamagraDetailToJson(this);
// }
//
// @JsonSerializable()
// class Total {
//   @JsonKey(name: "totalPurchaseValue")
//   int? totalPurchaseValue;
//   @JsonKey(name: "totalMarketValue")
//   int? totalMarketValue;
//
//   Total({
//     this.totalPurchaseValue,
//     this.totalMarketValue,
//   });
//
//   factory Total.fromJson(Map<String, dynamic> json) => _$TotalFromJson(json);
//
//   Map<String, dynamic> toJson() => _$TotalToJson(this);
// }
//
// @JsonSerializable()
// class TotalIncomeDetails {
//   @JsonKey(name: "totalYearlyIncome")
//   String? totalYearlyIncome;
//   @JsonKey(name: "totalMonthlyIncome")
//   String? totalMonthlyIncome;
//   @JsonKey(name: "totalExpensesYearly")
//   String? totalExpensesYearly;
//   @JsonKey(name: "totalExpensesMonthly")
//   String? totalExpensesMonthly;
//
//   TotalIncomeDetails({
//     this.totalYearlyIncome,
//     this.totalMonthlyIncome,
//     this.totalExpensesYearly,
//     this.totalExpensesMonthly,
//   });
//
//   factory TotalIncomeDetails.fromJson(Map<String, dynamic> json) => _$TotalIncomeDetailsFromJson(json);
//
//   Map<String, dynamic> toJson() => _$TotalIncomeDetailsToJson(this);
// }
