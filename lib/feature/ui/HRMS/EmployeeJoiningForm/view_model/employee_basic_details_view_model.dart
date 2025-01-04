import 'package:dio/dio.dart';
import 'package:dropdown_textfield/dropdown_textfield.dart';
import 'package:finexe/feature/base/api/dio.dart';
import 'package:finexe/feature/base/api/dio_exception.dart';
import 'package:finexe/feature/base/utils/Repo/image_upload.dart';
import 'package:finexe/feature/ui/HRMS/EmployeeJoiningForm/model/employee_model.dart';
import 'package:flutter/Material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

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
//------------------------end--------------------------------------------------------------

final employeeViewModelProvider =
    StateNotifierProvider<EmployeeDetailsViewModel, EmployeeDetailsModel>(
        (ref) {
  final dio = ref.watch(dioProvider);
  // final checkStatus = ref.watch(checkBoxTermsConditionApplicant);
  return EmployeeDetailsViewModel(dio);
});

// final isLoading = StateProvider<bool>((ref) => false);

class EmployeeDetailsViewModel extends StateNotifier<EmployeeDetailsModel> {
  final Dio dio;
  EmployeeDetailsViewModel(this.dio)
      : super(EmployeeDetailsModel(
            additionalFamilyMember: [AdditionalFamilyMemberModel()],
            educationalDetail: [EducationaldetailModel()],
            employmentHistory: [EmploymentHistoryModel()],
            documents: List.filled(10, ''),
            isLoading:List.filled(11, false) ));
  final SingleValueDropDownController dependentDropdownControllerProvider =
      SingleValueDropDownController();
  final SingleValueDropDownController
      whetherEmployeeDropdownControllerProvider =
      SingleValueDropDownController();
  final SingleValueDropDownController gradeDropdownControllerProvider =
      SingleValueDropDownController();

  List<DropDownValueModel> dependentDropdown = const [
    DropDownValueModel(name: 'Yes', value: 'Yes'),
    DropDownValueModel(name: 'No', value: 'No')
  ];

  List<DropDownValueModel> whetherEmployeeDropdown = const [
    DropDownValueModel(name: 'State', value: 'State'),
    DropDownValueModel(name: 'Center', value: 'Center'),
    DropDownValueModel(name: 'Unemployed', value: 'Unemployed'),
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

  @override
  void dispose() {
    gradeDropdownControllerProvider.dispose();
    dependentDropdownControllerProvider.dispose();
    whetherEmployeeDropdownControllerProvider.dispose();
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

  void updateFathers(String val) {}
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
  
    state = state.copyWith(isLoading: [ ...state.isLoading.sublist(0, index),
                true,
                ...state.isLoading.sublist(index + 1),]);
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
     state = state.copyWith(isLoading: [ ...state.isLoading.sublist(0, index),
                false,
                ...state.isLoading.sublist(index + 1),]);

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
