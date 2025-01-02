// import 'package:json_annotation/json_annotation.dart';
// part 'pd_addreport_model.g.dart';

// @JsonSerializable()
// class PdAddReportResponseModel {
//   bool status;
//   int subCode;
//   String message;
//   String error;
//   Items items;

//   PdAddReportResponseModel({
//     required this.status,
//     required this.subCode,
//     required this.message,
//     required this.error,
//     required this.items,
//   });

//   factory PdAddReportResponseModel.fromJson(Map<String, dynamic> map) =>
//       _$PdAddReportResponseModelFromJson(map);

//   Map<String, dynamic> toJson() => _$PdAddReportResponseModelToJson(this);
// }

// @JsonSerializable()
// class Items {
//   Applicant applicant;
//   Applicant guarantor;
//   PoliceStation policeStation;
//   CibilAnalysis cibilAnalysis;
//   Property property;
//   BankDetail bankDetail;
//   Total total;
//   TotalIncomeDetails totalIncomeDetails;
//   ApproveLoanDetails approveLoanDetails;
//   SamagraDetail samagraDetail;
//   String id;
//   String customerId;
//   String pdId;
//   String pdType;
//   dynamic videoUpload;
//   String rejectReason;
//   String pendingReason;
//   String applicantImage;
//   String guarantorImage;
//   List<dynamic> coApplicantImage;
//   List<Applicant> coApplicant;
//   List<FamilyMember> familyMember;
//   List<IncomeSource> incomeSource;
//   List<ReferenceDetail> referenceDetails;
//   String landmarkPhoto;
//   String latLongPhoto;
//   List<dynamic> fourBoundaryPhotos;
//   List<dynamic> workPhotos;
//   List<dynamic> propertyOtherPhotos;
//   String selfiWithCustomer;
//   String photoWithLatLong;
//   String front;
//   String leftSide;
//   String rightSide;
//   String approachRoad;
//   String mainRoad;
//   String interiorRoad;
//   String selfieWithProperty;
//   String propertyPhoto;
//   List<AssetDetail> assetDetails;
//   String gasDiaryPhoto;
//   String sssmPhoto;
//   List<dynamic> familyMemberPhotos;
//   String otherDocUpload;
//   String residentType;
//   int residentCurrentSince;
//   String remarkByPd;
//   String status;
//   String approvalRemarkCreditPd;
//   String pdfLink;
//   String remarkMessage;
//   String bdCompleteDate;
//   DateTime createdAt;
//   DateTime updatedAt;
//   int v;

//   Items({
//     required this.applicant,
//     required this.guarantor,
//     required this.policeStation,
//     required this.cibilAnalysis,
//     required this.property,
//     required this.bankDetail,
//     required this.total,
//     required this.totalIncomeDetails,
//     required this.approveLoanDetails,
//     required this.samagraDetail,
//     required this.id,
//     required this.customerId,
//     required this.pdId,
//     required this.pdType,
//     required this.videoUpload,
//     required this.rejectReason,
//     required this.pendingReason,
//     required this.applicantImage,
//     required this.guarantorImage,
//     required this.coApplicantImage,
//     required this.coApplicant,
//     required this.familyMember,
//     required this.incomeSource,
//     required this.referenceDetails,
//     required this.landmarkPhoto,
//     required this.latLongPhoto,
//     required this.fourBoundaryPhotos,
//     required this.workPhotos,
//     required this.propertyOtherPhotos,
//     required this.selfiWithCustomer,
//     required this.photoWithLatLong,
//     required this.front,
//     required this.leftSide,
//     required this.rightSide,
//     required this.approachRoad,
//     required this.mainRoad,
//     required this.interiorRoad,
//     required this.selfieWithProperty,
//     required this.propertyPhoto,
//     required this.assetDetails,
//     required this.gasDiaryPhoto,
//     required this.sssmPhoto,
//     required this.familyMemberPhotos,
//     required this.otherDocUpload,
//     required this.residentType,
//     required this.residentCurrentSince,
//     required this.remarkByPd,
//     required this.status,
//     required this.approvalRemarkCreditPd,
//     required this.pdfLink,
//     required this.remarkMessage,
//     required this.bdCompleteDate,
//     required this.createdAt,
//     required this.updatedAt,
//     required this.v,
//   });

//   factory Items.fromJson(Map<String, dynamic> map) => _$ItemsFromJson(map);

//   Map<String, dynamic> toJson() => _$ItemsToJson(this);
// }

// @JsonSerializable()
// class Applicant {
//   String residenceType;
//   String? applicantType;
//   String businessType;
//   String occupation;
//   String dob;
//   String? email;
//   String houseLandMark;
//   String alternateMobileNo;
//   String noOfyearsAtCurrentAddress;
//   String gender;
//   String religion;
//   String nationality;
//   String category;
//   String caste;
//   String maritalStatus;
//   String? noOfDependentWithCustomer;
//   String educationalDetails;
//   String? coApplicantType;
//   String? emailId;
//   String? id;
//   String? guarantorType;

//   Applicant({
//     required this.residenceType,
//     this.applicantType,
//     required this.businessType,
//     required this.occupation,
//     required this.dob,
//     this.email,
//     required this.houseLandMark,
//     required this.alternateMobileNo,
//     required this.noOfyearsAtCurrentAddress,
//     required this.gender,
//     required this.religion,
//     required this.nationality,
//     required this.category,
//     required this.caste,
//     required this.maritalStatus,
//     this.noOfDependentWithCustomer,
//     required this.educationalDetails,
//     this.coApplicantType,
//     this.emailId,
//     this.id,
//     this.guarantorType,
//   });

//   factory Applicant.fromJson(Map<String, dynamic> map) =>
//       _$ApplicantFromJson(map);

//   Map<String, dynamic> toJson() => _$ApplicantToJson(this);
// }

// @JsonSerializable()
// class PoliceStation {
//   String staionName;
//   String stationAdress;

//   PoliceStation({
//     required this.staionName,
//     required this.stationAdress,
//   });

//    factory PoliceStation.fromJson(Map<String, dynamic> map) => _$PoliceStationFromJson(map);
//   Map<String, dynamic> toJson() => _$PoliceStationToJson(this);
// }

// @JsonSerializable()
// class ApproveLoanDetails {
//   int approvedAmount;
//   int roi;
//   int tenure;
//   int emi;
//   String demandLoanAmountByCustomer;
//   dynamic finalDecision;
//   String endUseOfLoan;

//   ApproveLoanDetails({
//     required this.approvedAmount,
//     required this.roi,
//     required this.tenure,
//     required this.emi,
//     required this.demandLoanAmountByCustomer,
//     required this.finalDecision,
//     required this.endUseOfLoan,
//   });

//   factory ApproveLoanDetails.fromJson(Map<String, dynamic> map) =>
//       _$ApproveLoanDetailsFromJson(map);

//   Map<String, dynamic> toJson() => _$ApproveLoanDetailsToJson(this);
// }

// @JsonSerializable()
// class AssetDetail {
//   String name;
//   String purchaseValue;
//   String marketValue;
//   String id;

//   AssetDetail({
//     required this.name,
//     required this.purchaseValue,
//     required this.marketValue,
//     required this.id,
//   });
//   factory AssetDetail.fromJson(Map<String, dynamic> map) =>
//       _$AssetDetailFromJson(map);

//   Map<String, dynamic> toJson() => _$AssetDetailToJson(this);
// }

// @JsonSerializable()
// class BankDetail {
//   String nameOfBank;
//   String branchName;
//   String accountNo;
//   String accountHolderName;
//   String accountType;
//   String ifscCode;

//   BankDetail({
//     required this.nameOfBank,
//     required this.branchName,
//     required this.accountNo,
//     required this.accountHolderName,
//     required this.accountType,
//     required this.ifscCode,
//   });
//   factory BankDetail.fromJson(Map<String, dynamic> map) =>
//       _$BankDetailFromJson(map);

//   Map<String, dynamic> toJson() => _$BankDetailToJson(this);
// }

// @JsonSerializable()
// class CibilAnalysis {
//   String totalLoans;
//   String detailsOfCurrentLoans;
//   String reasonforDpd;

//   CibilAnalysis({
//     required this.totalLoans,
//     required this.detailsOfCurrentLoans,
//     required this.reasonforDpd,
//   });

//    factory CibilAnalysis.fromJson(Map<String, dynamic> map) => _$CibilAnalysisFromJson(map);

//   Map<String, dynamic> toJson() => _$CibilAnalysisToJson(this);
// }

// @JsonSerializable()
// class FamilyMember {
//   OccupationTypeDetails occupationTypeDetails;
//   String name;
//   int age;
//   String relation;
//   String dependent;
//   String id;

//   FamilyMember({
//     required this.occupationTypeDetails,
//     required this.name,
//     required this.age,
//     required this.relation,
//     required this.dependent,
//     required this.id,
//   });

//    factory FamilyMember.fromJson(Map<String, dynamic> map) => _$FamilyMemberFromJson(map);

//   Map<String, dynamic> toJson() => _$FamilyMemberToJson(this);
// }

// @JsonSerializable()
// class OccupationTypeDetails {
//   String institutionName;
//   String nameOfOrganization;
//   String designation;
//   String dateOfJoining;

//   OccupationTypeDetails({
//     required this.institutionName,
//     required this.nameOfOrganization,
//     required this.designation,
//     required this.dateOfJoining,
//   });

//    factory OccupationTypeDetails.fromJson(Map<String, dynamic> map) => _$OccupationTypeDetailsFromJson(map);

//   Map<String, dynamic> toJson() => _$OccupationTypeDetailsToJson(this);
// }

// @JsonSerializable()
// class IncomeSource {
//   AgricultureBusiness agricultureBusiness;
//   MilkBusiness milkBusiness;
//   SalaryIncome salaryIncome;
//   Other other;
//   String incomeSourceType;
//   String id;

//   IncomeSource({
//     required this.agricultureBusiness,
//     required this.milkBusiness,
//     required this.salaryIncome,
//     required this.other,
//     required this.incomeSourceType,
//     required this.id,
//   });

//   factory IncomeSource.fromJson(Map<String, dynamic> map) => _$IncomeSourceFromJson(map);
//   Map<String, dynamic> toJson() => _$IncomeSourceToJson(this);
// }

// @JsonSerializable()
// class AgricultureBusiness {
//   String haveYouFaced;
//   List<dynamic> nameOfAgriOwner;
//   String relationOfApplicant;
//   String kasraSurveyNo;
//   String agriLandInBigha;
//   String otherName;
//   String otherRelation;
//   String otherRemark;
//   String villageName;
//   String detailOfLastCorp;
//   String howmuchcorpsoldInAmt;
//   List<dynamic> agriculturePhotos;
//   List<dynamic> whichCropIsPlanted;
//   String agriDoingFromNoOfYears;
//   String addressAsPerPawti;
//   String districtName;
//   String agriLandSurveyNo;
//   String fertilizerShopOwnerName;
//   String fertilizerShopOwnerContactNumber;
//   String whatTypeOfIrrigationMethod;
//   String significantChallengesThisSeason;
//   String agriIncomeYearly;
//   String ifCropDestroyedHowToPayEmi;

//   AgricultureBusiness({
//     required this.haveYouFaced,
//     required this.nameOfAgriOwner,
//     required this.relationOfApplicant,
//     required this.kasraSurveyNo,
//     required this.agriLandInBigha,
//     required this.otherName,
//     required this.otherRelation,
//     required this.otherRemark,
//     required this.villageName,
//     required this.detailOfLastCorp,
//     required this.howmuchcorpsoldInAmt,
//     required this.agriculturePhotos,
//     required this.whichCropIsPlanted,
//     required this.agriDoingFromNoOfYears,
//     required this.addressAsPerPawti,
//     required this.districtName,
//     required this.agriLandSurveyNo,
//     required this.fertilizerShopOwnerName,
//     required this.fertilizerShopOwnerContactNumber,
//     required this.whatTypeOfIrrigationMethod,
//     required this.significantChallengesThisSeason,
//     required this.agriIncomeYearly,
//     required this.ifCropDestroyedHowToPayEmi,
//   });

//    factory AgricultureBusiness.fromJson(Map<String, dynamic> map) => _$AgricultureBusinessFromJson(map);
//   Map<String, dynamic> toJson() => _$AgricultureBusinessToJson(this);
// }

// @JsonSerializable()
// class MilkBusiness {
//   String numberOfCattrels;
//   String noOfMilkGivingCattles;
//   String doingFromNoOfYears;
//   String totalMilkSupplyPerDay;
//   String nameOfDairy;
//   String dairyOwnerMobNo;
//   String dairyAddress;
//   String milkprovideFromSinceYear;
//   String expensesOfMilkBusiness;
//   String monthlyIncomeMilkBusiness;
//   List<dynamic> milkPhotos;
//   List<dynamic> animalPhotos;
//   String currentMilkUtilization;
//   List<dynamic> breedOfCattles;
//   String ifCropDestroyedHowToPayEmi;
//   String observedDesignatedCattleTyingArea;

//   MilkBusiness({
//     required this.numberOfCattrels,
//     required this.noOfMilkGivingCattles,
//     required this.doingFromNoOfYears,
//     required this.totalMilkSupplyPerDay,
//     required this.nameOfDairy,
//     required this.dairyOwnerMobNo,
//     required this.dairyAddress,
//     required this.milkprovideFromSinceYear,
//     required this.expensesOfMilkBusiness,
//     required this.monthlyIncomeMilkBusiness,
//     required this.milkPhotos,
//     required this.animalPhotos,
//     required this.currentMilkUtilization,
//     required this.breedOfCattles,
//     required this.ifCropDestroyedHowToPayEmi,
//     required this.observedDesignatedCattleTyingArea,
//   });

//   factory MilkBusiness.fromJson(Map<String, dynamic> map) => _$MilkBusinessFromJson(map);
//   Map<String, dynamic> toJson() => _$MilkBusinessToJson(this);
// }

// @JsonSerializable()
// class Other {
//   String bussinessFromSinceYear;
//   String natureOfBusiness;
//   int monthlyIncome;
//   int yearlyIncome;
//   String discriptionOfBusiness;
//   List<dynamic> incomeOtherImages;

//   Other({
//     required this.bussinessFromSinceYear,
//     required this.natureOfBusiness,
//     required this.monthlyIncome,
//     required this.yearlyIncome,
//     required this.discriptionOfBusiness,
//     required this.incomeOtherImages,
//   });

//   factory Other.fromJson(Map<String, dynamic> map) => _$OtherFromJson(map);
//   Map<String, dynamic> toJson() => _$OtherToJson(this);
// }

// @JsonSerializable()
// class SalaryIncome {
//   String numberOfCattrels;
//   String companyName;
//   String addressOfSalaryProvider;
//   String mobNoOfSalaryProvider;
//   String doingFromNoYears;
//   String salaryPaidThrouch;
//   String monthlyNetSalary;
//   String salaryCredited6Month;
//   List<dynamic> last3MonthSalarySlipPhotos;
//   String bankStatementPhoto;
//   List<dynamic> salaryPhotos;

//   SalaryIncome({
//     required this.numberOfCattrels,
//     required this.companyName,
//     required this.addressOfSalaryProvider,
//     required this.mobNoOfSalaryProvider,
//     required this.doingFromNoYears,
//     required this.salaryPaidThrouch,
//     required this.monthlyNetSalary,
//     required this.salaryCredited6Month,
//     required this.last3MonthSalarySlipPhotos,
//     required this.bankStatementPhoto,
//     required this.salaryPhotos,
//   });

//  factory SalaryIncome.fromJson(Map<String, dynamic> map) => _$SalaryIncomeFromJson(map);
//   Map<String, dynamic> toJson() => _$SalaryIncomeToJson(this);
// }



// @JsonSerializable()
// class Property {
//   CollateralsDetails collateralsDetails;
//   AccommodationDetails accommodationDetails;
//   String fatherName;
//   String latitudeOfTheProrty;
//   String longitudeOfTheProrty;
//   String totalBuilUpArea;
//   String qualityOfConstruction;
//   String ageOfProperty;
//   String maintenanceOfTheProperty;
//   String projectedLifeYear;
//   String kitchenAndLatBathAvailable;
//   String doorsAndWindowsAreAvailable;
//   String propertyOwnerName;
//   String relationWithApplicant;
//   String villageName;
//   String gramPanchayat;
//   String patwariHalkaNo;
//   String state;
//   String district;
//   String tehsil;
//   String houseNo;
//   String wardNo;
//   String surveyNo;
//   List<dynamic> assetSeenAtResidence;
//   String typeOfContruction;
//   String landRatePerSqft;
//   String totalConstruction;

//   Property({
//     required this.collateralsDetails,
//     required this.accommodationDetails,
//     required this.fatherName,
//     required this.latitudeOfTheProrty,
//     required this.longitudeOfTheProrty,
//     required this.totalBuilUpArea,
//     required this.qualityOfConstruction,
//     required this.ageOfProperty,
//     required this.maintenanceOfTheProperty,
//     required this.projectedLifeYear,
//     required this.kitchenAndLatBathAvailable,
//     required this.doorsAndWindowsAreAvailable,
//     required this.propertyOwnerName,
//     required this.relationWithApplicant,
//     required this.villageName,
//     required this.gramPanchayat,
//     required this.patwariHalkaNo,
//     required this.state,
//     required this.district,
//     required this.tehsil,
//     required this.houseNo,
//     required this.wardNo,
//     required this.surveyNo,
//     required this.assetSeenAtResidence,
//     required this.typeOfContruction,
//     required this.landRatePerSqft,
//     required this.totalConstruction,
//   });

//    factory Property.fromJson(Map<String, dynamic> map) => _$PropertyFromJson(map);
//   Map<String, dynamic> toJson() => _$PropertyToJson(this);
// }

// @JsonSerializable()
// class AccommodationDetails {
//   String groundFloor;
//   String firstFloor;
//   String actualUsageOfProperty;
//   String typeOfStructure;
//   String locationOfPlot;
//   String builtUpAreaSft;
//   String occupancy;
//   String electricityAndGasConnection;
//   String developmentOfSurroundingArea;

//   AccommodationDetails({
//     required this.groundFloor,
//     required this.firstFloor,
//     required this.actualUsageOfProperty,
//     required this.typeOfStructure,
//     required this.locationOfPlot,
//     required this.builtUpAreaSft,
//     required this.occupancy,
//     required this.electricityAndGasConnection,
//     required this.developmentOfSurroundingArea,
//   });
//    factory AccommodationDetails.fromJson(Map<String, dynamic> map) => _$AccommodationDetailsFromJson(map);
//   Map<String, dynamic> toJson() => _$AccommodationDetailsToJson(this);
// }

// @JsonSerializable()
// class CollateralsDetails {
//   String nameOfTheDocumentHolder;
//   String documentsProvided;
//   String propertyAddress;
//   String landmark;
//   String locationZone;
//   String availabilityOfLocalTransport;
//   String classOfLocality;
//   String typeOfLocality;
//   String asPerSite;
//   String boundariesMatching;
//   String statusOfTheLandFlat;
//   String typeOfProperty;
//   String boundariesEast;
//   String boundariesWest;
//   String boundariesNorth;
//   String boundariesSouth;

//   CollateralsDetails({
//     required this.nameOfTheDocumentHolder,
//     required this.documentsProvided,
//     required this.propertyAddress,
//     required this.landmark,
//     required this.locationZone,
//     required this.availabilityOfLocalTransport,
//     required this.classOfLocality,
//     required this.typeOfLocality,
//     required this.asPerSite,
//     required this.boundariesMatching,
//     required this.statusOfTheLandFlat,
//     required this.typeOfProperty,
//     required this.boundariesEast,
//     required this.boundariesWest,
//     required this.boundariesNorth,
//     required this.boundariesSouth,
//   });

//   factory CollateralsDetails.fromJson(Map<String, dynamic> map) => _$CollateralsDetailsFromJson(map);
//   Map<String, dynamic> toJson() => _$CollateralsDetailsToJson(this);
// }

// @JsonSerializable()
// class ReferenceDetail {
//   String name;
//   String address;
//   String relation;
//   String mobileNumber;
//   String id;

//   ReferenceDetail({
//     required this.name,
//     required this.address,
//     required this.relation,
//     required this.mobileNumber,
//     required this.id,
//   });

//   factory ReferenceDetail.fromJson(Map<String, dynamic> map) => _$ReferenceDetailFromJson(map);
//   Map<String, dynamic> toJson() => _$ReferenceDetailToJson(this);
// }

// @JsonSerializable()
// class SamagraDetail {
//   String samagraFamilyIdNo;
//   String samagraIdHeadName;

//   SamagraDetail({
//     required this.samagraFamilyIdNo,
//     required this.samagraIdHeadName,
//   });

//    factory SamagraDetail.fromJson(Map<String, dynamic> map) => _$SamagraDetailFromJson(map);
//   Map<String, dynamic> toJson() => _$SamagraDetailToJson(this);
// }

// @JsonSerializable()
// class Total {
//   int totalPurchaseValue;
//   int totalMarketValue;

//   Total({
//     required this.totalPurchaseValue,
//     required this.totalMarketValue,
//   });
//   factory Total.fromJson(Map<String, dynamic> map) => _$TotalFromJson(map);
//   Map<String, dynamic> toJson() => _$TotalToJson(this);
// }

// @JsonSerializable()
// class TotalIncomeDetails {
//   String totalYearlyIncome;
//   String totalMonthlyIncome;
//   String totalExpensesYearly;
//   String totalExpensesMonthly;

//   TotalIncomeDetails({
//     required this.totalYearlyIncome,
//     required this.totalMonthlyIncome,
//     required this.totalExpensesYearly,
//     required this.totalExpensesMonthly,
//   });
//     factory TotalIncomeDetails.fromJson(Map<String, dynamic> map) => _$TotalIncomeDetailsFromJson(map);
//   Map<String, dynamic> toJson() => _$TotalIncomeDetailsToJson(this);
// }
