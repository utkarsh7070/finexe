// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pd_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PdResponseModel _$PdResponseModelFromJson(Map<String, dynamic> json) =>
    PdResponseModel(
      status: json['status'] as bool?,
      subCode: (json['subCode'] as num?)?.toInt(),
      message: json['message'] as String?,
      error: json['error'] as String?,
      items: json['items'] == null
          ? null
          : Items.fromJson(json['items'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$PdResponseModelToJson(PdResponseModel instance) =>
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
          : PdApplicant.fromJson(json['applicant'] as Map<String, dynamic>),
      guarantor: json['guarantor'] == null
          ? null
          : PdApplicant.fromJson(json['guarantor'] as Map<String, dynamic>),
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
      hoId: json['hoId'],
      udyamCertificate: json['udyamCertificate'] as String?,
      reasonForReject: json['reasonForReject'] as String?,
      pDdocuments: json['PDdocuments'] as bool?,
      id: json['_id'] as String?,
      customerId: json['customerId'] as String?,
      pdId: json['pdId'] as String?,
      pdType: json['pdType'] as String?,
      videoUpload: json['videoUpload'],
      rejectReason: json['rejectReason'] as String?,
      pendingReason: json['pendingReason'] as String?,
      applicantImage: json['applicantImage'] as String?,
      guarantorImage: json['guarantorImage'] as String?,
      coApplicantImage: (json['coApplicantImage'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      coApplicant: (json['co_Applicant'] as List<dynamic>?)
          ?.map((e) => PdApplicant.fromJson(e as Map<String, dynamic>))
          .toList(),
      familyMember: (json['familyMember'] as List<dynamic>?)
          ?.map((e) => FamilyMember.fromJson(e as Map<String, dynamic>))
          .toList(),
      referenceDetails: (json['referenceDetails'] as List<dynamic>?)
          ?.map((e) => ReferenceDetail.fromJson(e as Map<String, dynamic>))
          .toList(),
      landmarkPhoto: json['landmarkPhoto'] as String?,
      latLongPhoto: json['latLongPhoto'] as String?,
      fourBoundaryPhotos: json['fourBoundaryPhotos'] as List<dynamic>?,
      workPhotos: json['workPhotos'] as List<dynamic>?,
      houseInsidePhoto: json['houseInsidePhoto'] as List<dynamic>?,
      propertyOtherPhotos: json['propertyOtherPhotos'] as List<dynamic>?,
      selfiWithCustomer: json['selfiWithCustomer'] as String?,
      photoWithLatLong: json['photoWithLatLong'] as String?,
      front: json['front'] as String?,
      leftSide: json['leftSide'] as String?,
      rightSide: json['rightSide'] as String?,
      approachRoad: json['approachRoad'] as String?,
      mainRoad: json['mainRoad'] as String?,
      interiorRoad: json['interiorRoad'] as String?,
      selfieWithProperty: json['selfieWithProperty'] as String?,
      propertyPhoto: json['propertyPhoto'] as String?,
      assetDetails: (json['assetDetails'] as List<dynamic>?)
          ?.map((e) => AssetDetail.fromJson(e as Map<String, dynamic>))
          .toList(),
      gasDiaryPhoto: json['gasDiaryPhoto'] as String?,
      meterPhoto: json['meterPhoto'] as String?,
      electricityBillPhoto: json['electricityBillPhoto'] as String?,
      sssmPhoto: json['SSSMPhoto'] as String?,
      familyMemberPhotos: json['familyMemberPhotos'] as List<dynamic>?,
      otherDocUpload: json['otherDocUpload'] as String?,
      residentType: json['residentType'] as String?,
      residentCurrentSince: (json['residentCurrentSince'] as num?)?.toInt(),
      status: json['status'] as String?,
      approvalRemarkCreditPd: json['approvalRemarkCreditPd'] as String?,
      pdfLink: json['pdfLink'] as String?,
      remarkMessage: json['remarkMessage'] as String?,
      bdCompleteDate: json['bdCompleteDate'] as String?,
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      updatedAt: json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
      v: (json['__v'] as num?)?.toInt(),
      incomeSource: json['incomeSource'] as List<dynamic>?,
      remarkByPd: json['remarkByPd'] as String?,
      pdFormDelete: json['pdFormDelete'] as bool?,
      departmentInfo: json['department_info'] as List<dynamic>?,
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
      'hoId': instance.hoId,
      'udyamCertificate': instance.udyamCertificate,
      'reasonForReject': instance.reasonForReject,
      'PDdocuments': instance.pDdocuments,
      '_id': instance.id,
      'customerId': instance.customerId,
      'pdId': instance.pdId,
      'pdType': instance.pdType,
      'videoUpload': instance.videoUpload,
      'rejectReason': instance.rejectReason,
      'pendingReason': instance.pendingReason,
      'applicantImage': instance.applicantImage,
      'guarantorImage': instance.guarantorImage,
      'coApplicantImage': instance.coApplicantImage,
      'co_Applicant': instance.coApplicant,
      'familyMember': instance.familyMember,
      'referenceDetails': instance.referenceDetails,
      'landmarkPhoto': instance.landmarkPhoto,
      'latLongPhoto': instance.latLongPhoto,
      'fourBoundaryPhotos': instance.fourBoundaryPhotos,
      'workPhotos': instance.workPhotos,
      'houseInsidePhoto': instance.houseInsidePhoto,
      'propertyOtherPhotos': instance.propertyOtherPhotos,
      'selfiWithCustomer': instance.selfiWithCustomer,
      'photoWithLatLong': instance.photoWithLatLong,
      'front': instance.front,
      'leftSide': instance.leftSide,
      'rightSide': instance.rightSide,
      'approachRoad': instance.approachRoad,
      'mainRoad': instance.mainRoad,
      'interiorRoad': instance.interiorRoad,
      'selfieWithProperty': instance.selfieWithProperty,
      'propertyPhoto': instance.propertyPhoto,
      'assetDetails': instance.assetDetails,
      'gasDiaryPhoto': instance.gasDiaryPhoto,
      'meterPhoto': instance.meterPhoto,
      'electricityBillPhoto': instance.electricityBillPhoto,
      'SSSMPhoto': instance.sssmPhoto,
      'familyMemberPhotos': instance.familyMemberPhotos,
      'otherDocUpload': instance.otherDocUpload,
      'residentType': instance.residentType,
      'residentCurrentSince': instance.residentCurrentSince,
      'status': instance.status,
      'approvalRemarkCreditPd': instance.approvalRemarkCreditPd,
      'pdfLink': instance.pdfLink,
      'remarkMessage': instance.remarkMessage,
      'bdCompleteDate': instance.bdCompleteDate,
      'createdAt': instance.createdAt?.toIso8601String(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
      '__v': instance.v,
      'incomeSource': instance.incomeSource,
      'remarkByPd': instance.remarkByPd,
      'pdFormDelete': instance.pdFormDelete,
      'department_info': instance.departmentInfo,
    };

PdApplicant _$PdApplicantFromJson(Map<String, dynamic> json) => PdApplicant(
      applicantType: json['applicantType'] as String?,
      businessType: json['businessType'] as String?,
      occupation: json['occupation'] as String?,
      dob: json['DOB'] as String?,
      email: json['email'] as String?,
      houseLandMark: json['houseLandMark'] as String?,
      alternateMobileNo: json['alternateMobileNo'] as String?,
      noOfyearsAtCurrentAddress: json['noOfyearsAtCurrentAddress'] as String?,
      gender: json['gender'] as String?,
      religion: json['religion'] as String?,
      nationality: json['nationality'] as String?,
      category: json['category'] as String?,
      caste: json['caste'] as String?,
      maritalStatus: json['maritalStatus'] as String?,
      noOfDependentWithCustomer: json['noOfDependentWithCustomer'] as String?,
      educationalDetails: json['educationalDetails'] as String?,
      residenceType: json['residenceType'] as String?,
      coApplicantType: json['coApplicantType'] as String?,
      emailId: json['emailId'] as String?,
      id: json['_id'] as String?,
      guarantorType: json['guarantorType'] as String?,
    );

Map<String, dynamic> _$PdApplicantToJson(PdApplicant instance) => <String, dynamic>{
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
      'coApplicantType': instance.coApplicantType,
      'emailId': instance.emailId,
      '_id': instance.id,
      'guarantorType': instance.guarantorType,
    };

ApproveLoanDetails _$ApproveLoanDetailsFromJson(Map<String, dynamic> json) =>
    ApproveLoanDetails(
      approvedAmount: (json['approvedAmount'] as num?)?.toInt(),
      roi: (json['ROI'] as num?)?.toInt(),
      tenure: (json['Tenure'] as num?)?.toInt(),
      emi: (json['EMI'] as num?)?.toInt(),
      demandLoanAmountByCustomer: json['demandLoanAmountByCustomer'] as String?,
      finalDecision: json['finalDecision'] as String?,
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

FamilyMember _$FamilyMemberFromJson(Map<String, dynamic> json) => FamilyMember(
      name: json['name'] as String?,
      samagraMemberId: json['samagraMemberId'] as String?,
      age: json['age'],
      gender: json['gender'] as String?,
      relation: json['relation'] as String?,
      dependent: json['dependent'] as String?,
      occupationType: json['occupationType'] as String?,
      occupationTypeDetails: json['occupationTypeDetails'] == null
          ? null
          : OccupationTypeDetails.fromJson(
              json['occupationTypeDetails'] as Map<String, dynamic>),
      id: json['_id'] as String?,
    );

Map<String, dynamic> _$FamilyMemberToJson(FamilyMember instance) =>
    <String, dynamic>{
      'name': instance.name,
      'samagraMemberId': instance.samagraMemberId,
      'age': instance.age,
      'gender': instance.gender,
      'relation': instance.relation,
      'dependent': instance.dependent,
      'occupationType': instance.occupationType,
      'occupationTypeDetails': instance.occupationTypeDetails,
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
      howManyFloors: json['howManyFloors'] as String?,
      pincode: json['pincode'] as String?,
      totalLandArea: json['TotalLandArea'] as String?,
      propertyOwnerName: json['propertyOwnerName'] as String?,
      relationWithApplicant: json['relationWithApplicant'] as String?,
      documentType: json['documentType'] as String?,
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
      assetSeenAtResidence: json['assetSeenAtResidence'] as List<dynamic>?,
    );

Map<String, dynamic> _$PropertyToJson(Property instance) => <String, dynamic>{
      'collateralsDetails': instance.collateralsDetails,
      'accommodationDetails': instance.accommodationDetails,
      'howManyFloors': instance.howManyFloors,
      'pincode': instance.pincode,
      'TotalLandArea': instance.totalLandArea,
      'propertyOwnerName': instance.propertyOwnerName,
      'relationWithApplicant': instance.relationWithApplicant,
      'documentType': instance.documentType,
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
      actualUsageOfProperty: json['actualUsageOfProperty'] as String?,
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
      asPerSite: json['asPerSite'] as String?,
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
