import 'package:dio/dio.dart';
import 'package:dropdown_textfield/dropdown_textfield.dart';
import 'package:finexe/feature/base/api/api.dart';
import 'package:finexe/feature/ui/Sales/SalesOnBoardingForm/model/responce_model/pan_response_model.dart';
import 'package:finexe/feature/ui/Sales/SalesOnBoardingForm/model/responce_model/submit_co_applicant_response_model.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../base/api/dio.dart';
import '../model/request_model/aadhaar_number_request_model.dart';
import '../model/request_model/aadhaar_otp_request_model.dart';
import '../model/request_model/pan_request_model.dart';
import '../model/request_model/submit_co_applicant_form_data.dart';
import '../model/request_model/submite_applicant_form_data_model.dart';
import '../model/responce_model/aadhaar_otp_responce_model.dart';
import '../model/responce_model/aadhar_number_response_model.dart';
import '../view/Sales_on_boarding_form/co-applicant_form/co_applicant_form1.dart';

final uploadCoDoc = StateProvider(
  (ref) {
    return false;
  },
);

final isCoPanLoading = StateProvider(
  (ref) {
    return false;
  },
);
final isCoTickColorChange = StateProvider(
  (ref) {
    return false;
  },
);

// final checkBoxTermsConditionCoApplicant = StateProvider(
//   (ref) {
//     return false;
//   },
// );

final getOptCoApp = StateProvider(
  (ref) {
    return false;
  },
);
final submitCoApplicantForm = StateProvider(
  (ref) {
    return false;
  },
);

final coApplicantAddressRoleProvider =
    StateNotifierProvider<OptionAddressRoleNotifier, CoApplicantOptionRole>(
        (ref) {
  return OptionAddressRoleNotifier();
});

class OptionAddressRoleNotifier extends StateNotifier<CoApplicantOptionRole> {
  OptionAddressRoleNotifier()
      : super(CoApplicantOptionRole.NON); // Default value for the radio buttons

  // Method to update the selected value
  void selectAddress(CoApplicantOptionRole value) {
    state = value;
  }
}

final coApplicantRoleProvider =
    StateNotifierProvider<CoOptionRoleNotifier, CoApplicantOptionRole>((ref) {
  return CoOptionRoleNotifier();
});

class CoOptionRoleNotifier extends StateNotifier<CoApplicantOptionRole> {
  CoOptionRoleNotifier()
      : super(CoApplicantOptionRole.NON); // Default value for the radio buttons

  // Method to update the selected value
  void select(CoApplicantOptionRole value) {
    state = value;
  }
}

final rememberCoProvider = StateProvider<bool>(
  (ref) {
    return false;
  },
);

final coApplicantFocusProvider =
    StateNotifierProvider<ApplicantFocusProvider, Map<String, bool>>((ref) {
  return ApplicantFocusProvider();
});

final listIndex = StateProvider<int>(
  (ref) {
    return 0;
  },
);

// final count = StateProvider<int>(
//       (ref) {
//     return 0;
//   },
// );

final coApplicantController =
    StateNotifierProvider<FormDataControllerNotifier, List<FormDataController>>(
        (ref) {
  return FormDataControllerNotifier();
});

class FormDataControllerNotifier
    extends StateNotifier<List<FormDataController>> {
  FormDataControllerNotifier()
      : super([
          FormDataController(
            aadhaarController: TextEditingController(),
            kycDocumentController: TextEditingController(),
            contactController: TextEditingController(),
            ageController: TextEditingController(),
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
            panController: TextEditingController(),
            permanentAddress1Controller: TextEditingController(),
            permanentAddress2Controller: TextEditingController(),
            permanentCityController: TextEditingController(),
            permanentDistrictController: TextEditingController(),
            permanentPinCodeController: TextEditingController(),
            permanentStateController: TextEditingController(),
          )
        ]);

  void addFormData() {
    state = [
      ...state,
      FormDataController(
        aadhaarController: TextEditingController(),
        kycDocumentController: TextEditingController(),
        contactController: TextEditingController(),
        ageController: TextEditingController(),
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
        panController: TextEditingController(),
        permanentAddress1Controller: TextEditingController(),
        permanentAddress2Controller: TextEditingController(),
        permanentCityController: TextEditingController(),
        permanentDistrictController: TextEditingController(),
        permanentPinCodeController: TextEditingController(),
        permanentStateController: TextEditingController(),
      ),
    ];
  }

  void removeFormData(int index) {
    state[index].dispose();
    state = [
      for (int i = 0; i < state.length; i++)
        if (i != index) state[i],
    ];
  }

  // void updateFormData(int index, String title, String description) {
  //   state[index].titleController.text = title;
  //   state[index].descriptionController.text = description;
  // }

  @override
  void dispose() {
    for (var form in state) {
      form.dispose();
    }
    super.dispose();
  }
}

final formDataProvider =
    StateNotifierProvider<FormDataControllerNotifier, List<FormDataController>>(
        (ref) {
  return FormDataControllerNotifier();
});

final coApplicantViewModelProvider =
    StateNotifierProvider<ApplicantViewModel, List<KycFormState>>((ref) {
  final dio = ref.watch(dioProvider);
  return ApplicantViewModel(dio);
});

class ApplicantViewModel extends StateNotifier<List<KycFormState>> {
  ApplicantViewModel(this.dio) : super([KycFormState()]);
  final Dio dio;
  final SingleValueDropDownController dropDownController =
      SingleValueDropDownController();

  AadhaarNumberResponseModel? aadhaarNumberResponseModel;
  AadhaarOtpResponseModel? aadhaarOtpResponseModel;

  // final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    dropDownController.dispose();
    super.dispose();
  }

  final ImagePicker picker = ImagePicker();

  void addForm() {
    state = [...state, KycFormState(id: state.last.id + 1)];
  }

// Add a new text field

  // void removeCoApplicant(int todoId) {
  //   // Again, our state is immutable. So we're making a new list instead of
  //   // changing the existing list.
  //   state = [
  //     for (final todo in state)
  //       if (todo.id == todoId) removeItem(index),
  //   ];
  // }

  Future<bool> fetchAadhaarNumber(int index) async {
    state = [
      for (final todo in state)
        if (todo.id == index) todo.copyWith(isLoading: true) else todo
    ];
    await fetchPanVerify(index);
    print(state[index].aadhaar);
    final aadhaarNumberRequestModel = AadhaarNumberRequestModel(
        aadharNo: state[index].aadhaar.trim().toString(),
        transId: '12345',
        docType: '211',
        formName: 'coApplicant');
    try {
      final response = await dio.post(Api.aadhaarNumber,
          data: aadhaarNumberRequestModel.toJson());
      if (response.statusCode == 200) {
        aadhaarNumberResponseModel =
            AadhaarNumberResponseModel.fromJson(response.data);
        state = [
          for (final todo in state)
            if (todo.id == index) todo.copyWith(isLoading: false) else todo
        ];
        return true;
      } else {
        state = [
          for (final todo in state)
            if (todo.id == index) todo.copyWith(isLoading: false) else todo
        ];
        return false;
      }
    } catch (e) {
      state = [
        for (final todo in state)
          if (todo.id == index) todo.copyWith(isLoading: false) else todo
      ];
      throw Exception(e);
    }
  }

  Future<bool> fetchOtp(int index) async {
    state = [
      for (final todo in state)
        if (todo.id == index) todo.copyWith(isLoading: true) else todo
    ];
    if (kDebugMode) {
      print(state[index].otp);
    }
    final aadhaarOtpResquestModel = AadhaarOtpRequestModel(
        transId: aadhaarNumberResponseModel!.items.tsTransId,
        otp: int.parse(state[index].otp));
    if (kDebugMode) {
      print(int.parse(state[index].otp));
    }
    if (kDebugMode) {
      print(
        aadhaarNumberResponseModel!.items.tsTransId,
      );
    }

    try {
      final response = await dio.post(Api.aadhaarOtpVerify,
          data: aadhaarOtpResquestModel.toJson());
      if (response.statusCode == 200) {
        state = [
          for (final todo in state)
            if (todo.id == index) todo.copyWith(isLoading: false) else todo
        ];
        aadhaarOtpResponseModel =
            AadhaarOtpResponseModel.fromJson(response.data);

        final age = calculateAge(aadhaarOtpResponseModel!.items.msg.dob);
        if (aadhaarOtpResponseModel != null) {
          state = [
            for (final todo in state)
              if (todo.id == index)
                todo.copyWith(
                  fullName: aadhaarOtpResponseModel!.items.msg.name,
                  dob: aadhaarOtpResponseModel!.items.msg.dob,
                  careOf: aadhaarOtpResponseModel!.items.msg.careof,
                  age: age.toString(),
                  communicationAddress1:
                      '${aadhaarOtpResponseModel!.items.msg.house}, ${aadhaarOtpResponseModel!.items.msg.street}, ${aadhaarOtpResponseModel!.items.msg.landmark}',
                  communicationAddress2:
                      aadhaarOtpResponseModel!.items.msg.locality,
                  communicationDistrict:
                      aadhaarOtpResponseModel!.items.msg.district,
                  communicationCity:
                      aadhaarOtpResponseModel!.items.msg.villageTownCity,
                  communicationPinCode:
                      aadhaarOtpResponseModel!.items.msg.pincode,
                  communicationState: aadhaarOtpResponseModel!.items.msg.state,
                  gender: aadhaarOtpResponseModel!.items.msg.gender,
                )
          ];
        }
        // AadhaarNumberResponseModel.fromJson(response.data);
        return true;
      } else {
        state = [
          for (final todo in state)
            if (todo.id == index) todo.copyWith(isLoading: false) else todo
        ];
        return false;
      }
    } catch (e) {
      state = [
        for (final todo in state)
          if (todo.id == index) todo.copyWith(isLoading: false) else todo
      ];
      throw Exception(e);
    }
  }

  int calculateAge(String birthOfDate) {
    DateTime birthDate = DateFormat("dd-MM-yyyy").parse(birthOfDate);
    DateTime today = DateTime.now();
    int age = today.year - birthDate.year;
    if (today.month < birthDate.month ||
        (today.month == birthDate.month && today.day < birthDate.day)) {
      age--;
    }
    return age;
  }

  Future<bool> submitCoApplicantForm(int index) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    final token = sharedPreferences.getString('token');
    final String? employeId = sharedPreferences.getString('employeId');
    final String? customerId = sharedPreferences.getString('customerId');
    if (kDebugMode) {
      print(employeId);
      print(customerId);
    }

    final formData = CoApplicantFormData(
        relationWithApplicant: '',
        docType: dropDownController.dropDownValue?.value,
        employeId: employeId ?? '',
        customerId: customerId ?? '',
        fullName: state[index].fullName,
        email: state[index].email,
        aadharNo: state[index].aadhaar,
        mobileNo: state[index].contact,
        docNo: state[index].pan,
        gender: state[index].gender,
        fatherName: state[index].fatherName,
        maritalStatus: '',
        spouseName: '',
        motherName: '',
        dob: state[index].dob,
        religion: '',
        caste: '',
        age: state[index].age,
        education: '',
        permanentAddressaddressLine1: state[index].permanentAddress1,
        permanentAddressaddressLine2: state[index].permanentAddress2,
        permanentAddresspinCode: state[index].permanentPinCode,
        permanentAddresscity: state[index].permanentCity,
        permanentAddressdistrict: state[index].permanentDistrict,
        permanentAddressstate: state[index].permanentState,
        localAddressaddressLine1: state[index].communicationAddress1,
        localAddressaddressLine2: state[index].communicationAddress2,
        localAddresspinCode: state[index].communicationPinCode,
        localAddresscity: state[index].communicationCity,
        localAddressdistrict: state[index].communicationDistrict,
        localAddressstate: state[index].communicationState);
    FormData dioFormData = formData.toFormData();

    final response = await dio.post(Api.submitCoApplicantForm,
        data: dioFormData, options: Options(headers: {'token': token}));
    print(response.statusMessage);
    print(response.statusCode);
    if (response.statusCode == 200) {
      // SubmitCoApplicantResponseModel.fromJson(response.data);

      return true;
    } else {
      throw Exception('Failed to load data');
    }
  }

  void setAutoValueByAadhaar(
      List<FormDataController> formListController, int index) {
    if (aadhaarOtpResponseModel != null) {
      formListController[index].fullNameController.text =
          aadhaarOtpResponseModel!.items.msg.name;
      formListController[index].dobController.text =
          aadhaarOtpResponseModel!.items.msg.dob;
      formListController[index].communicationAddress1Controller.text =
          '${aadhaarOtpResponseModel!.items.msg.house}, ${aadhaarOtpResponseModel!.items.msg.street}, ${aadhaarOtpResponseModel!.items.msg.landmark}';
      formListController[index].communicationAddress2Controller.text =
          aadhaarOtpResponseModel!.items.msg.locality;
      formListController[index].communicationDistrictController.text =
          aadhaarOtpResponseModel!.items.msg.district;
      formListController[index].communicationCityController.text =
          aadhaarOtpResponseModel!.items.msg.villageTownCity;
      formListController[index].communicationPinCodeController.text =
          aadhaarOtpResponseModel!.items.msg.pincode;
      formListController[index].communicationStateController.text =
          aadhaarOtpResponseModel!.items.msg.state;
      formListController[index].genderController.text =
          aadhaarOtpResponseModel!.items.msg.gender;
    }
  }

  Future<bool> fetchAadhaarWithPhoto(int index) async {
    var formData = FormData.fromMap({
      'front_image':
          await MultipartFile.fromFile(state[index].aadhaarPhotoFilePath1),
      'back_image':
          await MultipartFile.fromFile(state[index].aadhaarPhotoFilePath2),
      'formName': 'coApplicant'
    });

    try {
      final response = await dio.post(Api.aadhaarPhoto, data: formData);
      if (response.statusCode == 200) {
        // ===========================pending response =================save value and auto value show ======
        return true;
      } else {
        return false;
      }
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<void> fetchPanFatherName(int index) async {
    final panRequestModel = PanRequestModel(
        docType: 522, panNumber: state[index].pan, transId: "12345");
    try {
      final response =
      await dio.post(Api.panFatherName, data: panRequestModel.toJson());
      if (kDebugMode) {
        print(response.data);
      }
      if(response.statusCode ==200){
        state = [
          for (final todo in state)
            if (todo.id == index)
              todo.copyWith(panFather: response.data['items']['msg']['data']['father_name'])
            else
              todo
        ];
        // state = state.copyWith(panFather: response.data['']);
      }
    } on DioException catch (error) {
      throw Exception(error);
      // throw Exception(error);
    }
  }

  Future<bool> fetchPanVerify(int index) async {
    await fetchPanFatherName(index);
    if (kDebugMode) {
      print(state[index].otp);
    }
    final panRequestModel = PanRequestModel(
        docType: 523, panNumber: state[index].pan, transId: "111XXXXX");
    try {
      final response =
          await dio.post(Api.panVerify, data: panRequestModel.toJson());
      if (response.statusCode == 200) {
        PanResponseModel panResponseModel =
            PanResponseModel.fromJson(response.data);
        final String dob =
            DateFormat("dd-MM-yyyy").format(panResponseModel.items.data.dob);
        state = [
          for (final todo in state)
            if (todo.id == index)
              todo.copyWith(
                  panName: panResponseModel.items.data.fullName,
                  panGender: panResponseModel.items.data.gender,
                  panDob: dob)
            else
              todo
        ];
        if (kDebugMode) {
          print(response.data);
        }
        return true;
      } else {
        return false;
      }
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<void> pickImages(int index) async {
    await Permission.photos.request();
    await Permission.videos.request();

    // var video = await Permission.storage.status;
    if (await Permission.photos.status.isDenied &&
        await Permission.videos.status.isDenied) {
      // We haven't asked for permission yet or the permission has been denied before, but not permanently.
    }
    if (await Permission.photos.status.isGranted &&
        await Permission.videos.status.isGranted) {
      try {
        XFile? pickedImage = await picker.pickImage(source: ImageSource.camera);
        if (kDebugMode) {
          print('image before null condition  ${pickedImage!.path.toString()}');
        }
        if (kDebugMode) {
          print('image ${pickedImage?.path}');
        }
        state = [
          for (final todo in state)
            if (todo.id == index)
              todo.copyWith(applicantPhotoFilePath: pickedImage?.path)
            else
              todo
        ];
        // state.copyWith(applicantPhotoFilePath: pickedImage.path);
        // File(pickedImage.path) as AadhaarFormState;
      } catch (e) {
        if (kDebugMode) {
          print('Failed to pick image: $e');
        }
      }
    }
  }

  // void clearImage() {
  //   state = null;
  // }

  void removeItem(int index) {
    state = [
      for (int i = 0; i < state.length; i++)
        if (i != index) state[i],
    ];

    // state = [
    //   for (final todo in state)
    //     if (todo.id != index) todo,
    // ];
  }

  // void removeItem(String item) {
  //   state = state.where((i) => i != item).toList();
  // }

  Future<void> pickAadhaar1Images(int index) async {
    await Permission.photos.request();
    await Permission.videos.request();

    // var video = await Permission.storage.status;
    if (await Permission.photos.status.isDenied &&
        await Permission.videos.status.isDenied) {
      // We haven't asked for permission yet or the permission has been denied before, but not permanently.
    }
    if (await Permission.photos.status.isGranted &&
        await Permission.videos.status.isGranted) {
      try {
        XFile? pickedImage =
            await picker.pickImage(source: ImageSource.gallery);
        print('image before null condition  ${pickedImage!.path.toString()}');
        print('image ${pickedImage.path}');
        state = [
          for (final todo in state)
            if (todo.id == index)
              todo.copyWith(aadhaarPhotoFilePath1: pickedImage.path)
            else
              todo
        ];
        // copyWith(aadhaarPhotoFilePath1: pickedImage.path);
        // File(pickedImage.path) as AadhaarFormState;
      } catch (e) {
        print('Failed to pick image: $e');
      }
    }
  }

  Future<void> pickAadhaar2Images(int index) async {
    // var video = await Permission.storage.status;
    if (await Permission.photos.status.isDenied &&
        await Permission.videos.status.isDenied) {
      await Permission.photos.request();
      await Permission.videos.request();
      // We haven't asked for permission yet or the permission has been denied before, but not permanently.
    }
    if (await Permission.photos.status.isGranted &&
        await Permission.videos.status.isGranted) {
      try {
        XFile? pickedImage =
            await picker.pickImage(source: ImageSource.gallery);
        print('image before null condition  ${pickedImage!.path.toString()}');
        print('image ${pickedImage.path}');
        state = [
          for (final todo in state)
            if (todo.id == index)
              todo.copyWith(aadhaarPhotoFilePath2: pickedImage.path)
            else
              todo
        ];
        // state.copyWith(aadhaarPhotoFilePath2: pickedImage.path);
        // File(pickedImage.path) as AadhaarFormState;
      } catch (e) {
        print('Failed to pick image: $e');
      }
    }
  }

  void localAddCopyPermanentAdd(int index) {
    state = [
      for (final todo in state)
        if (todo.id == index)
          todo.copyWith(
              permanentAddress1: state[index].communicationAddress1,
              isPermanentAddress1Valid: state[index].isPermanentAddress1Valid,
              permanentAddress2: state[index].communicationAddress2,
              isPermanentAddress2Valid:
                  state[index].isCommunicationAddress2Valid,
              permanentCity: state[index].communicationCity,
              isPermanentCityValid: state[index].isCommunicationCityValid,
              permanentDistrict: state[index].communicationDistrict,
              isPermanentDistrictValid:
                  state[index].isCommunicationDistrictValid,
              permanentPinCode: state[index].communicationPinCode,
              isPermanentPinCodeValid: state[index].isCommunicationPinCodeValid,
              permanentState: state[index].communicationState,
              isPermanentStateValid: state[index].isCommunicationStateValid)
        else
          todo
    ];
    print(
        'permanent add ${state[index].permanentAddress1}, ${state[index].permanentAddress2}');
  }

  bool validateCoApplicant(int index) {
    final isAadhaar = _validateAadhaar(state[index].aadhaar);
    final isDoc = _validatePan(state[index].pan);
    final isCheckBox = state[index].checkBoxTermsConditionCoApplicant;
    state = state = [
      for (final todo in state)
        if (todo.id == index)
          todo.copyWith(isAadhaarValid: isAadhaar, isPanValid: isDoc)
        else
          todo
    ];
    return isAadhaar && isDoc && isCheckBox;
  }

  void submitCoApplicant(bool value, int index) {
    state = [
      for (final todo in state)
        if (todo.id == index) todo.copyWith(isSubmitCoApplicant: value) else todo
    ];
  }

  void updateKycDoc(String value, int index) {
    final isValid = _validateKycDoc(value);

    state = [
      for (final todo in state)
        if (todo.id == index)
          todo.copyWith(kycDocument: value, isKycValid: isValid)
        else
          todo
    ];
    // copyWith(kycDocument: value, isKycValid: isValid);
  }

  void updateAadhaar(String value, int index) {
    final isValid = _validateAadhaar(value);
    state = [
      for (final todo in state)
        if (todo.id == index)
          todo.copyWith(aadhaar: value, isAadhaarValid: isValid)
        else
          todo
    ];
    // copyWith(kycDocument: value, isKycValid: isValid);
  }

  void updateOtp(String value, int index) {
    final isValid = _validateOtp(value);
    state = [
      for (final todo in state)
        if (todo.id == index)
          todo.copyWith(otp: value, isOtpValid: isValid)
        else
          todo
    ];
  }

  void updatePan(String value, int index) {
    final isValid = _validatePan(value);
    state = [
      for (final todo in state)
        if (todo.id == index)
          todo.copyWith(pan: value, isPanValid: isValid)
        else
          todo
    ];
  }

  void updateMother(String value, int index) {
    final isValid = _validateMother(value);
    state = [
      for (final todo in state)
        if (todo.id == index)
          todo.copyWith(mother: value, isMotherValid: isValid)
        else
          todo
    ];
  }

  void updateContact(String value, int index) {
    final isValid = _validateContact(value);
    state = [
      for (final todo in state)
        if (todo.id == index)
          todo.copyWith(contact: value, isContactValid: isValid)
        else
          todo
    ];
  }

  void updateEmail(String value, int index) {
    final isValid = _validateEmail(value);
    state = [
      for (final todo in state)
        if (todo.id == index)
          todo.copyWith(email: value, isEmailValid: isValid)
        else
          todo
    ];
  }

  void updateMarital(String value, int index) {
    final isValid = _validateMarital(value);
    state = [
      for (final todo in state)
        if (todo.id == index)
          todo.copyWith(marital: value, isMaritalValid: isValid)
        else
          todo
    ];
  }

  void updateReligion(String value, int index) {
    final isValid = _validateReligion(value);
    state = [
      for (final todo in state)
        if (todo.id == index)
          todo.copyWith(religion: value, isReligionValid: isValid)
        else
          todo
    ];
  }

  void updateCaste(String value, int index) {
    final isValid = _validateCaste(value);
    state = [
      for (final todo in state)
        if (todo.id == index)
          todo.copyWith(caste: value, isCasteValid: isValid)
        else
          todo
    ];
  }

  void updateEducationOfApplicant(String value, int index) {
    final isValid = _validateEducationOfApplicant(value);
    state = [
      for (final todo in state)
        if (todo.id == index)
          todo.copyWith(
              educationOfApplicant: value, isEducationOfApplicantValid: isValid)
        else
          todo
    ];
  }

  void updateGender(String value, int index) {
    final isValid = _validateGender(value);
    state = [
      for (final todo in state)
        if (todo.id == index)
          todo.copyWith(gender: value, isGenderValid: isValid)
        else
          todo
    ];
  }

  void updateFullName(String value, int index) {
    final isValid = _validateFullName(value);
    state = [
      for (final todo in state)
        if (todo.id == index)
          todo.copyWith(fullName: value, isFullNameValid: isValid)
        else
          todo
    ];
  }

  void updateFatherName(String value, int index) {
    final isValid = _validateFatherName(value);
    state = [
      for (final todo in state)
        if (todo.id == index)
          todo.copyWith(fatherName: value, isFatherNameValid: isValid)
        else
          todo
    ];
  }

  void updateAge(String value, int index) {
    final isValid = _validateAge(value);
    state = [
      for (final todo in state)
        if (todo.id == index)
          todo.copyWith(age: value, isAgeValid: isValid)
        else
          todo
    ];
  }

  void updateRelationWithApplicant(String value, int index) {
    final isValid = _validateRelationWithApplicant(value);
    state = [
      for (final todo in state)
        if (todo.id == index)
          todo.copyWith(
              relationWithApplicant: value,
              isRelationWithApplicantValid: isValid)
        else
          todo
    ];
  }

  void updateDob(String value, int index) {
    final isValid = _validateDob(value);
    state = [
      for (final todo in state)
        if (todo.id == index)
          todo.copyWith(dob: value, isDobValid: isValid)
        else
          todo
    ];
  }

  void updateCommunicationAddress1(String value, int index) {
    final isValid = _validateCommunicationAddress1(value);
    state = [
      for (final todo in state)
        if (todo.id == index)
          todo.copyWith(
              communicationAddress1: value,
              isCommunicationAddress1Valid: isValid)
        else
          todo
    ];
  }

  void updateCommunicationAddress2(String value, int index) {
    final isValid = _validateCommunicationAddress2(value);
    state = [
      for (final todo in state)
        if (todo.id == index)
          todo.copyWith(
              communicationAddress2: value,
              isCommunicationAddress2Valid: isValid)
        else
          todo
    ];
  }

  void updateCommunicationCity(String value, int index) {
    final isValid = _validateCommunicationCity(value);
    state = [
      for (final todo in state)
        if (todo.id == index)
          todo.copyWith(
              communicationCity: value, isCommunicationCityValid: isValid)
        else
          todo
    ];
  }

  void updateCommunicationDistrict(String value, int index) {
    final isValid = _validateCommunicationDistrict(value);
    state = [
      for (final todo in state)
        if (todo.id == index)
          todo.copyWith(
              communicationDistrict: value,
              isCommunicationDistrictValid: isValid)
        else
          todo
    ];
  }

  void updateCommunicationState(String value, int index) {
    final isValid = _validateCommunicationState(value);
    state = [
      for (final todo in state)
        if (todo.id == index)
          todo.copyWith(
              communicationState: value, isCommunicationStateValid: isValid)
        else
          todo
    ];
  }

  void updateCommunicationPinCode(String value, int index) {
    final isValid = _validateCommunicationPinCode(value);
    state = [
      for (final todo in state)
        if (todo.id == index)
          todo.copyWith(
              communicationPinCode: value, isCommunicationPinCodeValid: isValid)
        else
          todo
    ];
  }

  void updateIsOtpVerified(bool value, int index) {
    state = [
      for (final todo in state)
        if (todo.id == index) todo.copyWith(isOtpVerified: value) else todo
    ];
  }

  void updatePermanentAddress1(String value, int index) {
    final isValid = _validatePermanentAddress1(value);
    state = [
      for (final todo in state)
        if (todo.id == index)
          todo.copyWith(
              permanentAddress1: value, isPermanentAddress1Valid: isValid)
        else
          todo
    ];
  }

  void updateCheckBox(bool value, int index) {
    state = [
      for (final todo in state)
        if (todo.id == index)
          todo.copyWith(checkBoxTermsConditionCoApplicant: value)
        else
          todo
    ];
  }

  void updatePermanentAddress2(String value, int index) {
    final isValid = _validatePermanentAddress2(value);
    state = [
      for (final todo in state)
        if (todo.id == index)
          todo.copyWith(
              permanentAddress2: value, isPermanentAddress2Valid: isValid)
        else
          todo
    ];
  }

  void updatePermanentCity(String value, int index) {
    final isValid = _validatePermanentCity(value);
    state = [
      for (final todo in state)
        if (todo.id == index)
          todo.copyWith(permanentCity: value, isPermanentCityValid: isValid)
        else
          todo
    ];
  }

  void updatePermanentDistrict(String value, int index) {
    final isValid = _validatePermanentDistrict(value);
    state = [
      for (final todo in state)
        if (todo.id == index)
          todo.copyWith(
              permanentDistrict: value, isPermanentDistrictValid: isValid)
        else
          todo
    ];
  }

  void updatePermanentState(String value, int index) {
    final isValid = _validatePermanentState(value);
    state = [
      for (final todo in state)
        if (todo.id == index)
          todo.copyWith(permanentState: value, isPermanentStateValid: isValid)
        else
          todo
    ];
  }

  void updatePermanentPinCode(String value, int index) {
    final isValid = _validatePermanentPinCode(value);
    state = [
      for (final todo in state)
        if (todo.id == index)
          todo.copyWith(
              permanentPinCode: value, isPermanentPinCodeValid: isValid)
        else
          todo
    ];
  }

  // Validate the form
  Future<bool?> validateForm(int index) async {
    for (final todo in state) {
      if (todo.id == index) {
        final isKycValid = _validateKycDoc(todo.kycDocument);
        final isPanValid = _validatePan(todo.pan);
        final isMotherValid = _validateMother(todo.mother);
        final isContactValid = _validateContact(todo.contact);
        final isEmailValid = _validateEmail(todo.email);
        final isMaritalValid = _validateMarital(todo.marital);
        final isReligionValid = _validateReligion(todo.religion);
        final isCasteValid = _validateCaste(todo.caste);
        final isRelationWithApplicantValid =
            _validateRelationWithApplicant(todo.relationWithApplicant);
        final isEducationOfApplicantValid =
            _validateEducationOfApplicant(todo.educationOfApplicant);
        final isAgeValid = _validateAge(todo.age);
        final isDobValid = _validateDob(todo.dob);
        final isFatherNameValid = _validateFatherName(todo.fatherName);
        final isFullNameValid = _validateFullName(todo.fullName);
        final isGenderValid = _validateGender(todo.gender);
        final isPermanentAddress1Valid =
            _validatePermanentAddress1(todo.permanentAddress1);
        final isPermanentAddress2Valid =
            _validatePermanentAddress2(todo.permanentAddress2);
        final isPermanentCityValid = _validatePermanentCity(todo.permanentCity);
        final isPermanentStateValid =
            _validatePermanentState(todo.permanentState);
        final isPermanentDistrictValid =
            _validatePermanentDistrict(todo.permanentDistrict);
        final isPermanentPinCodeValid =
            _validatePermanentPinCode(todo.permanentPinCode);
        final isCommunicationAddress1Valid =
            _validateCommunicationAddress1(todo.communicationAddress1);
        final isCommunicationAddress2Valid =
            _validateCommunicationAddress2(todo.communicationAddress2);
        final isCommunicationCityValid =
            _validateCommunicationCity(todo.communicationCity);
        final isCommunicationStateValid =
            _validateCommunicationState(todo.communicationState);
        final isCommunicationDistrictValid =
            _validateCommunicationDistrict(todo.communicationDistrict);
        final isCommunicationPinCodeValid =
            _validateCommunicationPinCode(todo.communicationPinCode);

        state = [
          todo.copyWith(
              isPermanentAddress1Valid: isPermanentAddress1Valid,
              isPermanentAddress2Valid: isPermanentAddress2Valid,
              isPermanentStateValid: isPermanentStateValid,
              isPermanentPinCodeValid: isPermanentPinCodeValid,
              isPermanentDistrictValid: isPermanentDistrictValid,
              isPermanentCityValid: isPermanentCityValid,
              isCommunicationPinCodeValid: isCommunicationPinCodeValid,
              isCommunicationDistrictValid: isCommunicationDistrictValid,
              isCommunicationStateValid: isCommunicationStateValid,
              isCommunicationCityValid: isCommunicationCityValid,
              isCommunicationAddress2Valid: isCommunicationAddress2Valid,
              isCommunicationAddress1Valid: isCommunicationAddress1Valid,
              isKycValid: isKycValid,
              isPanValid: isPanValid,
              isCasteValid: isCasteValid,
              isContactValid: isContactValid,
              isMotherValid: isMotherValid,
              isMaritalValid: isMaritalValid,
              isEmailValid: isEmailValid,
              isReligionValid: isReligionValid,
              isRelationWithApplicantValid: isRelationWithApplicantValid,
              isEducationOfApplicantValid: isEducationOfApplicantValid,
              isAgeValid: isAgeValid,
              isGenderValid: isGenderValid,
              isFullNameValid: isFullNameValid,
              isDobValid: isDobValid,
              isFatherNameValid: isFatherNameValid)
        ];
        return isKycValid &&
            isPanValid &&
            isCasteValid &&
            isReligionValid &&
            isMaritalValid &&
            isEmailValid &&
            isContactValid &&
            isMotherValid &&
            isGenderValid &&
            isFullNameValid &&
            isFatherNameValid &&
            isDobValid &&
            isAgeValid &&
            isEducationOfApplicantValid &&
            isRelationWithApplicantValid &&
            isCommunicationPinCodeValid &&
            isCommunicationDistrictValid &&
            isCommunicationStateValid &&
            isCommunicationAddress2Valid &&
            isCommunicationCityValid &&
            isCommunicationAddress1Valid &&
            isPermanentAddress1Valid &&
            isPermanentAddress2Valid &&
            isPermanentCityValid &&
            isPermanentStateValid &&
            isPermanentDistrictValid &&
            isPermanentPinCodeValid;
      }
    }
    return null;
  }

// Communication Address ----------------------------------------

  //   bool _validateKycDocForm(String text,int index) {
  //   return aadhaar[index].length >= 12 && aadhaar[index].isNotEmpty;
  // }
  //
  bool _validateCommunicationAddress1(String address1) {
    return address1.isNotEmpty;
  }

  bool _validateCommunicationAddress2(String address2) {
    return address2.isNotEmpty;
  }

  bool _validateCommunicationCity(String city) {
    return city.isNotEmpty;
  }

  bool _validateCommunicationState(String state) {
    return state.isNotEmpty;
  }

  bool _validateCommunicationDistrict(String district) {
    return district.isNotEmpty;
  }

  bool _validateCommunicationPinCode(String pinCode) {
    return pinCode.isNotEmpty;
  }

  bool _validatePermanentAddress1(String address1) {
    return address1.isNotEmpty;
  }

  bool _validatePermanentAddress2(String address2) {
    return address2.isNotEmpty;
  }

  bool _validatePermanentCity(String city) {
    return city.isNotEmpty;
  }

  bool _validatePermanentState(String state) {
    return state.isNotEmpty;
  }

  bool _validatePermanentDistrict(String district) {
    return district.isNotEmpty;
  }

  bool _validatePermanentPinCode(String pinCode) {
    return pinCode.isNotEmpty;
  }

  // Email validation logic
  bool _validateKycDoc(String aadhaar) {
    return aadhaar.length >= 12 && aadhaar.isNotEmpty;
  }

  bool _validateAadhaar(String aadhaar) {
    return aadhaar.length >= 12 && aadhaar.isNotEmpty;
  }

// License validation logic
  bool _validatePan(String pan) {
    return pan.length >= 10;
  }

  bool _validateMother(String mother) {
    return mother.isNotEmpty;
  }

  bool _validateContact(String contact) {
    return contact.length >= 10;
  }

  bool _validateEmail(String email) {
    return email.isNotEmpty;
  }

  bool _validateMarital(String marital) {
    return marital.isNotEmpty;
  }

  bool _validateReligion(String religion) {
    return religion.isNotEmpty;
  }

  bool _validateCaste(String caste) {
    return caste.isNotEmpty;
  }

  bool _validateRelationWithApplicant(String relationWithApplicant) {
    return relationWithApplicant.isNotEmpty;
  }

  bool _validateOtp(String otp) {
    return otp.isNotEmpty;
  }

  bool _validateAge(String age) {
    return age.isNotEmpty;
  }

  bool _validateDob(String dob) {
    return dob.isNotEmpty;
  }

  bool _validateFatherName(String fatherName) {
    return fatherName.isNotEmpty;
  }

  bool _validateFullName(String fullName) {
    return fullName.isNotEmpty;
  }

  bool _validateGender(String gender) {
    return gender.isNotEmpty;
  }

  bool _validateEducationOfApplicant(String educationOfApplicant) {
    return educationOfApplicant.isNotEmpty;
  }
}

//----------------on focus------------------------------

class ApplicantFocusProvider extends StateNotifier<Map<String, bool>> {
  final FocusNode aadhaarFocusNode;
  final FocusNode kycDocFocusNode;
  final FocusNode panFocusNode;
  final FocusNode motherFocusNode;
  final FocusNode contactFocusNode;
  final FocusNode emailFocusNode;
  final FocusNode maritalFocusNode;
  final FocusNode religionFocusNode;
  final FocusNode casteFocusNode;

  final FocusNode educationOfApplicantFocusNode;
  final FocusNode genderFocusNode;
  final FocusNode fullNameFocusNode;
  final FocusNode fatherNameFocusNode;
  final FocusNode dobFocusNode;
  final FocusNode ageFocusNode;
  final FocusNode relationWithApplicantFocusNode;

  final FocusNode communicationAddress1FocusNode;
  final FocusNode communicationAddress2FocusNode;
  final FocusNode communicationCityFocusNode;
  final FocusNode communicationStateFocusNode;
  final FocusNode communicationDistrictFocusNode;
  final FocusNode communicationPinCodeFocusNode;

  final FocusNode permanentAddress1FocusNode;
  final FocusNode permanentAddress2FocusNode;
  final FocusNode permanentCityFocusNode;
  final FocusNode permanentStateFocusNode;
  final FocusNode permanentDistrictFocusNode;
  final FocusNode permanentPinCodeFocusNode;

  ApplicantFocusProvider()
      : aadhaarFocusNode = FocusNode(),
        kycDocFocusNode = FocusNode(),
        panFocusNode = FocusNode(),
        motherFocusNode = FocusNode(),
        contactFocusNode = FocusNode(),
        emailFocusNode = FocusNode(),
        maritalFocusNode = FocusNode(),
        religionFocusNode = FocusNode(),
        casteFocusNode = FocusNode(),
        educationOfApplicantFocusNode = FocusNode(),
        genderFocusNode = FocusNode(),
        fullNameFocusNode = FocusNode(),
        fatherNameFocusNode = FocusNode(),
        dobFocusNode = FocusNode(),
        ageFocusNode = FocusNode(),
        relationWithApplicantFocusNode = FocusNode(),
        communicationAddress1FocusNode = FocusNode(),
        communicationAddress2FocusNode = FocusNode(),
        communicationCityFocusNode = FocusNode(),
        communicationDistrictFocusNode = FocusNode(),
        communicationPinCodeFocusNode = FocusNode(),
        communicationStateFocusNode = FocusNode(),
        permanentAddress1FocusNode = FocusNode(),
        permanentAddress2FocusNode = FocusNode(),
        permanentCityFocusNode = FocusNode(),
        permanentDistrictFocusNode = FocusNode(),
        permanentPinCodeFocusNode = FocusNode(),
        permanentStateFocusNode = FocusNode(),
        super({
          'aadhaarFocusNode': false,
          'kycDocFocusNode': false,
          'panFocusNode': false,
          'motherFocusNode': false,
          'contactFocusNode': false,
          'emailFocusNode': false,
          'maritalFocusNode': false,
          'religionFocusNode': false,
          'casteFocusNode': false,
          'educationOfApplicantFocusNode': false,
          'genderFocusNode': false,
          'fullNameFocusNode': false,
          'fatherNameFocusNode': false,
          'dobFocusNode': false,
          'ageFocusNode': false,
          'relationWithApplicantFocusNode': false,
          'communicationAddress1FocusNode': false,
          'communicationAddress2FocusNode': false,
          'communicationCityFocusNode': false,
          'communicationDistrictFocusNode': false,
          'communicationPinCodeFocusNode': false,
          'communicationStateFocusNode': false,
          'permanentAddress1FocusNode': false,
          'permanentAddress2FocusNode': false,
          'permanentCityFocusNode': false,
          'permanentDistrictFocusNode': false,
          'permanentPinCodeFocusNode': false,
          'permanentStateFocusNode': false,
        }) {
    aadhaarFocusNode.addListener(
      () => _focusListener('aadhaarFocusNode', aadhaarFocusNode),
    );
    kycDocFocusNode
        .addListener(() => _focusListener('kycDocFocusNode', kycDocFocusNode));
    panFocusNode
        .addListener(() => _focusListener('panFocusNode', panFocusNode));
    motherFocusNode
        .addListener(() => _focusListener('motherFocusNode', motherFocusNode));
    contactFocusNode.addListener(
        () => _focusListener('contactFocusNode', contactFocusNode));
    emailFocusNode
        .addListener(() => _focusListener('emailFocusNode', emailFocusNode));
    maritalFocusNode.addListener(
        () => _focusListener('maritalFocusNode', maritalFocusNode));
    religionFocusNode.addListener(
        () => _focusListener('religionFocusNode', religionFocusNode));
    casteFocusNode
        .addListener(() => _focusListener('casteFocusNode', casteFocusNode));
    educationOfApplicantFocusNode.addListener(() => _focusListener(
        'educationOfApplicantFocusNode', educationOfApplicantFocusNode));
    genderFocusNode
        .addListener(() => _focusListener('genderFocusNode', genderFocusNode));
    fullNameFocusNode.addListener(
        () => _focusListener('fullNameFocusNode', fullNameFocusNode));
    fatherNameFocusNode.addListener(
        () => _focusListener('fatherNameFocusNode', fatherNameFocusNode));
    dobFocusNode
        .addListener(() => _focusListener('dobFocusNode', dobFocusNode));
    ageFocusNode
        .addListener(() => _focusListener('ageFocusNode', ageFocusNode));
    relationWithApplicantFocusNode.addListener(() => _focusListener(
        'relationWithApplicantFocusNode', relationWithApplicantFocusNode));
    communicationAddress1FocusNode.addListener(() => _focusListener(
        'communicationAddress1FocusNode', communicationAddress1FocusNode));
    communicationCityFocusNode.addListener(() => _focusListener(
        'communicationCityFocusNode', communicationCityFocusNode));
    communicationDistrictFocusNode.addListener(() => _focusListener(
        'communicationDistrictFocusNode', communicationDistrictFocusNode));
    communicationPinCodeFocusNode.addListener(() => _focusListener(
        'communicationPinCodeFocusNode', communicationPinCodeFocusNode));
    communicationStateFocusNode.addListener(() => _focusListener(
        'communicationStateFocusNode', communicationStateFocusNode));
    communicationAddress2FocusNode.addListener(() => _focusListener(
        'communicationAddress2FocusNode', communicationAddress2FocusNode));
    permanentAddress1FocusNode.addListener(() => _focusListener(
        'permanentAddress1FocusNode', permanentAddress1FocusNode));
    permanentAddress2FocusNode.addListener(() => _focusListener(
        'permanentAddress2FocusNode', permanentAddress2FocusNode));
    permanentCityFocusNode.addListener(
        () => _focusListener('permanentCityFocusNode', permanentCityFocusNode));
    permanentDistrictFocusNode.addListener(() => _focusListener(
        'permanentDistrictFocusNode', permanentDistrictFocusNode));
    permanentPinCodeFocusNode.addListener(() =>
        _focusListener('permanentPinCodeFocusNode', permanentPinCodeFocusNode));
    permanentStateFocusNode.addListener(() =>
        _focusListener('permanentStateFocusNode', permanentStateFocusNode));
  }

  void _focusListener(String field, FocusNode focusNode) {
    state = {
      ...state,
      field: focusNode.hasFocus,
    };
  }

  @override
  void dispose() {
    aadhaarFocusNode.removeListener(
      () => _focusListener('aadhaarFocusNode', aadhaarFocusNode),
    );
    kycDocFocusNode.removeListener(
        () => _focusListener('kycDocFocusNode', kycDocFocusNode));
    panFocusNode
        .removeListener(() => _focusListener('panFocusNode', panFocusNode));
    motherFocusNode.removeListener(
        () => _focusListener('motherFocusNode', motherFocusNode));
    contactFocusNode.removeListener(
        () => _focusListener('contactFocusNode', contactFocusNode));
    emailFocusNode
        .removeListener(() => _focusListener('emailFocusNode', emailFocusNode));
    maritalFocusNode.removeListener(
        () => _focusListener('maritalFocusNode', maritalFocusNode));
    religionFocusNode.removeListener(
        () => _focusListener('religionFocusNode', religionFocusNode));
    casteFocusNode
        .removeListener(() => _focusListener('casteFocusNode', casteFocusNode));
    educationOfApplicantFocusNode.removeListener(() => _focusListener(
        'educationOfApplicantFocusNode', educationOfApplicantFocusNode));
    genderFocusNode.removeListener(
        () => _focusListener('genderFocusNode', genderFocusNode));
    fullNameFocusNode.removeListener(
        () => _focusListener('fullNameFocusNode', fullNameFocusNode));
    fatherNameFocusNode.removeListener(
        () => _focusListener('fatherNameFocusNode', fatherNameFocusNode));
    dobFocusNode
        .removeListener(() => _focusListener('dobFocusNode', dobFocusNode));
    ageFocusNode
        .removeListener(() => _focusListener('ageFocusNode', ageFocusNode));
    relationWithApplicantFocusNode.removeListener(() => _focusListener(
        'relationWithApplicantFocusNode', relationWithApplicantFocusNode));

    communicationAddress1FocusNode.removeListener(() => _focusListener(
        'communicationAddress1FocusNode', communicationAddress1FocusNode));
    communicationCityFocusNode.removeListener(() => _focusListener(
        'communicationCityFocusNode', communicationCityFocusNode));
    communicationDistrictFocusNode.removeListener(() => _focusListener(
        'communicationDistrictFocusNode', communicationDistrictFocusNode));
    communicationPinCodeFocusNode.removeListener(() => _focusListener(
        'communicationPinCodeFocusNode', communicationPinCodeFocusNode));
    communicationStateFocusNode.removeListener(() => _focusListener(
        'communicationStateFocusNode', communicationStateFocusNode));
    communicationAddress2FocusNode.removeListener(() => _focusListener(
        'communicationAddress2FocusNode', communicationAddress2FocusNode));
    permanentAddress1FocusNode.removeListener(() => _focusListener(
        'permanentAddress1FocusNode', permanentAddress1FocusNode));
    permanentAddress2FocusNode.removeListener(() => _focusListener(
        'permanentAddress2FocusNode', permanentAddress2FocusNode));
    permanentCityFocusNode.removeListener(
        () => _focusListener('permanentCityFocusNode', permanentCityFocusNode));
    permanentDistrictFocusNode.removeListener(() => _focusListener(
        'permanentDistrictFocusNode', permanentDistrictFocusNode));
    permanentPinCodeFocusNode.removeListener(() =>
        _focusListener('permanentPinCodeFocusNode', permanentPinCodeFocusNode));
    permanentStateFocusNode.removeListener(() =>
        _focusListener('permanentStateFocusNode', permanentStateFocusNode));

    aadhaarFocusNode.dispose();
    kycDocFocusNode.dispose();
    panFocusNode.dispose();
    motherFocusNode.dispose();
    contactFocusNode.dispose();
    emailFocusNode.dispose();
    maritalFocusNode.dispose();
    religionFocusNode.dispose();
    casteFocusNode.dispose();
    educationOfApplicantFocusNode.dispose();
    genderFocusNode.dispose();
    fullNameFocusNode.dispose();
    fatherNameFocusNode.dispose();
    dobFocusNode.dispose();
    ageFocusNode.dispose();
    relationWithApplicantFocusNode.dispose();
    communicationAddress1FocusNode.dispose();
    communicationStateFocusNode.dispose();
    communicationPinCodeFocusNode.dispose();
    communicationDistrictFocusNode.dispose();
    communicationCityFocusNode.dispose();
    permanentAddress1FocusNode.dispose();
    permanentAddress2FocusNode.dispose();
    permanentStateFocusNode.dispose();
    permanentDistrictFocusNode.dispose();
    permanentCityFocusNode.dispose();
    permanentPinCodeFocusNode.dispose();
    super.dispose();
  }
}

class FormDataController {
  final TextEditingController aadhaarController;
  final TextEditingController kycDocumentController;
  final TextEditingController panController;
  final TextEditingController contactController;
  final TextEditingController emailController;
  final TextEditingController otpController;

  final TextEditingController genderController;
  final TextEditingController fullNameController;
  final TextEditingController fatherNameController;
  final TextEditingController dobController;
  final TextEditingController ageController;

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

  FormDataController({
    required this.kycDocumentController,
    required this.contactController,
    required this.emailController,
    required this.fatherNameController,
    required this.ageController,
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
    required this.aadhaarController,
    required this.panController,
    required this.dobController,
    required this.genderController,
    required this.otpController,
  });

  void dispose() {
    aadhaarController.dispose();
    ageController.dispose();
    communicationAddress1Controller.dispose();
    communicationAddress2Controller.dispose();
    communicationCityController.dispose();
    communicationDistrictController.dispose();
    communicationPinCodeController.dispose();
    communicationStateController.dispose();
  }
}

class KycFormState {
  final bool isLoading;
  final int id;
  final String applicantPhotoFilePath;
  final String aadhaarPhotoFilePath1;
  final String aadhaarPhotoFilePath2;
  final bool checkBoxTermsConditionCoApplicant;
  final bool isCoApplicantFormSubmitted;
  final bool isOtpVerified;
  final String careOf;

  final String panName;
  final String panGender;
  final String panDob;
  final bool isSubmitCoApplicant;

  final String aadhaar;
  final String kycDocument;
  final String pan;
  final String mother;
  final String contact;
  final String email;
  final String marital;
  final String religion;
  final String caste;
  final String panFather;
  final String otp;
  final bool isOtpValid;

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

  KycFormState({
    this.panFather = '',
    this.isSubmitCoApplicant = false,
    this.panGender = '',
    this.panDob = '',
    this.panName = '',
    this.careOf = '',
    this.isOtpVerified = false,
    this.isCoApplicantFormSubmitted = false,
    this.isLoading = false,
    this.checkBoxTermsConditionCoApplicant = false,
    this.id = 0,
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

  KycFormState copyWith(
      {
        String? panFather,
        bool? isSubmitCoApplicant,
      String? panName,
      String? panGender,
      String? panDob,
      String? careOf,
      bool? isOtpVerified,
      bool? isCoApplicantFormSubmitted,
      bool? isLoading,
      bool? checkBoxTermsConditionCoApplicant,
      int? id,
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
      bool? isOtpValid,
      String? kycDocument,
      String? otp,
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
      bool? isCommunicationAddress1Valid,
      bool? isCommunicationAddress2Valid,
      bool? isCommunicationCityValid,
      bool? isCommunicationStateValid,
      bool? isCommunicationDistrictValid,
      bool? isCommunicationPinCodeValid,
      bool? isKycValid,
      bool? isAadhaarValid,
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
    return KycFormState(
      panFather: panFather??this.panFather,
        isSubmitCoApplicant: isSubmitCoApplicant ?? this.isSubmitCoApplicant,
        panName: panName ?? this.panName,
        panGender: panGender ?? this.panGender,
        panDob: panDob ?? this.panDob,
        careOf: careOf ?? this.careOf,
        isOtpVerified: isOtpVerified ?? this.isOtpVerified,
        isCoApplicantFormSubmitted:
            isCoApplicantFormSubmitted ?? this.isCoApplicantFormSubmitted,
        isLoading: isLoading ?? this.isLoading,
        checkBoxTermsConditionCoApplicant: checkBoxTermsConditionCoApplicant ??
            this.checkBoxTermsConditionCoApplicant,
        applicantPhotoFilePath:
            applicantPhotoFilePath ?? this.applicantPhotoFilePath,
        aadhaarPhotoFilePath1:
            aadhaarPhotoFilePath1 ?? this.aadhaarPhotoFilePath1,
        aadhaarPhotoFilePath2:
            aadhaarPhotoFilePath2 ?? this.aadhaarPhotoFilePath2,
        id: id ?? this.id,
        otp: otp ?? this.otp,
        isOtpValid: isOtpValid ?? this.isOtpValid,
        isAadhaarValid: isAadhaarValid ?? this.isAadhaarValid,
        aadhaar: aadhaar ?? this.aadhaar,
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

//-----------------------pageView-------------------------------------------------

final pageViewModelProvider = StateNotifierProvider<CoTabViewModel, CoTabModel>(
  (ref) => CoTabViewModel(),
);

class CoTabViewModel extends StateNotifier<CoTabModel> {
  CoTabViewModel() : super(CoTabModel(selectedIndex: 0));

  void setTabIndex(int index) {
    state = state.copyWith(selectedIndex: index);
  }
}

// class PageIndexNotifier extends StateNotifier<int> {
//   PageIndexNotifier() : super(0);
//
//   void setPageIndex(int index) {
//     state = index;
//   }
// }
//
// final pageIndexProvider = StateNotifierProvider<PageIndexNotifier, int>((ref) {
//   return PageIndexNotifier();
// });
//-----------------------------------------------------------------------------------
class CoTabModel {
  final int selectedIndex;

  CoTabModel({required this.selectedIndex});

  CoTabModel copyWith({int? selectedIndex}) {
    return CoTabModel(
      selectedIndex: selectedIndex ?? this.selectedIndex,
    );
  }
}
