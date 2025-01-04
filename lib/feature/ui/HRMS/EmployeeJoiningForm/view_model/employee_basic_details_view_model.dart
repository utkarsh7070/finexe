import 'package:dio/dio.dart';
import 'package:dropdown_textfield/dropdown_textfield.dart';
import 'package:flutter/Material.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import '../../../../base/api/api.dart';
import '../../../../base/api/dio.dart';
import '../../../../base/utils/widget/custom_snackbar.dart';
import '../../../Sales/SalesOnBoardingForm/model/request_model/aadhaar_number_request_model.dart';
import '../../../Sales/SalesOnBoardingForm/model/request_model/aadhaar_otp_request_model.dart';
import '../../../Sales/SalesOnBoardingForm/model/responce_model/aadhaar_otp_responce_model.dart';
import '../../../Sales/SalesOnBoardingForm/model/responce_model/aadhar_number_response_model.dart';

final employeeDetailsController = StateNotifierProvider<
    EmployeeDetailsControllerNotifier, EmployeeDetailsController>((ref) {
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

bool _validString(String val) {
  return val.isNotEmpty;
}

bool _validContact(String val) {
  return val.isNotEmpty && val.length == 10;
}
//------------------------end--------------------------------------------------------------

final joiningFormFocusProvider =
    StateNotifierProvider<JoiningFormFocusProvider, Map<String, bool>>((ref) {
  return JoiningFormFocusProvider();
});

class JoiningFormFocusProvider extends StateNotifier<Map<String, bool>> {
  final FocusNode categoryFocusNode;
  final FocusNode religionFocusNode;
  final FocusNode bloodFocusNode;

  // final FocusNode religionFocusNode;

  JoiningFormFocusProvider()
      : categoryFocusNode = FocusNode(),
        religionFocusNode = FocusNode(),
        bloodFocusNode = FocusNode(),
        super({
          'categoryFocusNode': false,
          'religionFocusNode': false,
          'bloodFocusNode': false,
        }) {
    categoryFocusNode.addListener(
      () => _focusListener('categoryFocusNode', categoryFocusNode),
    );
    religionFocusNode.addListener(
        () => _focusListener('religionFocusNode', religionFocusNode));
    bloodFocusNode
        .addListener(() => _focusListener('bloodFocusNode', bloodFocusNode));
  }

  void _focusListener(String field, FocusNode focusNode) {
    state = {
      ...state,
      field: focusNode.hasFocus,
    };
  }

  @override
  void dispose() {
    categoryFocusNode.removeListener(
      () => _focusListener('categoryFocusNode', categoryFocusNode),
    );
    religionFocusNode.removeListener(
        () => _focusListener('religionFocusNode', religionFocusNode));
    bloodFocusNode
        .removeListener(() => _focusListener('bloodFocusNode', bloodFocusNode));
    categoryFocusNode.dispose();
    religionFocusNode.dispose();
    bloodFocusNode.dispose();
    super.dispose();
  }
}

final employeeViewModelProvider =
    StateNotifierProvider<EmployeeDetailsViewModel, EmployeeDetailsModel>(
        (ref) {
  final dio = ref.watch(dioProvider);
  // final checkStatus = ref.watch(checkBoxTermsConditionApplicant);
  return EmployeeDetailsViewModel(dio);
});

class EmployeeDetailsViewModel extends StateNotifier<EmployeeDetailsModel> {
  final Dio dio;

  EmployeeDetailsViewModel(this.dio)
      : super(EmployeeDetailsModel(
            additionalFamilyMember: [AdditionalFamilyMemberModel()],
            nomineeInformation: [NomineeInformationModel()]));
  final TextEditingController dobController = TextEditingController();
  final SingleValueDropDownController dependentDropdownControllerProvider =
      SingleValueDropDownController();
  final SingleValueDropDownController nominationTypeControllerProvider =
      SingleValueDropDownController();
  final SingleValueDropDownController
      whetherEmployeeDropdownControllerProvider =
      SingleValueDropDownController();
  final SingleValueDropDownController categoryControllerProvider =
      SingleValueDropDownController();
  final SingleValueDropDownController religionControllerProvider =
      SingleValueDropDownController();
  final SingleValueDropDownController bloodGroupControllerProvider =
      SingleValueDropDownController();
  AadhaarNumberResponseModel? aadhaarNumberResponseModel;
  AadhaarOtpResponseModel? aadhaarOtpResponseModel;

  final TextEditingController permanentAddress1Controller =
      TextEditingController();
  final TextEditingController permanentAddress2Controller =
      TextEditingController();
  final TextEditingController permanentCityController = TextEditingController();
  final TextEditingController permanentStateController =
      TextEditingController();
  final TextEditingController permanentDistrictController =
      TextEditingController();
  final TextEditingController permanentPinCodeController =
      TextEditingController();
  final TextEditingController fullNameController =
      TextEditingController();

  List<DropDownValueModel> dependentDropdown = const [
    DropDownValueModel(name: 'Yes', value: 'Yes'),
    DropDownValueModel(name: 'No', value: 'No')
  ];
  List<DropDownValueModel> nominationTypeDropdown = const [
    DropDownValueModel(name: 'Primary', value: 'Primary'),
    DropDownValueModel(name: 'Secondary', value: 'Secondary')
  ];

  List<DropDownValueModel> whetherEmployeeDropdown = const [
    DropDownValueModel(name: 'State', value: 'State'),
    DropDownValueModel(name: 'Center', value: 'Center'),
    DropDownValueModel(name: 'Unemployed', value: 'Unemployed'),
  ];
  List<DropDownValueModel> categoryDropdown = const [
    DropDownValueModel(name: 'General', value: 'General'),
    DropDownValueModel(name: 'OBC', value: 'OBC'),
    DropDownValueModel(name: 'ST', value: 'ST'),
    DropDownValueModel(name: 'SC', value: 'SC'),
  ];
  List<DropDownValueModel> religionDropdown = const [
    DropDownValueModel(name: 'Hindu', value: 'Hindu'),
    DropDownValueModel(name: 'Christen', value: 'Christen'),
    DropDownValueModel(name: 'Muslim', value: 'Muslim'),
    DropDownValueModel(name: 'Sikh', value: 'Sikh'),
    DropDownValueModel(name: 'Other', value: 'Other'),
  ];
  List<DropDownValueModel> bloodGroupDropdown = const [
    DropDownValueModel(name: 'A+', value: 'A+'),
    DropDownValueModel(name: 'A-', value: 'A-'),
    DropDownValueModel(name: 'B+', value: 'B-'),
    DropDownValueModel(name: 'AB+', value: 'AB-'),
    DropDownValueModel(name: 'O+', value: 'O+'),
    DropDownValueModel(name: 'O-', value: 'O-'),
  ];

  @override
  void dispose() {
    dependentDropdownControllerProvider.dispose();
    whetherEmployeeDropdownControllerProvider.dispose();
    categoryControllerProvider.dispose();
    religionControllerProvider.dispose();
    bloodGroupControllerProvider.dispose();
    dobController.dispose();
    permanentAddress1Controller.dispose();
    permanentAddress2Controller.dispose();
    permanentCityController.dispose();
    permanentDistrictController.dispose();
    permanentPinCodeController.dispose();
    permanentStateController.dispose();
    fullNameController.dispose();
    super.dispose();
  }

  Future<bool> fetchAadhaarNumber(context) async {
    state = state.copyWith(isLoading: true);
    // await fetchPanVerify(context);
    // on DioException catch (error)
    if (kDebugMode) {
      print(state.aadhaar);
    }
    final aadhaarNumberRequestModel = AadhaarNumberRequestModel(
        aadharNo: state.aadhaar.trim().toString(),
        transId: '12345',
        docType: '211',
        formName: 'joiningForm');
    try {
      final response = await dio.post(Api.aadhaarNumber,
          data: aadhaarNumberRequestModel.toJson());
      var responseData = response.data;
      print('Login response: $responseData');
      var message = responseData['message'];
      print(message);
      if (response.statusCode == 400) {
        state = state.copyWith(isLoading: false);
        showCustomSnackBar(context, message, Colors.red);
        return true;
      }
      if (kDebugMode) {
        print(response.data);
      }
      if (response.statusCode == 200) {
        aadhaarNumberResponseModel =
            AadhaarNumberResponseModel.fromJson(response.data);
        state = state.copyWith(isLoading: false);
        return true;
      } else {
        state = state.copyWith(isLoading: false);
        return false;
      }
    } catch (e) {
      state = state.copyWith(isLoading: false);
      throw Exception(e);
    }
  }

  Future<bool> submitOtp() async {
    state = state.copyWith(isLoading: true);
    if (kDebugMode) {
      print(state.otp);
    }
    final aadhaarOtpRequestModel = AadhaarOtpRequestModel(
        transId: aadhaarNumberResponseModel!.items.tsTransId,
        otp: int.parse(state.otp));
    if (kDebugMode) {
      print(int.parse(state.otp));
      print(
        aadhaarNumberResponseModel!.items.tsTransId,
      );
    }

    try {
      final response = await dio.post(Api.aadhaarOtpVerify,
          data: aadhaarOtpRequestModel.toJson());
      if (response.statusCode == 200) {
        state = state.copyWith(isLoading: false);
        aadhaarOtpResponseModel =
            AadhaarOtpResponseModel.fromJson(response.data);

        state = state.copyWith(
          fullName: aadhaarOtpResponseModel!.items.msg.name,
          permanentAddress1:
              '${aadhaarOtpResponseModel!.items.msg.house}, ${aadhaarOtpResponseModel!.items.msg.street}, ${aadhaarOtpResponseModel!.items.msg.landmark},${aadhaarOtpResponseModel!.items.msg.locality}',
          permanentDistrict: aadhaarOtpResponseModel!.items.msg.district,
          permanentCity: aadhaarOtpResponseModel!.items.msg.villageTownCity,
          permanentPinCode: aadhaarOtpResponseModel!.items.msg.pincode,
          permanentState: aadhaarOtpResponseModel!.items.msg.state,
          // gender: aadhaarOtpResponseModel!.items.msg.gender,
        );
        permanentStateController.text =
            aadhaarOtpResponseModel!.items.msg.state;
        permanentPinCodeController.text =
            aadhaarOtpResponseModel!.items.msg.pincode;
        permanentCityController.text =
            aadhaarOtpResponseModel!.items.msg.villageTownCity;
        permanentDistrictController.text =
            aadhaarOtpResponseModel!.items.msg.district;
        permanentAddress1Controller.text =
            '${aadhaarOtpResponseModel!.items.msg.house}, ${aadhaarOtpResponseModel!.items.msg.street}, ${aadhaarOtpResponseModel!.items.msg.landmark},${aadhaarOtpResponseModel!.items.msg.locality}';
        fullNameController.text =  aadhaarOtpResponseModel!.items.msg.name;
        // AadhaarNumberResponseModel.fromJson(response.data);
        return true;
      } else {
        state = state.copyWith(isLoading: false);
        return false;
      }
    } catch (e) {
      state = state.copyWith(isLoading: false);
      throw Exception(e);
    }
  }

  void updateFathers(String val) {
    final valid = _validString(val);
    state = state.copyWith(fatherName: val, isFatherNameValid: valid);
  }

  void updateName(String val) {
    final valid = _validString(val);
    state = state.copyWith(fullName: val, isFullNameValid: valid);
  }

  void updateGender(String val) {
    final valid = _validString(val);
    state = state.copyWith(gender: val, isGenderValid: valid);
  }

  void updateMaritalStatus(String val) {
    final valid = _validString(val);
    state = state.copyWith(marital: val, isMaritalValid: valid);
  }

  void updateContact(String val) {
    final valid = _validContact(val);
    state = state.copyWith(contact: val, isContactValid: valid);
  }

  void updateEmail(String val) {
    final valid = _validString(val);
    state = state.copyWith(email: val, isEmailValid: valid);
  }

  void updateDob(String val) {
    final valid = _validString(val);
    state = state.copyWith(dob: val, isDobValid: valid);
  }

  void updateIdentityMark(String val) {
    final valid = _validString(val);
    state = state.copyWith(identityMark: val, isIdentityMark: valid);
  }

  void updatePermanentAddress(String val) {
    final valid = _validString(val);
    state =
        state.copyWith(permanentAddress1: val, isPermanentAddress1Valid: valid);
  }

  void updatePermanentAddressState(String val) {
    final valid = _validString(val);
    state = state.copyWith(permanentState: val, isPermanentStateValid: valid);
  }

  void updatePermanentCity(String val) {
    final valid = _validString(val);
    state = state.copyWith(permanentCity: val, isPermanentCityValid: valid);
  }

  void updatePermanentPinCode(String val) {
    final valid = _validString(val);
    state =
        state.copyWith(permanentPinCode: val, isPermanentPinCodeValid: valid);
  }

  void updateLatitude(String val) {
    final valid = _validString(val);
    state = state.copyWith(latitude: val, isLatitude: valid);
  }

  void updateLongitude(String val) {
    final valid = _validString(val);
    state = state.copyWith(longitude: val, isLongitude: valid);
  }

  void updateCurrentAddress(String val) {
    final valid = _validString(val);
    state = state.copyWith(
        communicationAddress1: val, isCommunicationAddress1Valid: valid);
  }

  void updateCurrentState(String val) {
    final valid = _validString(val);
    state = state.copyWith(
        communicationState: val, isCommunicationStateValid: valid);
  }

  void updateCurrentCity(String val) {
    final valid = _validString(val);
    state =
        state.copyWith(communicationCity: val, isCommunicationCityValid: valid);
  }

  void updateCurrentPinCode(String val) {
    final valid = _validString(val);
    state = state.copyWith(
        communicationPinCode: val, isCommunicationPinCodeValid: valid);
  }

  void updateBankAccountNumber(String val) {
    final valid = _validString(val);
    state = state.copyWith(bankAccountNumber: val, isBankAccountNumber: valid);
  }

  void updateEsicNumber(String val) {
    final valid = _validString(val);
    state = state.copyWith(esicNumber: val, isEsicNumber: valid);
  }

  void updateCaste(String val) {
    final valid = _validString(val);
    state = state.copyWith(caste: val, isCasteValid: valid);
  }

  void updateCategory(String val) {
    final valid = _validString(val);
    state = state.copyWith(category: val, isCategory: valid);
  }

  void updateReligion(String val) {
    final valid = _validString(val);
    state = state.copyWith(religion: val, isReligionValid: valid);
  }

  void updateNomineeName(String val) {}

  void updateRelationWithEmployee(String val) {}

  void updateNominationType(String val) {}

  void updateNomineeAge(String val) {}

  void updateNomineeAddress(String val) {}

  void updateNomineeState(String val) {}

  void updateNomineeDistrict(String val) {}

  void updateNomineeBlock(String val) {}

  void updateNomineePanchayat(String val) {}

  void updateNomineePincode(String val) {}

  void updateNomineePhoneNumber(String val) {}

  void updateBloodGroup(String val) {}

  void updateHomeDistrict(String val) {}

  void updateHomeState(String val) {}

  void updateNearestRailwayStation(String val) {}

  void updateUniversity(String val) {}

  void updateUANNo(String val) {}

  void updateBranchAddress(String val) {}

  void updateNameAsPerBank(String val) {}

  void updateBankName(String val) {}

  void updateIfscCode(String val) {}

  void updateAdditionalFamilyCompany(String val) {}

  void updateFathersOccupations(String val) {}

  void updateFathersContact(String val) {}

  void updateMothersName(String val) {}

  void updateMothersContact(String val) {}

  void updateFamilyIncome(String val) {}

  void updateAdditionalFamilyName(String val) {}

  void updateAdditionalFamilyRelation(String val) {}

  void updateAdditionalFamilyDob(String val) {}

  void updateAdditionalFamilyDependent(String val) {}

  void updateAdditionalFamilyWhetherEmployee(String val) {}

  void updateAdditionalFamilyOccupation(String val) {}

  void updateAdditionalFamilyDepartment(String val) {}

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
    state = state.copyWith(additionalFamilyMember: [
      for (int i = 0; i < state.additionalFamilyMember.length; i++)
        if (i != index) state.additionalFamilyMember[i],
    ]);
  }

  void addNominee() {
    state = state.copyWith(nomineeInformation: [
      ...state.nomineeInformation,
      NomineeInformationModel()
    ]);
  }

  void removeNominee(int index) {
    state = state.copyWith(nomineeInformation: [
      for (int i = 0; i < state.nomineeInformation.length; i++)
        if (i != index) state.nomineeInformation[i],
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
    if (pickedDate != null) {
      String? formattedDate = DateFormat('dd/MM/yyyy').format(pickedDate);
      dobController.text = formattedDate;
      state = state.copyWith(dob: formattedDate);
    }
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
  final List<NomineeInformationModel> nomineeInformation;

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

  EmployeeDetailsModel copyWith(
      {String? esicNumber,
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
