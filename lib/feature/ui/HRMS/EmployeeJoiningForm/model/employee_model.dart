class EmployeeDetailsModel {
  final String applicantPhotoFilePath;
  final bool isApplicantPhoto;
  final String aadhaarPhotoFilePath1;
  final String aadhaarPhotoFilePath2;
  final bool checkBoxTermsConditionApplicant;
  final String careOf;
  final List<AdditionalFamilyMemberModel> additionalFamilyMember;
  final List<NomineeInformationModel> nomineeInformation;
  final List<EducationaldetailModel> educationalDetail;
  final List<EmploymentHistoryModel> employmentHistory;
  final List<String> documents;
  final List<bool> isLoading;

  final String panName;
  final String panFather;
  final String panGender;
  final String panDob;
  final String aadhaar;
  final String otp;
  final bool isOtpVerify;
  final bool isOpenSelectedIdField;
  final bool isOtpValid;
  final String kycDocument;
  final String pan;
  final String mother;
  final String contact;
  final String email;
  final String marital;
  final String religion;
  final String caste;
  final String identityMark;
  final bool isIdentityMark;
  final String latitude;
  final bool isLatitude;
  final String longitude;
  final bool isLongitude;
  final String bankAccountNumber;
  final bool isBankAccountNumber;
  final String esicNumber;
  final bool isEsicNumber;
  final String category;
  final bool isCategory;

  final String educationOfApplicant;
  final String gender;
  final String fullName;
  final String fatherName;
  final String dob;
  final String age;
  final String relationWithApplicant;

  final String communicationAddress1;
  final String communicationAddress2;
  final String communicationCity;
  final String communicationState;
  final String communicationDistrict;
  final String communicationPinCode;

  final String permanentAddress1;
  final String permanentAddress2;
  final String permanentCity;
  final String permanentState;
  final String permanentDistrict;
  final String permanentPinCode;

  final bool isAadhaarValid;
  final bool isPanValid;
  final bool isKycValid;
  final bool isMotherValid;
  final bool isContactValid;
  final bool isEmailValid;
  final bool isMaritalValid;
  final bool isReligionValid;
  final bool isCasteValid;

  final bool isEducationOfApplicantValid;
  final bool isGenderValid;
  final bool isFullNameValid;
  final bool isFatherNameValid;
  final bool isDobValid;
  final bool isAgeValid;
  final bool isRelationWithApplicantValid;

  final bool isCommunicationAddress1Valid;
  final bool isCommunicationAddress2Valid;
  final bool isCommunicationCityValid;
  final bool isCommunicationStateValid;
  final bool isCommunicationDistrictValid;
  final bool isCommunicationPinCodeValid;

  final bool isPermanentAddress1Valid;
  final bool isPermanentAddress2Valid;
  final bool isPermanentCityValid;
  final bool isPermanentStateValid;
  final bool isPermanentDistrictValid;
  final bool isPermanentPinCodeValid;
  final bool isApplicantFormSubmitted;

  EmployeeDetailsModel({
    this.documents=const [],
    this.employmentHistory=const [],
    this.educationalDetail=const[],
    this.isLoading = const [],

    this.esicNumber = '',
    this.isEsicNumber = true,
    this.category = '',
    this.isCategory = true,
    this.bankAccountNumber = '',
    this.isBankAccountNumber = true,
    this.longitude = '',
    this.isLongitude = true,
    this.latitude = '',
    this.isLatitude = true,
    this.isIdentityMark = true,
    this.identityMark = '',
    this.additionalFamilyMember = const [],
    this.nomineeInformation = const [],
    this.panFather = '',
    this.panDob = '',
    this.panGender = '',
    this.panName = '',
    this.isApplicantFormSubmitted = false,
    this.careOf = '',
    this.isApplicantPhoto = true,
    this.checkBoxTermsConditionApplicant = false,
    this.isOtpVerify = false,
    this.isOpenSelectedIdField = false,
    this.otp = '',
    this.isOtpValid = true,
    this.applicantPhotoFilePath = '',
    this.aadhaarPhotoFilePath1 = '',
    this.aadhaarPhotoFilePath2 = '',
    this.aadhaar = '',
    this.permanentAddress1 = '',
    this.permanentAddress2 = '',
    this.permanentCity = '',
    this.permanentDistrict = '',
    this.permanentPinCode = '',
    this.permanentState = '',
    this.isAadhaarValid = true,
    this.isPermanentAddress1Valid = true,
    this.isPermanentAddress2Valid = true,
    this.isPermanentCityValid = true,
    this.isPermanentDistrictValid = true,
    this.isPermanentPinCodeValid = true,
    this.isPermanentStateValid = true,
    this.communicationAddress1 = '',
    this.communicationAddress2 = '',
    this.communicationCity = '',
    this.communicationState = '',
    this.communicationDistrict = '',
    this.communicationPinCode = '',
    this.isCommunicationAddress1Valid = true,
    this.isCommunicationAddress2Valid = true,
    this.isCommunicationCityValid = true,
    this.isCommunicationStateValid = true,
    this.isCommunicationDistrictValid = true,
    this.isCommunicationPinCodeValid = true,
    this.mother = '',
    this.contact = '',
    this.email = '',
    this.marital = '',
    this.religion = '',
    this.caste = '',
    this.kycDocument = '',
    this.pan = '',
    this.isKycValid = true,
    this.isPanValid = true,
    this.isMotherValid = true,
    this.isContactValid = true,
    this.isEmailValid = true,
    this.isMaritalValid = true,
    this.isReligionValid = true,
    this.isCasteValid = true,
    this.educationOfApplicant = '',
    this.gender = '',
    this.fullName = '',
    this.fatherName = '',
    this.dob = '',
    this.age = '',
    this.relationWithApplicant = '',
    this.isEducationOfApplicantValid = true,
    this.isGenderValid = true,
    this.isFullNameValid = true,
    this.isFatherNameValid = true,
    this.isDobValid = true,
    this.isAgeValid = true,
    this.isRelationWithApplicantValid = true,
  });

  EmployeeDetailsModel copyWith(
      {
        List< bool>? isLoading,
        List<EducationaldetailModel>? educationalDetail,
        List<EmploymentHistoryModel>? employmentHistory,
        List<String> ? documents ,
        String? esicNumber,
        bool? isEsicNumber,
        String? category,
        bool? isCategory,
        String? bankAccountNumber,
        bool? isBankAccountNumber,
        String? latitude,
        bool? isLatitude,
        String? longitude,
        bool? isLongitude,
        String? panFather,
        List<AdditionalFamilyMemberModel>? additionalFamilyMember,
        List<NomineeInformationModel>? nomineeInformation,
        String? panName,
        String? panGender,
        String? panDob,
        String? identityMark,
        bool? isIdentityMark,
        bool? checkBoxTermsConditionApplicant,
        bool? isApplicantFormSubmitted,
        String? careOf,
        bool? isOtpVerify,
        bool? isOpenSelectedIdField,
        String? otp,
        bool? isOtpValid,
        String? applicantPhotoFilePath,
        String? aadhaarPhotoFilePath1,
        String? aadhaarPhotoFilePath2,
        String? aadhaar,
        String? permanentAddress1,
        String? permanentAddress2,
        String? permanentCity,
        String? permanentState,
        String? permanentDistrict,
        String? permanentPinCode,
        bool? isPermanentAddress1Valid,
        bool? isPermanentAddress2Valid,
        bool? isPermanentCityValid,
        bool? isPermanentStateValid,
        bool? isPermanentDistrictValid,
        bool? isPermanentPinCodeValid,
        bool? isAadhaarValid,
        String? kycDocument,
        String? pan,
        String? mother,
        String? contact,
        String? email,
        String? marital,
        String? religion,
        String? caste,
        String? educationOfApplicant,
        String? gender,
        String? fullName,
        String? fatherName,
        String? dob,
        String? age,
        String? relationWithApplicant,
        String? communicationAddress1,
        String? communicationAddress2,
        String? communicationCity,
        String? communicationState,
        String? communicationDistrict,
        String? communicationPinCode,
        bool? isApplicantPhoto,
        bool? isCommunicationAddress1Valid,
        bool? isCommunicationAddress2Valid,
        bool? isCommunicationCityValid,
        bool? isCommunicationStateValid,
        bool? isCommunicationDistrictValid,
        bool? isCommunicationPinCodeValid,
        bool? isKycValid,
        bool? isPanValid,
        bool? isMotherValid,
        bool? isContactValid,
        bool? isEmailValid,
        bool? isMaritalValid,
        bool? isReligionValid,
        bool? isCasteValid,
        bool? isEducationOfApplicantValid,
        bool? isGenderValid,
        bool? isFullNameValid,
        bool? isFatherNameValid,
        bool? isDobValid,
        bool? isAgeValid,
        bool? isRelationWithApplicantValid}) {
    return EmployeeDetailsModel(
        documents: documents?? this.documents ,
        employmentHistory: employmentHistory??this.employmentHistory,
        educationalDetail:educationalDetail??this.educationalDetail ,
        isLoading: isLoading??this.isLoading,
        // isLoading: isLoading ?? this.isLoading,
        category: category ?? this.category,
        esicNumber: esicNumber ?? this.esicNumber,
        isCategory: isCategory ?? this.isCategory,
        isEsicNumber: isEsicNumber ?? this.isEsicNumber,
        bankAccountNumber: bankAccountNumber ?? this.bankAccountNumber,
        isBankAccountNumber: isBankAccountNumber ?? this.isBankAccountNumber,
        isLatitude: isLatitude ?? this.isLatitude,
        isLongitude: isLongitude ?? this.isLongitude,
        latitude: latitude ?? this.latitude,
        longitude: longitude ?? this.longitude,
        isIdentityMark: isIdentityMark ?? this.isIdentityMark,
        identityMark: identityMark ?? this.identityMark,
        nomineeInformation: nomineeInformation ?? this.nomineeInformation,
        additionalFamilyMember:
        additionalFamilyMember ?? this.additionalFamilyMember,
        panFather: panFather ?? this.panFather,
        panDob: panDob ?? this.panDob,
        panGender: panGender ?? this.panGender,
        panName: panName ?? this.panName,
        isApplicantFormSubmitted:
        isApplicantFormSubmitted ?? this.isApplicantFormSubmitted,
        careOf: careOf ?? this.careOf,
        isApplicantPhoto: isApplicantPhoto ?? this.isApplicantPhoto,

        checkBoxTermsConditionApplicant: checkBoxTermsConditionApplicant ??
            this.checkBoxTermsConditionApplicant,
        isOtpVerify: isOtpVerify ?? this.isOtpVerify,
        isOpenSelectedIdField:
        isOpenSelectedIdField ?? this.isOpenSelectedIdField,
        isOtpValid: isOtpValid ?? this.isOtpValid,
        otp: otp ?? this.otp,
        applicantPhotoFilePath:
        applicantPhotoFilePath ?? this.applicantPhotoFilePath,
        aadhaarPhotoFilePath1:
        aadhaarPhotoFilePath1 ?? this.aadhaarPhotoFilePath1,
        aadhaarPhotoFilePath2:
        aadhaarPhotoFilePath2 ?? this.aadhaarPhotoFilePath2,
        aadhaar: aadhaar ?? this.aadhaar,
        isAadhaarValid: isAadhaarValid ?? this.isAadhaarValid,
        kycDocument: kycDocument ?? this.kycDocument,
        pan: pan ?? this.pan,
        mother: mother ?? this.mother,
        contact: contact ?? this.contact,
        email: email ?? this.email,
        marital: marital ?? this.marital,
        religion: religion ?? this.religion,
        caste: caste ?? this.caste,
        educationOfApplicant: educationOfApplicant ?? this.educationOfApplicant,
        gender: gender ?? this.gender,
        fullName: fullName ?? this.fullName,
        fatherName: fatherName ?? this.fatherName,
        dob: dob ?? this.dob,
        age: age ?? this.age,
        relationWithApplicant:
        relationWithApplicant ?? this.relationWithApplicant,
        communicationAddress1:
        communicationAddress1 ?? this.communicationAddress1,
        communicationAddress2:
        communicationAddress2 ?? this.communicationAddress2,
        communicationCity: communicationCity ?? this.communicationCity,
        communicationDistrict:
        communicationDistrict ?? this.communicationDistrict,
        communicationPinCode: communicationPinCode ?? this.communicationPinCode,
        communicationState: communicationState ?? this.communicationState,
        permanentAddress1: permanentAddress1 ?? this.permanentAddress1,
        permanentAddress2: permanentAddress2 ?? this.permanentAddress2,
        permanentCity: permanentCity ?? this.permanentCity,
        permanentDistrict: permanentDistrict ?? this.permanentDistrict,
        permanentPinCode: permanentPinCode ?? this.permanentPinCode,
        permanentState: permanentState ?? this.permanentState,
        isPermanentAddress1Valid:
        isPermanentAddress1Valid ?? this.isPermanentAddress1Valid,
        isPermanentAddress2Valid:
        isPermanentAddress2Valid ?? this.isPermanentAddress2Valid,
        isPermanentCityValid: isPermanentCityValid ?? this.isPermanentCityValid,
        isPermanentDistrictValid:
        isPermanentDistrictValid ?? this.isPermanentDistrictValid,
        isPermanentPinCodeValid:
        isPermanentPinCodeValid ?? this.isPermanentPinCodeValid,
        isPermanentStateValid:
        isPermanentStateValid ?? this.isPermanentStateValid,
        isCommunicationAddress1Valid:
        isCommunicationAddress1Valid ?? this.isCommunicationAddress1Valid,
        isCommunicationAddress2Valid:
        isCommunicationAddress2Valid ?? this.isCommunicationAddress2Valid,
        isCommunicationCityValid:
        isCommunicationCityValid ?? this.isCommunicationCityValid,
        isCommunicationDistrictValid:
        isCommunicationDistrictValid ?? this.isCommunicationDistrictValid,
        isCommunicationPinCodeValid:
        isCommunicationPinCodeValid ?? this.isCommunicationPinCodeValid,
        isCommunicationStateValid:
        isCommunicationStateValid ?? this.isCommunicationStateValid,
        isKycValid: isKycValid ?? this.isKycValid,
        isPanValid: isPanValid ?? this.isPanValid,
        isMotherValid: isMotherValid ?? this.isMotherValid,
        isContactValid: isContactValid ?? this.isContactValid,
        isEmailValid: isEmailValid ?? this.isEmailValid,
        isMaritalValid: isMaritalValid ?? this.isMaritalValid,
        isReligionValid: isReligionValid ?? this.isReligionValid,
        isCasteValid: isCasteValid ?? this.isCasteValid,
        isEducationOfApplicantValid:
        isEducationOfApplicantValid ?? this.isEducationOfApplicantValid,
        isGenderValid: isGenderValid ?? this.isGenderValid,
        isFullNameValid: isFullNameValid ?? this.isFullNameValid,
        isFatherNameValid: isFatherNameValid ?? this.isFatherNameValid,
        isDobValid: isDobValid ?? this.isDobValid,
        isAgeValid: isAgeValid ?? this.isAgeValid,
        isRelationWithApplicantValid:
        isRelationWithApplicantValid ?? this.isRelationWithApplicantValid);
  }
}

class AdditionalFamilyMemberModel {
  final String dependentDropdownValue;
  final String whetherEmployeeDropdownValue;
  final String additionalFamilyName;
  final String additionalFamilyRelation;
  final String additionalFamilyDob;
  final String additionalFamilyMobile;
  final String additionalFamilyOccupation;
  final String additionalFamilyNameOfDepartment;
  final String additionalFamilyCompanyName;
  final bool isAdditionalFamilyCompanyName;
  final bool isAdditionalFamilyNameOfDepartment;
  final bool isAdditionalFamilyOccupation;
  final bool isAdditionalFamilyMobile;
  final bool isAdditionalFamilyDob;
  final bool isAdditionalFamilyRelation;
  final bool isAdditionalFamilyName;

  AdditionalFamilyMemberModel(
      {this.dependentDropdownValue = '',
        this.whetherEmployeeDropdownValue = '',
        this.additionalFamilyName = '',
        this.additionalFamilyRelation = '',
        this.additionalFamilyDob = '',
        this.additionalFamilyMobile = '',
        this.additionalFamilyOccupation = '',
        this.additionalFamilyNameOfDepartment = '',
        this.additionalFamilyCompanyName = '',
        this.isAdditionalFamilyCompanyName = true,
        this.isAdditionalFamilyNameOfDepartment = true,
        this.isAdditionalFamilyOccupation = true,
        this.isAdditionalFamilyMobile = true,
        this.isAdditionalFamilyDob = true,
        this.isAdditionalFamilyRelation = true,
        this.isAdditionalFamilyName = true});

  AdditionalFamilyMemberModel copyWith(
      String? dependentDropdownValue,
      String? whetherEmployeeDropdownValue,
      String? additionalFamilyName,
      String? additionalFamilyRelation,
      String? additionalFamilyDob,
      String? additionalFamilyMobile,
      String? additionalFamilyOccupation,
      String? additionalFamilyNameOfDepartment,
      String? additionalFamilyCompanyName,
      bool? isAdditionalFamilyCompanyName,
      bool? isAdditionalFamilyNameOfDepartment,
      bool? isAdditionalFamilyOccupation,
      bool? isAdditionalFamilyMobile,
      bool? isAdditionalFamilyDob,
      bool? isAdditionalFamilyRelation,
      bool? isAdditionalFamilyName) {
    return AdditionalFamilyMemberModel(
        additionalFamilyCompanyName:
        additionalFamilyCompanyName ?? this.additionalFamilyCompanyName,
        additionalFamilyDob: additionalFamilyDob ?? this.additionalFamilyDob,
        additionalFamilyMobile:
        additionalFamilyMobile ?? this.additionalFamilyMobile,
        additionalFamilyName: additionalFamilyName ?? this.additionalFamilyName,
        additionalFamilyNameOfDepartment: additionalFamilyNameOfDepartment ??
            this.additionalFamilyNameOfDepartment,
        additionalFamilyOccupation:
        additionalFamilyOccupation ?? this.additionalFamilyOccupation,
        additionalFamilyRelation:
        additionalFamilyRelation ?? this.additionalFamilyRelation,
        dependentDropdownValue:
        dependentDropdownValue ?? this.dependentDropdownValue,
        isAdditionalFamilyCompanyName:
        isAdditionalFamilyCompanyName ?? this.isAdditionalFamilyCompanyName,
        isAdditionalFamilyDob:
        isAdditionalFamilyDob ?? this.isAdditionalFamilyDob,
        isAdditionalFamilyMobile:
        isAdditionalFamilyMobile ?? this.isAdditionalFamilyMobile,
        isAdditionalFamilyName:
        isAdditionalFamilyName ?? this.isAdditionalFamilyName,
        isAdditionalFamilyNameOfDepartment:
        isAdditionalFamilyNameOfDepartment ??
            this.isAdditionalFamilyNameOfDepartment,
        isAdditionalFamilyOccupation:
        isAdditionalFamilyOccupation ?? this.isAdditionalFamilyOccupation,
        isAdditionalFamilyRelation:
        isAdditionalFamilyRelation ?? this.isAdditionalFamilyRelation,
        whetherEmployeeDropdownValue:
        whetherEmployeeDropdownValue ?? this.whetherEmployeeDropdownValue);
  }
}

class NomineeInformationModel {
  final String nominationTypeDropdownValue;
  final String relationWithEmployee;
  final String nomineeName;
  final String nomineeAge;
  final String nomineeAddress;
  final String nomineeState;
  final String nomineeDistrict;
  final String nomineeBlock;
  final String nomineePanchayat;
  final String nomineePincode;
  final String nomineePhoneNumber;
  final bool isNomineePhoneNumber;
  final bool isNomineePincode;
  final bool isNomineePanchayat;
  final bool isNomineeBlock;
  final bool isNomineeDistrict;
  final bool isNomineeState;
  final bool isNomineeAddress;
  final bool isNomineeAge;
  final bool isNomineeName;
  final bool isRelationWithEmployee;
  final bool isNominationTypeDropdownValue;

  NomineeInformationModel(
      {this.nominationTypeDropdownValue = '',
        this.relationWithEmployee = '',
        this.nomineeName = '',
        this.nomineeAge = '',
        this.nomineeAddress = '',
        this.nomineeState = '',
        this.nomineeDistrict = '',
        this.nomineeBlock = '',
        this.nomineePanchayat = '',
        this.nomineePincode = '',
        this.nomineePhoneNumber = '',
        this.isNomineePhoneNumber = true,
        this.isNomineePincode = true,
        this.isNomineePanchayat = true,
        this.isNomineeBlock = true,
        this.isNomineeDistrict = true,
        this.isNomineeState = true,
        this.isNomineeAddress = true,
        this.isNomineeAge = true,
        this.isNomineeName = true,
        this.isRelationWithEmployee = true,
        this.isNominationTypeDropdownValue = true});

  NomineeInformationModel copyWith(
      String? nominationTypeDropdownValue,
      String? relationWithEmployee,
      String? nomineeName,
      String? nomineeAge,
      String? nomineeAddress,
      String? nomineeState,
      String? nomineeDistrict,
      String? nomineeBlock,
      String? nomineePanchayat,
      String? nomineePincode,
      String? nomineePhoneNumber,
      bool? isNomineePhoneNumber,
      bool? isNomineePincode,
      bool? isNomineePanchayat,
      bool? isNomineeBlock,
      bool? isNomineeDistrict,
      bool? isNomineeState,
      bool? isNomineeAddress,
      bool? isNomineeAge,
      bool? isNomineeName,
      bool? isRelationWithEmployee,
      bool? isNominationTypeDropdownValue) {
    return NomineeInformationModel(
        isNominationTypeDropdownValue:
        isNominationTypeDropdownValue ?? this.isNominationTypeDropdownValue,
        isNomineeAddress: isNomineeAddress ?? this.isNomineeAddress,
        isNomineeAge: isNomineeAge ?? this.isNomineeAge,
        isNomineeBlock: isNomineeBlock ?? this.isNomineeBlock,
        isNomineeDistrict: isNomineeDistrict ?? this.isNomineeDistrict,
        isNomineeName: isNomineeName ?? this.isNomineeName,
        isNomineePanchayat: isNomineePanchayat ?? this.isNomineePanchayat,
        isNomineePhoneNumber: isNomineePhoneNumber ?? this.isNomineePhoneNumber,
        isNomineePincode: isNomineePhoneNumber ?? this.isNomineePhoneNumber,
        isNomineeState: isNomineeState ?? this.isNomineeState,
        isRelationWithEmployee:
        isRelationWithEmployee ?? this.isRelationWithEmployee,
        nominationTypeDropdownValue:
        nominationTypeDropdownValue ?? this.nominationTypeDropdownValue,
        nomineeAddress: nomineeAddress ?? this.nomineeAddress,
        nomineeAge: nomineeAge ?? this.nomineeAge,
        nomineeBlock: nomineeBlock ?? this.nomineeBlock,
        nomineeDistrict: nomineeDistrict ?? this.nomineeDistrict,
        nomineeName: nomineeName ?? this.nomineeName,
        nomineePanchayat: nomineePanchayat ?? this.nomineePanchayat,
        nomineePhoneNumber: nomineePhoneNumber ?? this.nomineePhoneNumber,
        nomineePincode: nomineePincode ?? this.nomineePincode,
        nomineeState: nomineeState ?? this.nomineeState,
        relationWithEmployee:
        relationWithEmployee ?? this.relationWithEmployee);
  }
}

class EducationaldetailModel {
  final String education;
  final String nameOfBoard;
  final String markObtained;
  final String passingYear;
  final String stream;
  final String gradeDropdownValue;
  final bool? isEducationValid;
  final bool? isNameOfBoardValid;
  final bool? isMarkObtainedValid;
  final bool? isPassingYearValid;
  final bool? isStreamValid;
  final bool? isGradeDropdownValueValid;



  EducationaldetailModel({this.education = '',
    this.gradeDropdownValue = '',
    this.markObtained = '',
    this.nameOfBoard = '',
    this.passingYear = '',
    this.stream = '',
    this.isEducationValid,
    this.isNameOfBoardValid=true,
    this.isMarkObtainedValid=true,
    this.isPassingYearValid=true,
    this.isStreamValid=true,
    this.isGradeDropdownValueValid=true,
  });


  EducationaldetailModel copyWith({
    String? education,
    String? nameOfBoard,
    String? markObtained,
    String? passingYear,
    String? stream,
    String? gradeDropdownValue,
    bool? isEducationValid,
    bool? isNameOfBoardValid,
    bool? isMarkObtainedValid,
    bool? isPassingYearValid,
    bool? isStreamValid,
    bool? isGradeDropdownValueValid,
  }) {
    return EducationaldetailModel(
      education: education ?? this.education,
      nameOfBoard: nameOfBoard ?? this.nameOfBoard,
      markObtained: markObtained ?? this.markObtained,
      passingYear: passingYear ?? this.passingYear,
      stream: stream ?? this.stream,
      gradeDropdownValue: gradeDropdownValue ?? this.gradeDropdownValue,
      isEducationValid: isEducationValid ?? this.isEducationValid,
      isNameOfBoardValid: isNameOfBoardValid ?? this.isNameOfBoardValid,
      isMarkObtainedValid: isMarkObtainedValid ?? this.isMarkObtainedValid,
      isPassingYearValid: isPassingYearValid ?? this.isPassingYearValid,
      isStreamValid: isStreamValid ?? this.isStreamValid,
      isGradeDropdownValueValid: isGradeDropdownValueValid ?? this.isGradeDropdownValueValid,
    );
  }
}


class EmploymentHistoryModel {
  final String currentDesignation;
  final String lastOrganization;
  final String startDate;
  final String endDate;
  final String totalExperience;
  final String currentCTC;
  final bool? isCurrentDesignationValid;
  final bool? isLastOrganizationValid;
  final bool? isStartDateValid;
  final bool? isEndDateValid;
  final bool? isTotalExperienceValid;
  final bool? isCurrentCTCValid;


  // Constructor
  EmploymentHistoryModel({
    this.currentDesignation = '',
    this.lastOrganization = '',
    this.startDate = '',
    this.endDate = '',
    this.totalExperience = '',
    this.currentCTC = '',
    this.isCurrentDesignationValid=true,
    this.isLastOrganizationValid=true,
    this.isStartDateValid=true,
    this.isEndDateValid=true,
    this.isTotalExperienceValid=true,
    this.isCurrentCTCValid=true,
  });


  // copyWith method for creating a copy with updated values
  EmploymentHistoryModel copyWith({
    String? currentDesignation,
    String? lastOrganization,
    String? startDate,
    String? endDate,
    String? totalExperience,
    String? currentCTC,
    bool? isCurrentDesignationValid,
    bool? isLastOrganizationValid,
    bool? isStartDateValid,
    bool? isEndDateValid,
    bool? isTotalExperienceValid,
    bool? isCurrentCTCValid,
  }) {
    return EmploymentHistoryModel(
      currentDesignation: currentDesignation ?? this.currentDesignation,
      lastOrganization: lastOrganization ?? this.lastOrganization,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      totalExperience: totalExperience ?? this.totalExperience,
      currentCTC: currentCTC ?? this.currentCTC,
      isCurrentDesignationValid: isCurrentDesignationValid ?? this.isCurrentDesignationValid,
      isLastOrganizationValid: isLastOrganizationValid ?? this.isLastOrganizationValid,
      isStartDateValid: isStartDateValid ?? this.isStartDateValid,
      isEndDateValid: isEndDateValid ?? this.isEndDateValid,
      isTotalExperienceValid: isTotalExperienceValid ?? this.isTotalExperienceValid,
      isCurrentCTCValid: isCurrentCTCValid ?? this.isCurrentCTCValid,
    );
  }
}
