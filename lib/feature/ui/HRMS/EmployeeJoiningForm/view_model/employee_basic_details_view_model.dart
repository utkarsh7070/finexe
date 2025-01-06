import 'package:dio/dio.dart';
import 'package:dropdown_textfield/dropdown_textfield.dart';
import 'package:finexe/feature/base/api/dio.dart';
import 'package:finexe/feature/base/api/dio_exception.dart';
import 'package:finexe/feature/base/utils/Repo/image_upload.dart';
import 'package:finexe/feature/ui/HRMS/EmployeeJoiningForm/model/employee_model.dart';
import 'package:flutter/Material.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import '../../../../base/api/api.dart';
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
      nomineeInformation: [NomineeInformationModel()],
      educationalDetail: [EducationaldetailModel()],
      employmentHistory: [EmploymentHistoryModel()],
      documents: List.filled(10, ''),
      isLoading: List.filled(11, false)));
  final TextEditingController dobController = TextEditingController();
  final SingleValueDropDownController dependentDropdownControllerProvider =
  SingleValueDropDownController();
  final SingleValueDropDownController
  whetherEmployeeDropdownControllerProvider =
  SingleValueDropDownController();
  final SingleValueDropDownController gradeDropdownControllerProvider =
  SingleValueDropDownController();

  final SingleValueDropDownController nominationTypeControllerProvider =
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
  final TextEditingController fullNameController = TextEditingController();

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

  List<Map<String, String>> documentsName = [
    {"Employee Photo": "20 KB"}, // Small image file (e.g., JPEG, PNG)
    {"Resume": "100 KB"}, // PDF or DOCX file with text
    {"Bank Details": "150 KB"}, // Bank statement or passbook snapshot
    {"Aadhar Card": "50 KB"}, // Scanned image of Aadhar card
    {"PAN Card": "50 KB"}, // Scanned image of PAN card
    {"Education Certification": "200 KB"}, // Scanned copy or PDF of certificate
    {"Experience Letter": "150 KB"}, // Scanned letter or PDF
    {
      "Employment Proof": "200 KB"
    }, // Employment-related document (e.g., work contract)
    {
      "Bank Account Proof": "100 KB"
    }, // Bank account-related document (e.g., statement)
    {"Offer Letter": "120 KB"} // Offer letter in PDF or Word format
  ];

// educational detail dropdown
  List<DropDownValueModel> gradedropdown = const [
    DropDownValueModel(name: 'A+', value: 'A+'),
    DropDownValueModel(name: 'A', value: 'A'),
    DropDownValueModel(name: 'B+', value: 'B+'),
    DropDownValueModel(name: 'B', value: 'B'),
    DropDownValueModel(name: 'C', value: 'C'),
    DropDownValueModel(name: 'D', value: 'D'),
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
    gradeDropdownControllerProvider.dispose();
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

  // <<<<<><<<<<<<<<<<<<<<employment hisatory >>>>>>>>>>>>>
  void updateCurrentDesignation(String val) {}

  void updateLastOrganization(String val) {}

  void updateStartDate(String val) {}

  void updateEndDate(String val) {}

  void updateTotalExperience(String val) {}

  void updateCurrentCTC(String val) {}

  // <<<<<><<<<<<<<<<<<<<<employment hisatory END>>>>>>>>>>>>>

  // <<<<<<<<<<<<<<<<<<<<<<<<educational detail >>>>>>>>>>>>>>>>>>>>

  void updateEducation(String val) {}

  void updateNameofboard(String val) {}

  void updateMarkobtained(String val) {}

  void updatePassingyear(String val) {}

  void updateStream(String val) {}

  void updategrade(String val) {}

  // <<<<<<<<<<<<<<<<<<<<<<<<educational detail END>>>>>>>>>>>>>>>>>>>>

  Future<bool> fetchAadhaarNumber(context) async {
    state = state.copyWith(isLoading: [
      ...state.isLoading.sublist(0, 11),
      true,
      ...state.isLoading.sublist(10 + 1),
    ]);
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
        state = state.copyWith(isLoading: [
          ...state.isLoading.sublist(0, 11),
          false,
          ...state.isLoading.sublist(10 + 1),
        ]);
        showCustomSnackBar(context, message, Colors.red);
        return true;
      }
      if (kDebugMode) {
        print(response.data);
      }
      if (response.statusCode == 200) {
        aadhaarNumberResponseModel =
            AadhaarNumberResponseModel.fromJson(response.data);
        return true;
      } else {
        return false;
      }
    } catch (e) {
      throw Exception(e);
    } finally {
      state = state.copyWith(isLoading: [
        ...state.isLoading.sublist(0, 11),
        false,
        ...state.isLoading.sublist(10 + 1),
      ]);
    }
  }

  Future<bool> submitOtp() async {
    state = state.copyWith(isLoading: [
      ...state.isLoading.sublist(0, 11),
      true,
      ...state.isLoading.sublist(10 + 1),
    ]);
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
        fullNameController.text = aadhaarOtpResponseModel!.items.msg.name;
        // AadhaarNumberResponseModel.fromJson(response.data);
        return true;
      } else {
        return false;
      }
    } catch (e) {
      throw Exception(e);
    } finally {
      state = state.copyWith(isLoading: [
        ...state.isLoading.sublist(0, 11),
        false,
        ...state.isLoading.sublist(10 + 1),
      ]);
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

// add documents
  Future<void> addDocsMember(int index) async {
    state = state.copyWith(isLoading: [
      ...state.isLoading.sublist(0, index),
      true,
      ...state.isLoading.sublist(index + 1),
    ]);
    try {
      await DocsUploader.uploadImage(dio).then(
            (value) {
          if (value != null) {
            state = state.copyWith(
              documents: [
                ...state.documents.sublist(0, index),
                value,
                ...state.documents.sublist(index + 1),
              ],
            );
          }
        },
      );
    } catch (e) {
      ExceptionHandler().handleError(e);
    } finally {
      state = state.copyWith(isLoading: [
        ...state.isLoading.sublist(0, index),
        false,
        ...state.isLoading.sublist(index + 1),
      ]);
    }
  }

// family detail
  void addFamilyMember() {
    state = state.copyWith(additionalFamilyMember: [
      ...state.additionalFamilyMember,
      AdditionalFamilyMemberModel()
    ]);
  }

  void removeFamilyItem(int index) {
    state = state.copyWith(additionalFamilyMember: [
      for (int i = 0; i < state.additionalFamilyMember.length; i++)
        if (i != index) state.additionalFamilyMember[i],
    ]);
  }

// educational detail

  void addEducationalDetail() {
    state = state.copyWith(educationalDetail: [
      ...state.educationalDetail,
      EducationaldetailModel()
    ]);
  }

  void removeEducationalItem(int index) {
    state = state.copyWith(educationalDetail: [
      for (int i = 0; i < state.educationalDetail.length; i++)
        if (i != index) state.educationalDetail[i],
    ]);
  }

  // employment history

  void addEmpHistory() {
    state = state.copyWith(employmentHistory: [
      ...state.employmentHistory,
      EmploymentHistoryModel()
    ]);
    print('add ${state.employmentHistory.length}');
  }

  void removeEmpHistory(int index) {
    print(index);
    state = state.copyWith(employmentHistory: [
      for (int i = 0; i < state.employmentHistory.length; i++)
        if (i != index) state.employmentHistory[i],
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

