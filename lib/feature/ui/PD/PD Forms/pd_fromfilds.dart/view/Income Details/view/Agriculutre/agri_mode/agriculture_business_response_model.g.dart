// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'agriculture_business_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AgricultureBusinessResponseModel _$AgricultureBusinessResponseModelFromJson(
        Map<String, dynamic> json) =>
    AgricultureBusinessResponseModel(
      status: json['status'] as bool?,
      subCode: (json['subCode'] as num?)?.toInt(),
      message: json['message'] as String?,
      error: json['error'] as String?,
      items: json['items'] == null
          ? null
          : Items.fromJson(json['items'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$AgricultureBusinessResponseModelToJson(
        AgricultureBusinessResponseModel instance) =>
    <String, dynamic>{
      'status': instance.status,
      'subCode': instance.subCode,
      'message': instance.message,
      'error': instance.error,
      'items': instance.items,
    };

Items _$ItemsFromJson(Map<String, dynamic> json) => Items(
      applicant: json['applicant'] == null
          ? null
          : Applicant.fromJson(json['applicant'] as Map<String, dynamic>),
      guarantor: json['guarantor'] == null
          ? null
          : Guarantor.fromJson(json['guarantor'] as Map<String, dynamic>),
      policeStation: json['policeStation'] == null
          ? null
          : PoliceStation.fromJson(
              json['policeStation'] as Map<String, dynamic>),
      cibilAnalysis: json['cibilAnalysis'] == null
          ? null
          : CibilAnalysis.fromJson(
              json['cibilAnalysis'] as Map<String, dynamic>),
      property: json['property'] == null
          ? null
          : Property.fromJson(json['property'] as Map<String, dynamic>),
      bankDetail: json['bankDetail'] == null
          ? null
          : BankDetail.fromJson(json['bankDetail'] as Map<String, dynamic>),
      total: json['total'] == null
          ? null
          : Total.fromJson(json['total'] as Map<String, dynamic>),
      totalIncomeDetails: json['totalIncomeDetails'] == null
          ? null
          : TotalIncomeDetails.fromJson(
              json['totalIncomeDetails'] as Map<String, dynamic>),
      approveLoanDetails: json['approveLoanDetails'] == null
          ? null
          : ApproveLoanDetails.fromJson(
              json['approveLoanDetails'] as Map<String, dynamic>),
      samagraDetail: json['samagraDetail'] == null
          ? null
          : SamagraDetail.fromJson(
              json['samagraDetail'] as Map<String, dynamic>),
      pdfLink: json['pdfLink'] as String?,
      id: json['_id'] as String?,
      customerId: json['customerId'] as String?,
      pdId: json['pdId'] as String?,
      coApplicantImage: (json['coApplicantImage'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      coApplicant: (json['co_Applicant'] as List<dynamic>?)
          ?.map((e) => CoApplicant.fromJson(e as Map<String, dynamic>))
          .toList(),
      familyMember: (json['familyMember'] as List<dynamic>?)
          ?.map((e) => FamilyMember.fromJson(e as Map<String, dynamic>))
          .toList(),
      incomeSource: (json['incomeSource'] as List<dynamic>?)
          ?.map((e) => IncomeSource.fromJson(e as Map<String, dynamic>))
          .toList(),
      referenceDetails: (json['referenceDetails'] as List<dynamic>?)
          ?.map((e) => ReferenceDetail.fromJson(e as Map<String, dynamic>))
          .toList(),
      fourBoundaryPhotos: (json['fourBoundaryPhotos'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      workPhotos: (json['workPhotos'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      propertyOtherPhotos: (json['propertyOtherPhotos'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      assetDetails: (json['assetDetails'] as List<dynamic>?)
          ?.map((e) => AssetDetail.fromJson(e as Map<String, dynamic>))
          .toList(),
      familyMemberPhotos: (json['familyMemberPhotos'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      otherDocUpload: json['otherDocUpload'] as String?,
      remarkByPd: json['remarkByPd'] as String?,
      status: json['status'] as String?,
      remarkMessage: json['remarkMessage'] as String?,
      pdType: json['pdType'] as String?,
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      updatedAt: json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
      v: (json['__v'] as num?)?.toInt(),
      approvalRemarkCreditPd: json['approvalRemarkCreditPd'] as String?,
      applicantImage: json['applicantImage'] as String?,
      guarantorImage: json['guarantorImage'] as String?,
      landmarkPhoto: json['landmarkPhoto'] as String?,
      latLongPhoto: json['latLongPhoto'] as String?,
      videoUpload: json['videoUpload'] as String?,
      bdCompleteDate: json['bdCompleteDate'] as String?,
      sssmPhoto: json['SSSMPhoto'] as String?,
      gasDiaryPhoto: json['gasDiaryPhoto'] as String?,
      approachRoad: json['approachRoad'] as String?,
      front: json['front'] as String?,
      interiorRoad: json['interiorRoad'] as String?,
      leftSide: json['leftSide'] as String?,
      mainRoad: json['mainRoad'] as String?,
      photoWithLatLong: json['photoWithLatLong'] as String?,
      rightSide: json['rightSide'] as String?,
      selfiWithCustomer: json['selfiWithCustomer'] as String?,
      pendingReason: json['pendingReason'] as String?,
      propertyPhoto: json['propertyPhoto'] as String?,
      rejectReason: json['rejectReason'] as String?,
      residentCurrentSince: (json['residentCurrentSince'] as num?)?.toInt(),
      residentType: json['residentType'] as String?,
      selfieWithProperty: json['selfieWithProperty'] as String?,
    );

Map<String, dynamic> _$ItemsToJson(Items instance) => <String, dynamic>{
      'applicant': instance.applicant,
      'guarantor': instance.guarantor,
      'policeStation': instance.policeStation,
      'cibilAnalysis': instance.cibilAnalysis,
      'property': instance.property,
      'bankDetail': instance.bankDetail,
      'total': instance.total,
      'totalIncomeDetails': instance.totalIncomeDetails,
      'approveLoanDetails': instance.approveLoanDetails,
      'samagraDetail': instance.samagraDetail,
      'pdfLink': instance.pdfLink,
      '_id': instance.id,
      'customerId': instance.customerId,
      'pdId': instance.pdId,
      'coApplicantImage': instance.coApplicantImage,
      'co_Applicant': instance.coApplicant,
      'familyMember': instance.familyMember,
      'incomeSource': instance.incomeSource,
      'referenceDetails': instance.referenceDetails,
      'fourBoundaryPhotos': instance.fourBoundaryPhotos,
      'workPhotos': instance.workPhotos,
      'propertyOtherPhotos': instance.propertyOtherPhotos,
      'assetDetails': instance.assetDetails,
      'familyMemberPhotos': instance.familyMemberPhotos,
      'otherDocUpload': instance.otherDocUpload,
      'remarkByPd': instance.remarkByPd,
      'status': instance.status,
      'remarkMessage': instance.remarkMessage,
      'pdType': instance.pdType,
      'createdAt': instance.createdAt?.toIso8601String(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
      '__v': instance.v,
      'approvalRemarkCreditPd': instance.approvalRemarkCreditPd,
      'applicantImage': instance.applicantImage,
      'guarantorImage': instance.guarantorImage,
      'landmarkPhoto': instance.landmarkPhoto,
      'latLongPhoto': instance.latLongPhoto,
      'videoUpload': instance.videoUpload,
      'bdCompleteDate': instance.bdCompleteDate,
      'SSSMPhoto': instance.sssmPhoto,
      'gasDiaryPhoto': instance.gasDiaryPhoto,
      'approachRoad': instance.approachRoad,
      'front': instance.front,
      'interiorRoad': instance.interiorRoad,
      'leftSide': instance.leftSide,
      'mainRoad': instance.mainRoad,
      'photoWithLatLong': instance.photoWithLatLong,
      'rightSide': instance.rightSide,
      'selfiWithCustomer': instance.selfiWithCustomer,
      'pendingReason': instance.pendingReason,
      'propertyPhoto': instance.propertyPhoto,
      'rejectReason': instance.rejectReason,
      'residentCurrentSince': instance.residentCurrentSince,
      'residentType': instance.residentType,
      'selfieWithProperty': instance.selfieWithProperty,
    };

Applicant _$ApplicantFromJson(Map<String, dynamic> json) => Applicant(
      applicantType: json['applicantType'] as String?,
      businessType: json['businessType'] as String?,
      occupation: json['occupation'] as String?,
      dob: json['DOB'],
      email: json['email'] as String?,
      houseLandMark: json['houseLandMark'] as String?,
      alternateMobileNo: json['alternateMobileNo'] as String?,
      noOfyearsAtCurrentAddress: json['noOfyearsAtCurrentAddress'] as String?,
      gender: json['gender'],
      religion: json['religion'] as String?,
      nationality: json['nationality'] as String?,
      category: json['category'] as String?,
      caste: json['caste'] as String?,
      maritalStatus: json['maritalStatus'],
      noOfDependentWithCustomer: json['noOfDependentWithCustomer'] as String?,
      educationalDetails: json['educationalDetails'] as String?,
      residenceType: json['residenceType'] as String?,
    );

Map<String, dynamic> _$ApplicantToJson(Applicant instance) => <String, dynamic>{
      'applicantType': instance.applicantType,
      'businessType': instance.businessType,
      'occupation': instance.occupation,
      'DOB': instance.dob,
      'email': instance.email,
      'houseLandMark': instance.houseLandMark,
      'alternateMobileNo': instance.alternateMobileNo,
      'noOfyearsAtCurrentAddress': instance.noOfyearsAtCurrentAddress,
      'gender': instance.gender,
      'religion': instance.religion,
      'nationality': instance.nationality,
      'category': instance.category,
      'caste': instance.caste,
      'maritalStatus': instance.maritalStatus,
      'noOfDependentWithCustomer': instance.noOfDependentWithCustomer,
      'educationalDetails': instance.educationalDetails,
      'residenceType': instance.residenceType,
    };

ApproveLoanDetails _$ApproveLoanDetailsFromJson(Map<String, dynamic> json) =>
    ApproveLoanDetails(
      approvedAmount: (json['approvedAmount'] as num?)?.toInt(),
      roi: (json['ROI'] as num?)?.toDouble(),
      tenure: (json['Tenure'] as num?)?.toInt(),
      emi: (json['EMI'] as num?)?.toInt(),
      demandLoanAmountByCustomer: json['demandLoanAmountByCustomer'] as String?,
      finalDecision: (json['finalDecision'] as num?)?.toInt(),
      endUseOfLoan: json['endUseOfLoan'] as String?,
    );

Map<String, dynamic> _$ApproveLoanDetailsToJson(ApproveLoanDetails instance) =>
    <String, dynamic>{
      'approvedAmount': instance.approvedAmount,
      'ROI': instance.roi,
      'Tenure': instance.tenure,
      'EMI': instance.emi,
      'demandLoanAmountByCustomer': instance.demandLoanAmountByCustomer,
      'finalDecision': instance.finalDecision,
      'endUseOfLoan': instance.endUseOfLoan,
    };

AssetDetail _$AssetDetailFromJson(Map<String, dynamic> json) => AssetDetail(
      name: json['name'] as String?,
      purchaseValue: json['purchaseValue'] as String?,
      marketValue: json['marketValue'] as String?,
      id: json['_id'] as String?,
    );

Map<String, dynamic> _$AssetDetailToJson(AssetDetail instance) =>
    <String, dynamic>{
      'name': instance.name,
      'purchaseValue': instance.purchaseValue,
      'marketValue': instance.marketValue,
      '_id': instance.id,
    };

BankDetail _$BankDetailFromJson(Map<String, dynamic> json) => BankDetail(
      nameOfBank: json['nameOfBank'] as String?,
      branchName: json['branchName'] as String?,
      accountNo: json['accountNo'] as String?,
      accountType: json['accountType'] as String?,
      ifscCode: json['IFSCCode'] as String?,
      accountHolderName: json['accountHolderName'] as String?,
    );

Map<String, dynamic> _$BankDetailToJson(BankDetail instance) =>
    <String, dynamic>{
      'nameOfBank': instance.nameOfBank,
      'branchName': instance.branchName,
      'accountNo': instance.accountNo,
      'accountType': instance.accountType,
      'IFSCCode': instance.ifscCode,
      'accountHolderName': instance.accountHolderName,
    };

CibilAnalysis _$CibilAnalysisFromJson(Map<String, dynamic> json) =>
    CibilAnalysis(
      totalLoans: json['TotalLoans'] as String?,
      detailsOfCurrentLoans: json['detailsOfCurrentLoans'] as String?,
      reasonforDpd: json['reasonforDPD'] as String?,
    );

Map<String, dynamic> _$CibilAnalysisToJson(CibilAnalysis instance) =>
    <String, dynamic>{
      'TotalLoans': instance.totalLoans,
      'detailsOfCurrentLoans': instance.detailsOfCurrentLoans,
      'reasonforDPD': instance.reasonforDpd,
    };

CoApplicant _$CoApplicantFromJson(Map<String, dynamic> json) => CoApplicant(
      coApplicantType: json['coApplicantType'] as String?,
      businessType: json['businessType'] as String?,
      occupation: json['occupation'] as String?,
      dob: json['DOB'],
      emailId: json['emailId'],
      houseLandMark: json['houseLandMark'] as String?,
      alternateMobileNo: json['alternateMobileNo'] as String?,
      noOfyearsAtCurrentAddress: json['noOfyearsAtCurrentAddress'],
      gender: json['gender'],
      religion: json['religion'] as String?,
      nationality: json['nationality'] as String?,
      category: json['category'] as String?,
      caste: json['caste'] as String?,
      maritalStatus: json['maritalStatus'],
      educationalDetails: json['educationalDetails'] as String?,
      residenceType: json['residenceType'] as String?,
      id: json['_id'],
    );

Map<String, dynamic> _$CoApplicantToJson(CoApplicant instance) =>
    <String, dynamic>{
      'coApplicantType': instance.coApplicantType,
      'businessType': instance.businessType,
      'occupation': instance.occupation,
      'DOB': instance.dob,
      'emailId': instance.emailId,
      'houseLandMark': instance.houseLandMark,
      'alternateMobileNo': instance.alternateMobileNo,
      'noOfyearsAtCurrentAddress': instance.noOfyearsAtCurrentAddress,
      'gender': instance.gender,
      'religion': instance.religion,
      'nationality': instance.nationality,
      'category': instance.category,
      'caste': instance.caste,
      'maritalStatus': instance.maritalStatus,
      'educationalDetails': instance.educationalDetails,
      'residenceType': instance.residenceType,
      '_id': instance.id,
    };

FamilyMember _$FamilyMemberFromJson(Map<String, dynamic> json) => FamilyMember(
      occupationTypeDetails: json['occupationTypeDetails'] == null
          ? null
          : OccupationTypeDetails.fromJson(
              json['occupationTypeDetails'] as Map<String, dynamic>),
      name: json['name'] as String?,
      age: (json['age'] as num?)?.toInt(),
      relation: json['relation'] as String?,
      dependent: json['dependent'] as String?,
      id: json['_id'] as String?,
    );

Map<String, dynamic> _$FamilyMemberToJson(FamilyMember instance) =>
    <String, dynamic>{
      'occupationTypeDetails': instance.occupationTypeDetails,
      'name': instance.name,
      'age': instance.age,
      'relation': instance.relation,
      'dependent': instance.dependent,
      '_id': instance.id,
    };

OccupationTypeDetails _$OccupationTypeDetailsFromJson(
        Map<String, dynamic> json) =>
    OccupationTypeDetails(
      institutionName: json['institutionName'] as String?,
      nameOfOrganization: json['nameOfOrganization'] as String?,
      designation: json['designation'] as String?,
      dateOfJoining: json['dateOfJoining'] as String?,
    );

Map<String, dynamic> _$OccupationTypeDetailsToJson(
        OccupationTypeDetails instance) =>
    <String, dynamic>{
      'institutionName': instance.institutionName,
      'nameOfOrganization': instance.nameOfOrganization,
      'designation': instance.designation,
      'dateOfJoining': instance.dateOfJoining,
    };

Guarantor _$GuarantorFromJson(Map<String, dynamic> json) => Guarantor(
      guarantorType: json['guarantorType'] as String?,
      businessType: json['businessType'] as String?,
      occupation: json['occupation'] as String?,
      residenceType: json['residenceType'] as String?,
      dob: json['DOB'],
      emailId: json['emailId'] as String?,
      houseLandMark: json['houseLandMark'] as String?,
      alternateMobileNo: json['alternateMobileNo'] as String?,
      noOfyearsAtCurrentAddress: json['noOfyearsAtCurrentAddress'] as String?,
      gender: json['gender'],
      religion: json['religion'] as String?,
      nationality: json['nationality'] as String?,
      category: json['category'] as String?,
      caste: json['caste'] as String?,
      maritalStatus: json['maritalStatus'],
      educationalDetails: json['educationalDetails'] as String?,
    );

Map<String, dynamic> _$GuarantorToJson(Guarantor instance) => <String, dynamic>{
      'guarantorType': instance.guarantorType,
      'businessType': instance.businessType,
      'occupation': instance.occupation,
      'residenceType': instance.residenceType,
      'DOB': instance.dob,
      'emailId': instance.emailId,
      'houseLandMark': instance.houseLandMark,
      'alternateMobileNo': instance.alternateMobileNo,
      'noOfyearsAtCurrentAddress': instance.noOfyearsAtCurrentAddress,
      'gender': instance.gender,
      'religion': instance.religion,
      'nationality': instance.nationality,
      'category': instance.category,
      'caste': instance.caste,
      'maritalStatus': instance.maritalStatus,
      'educationalDetails': instance.educationalDetails,
    };

IncomeSource _$IncomeSourceFromJson(Map<String, dynamic> json) => IncomeSource(
      agricultureBusiness: json['agricultureBusiness'] == null
          ? null
          : AgricultureBusiness.fromJson(
              json['agricultureBusiness'] as Map<String, dynamic>),
      milkBusiness: json['milkBusiness'] == null
          ? null
          : MilkBusiness.fromJson(json['milkBusiness'] as Map<String, dynamic>),
      salaryIncome: json['salaryIncome'] == null
          ? null
          : SalaryIncome.fromJson(json['salaryIncome'] as Map<String, dynamic>),
      other: json['other'] == null
          ? null
          : Other.fromJson(json['other'] as Map<String, dynamic>),
      incomeSourceType: json['incomeSourceType'] as String?,
      id: json['_id'] as String?,
    );

Map<String, dynamic> _$IncomeSourceToJson(IncomeSource instance) =>
    <String, dynamic>{
      'agricultureBusiness': instance.agricultureBusiness,
      'milkBusiness': instance.milkBusiness,
      'salaryIncome': instance.salaryIncome,
      'other': instance.other,
      'incomeSourceType': instance.incomeSourceType,
      '_id': instance.id,
    };

AgricultureBusiness _$AgricultureBusinessFromJson(Map<String, dynamic> json) =>
    AgricultureBusiness(
      haveYouFaced: json['haveYouFaced'] as String?,
      nameOfAgriOwner: (json['nameOfAgriOwner'] as List<String>?)
          ?.map((e) => e as String)
          .toList(),
      relationOfApplicant: json['relationOfApplicant'] as String?,
      kasraSurveyNo: json['kasraSurveyNo'] as String?,
      agriLandInBigha: json['agriLandInBigha'] as String?,
      otherName: json['otherName'] as String?,
      otherRelation: json['otherRelation'] as String?,
      otherRemark: json['otherRemark'] as String?,
      villageName: json['villageName'] as String?,
      detailOfLastCorp: json['detailOfLastCorp'] as String?,
      howmuchcorpsoldInAmt: json['howmuchcorpsoldInAmt'] as String?,
      agriculturePhotos: (json['agriculturePhotos'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      whichCropIsPlanted: (json['whichCropIsPlanted'] as List<String>?)
          ?.map((e) => e as String)
          .toList(),
      agriDoingFromNoOfYears: json['agriDoingFromNoOfYears'] as String?,
      addressAsPerPawti: json['addressAsPerPawti'] as String?,
      districtName: json['districtName'] as String?,
      agriLandSurveyNo: json['agriLandSurveyNo'] as String?,
      fertilizerShopOwnerName: json['fertilizerShopOwnerName'] as String?,
      fertilizerShopOwnerContactNumber:
          json['fertilizerShopOwnerContactNumber'] as String?,
      whatTypeOfIrrigationMethod: json['WhatTypeOfIrrigationMethod'] as String?,
      significantChallengesThisSeason:
          json['significantChallengesThisSeason'] as String?,
      agriIncomeYearly: json['agriIncomeYearly'] as String?,
      ifCropDestroyedHowToPayEmi: json['ifCropDestroyedHowToPayEMI'] as String?,
    );

Map<String, dynamic> _$AgricultureBusinessToJson(
        AgricultureBusiness instance) =>
    <String, dynamic>{
      'haveYouFaced': instance.haveYouFaced,
      'nameOfAgriOwner': instance.nameOfAgriOwner,
      'relationOfApplicant': instance.relationOfApplicant,
      'kasraSurveyNo': instance.kasraSurveyNo,
      'agriLandInBigha': instance.agriLandInBigha,
      'otherName': instance.otherName,
      'otherRelation': instance.otherRelation,
      'otherRemark': instance.otherRemark,
      'villageName': instance.villageName,
      'detailOfLastCorp': instance.detailOfLastCorp,
      'howmuchcorpsoldInAmt': instance.howmuchcorpsoldInAmt,
      'agriculturePhotos': instance.agriculturePhotos,
      'whichCropIsPlanted': instance.whichCropIsPlanted,
      'agriDoingFromNoOfYears': instance.agriDoingFromNoOfYears,
      'addressAsPerPawti': instance.addressAsPerPawti,
      'districtName': instance.districtName,
      'agriLandSurveyNo': instance.agriLandSurveyNo,
      'fertilizerShopOwnerName': instance.fertilizerShopOwnerName,
      'fertilizerShopOwnerContactNumber':
          instance.fertilizerShopOwnerContactNumber,
      'WhatTypeOfIrrigationMethod': instance.whatTypeOfIrrigationMethod,
      'significantChallengesThisSeason':
          instance.significantChallengesThisSeason,
      'agriIncomeYearly': instance.agriIncomeYearly,
      'ifCropDestroyedHowToPayEMI': instance.ifCropDestroyedHowToPayEmi,
    };

MilkBusiness _$MilkBusinessFromJson(Map<String, dynamic> json) => MilkBusiness(
      numberOfCattrels: json['numberOfCattrels'] as String?,
      noOfMilkGivingCattles: json['noOfMilkGivingCattles'] as String?,
      doingFromNoOfYears: json['doingFromNoOfYears'] as String?,
      totalMilkSupplyPerDay: json['totalMilkSupplyPerDay'] as String?,
      nameOfDairy: json['nameOfDairy'] as String?,
      dairyOwnerMobNo: json['dairyOwnerMobNo'] as String?,
      dairyAddress: json['dairyAddress'] as String?,
      milkprovideFromSinceYear: json['milkprovideFromSinceYear'] as String?,
      expensesOfMilkBusiness: json['expensesOfMilkBusiness'] as String?,
      monthlyIncomeMilkBusiness: json['monthlyIncomeMilkBusiness'] as String?,
      milkPhotos: json['milkPhotos'] as List<dynamic>?,
      animalPhotos: json['animalPhotos'] as List<dynamic>?,
      currentMilkUtilization: json['currentMilkUtilization'] as String?,
      breedOfCattles: json['breedOfCattles'] as List<dynamic>?,
      ifCropDestroyedHowToPayEmi: json['ifCropDestroyedHowToPayEMI'] as String?,
      observedDesignatedCattleTyingArea:
          json['observedDesignatedCattleTyingArea'] as String?,
    );

Map<String, dynamic> _$MilkBusinessToJson(MilkBusiness instance) =>
    <String, dynamic>{
      'numberOfCattrels': instance.numberOfCattrels,
      'noOfMilkGivingCattles': instance.noOfMilkGivingCattles,
      'doingFromNoOfYears': instance.doingFromNoOfYears,
      'totalMilkSupplyPerDay': instance.totalMilkSupplyPerDay,
      'nameOfDairy': instance.nameOfDairy,
      'dairyOwnerMobNo': instance.dairyOwnerMobNo,
      'dairyAddress': instance.dairyAddress,
      'milkprovideFromSinceYear': instance.milkprovideFromSinceYear,
      'expensesOfMilkBusiness': instance.expensesOfMilkBusiness,
      'monthlyIncomeMilkBusiness': instance.monthlyIncomeMilkBusiness,
      'milkPhotos': instance.milkPhotos,
      'animalPhotos': instance.animalPhotos,
      'currentMilkUtilization': instance.currentMilkUtilization,
      'breedOfCattles': instance.breedOfCattles,
      'ifCropDestroyedHowToPayEMI': instance.ifCropDestroyedHowToPayEmi,
      'observedDesignatedCattleTyingArea':
          instance.observedDesignatedCattleTyingArea,
    };

Other _$OtherFromJson(Map<String, dynamic> json) => Other(
      bussinessFromSinceYear: json['bussinessFromSinceYear'] as String?,
      natureOfBusiness: json['natureOfBusiness'] as String?,
      monthlyIncome: (json['monthlyIncome'] as num?)?.toInt(),
      yearlyIncome: (json['yearlyIncome'] as num?)?.toInt(),
      discriptionOfBusiness: json['discriptionOfBusiness'] as String?,
      incomeOtherImages: json['incomeOtherImages'] as List<dynamic>?,
    );

Map<String, dynamic> _$OtherToJson(Other instance) => <String, dynamic>{
      'bussinessFromSinceYear': instance.bussinessFromSinceYear,
      'natureOfBusiness': instance.natureOfBusiness,
      'monthlyIncome': instance.monthlyIncome,
      'yearlyIncome': instance.yearlyIncome,
      'discriptionOfBusiness': instance.discriptionOfBusiness,
      'incomeOtherImages': instance.incomeOtherImages,
    };

SalaryIncome _$SalaryIncomeFromJson(Map<String, dynamic> json) => SalaryIncome(
      numberOfCattrels: json['numberOfCattrels'] as String?,
      companyName: json['companyName'] as String?,
      addressOfSalaryProvider: json['addressOfSalaryProvider'] as String?,
      mobNoOfSalaryProvider: json['MobNoOfSalaryProvider'] as String?,
      doingFromNoYears: json['doingFromNoYears'] as String?,
      salaryPaidThrouch: json['salaryPaidThrouch'] as String?,
      monthlyNetSalary: json['monthlyNetSalary'] as String?,
      salaryCredited6Month: json['salaryCredited6Month'] as String?,
      last3MonthSalarySlipPhotos:
          json['last3MonthSalarySlipPhotos'] as List<dynamic>?,
      bankStatementPhoto: json['bankStatementPhoto'] as String?,
      salaryPhotos: json['salaryPhotos'] as List<dynamic>?,
    );

Map<String, dynamic> _$SalaryIncomeToJson(SalaryIncome instance) =>
    <String, dynamic>{
      'numberOfCattrels': instance.numberOfCattrels,
      'companyName': instance.companyName,
      'addressOfSalaryProvider': instance.addressOfSalaryProvider,
      'MobNoOfSalaryProvider': instance.mobNoOfSalaryProvider,
      'doingFromNoYears': instance.doingFromNoYears,
      'salaryPaidThrouch': instance.salaryPaidThrouch,
      'monthlyNetSalary': instance.monthlyNetSalary,
      'salaryCredited6Month': instance.salaryCredited6Month,
      'last3MonthSalarySlipPhotos': instance.last3MonthSalarySlipPhotos,
      'bankStatementPhoto': instance.bankStatementPhoto,
      'salaryPhotos': instance.salaryPhotos,
    };

PoliceStation _$PoliceStationFromJson(Map<String, dynamic> json) =>
    PoliceStation(
      staionName: json['staionName'] as String?,
      stationAdress: json['stationAdress'] as String?,
    );

Map<String, dynamic> _$PoliceStationToJson(PoliceStation instance) =>
    <String, dynamic>{
      'staionName': instance.staionName,
      'stationAdress': instance.stationAdress,
    };

Property _$PropertyFromJson(Map<String, dynamic> json) => Property(
      collateralsDetails: json['collateralsDetails'] == null
          ? null
          : CollateralsDetails.fromJson(
              json['collateralsDetails'] as Map<String, dynamic>),
      accommodationDetails: json['accommodationDetails'] == null
          ? null
          : AccommodationDetails.fromJson(
              json['accommodationDetails'] as Map<String, dynamic>),
      propertyOwnerName: json['propertyOwnerName'],
      relationWithApplicant: json['relationWithApplicant'] as String?,
      villageName: json['villageName'] as String?,
      gramPanchayat: json['gramPanchayat'] as String?,
      patwariHalkaNo: json['patwariHalkaNo'] as String?,
      state: json['state'] as String?,
      district: json['district'] as String?,
      tehsil: json['tehsil'] as String?,
      houseNo: json['houseNo'] as String?,
      wardNo: json['wardNo'] as String?,
      surveyNo: json['surveyNo'] as String?,
      totalBuilUpArea: json['TotalBuilUpArea'] as String?,
      qualityOfConstruction: json['qualityOfConstruction'] as String?,
      ageOfProperty: json['ageOfProperty'] as String?,
      maintenanceOfTheProperty: json['MaintenanceOfTheProperty'] as String?,
      projectedLifeYear: json['ProjectedLifeYear'] as String?,
      typeOfContruction: json['typeOfContruction'] as String?,
      landRatePerSqft: json['landRatePerSQFT'] as String?,
      totalConstruction: json['totalConstruction'] as String?,
      fatherName: json['fatherName'] as String?,
      latitudeOfTheProrty: json['latitudeOfTheProrty'] as String?,
      longitudeOfTheProrty: json['longitudeOfTheProrty'] as String?,
      doorsAndWindowsAreAvailable:
          json['doorsAndWindowsAreAvailable'] as String?,
      kitchenAndLatBathAvailable: json['kitchenAndLatBathAvailable'] as String?,
      assetSeenAtResidence: json['assetSeenAtResidence'],
    );

Map<String, dynamic> _$PropertyToJson(Property instance) => <String, dynamic>{
      'collateralsDetails': instance.collateralsDetails,
      'accommodationDetails': instance.accommodationDetails,
      'propertyOwnerName': instance.propertyOwnerName,
      'relationWithApplicant': instance.relationWithApplicant,
      'villageName': instance.villageName,
      'gramPanchayat': instance.gramPanchayat,
      'patwariHalkaNo': instance.patwariHalkaNo,
      'state': instance.state,
      'district': instance.district,
      'tehsil': instance.tehsil,
      'houseNo': instance.houseNo,
      'wardNo': instance.wardNo,
      'surveyNo': instance.surveyNo,
      'TotalBuilUpArea': instance.totalBuilUpArea,
      'qualityOfConstruction': instance.qualityOfConstruction,
      'ageOfProperty': instance.ageOfProperty,
      'MaintenanceOfTheProperty': instance.maintenanceOfTheProperty,
      'ProjectedLifeYear': instance.projectedLifeYear,
      'typeOfContruction': instance.typeOfContruction,
      'landRatePerSQFT': instance.landRatePerSqft,
      'totalConstruction': instance.totalConstruction,
      'fatherName': instance.fatherName,
      'latitudeOfTheProrty': instance.latitudeOfTheProrty,
      'longitudeOfTheProrty': instance.longitudeOfTheProrty,
      'doorsAndWindowsAreAvailable': instance.doorsAndWindowsAreAvailable,
      'kitchenAndLatBathAvailable': instance.kitchenAndLatBathAvailable,
      'assetSeenAtResidence': instance.assetSeenAtResidence,
    };

AccommodationDetails _$AccommodationDetailsFromJson(
        Map<String, dynamic> json) =>
    AccommodationDetails(
      groundFloor: json['groundFloor'] as String?,
      firstFloor: json['firstFloor'] as String?,
      actualUsageOfProperty: json['actualUsageOfProperty'],
      typeOfStructure: json['typeOfStructure'] as String?,
      locationOfPlot: json['locationOfPlot'] as String?,
      builtUpAreaSft: json['builtUpAreaSft'] as String?,
      occupancy: json['occupancy'] as String?,
      electricityAndGasConnection:
          json['electricityAndGasConnection'] as String?,
      developmentOfSurroundingArea:
          json['developmentOfSurroundingArea'] as String?,
    );

Map<String, dynamic> _$AccommodationDetailsToJson(
        AccommodationDetails instance) =>
    <String, dynamic>{
      'groundFloor': instance.groundFloor,
      'firstFloor': instance.firstFloor,
      'actualUsageOfProperty': instance.actualUsageOfProperty,
      'typeOfStructure': instance.typeOfStructure,
      'locationOfPlot': instance.locationOfPlot,
      'builtUpAreaSft': instance.builtUpAreaSft,
      'occupancy': instance.occupancy,
      'electricityAndGasConnection': instance.electricityAndGasConnection,
      'developmentOfSurroundingArea': instance.developmentOfSurroundingArea,
    };

CollateralsDetails _$CollateralsDetailsFromJson(Map<String, dynamic> json) =>
    CollateralsDetails(
      nameOfTheDocumentHolder: json['nameOfTheDocumentHolder'] as String?,
      documentsProvided: json['documentsProvided'] as String?,
      propertyAddress: json['propertyAddress'] as String?,
      landmark: json['landmark'] as String?,
      locationZone: json['locationZone'] as String?,
      availabilityOfLocalTransport:
          json['availabilityOfLocalTransport'] as String?,
      classOfLocality: json['classOfLocality'] as String?,
      typeOfLocality: json['typeOfLocality'] as String?,
      asPerSite: json['asPerSite'],
      boundariesMatching: json['boundariesMatching'] as String?,
      statusOfTheLandFlat: json['statusOfTheLandFlat'] as String?,
      typeOfProperty: json['typeOfProperty'] as String?,
      boundariesEast: json['boundariesEast'] as String?,
      boundariesWest: json['boundariesWest'] as String?,
      boundariesNorth: json['boundariesNorth'] as String?,
      boundariesSouth: json['boundariesSouth'] as String?,
    );

Map<String, dynamic> _$CollateralsDetailsToJson(CollateralsDetails instance) =>
    <String, dynamic>{
      'nameOfTheDocumentHolder': instance.nameOfTheDocumentHolder,
      'documentsProvided': instance.documentsProvided,
      'propertyAddress': instance.propertyAddress,
      'landmark': instance.landmark,
      'locationZone': instance.locationZone,
      'availabilityOfLocalTransport': instance.availabilityOfLocalTransport,
      'classOfLocality': instance.classOfLocality,
      'typeOfLocality': instance.typeOfLocality,
      'asPerSite': instance.asPerSite,
      'boundariesMatching': instance.boundariesMatching,
      'statusOfTheLandFlat': instance.statusOfTheLandFlat,
      'typeOfProperty': instance.typeOfProperty,
      'boundariesEast': instance.boundariesEast,
      'boundariesWest': instance.boundariesWest,
      'boundariesNorth': instance.boundariesNorth,
      'boundariesSouth': instance.boundariesSouth,
    };

ReferenceDetail _$ReferenceDetailFromJson(Map<String, dynamic> json) =>
    ReferenceDetail(
      name: json['name'] as String?,
      address: json['address'] as String?,
      relation: json['relation'] as String?,
      mobileNumber: json['mobileNumber'] as String?,
      id: json['_id'] as String?,
    );

Map<String, dynamic> _$ReferenceDetailToJson(ReferenceDetail instance) =>
    <String, dynamic>{
      'name': instance.name,
      'address': instance.address,
      'relation': instance.relation,
      'mobileNumber': instance.mobileNumber,
      '_id': instance.id,
    };

SamagraDetail _$SamagraDetailFromJson(Map<String, dynamic> json) =>
    SamagraDetail(
      samagraFamilyIdNo: json['samagraFamilyIdNo'] as String?,
      samagraIdHeadName: json['samagraIdHeadName'] as String?,
    );

Map<String, dynamic> _$SamagraDetailToJson(SamagraDetail instance) =>
    <String, dynamic>{
      'samagraFamilyIdNo': instance.samagraFamilyIdNo,
      'samagraIdHeadName': instance.samagraIdHeadName,
    };

Total _$TotalFromJson(Map<String, dynamic> json) => Total(
      totalPurchaseValue: (json['totalPurchaseValue'] as num?)?.toInt(),
      totalMarketValue: (json['totalMarketValue'] as num?)?.toInt(),
    );

Map<String, dynamic> _$TotalToJson(Total instance) => <String, dynamic>{
      'totalPurchaseValue': instance.totalPurchaseValue,
      'totalMarketValue': instance.totalMarketValue,
    };

TotalIncomeDetails _$TotalIncomeDetailsFromJson(Map<String, dynamic> json) =>
    TotalIncomeDetails(
      totalYearlyIncome: json['totalYearlyIncome'] as String?,
      totalMonthlyIncome: json['totalMonthlyIncome'] as String?,
      totalExpensesYearly: json['totalExpensesYearly'] as String?,
      totalExpensesMonthly: json['totalExpensesMonthly'] as String?,
    );

Map<String, dynamic> _$TotalIncomeDetailsToJson(TotalIncomeDetails instance) =>
    <String, dynamic>{
      'totalYearlyIncome': instance.totalYearlyIncome,
      'totalMonthlyIncome': instance.totalMonthlyIncome,
      'totalExpensesYearly': instance.totalExpensesYearly,
      'totalExpensesMonthly': instance.totalExpensesMonthly,
    };
