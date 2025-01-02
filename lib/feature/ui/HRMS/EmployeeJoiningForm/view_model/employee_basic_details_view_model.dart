import 'package:dropdown_textfield/dropdown_textfield.dart';
import 'package:flutter/Material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final employeeDetailsController = StateNotifierProvider<
    EmployeeDetailsControllerNotifier,
    EmployeeDetailsController>((ref) {
  return EmployeeDetailsControllerNotifier();
});

class EmployeeDetailsControllerNotifier
    extends StateNotifier<EmployeeDetailsController> {
  EmployeeDetailsControllerNotifier()
      : super(EmployeeDetailsController(
    contactController: TextEditingController(),
    dobController: TextEditingController(),
    communicationAddress1Controller: TextEditingController(),
    communicationAddress2Controller: TextEditingController(),
    communicationCityController: TextEditingController(),
    communicationDistrictController: TextEditingController(),
    communicationPinCodeController: TextEditingController(),
    communicationStateController: TextEditingController(),
    emailController: TextEditingController(),
    fatherNameController: TextEditingController(),
    fullNameController: TextEditingController(),
    genderController: TextEditingController(),
    otpController: TextEditingController(),
    permanentAddress1Controller: TextEditingController(),
    permanentAddress2Controller: TextEditingController(),
    permanentCityController: TextEditingController(),
    permanentDistrictController: TextEditingController(),
    permanentPinCodeController: TextEditingController(),
    permanentStateController: TextEditingController(),
  ));

  @override
  void dispose() {
    state.contactController.dispose();
    state.emailController.dispose();
    state.otpController.dispose();
    state.genderController.dispose();
    state.communicationAddress2Controller.dispose();
    state.communicationCityController.dispose();
    state.communicationStateController.dispose();
    state.communicationDistrictController.dispose();
    state.communicationPinCodeController.dispose();
    state.communicationAddress1Controller.dispose();
    state.dobController.dispose();
    state.fatherNameController.dispose();
    state.fullNameController.dispose();
    state.permanentAddress1Controller.dispose();
    state.permanentAddress2Controller.dispose();
    state.permanentCityController.dispose();
    state.permanentStateController.dispose();
    state.permanentDistrictController.dispose();
    state.permanentPinCodeController.dispose();
    super.dispose();
  }
}

class EmployeeDetailsController {
  final TextEditingController contactController;
  final TextEditingController emailController;
  final TextEditingController otpController;

  final TextEditingController genderController;
  final TextEditingController fullNameController;
  final TextEditingController fatherNameController;
  final TextEditingController dobController;

  final TextEditingController communicationAddress1Controller;
  final TextEditingController communicationAddress2Controller;
  final TextEditingController communicationCityController;
  final TextEditingController communicationStateController;
  final TextEditingController communicationDistrictController;
  final TextEditingController communicationPinCodeController;

  final TextEditingController permanentAddress1Controller;
  final TextEditingController permanentAddress2Controller;
  final TextEditingController permanentCityController;
  final TextEditingController permanentStateController;
  final TextEditingController permanentDistrictController;
  final TextEditingController permanentPinCodeController;

  // final TextEditingController titleController;
  // final TextEditingController descriptionController;

  EmployeeDetailsController({
    required this.contactController,
    required this.emailController,
    required this.fatherNameController,
    required this.communicationAddress1Controller,
    required this.communicationAddress2Controller,
    required this.communicationCityController,
    required this.communicationStateController,
    required this.communicationDistrictController,
    required this.communicationPinCodeController,
    required this.permanentAddress1Controller,
    required this.permanentAddress2Controller,
    required this.permanentCityController,
    required this.permanentStateController,
    required this.permanentDistrictController,
    required this.permanentPinCodeController,
    required this.fullNameController,
    required this.dobController,
    required this.genderController,
    required this.otpController,
  });
}

//-----------------validation function-----------------------------------------------------
bool _validateAadhaar(String aadhaar) {
  return aadhaar.length >= 12 && aadhaar.isNotEmpty;
}

bool _validatePan(String pan) {
  return pan.length >= 10 && pan.isNotEmpty;
}

bool _validateOtp(String aadhaar) {
  return aadhaar.length >= 6 && aadhaar.isNotEmpty;
}
//------------------------end--------------------------------------------------------------

final employeeViewModelProvider =
StateNotifierProvider<EmployeeDetailsViewModel, EmployeeDetailsModel>(
        (ref) {
      // final dio = ref.read(dioProvider);
      // final checkStatus = ref.watch(checkBoxTermsConditionApplicant);
      return EmployeeDetailsViewModel();
    });

class EmployeeDetailsViewModel extends StateNotifier<EmployeeDetailsModel> {
  EmployeeDetailsViewModel() : super(EmployeeDetailsModel());
  final SingleValueDropDownController dependentDropdownControllerProvider = SingleValueDropDownController();
  final SingleValueDropDownController whetherEmployeeDropdownControllerProvider = SingleValueDropDownController();

  List<DropDownValueModel> dependentDropdown = const [
    DropDownValueModel(name: 'Yes', value: 'Yes'),
    DropDownValueModel(name: 'No', value: 'No')
  ];

  List<DropDownValueModel> whetherEmployeeDropdown = const [
    DropDownValueModel(name: 'State', value: 'State'),
    DropDownValueModel(name: 'Center', value: 'Center'),
    DropDownValueModel(name: 'Unemployed', value: 'Unemployed'),
  ];

  @override
  void dispose() {
    dependentDropdownControllerProvider.dispose();
    whetherEmployeeDropdownControllerProvider.dispose();
    super.dispose();
  }

  void updateFathers(String val){

  }
  void updateAdditionalFamilyCompany(String val){

  }
  void updateFathersOccupations(String val){

  }
  void updateFathersContact(String val){

  }
  void updateMothersName(String val){

  }
  void updateMothersContact(String val){

  }
  void updateFamilyIncome(String val){

  }
  void updateAdditionalFamilyName(String val){

  }
  void updateAdditionalFamilyRelation(String val){

  }
  void updateAdditionalFamilyDob(String val){

  }
  void updateAdditionalFamilyDependent(String val){

  }
  void updateAdditionalFamilyWhetherEmployee(String val){

  }
  void updateAdditionalFamilyOccupation(String val){

  }
  void updateAdditionalFamilyDepartment(String val){

  }

  void otpUpdate(String otp) {
    final valid = _validateOtp(otp);
    state = state.copyWith(otp: otp, isOtpValid: valid);
  }

  void addFamilyMember() {
    state = state.copyWith(additionalFamilyMember: [
      ...state.additionalFamilyMember,
      AdditionalFamilyMemberModel()
    ]);
  }

  void removeItem(int index) {
    state = state.copyWith(additionalFamilyMember:  [
      for (int i = 0; i < state.additionalFamilyMember.length; i++)
        if (i != index) state.additionalFamilyMember[i],
    ]);

  }


  // void removeItem(int index) {
  //   state = [
  //     for (int i = 0; i < state.length; i++)
  //       if (i != index) state[i],
  //   ];
  //
  // }

  Future<void> openDatePicker(BuildContext context) async {
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (pickedDate != null) {}
  }

  void updateAadhaar(String aadhaar) {
    final valid = _validateAadhaar(aadhaar);
    state = state.copyWith(aadhaar: aadhaar, isAadhaarValid: valid);
  }

  void updatePan(String pan) {
    final valid = _validatePan(pan);
    state = state.copyWith(aadhaar: pan, isPanValid: valid);
  }
}

class EmployeeDetailsModel {
  final bool isLoading;
  final String applicantPhotoFilePath;
  final bool isApplicantPhoto;
  final String aadhaarPhotoFilePath1;
  final String aadhaarPhotoFilePath2;
  final bool checkBoxTermsConditionApplicant;
  final String careOf;
  final List<AdditionalFamilyMemberModel> additionalFamilyMember;

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
    this.additionalFamilyMember = const [],
    this.panFather = '',
    this.panDob = '',
    this.panGender = '',
    this.panName = '',
    this.isApplicantFormSubmitted = false,
    this.careOf = '',
    this.isApplicantPhoto = true,
    this.isLoading = false,
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

  EmployeeDetailsModel copyWith({String? panFather,
    List<AdditionalFamilyMemberModel>? additionalFamilyMember,
    String? panName,
    String? panGender,
    String? panDob,
    bool? isLoading,
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
        isLoading: isLoading ?? this.isLoading,
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

  AdditionalFamilyMemberModel({this.dependentDropdownValue = '',
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

  AdditionalFamilyMemberModel copyWith(String? dependentDropdownValue,
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
