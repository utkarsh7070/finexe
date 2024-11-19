import 'package:dio/dio.dart';
import 'package:finexe/feature/base/api/api.dart';
import 'package:finexe/feature/ui/Sales/SalesOnBoardingForm/model/request_model/Submite_guarantor_form_data.dart';
import 'package:finexe/feature/ui/Sales/SalesOnBoardingForm/model/responce_model/submit_guarantor_response_model.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../base/api/dio.dart';
import '../model/payment_initiate_response_model.dart';
import '../model/request_model/aadhaar_number_request_model.dart';
import '../model/request_model/aadhaar_otp_request_model.dart';
import '../model/request_model/pan_request_model.dart';
import '../model/responce_model/aadhaar_otp_responce_model.dart';
import '../model/responce_model/aadhar_number_response_model.dart';
import '../model/responce_model/pan_response_model.dart';
import '../view/Sales_on_boarding_form/guarantor_form/dialog/form_completed_dialog.dart';

final getOptGuarantor = StateProvider(
  (ref) {
    return false;
  },
);

final uploadGuarantorDoc = StateProvider(
  (ref) {
    return false;
  },
);

// final checkBoxTermsConditionGuarantor = StateProvider(
//   (ref) {
//     return false;
//   },
// );

final isGuarantorPanLoading = StateProvider(
  (ref) {
    return false;
  },
);
final isGuarantorTickColorChange = StateProvider(
  (ref) {
    return false;
  },
);

final guarantorAddressRoleProvider =
    StateNotifierProvider<OptionAddressRoleNotifier, GuarantorOptionRole>(
        (ref) {
  return OptionAddressRoleNotifier();
});

class OptionAddressRoleNotifier extends StateNotifier<GuarantorOptionRole> {
  OptionAddressRoleNotifier()
      : super(GuarantorOptionRole.NON); // Default value for the radio buttons

  // Method to update the selected value
  void selectAddress(GuarantorOptionRole value) {
    state = value;
  }
}

final guarantorRoleProvider =
    StateNotifierProvider<OptionRoleNotifier, GuarantorOptionRole>((ref) {
  return OptionRoleNotifier();
});

class OptionRoleNotifier extends StateNotifier<GuarantorOptionRole> {
  OptionRoleNotifier()
      : super(GuarantorOptionRole.NON); // Default value for the radio buttons

  // Method to update the selected value
  void select(GuarantorOptionRole value) {
    state = value;
  }
}

final guarantorRememberProvider = StateProvider<bool>(
  (ref) {
    return false;
  },
);

final guarantorFocusProvider =
    StateNotifierProvider.autoDispose<GuarantorFocusProvider, Map<String, bool>>((ref) {
  return GuarantorFocusProvider();
});

final guarantorViewModelProvider =
    StateNotifierProvider.autoDispose<GuarantorViewModel, GuarantorKycFormState>((ref) {
  final dio = ref.read(dioProvider);
  return GuarantorViewModel(dio);
});

class GuarantorViewModel extends StateNotifier<GuarantorKycFormState> {
  final Dio dio;

  GuarantorViewModel(this.dio) : super(GuarantorKycFormState());

  AadhaarNumberResponseModel? aadhaarNumberResponseModel;
  AadhaarOtpResponseModel? aadhaarOtpResponseModel;
  final ImagePicker picker = ImagePicker();

// Add a new text field

  // Update a specific text field's name or last name
  // void updateTextField(int index, String newValue, bool isNameField) {
  //   if (index >= 0 && index < state.length) {
  //     state = [
  //       for (var i = 0; i < state.length; i++)
  //         if (i == index)
  //           KycFormState()
  //         else
  //           state[i]
  //     ];
  //   }
  // }
  // Update email field

  void updateOtp(String code) {
    state = state.copyWith(
      otp: code,
    );
  }

  void setAutoValueByAadhaar(GuarantorDataController formListController) {
    if (aadhaarOtpResponseModel != null) {
      formListController.fullNameController.text =
          aadhaarOtpResponseModel!.items.msg.name;
      formListController.dobController.text =
          aadhaarOtpResponseModel!.items.msg.dob;
      formListController.communicationAddress1Controller.text =
          '${aadhaarOtpResponseModel!.items.msg.house}, ${aadhaarOtpResponseModel!.items.msg.street}, ${aadhaarOtpResponseModel!.items.msg.landmark}';
      formListController.communicationAddress2Controller.text =
          aadhaarOtpResponseModel!.items.msg.locality;
      formListController.communicationDistrictController.text =
          aadhaarOtpResponseModel!.items.msg.district;
      formListController.communicationCityController.text =
          aadhaarOtpResponseModel!.items.msg.villageTownCity;
      formListController.communicationPinCodeController.text =
          aadhaarOtpResponseModel!.items.msg.pincode;
      formListController.communicationStateController.text =
          aadhaarOtpResponseModel!.items.msg.state;
      formListController.genderController.text =
          aadhaarOtpResponseModel!.items.msg.gender;
    }
  }

  Future<void> fetchAadhaarNumber() async {
    state = state.copyWith(isLoading: true);
    await fetchPanVerify().then(
      (value) async {
        if (value) {
          print(state.aadhaar);
          final aadhaarNumberRequestModel = AadhaarNumberRequestModel(
              aadharNo: state.aadhaar.trim().toString(),
              transId: '12345',
              docType: '211',
              formName: 'guarantor');
          try {
            final response = await dio.post(Api.aadhaarNumber,
                data: aadhaarNumberRequestModel.toJson());
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
      },
    );
  }

  Future<bool> fetchOtp() async {
    state = state.copyWith(isLoading: true);
    print(state.otp);
    final aadhaarOtpResquestModel = AadhaarOtpRequestModel(
        transId: aadhaarNumberResponseModel!.items.tsTransId,
        otp: int.parse(state.otp));
    print(int.parse(state.otp));
    print(
      aadhaarNumberResponseModel!.items.tsTransId,
    );

    try {
      final response = await dio.post(Api.aadhaarOtpVerify,
          data: aadhaarOtpResquestModel.toJson());
      if (response.statusCode == 200) {
        state = state.copyWith(isLoading: false);
        aadhaarOtpResponseModel =
            AadhaarOtpResponseModel.fromJson(response.data);
        final age = calculateAge(aadhaarOtpResponseModel!.items.msg.dob);
        state = state.copyWith(
          fullName: aadhaarOtpResponseModel?.items.msg.name,
          dob: aadhaarOtpResponseModel?.items.msg.dob,
          age: age.toString(),
          communicationAddress1:
              '${aadhaarOtpResponseModel?.items.msg.house}, ${aadhaarOtpResponseModel?.items.msg.street}, ${aadhaarOtpResponseModel?.items.msg.landmark}',
          communicationAddress2: aadhaarOtpResponseModel?.items.msg.locality,
          communicationDistrict: aadhaarOtpResponseModel?.items.msg.district,
          communicationCity: aadhaarOtpResponseModel?.items.msg.villageTownCity,
          communicationPinCode: aadhaarOtpResponseModel?.items.msg.pincode,
          communicationState: aadhaarOtpResponseModel?.items.msg.state,
          gender: aadhaarOtpResponseModel?.items.msg.gender,
        );
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

  Future<bool> fetchAadhaarWithPhoto() async {
    var formData = FormData.fromMap({
      'front_image': await MultipartFile.fromFile(state.aadhaarPhotoFilePath1),
      'back_image': await MultipartFile.fromFile(state.aadhaarPhotoFilePath2),
      'formName': 'guarantor'
    });

    try {
      final response = await dio.post(Api.aadhaarPhoto, data: formData);
      if (response.statusCode == 200) {
        //=============  response pending set value and auto set value is pending ===============
        return true;
      } else {
        return false;
      }
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<void> fetchPanFatherName() async {
    final panRequestModel ={
      "trans_id":"12345",
      "docType":"522",
      "docNumber":state.pan
    };
    try {
      final response =
          await dio.post(Api.panFatherName, data: panRequestModel);
      if (kDebugMode) {
        print(response.data);
      }
      if (response.statusCode == 200) {
        state = state.copyWith(
            panFather: response.data['items']['msg']['data']['father_name']);
      }
    } on DioException catch (error) {
      state = state.copyWith(isLoading: false);
      throw Exception(error);
      // throw Exception(error);
    }
  }

  Future<bool> fetchPanVerify() async {
    await fetchPanFatherName();
    print(state.otp);
    final panRequestModel = PanRequestModel(
        docType: 523, panNumber: state.pan, transId: "111XXXXX");
    try {
      final response =
          await dio.post(Api.panVerify, data: panRequestModel.toJson());
      if (response.statusCode == 200) {
        PanResponseModel panResponseModel =
            PanResponseModel.fromJson(response.data);
        final String dob =
            DateFormat("dd-MM-yyyy").format(panResponseModel.items.data.dob);
        state = state.copyWith(
            panDob: dob,
            panGender: panResponseModel.items.data.gender,
            panName: panResponseModel.items.data.fullName);
        print(response.data);
        return true;
      } else {
        return false;
      }
    } catch (e) {
      state = state.copyWith(isLoading: false);
      throw Exception(e);
    }
  }

  Future<bool> submitGuarantorForm() async {
    state = state.copyWith(isLoading: true);
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    final token = sharedPreferences.getString('token');
    final customerId = sharedPreferences.getString('customerId');
    final formData = GuarantorFormData(
        relationWithApplicant: '',
        docType: 'panCard',
        customerId: customerId!,
        fullName: state.fullName,
        email: state.email,
        aadharNo: state.aadhaar,
        mobileNo: state.contact,
        docNo: state.pan,
        gender: state.gender,
        fatherName: state.fatherName,
        maritalStatus: '',
        spouseName: '',
        motherName: '',
        dob: state.dob,
        religion: '',
        caste: '',
        age: state.age,
        education: '',
        permanentAddressaddressLine1: state.permanentAddress1,
        permanentAddressaddressLine2: state.permanentAddress2,
        permanentAddresspinCode: state.permanentPinCode,
        permanentAddresscity: state.permanentCity,
        permanentAddressdistrict: state.permanentDistrict,
        permanentAddressstate: state.permanentState,
        localAddressaddressLine1: state.communicationAddress1,
        localAddressaddressLine2: state.communicationAddress2,
        localAddresspinCode: state.communicationPinCode,
        localAddresscity: state.communicationCity,
        localAddressdistrict: state.communicationDistrict,
        localAddressstate: state.communicationState);
    FormData dioFormData = formData.toFormData();

    final response = await dio.post(Api.submitGuarantorForm,
        data: dioFormData, options: Options(headers: {'token': token}));
    print(response.statusMessage);
    print(response.statusCode);
    if (response.statusCode == 200) {
      state = state.copyWith(isLoading: false);
      SubmitGuarantorResponseModel.fromJson(response.data);
      return true;
    } else {
      state = state.copyWith(isLoading: false);
      throw Exception('Failed to load data');
    }
  }

  Future<PaymentInitiateResponseModel> paymentInitiate() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    final token = sharedPreferences.getString('token');
    final customerId = sharedPreferences.getString('customerId');
    final requestData = {'customerId': customerId.toString()};
    if (kDebugMode) {
      print(customerId);
      print(token);
    }
    final response = await dio.post(Api.paymentAmount,
        data: requestData, options: Options(headers: {'token': token}));
    PaymentInitiateResponseModel responseModel =
        PaymentInitiateResponseModel.fromJson(response.data);
    if (kDebugMode) {
      print(response.data);
      print(response.statusCode);
    }
    if (response.statusCode == 200) {
      return responseModel;
    } else {
      throw Exception('Failed to load data');
    }
  }

  Future<void> pickImages() async {
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
            await picker.pickImage(source: ImageSource.camera);
        print('image before null condition  ${pickedImage!.path.toString()}');
        if (pickedImage != null) {
          print('image ${pickedImage.path}');
          state = state.copyWith(applicantPhotoFilePath: pickedImage.path);
          // File(pickedImage.path) as AadhaarFormState;
        }
      } catch (e) {
        print('Failed to pick image: $e');
      }
    }
  }

  Future<void> pickAadhaar1Images() async {
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
        if (pickedImage != null) {
          print('image ${pickedImage.path}');
          state = state.copyWith(aadhaarPhotoFilePath1: pickedImage.path);
          // File(pickedImage.path) as AadhaarFormState;
        }
      } catch (e) {
        print('Failed to pick image: $e');
      }
    }
  }

  Future<void> pickAadhaar2Images() async {
    if (await Permission.photos.status.isDenied &&
        await Permission.videos.status.isDenied) {
      await Permission.photos.request();
      await Permission.videos.request();
    }
    if (await Permission.photos.status.isGranted &&
        await Permission.videos.status.isGranted) {
      try {
        XFile? pickedImage =
            await picker.pickImage(source: ImageSource.gallery);
        print('image before null condition  ${pickedImage!.path.toString()}');
        if (pickedImage != null) {
          print('image ${pickedImage.path}');
          state = state.copyWith(aadhaarPhotoFilePath2: pickedImage.path);
        }
      } catch (e) {
        print('Failed to pick image: $e');
      }
    }
  }

  void localAddCopyPermanentAdd() {
    state = state.copyWith(
        permanentAddress1: state.communicationAddress1,
        isPermanentAddress1Valid: state.isPermanentAddress1Valid,
        permanentAddress2: state.communicationAddress2,
        isPermanentAddress2Valid: state.isCommunicationAddress2Valid,
        permanentCity: state.communicationCity,
        isPermanentCityValid: state.isCommunicationCityValid,
        permanentDistrict: state.communicationDistrict,
        isPermanentDistrictValid: state.isCommunicationDistrictValid,
        permanentPinCode: state.communicationPinCode,
        isPermanentPinCodeValid: state.isCommunicationPinCodeValid,
        permanentState: state.communicationState,
        isPermanentStateValid: state.isCommunicationStateValid);
    print(
        'permanent add ${state.permanentAddress1}, ${state.permanentAddress2}');
  }

  void verifyOtp(bool value) {
    state = state.copyWith(isOtpVerify: value);
  }

  void updateCheckBox(bool value) {
    state = state.copyWith(checkBoxTermsConditionGuarantor: value);
  }

  void updateAadhar(String value) {
    final isValid = _validateAadhaar(value);
    state = state.copyWith(aadhaar: value);
  }

  void updateKycDoc(String value) {
    final isValid = _validateKycDoc(value);
    state = state.copyWith(kycDocument: value, isKycValid: isValid);
    // copyWith(kycDocument: value, isKycValid: isValid);
  }

  void updatePan(String value) {
    final isValid = _validatePan(value);
    state = state.copyWith(pan: value, isPanValid: isValid);
  }

  void updateMother(String value) {
    final isValid = _validateMother(value);
    state = state.copyWith(mother: value, isMotherValid: isValid);
  }

  void updateContact(String value) {
    final isValid = _validateContact(value);
    state = state.copyWith(contact: value, isContactValid: isValid);
  }

  void updateEmail(String value) {
    final isValid = _validateEmail(value);
    state = state.copyWith(email: value, isEmailValid: isValid);
  }

  void updateApplicantFormSubmitted(bool value) {
    state = state.copyWith(isApplicantFormSubmitted: value);
  }

  void updateMarital(String value) {
    final isValid = _validateMarital(value);
    state = state.copyWith(marital: value, isMaritalValid: isValid);
  }

  void updateReligion(String value) {
    final isValid = _validateReligion(value);
    state = state.copyWith(religion: value, isReligionValid: isValid);
  }

  void updateCaste(String value) {
    final isValid = _validateCaste(value);
    state = state.copyWith(caste: value, isCasteValid: isValid);
  }

  void updateEducationOfApplicant(String value) {
    final isValid = _validateEducationOfApplicant(value);
    state = state.copyWith(
        educationOfApplicant: value, isEducationOfApplicantValid: isValid);
  }

  void updateGender(String value) {
    final isValid = _validateGender(value);
    state = state.copyWith(gender: value, isGenderValid: isValid);
  }

  void updateFullName(String value) {
    final isValid = _validateFullName(value);
    state = state.copyWith(fullName: value, isFullNameValid: isValid);
  }

  void updateFatherName(String value) {
    final isValid = _validateFatherName(value);
    state = state.copyWith(fatherName: value, isFatherNameValid: isValid);
  }

  void updateAge(String value) {
    final isValid = _validateAge(value);
    state = state.copyWith(age: value, isAgeValid: isValid);
  }

  void updateRelationWithApplicant(String value) {
    final isValid = _validateRelationWithApplicant(value);
    state = state.copyWith(
        relationWithApplicant: value, isRelationWithApplicantValid: isValid);
  }

  void updateDob(String value) {
    final isValid = _validateDob(value);
    state = state.copyWith(dob: value, isDobValid: isValid);
  }

  void updateCommunicationAddress1(String value) {
    final isValid = _validateCommunicationAddress1(value);
    state = state.copyWith(
        communicationAddress1: value, isCommunicationAddress1Valid: isValid);
  }

  void updateCommunicationAddress2(String value) {
    final isValid = _validateCommunicationAddress2(value);
    state = state.copyWith(
        communicationAddress2: value, isCommunicationAddress2Valid: isValid);
  }

  void updateCommunicationCity(String value) {
    final isValid = _validateCommunicationCity(value);
    state = state.copyWith(
        communicationCity: value, isCommunicationCityValid: isValid);
  }

  void updateCommunicationDistrict(String value) {
    final isValid = _validateCommunicationDistrict(value);
    state = state.copyWith(
        communicationDistrict: value, isCommunicationDistrictValid: isValid);
  }

  void updateCommunicationState(String value) {
    final isValid = _validateCommunicationState(value);
    state = state.copyWith(
        communicationState: value, isCommunicationStateValid: isValid);
  }

  void updateCommunicationPinCode(String value) {
    final isValid = _validateCommunicationPinCode(value);
    state = state.copyWith(
        communicationPinCode: value, isCommunicationPinCodeValid: isValid);
  }

  void updatePermanentAddress1(String value) {
    final isValid = _validatePermanentAddress1(value);
    state = state.copyWith(
        permanentAddress1: value, isPermanentAddress1Valid: isValid);
  }

  void updatePermanentAddress2(String value) {
    final isValid = _validatePermanentAddress2(value);
    state = state.copyWith(
        permanentAddress2: value, isPermanentAddress2Valid: isValid);
  }

  void updatePermanentCity(String value) {
    final isValid = _validatePermanentCity(value);
    state = state.copyWith(permanentCity: value, isPermanentCityValid: isValid);
  }

  void updatePermanentDistrict(String value) {
    final isValid = _validatePermanentDistrict(value);
    state = state.copyWith(
        permanentDistrict: value, isPermanentDistrictValid: isValid);
  }

  void updatePermanentState(String value) {
    final isValid = _validatePermanentState(value);
    state =
        state.copyWith(permanentState: value, isPermanentStateValid: isValid);
  }

  void updatePermanentPinCode(String value) {
    final isValid = _validatePermanentPinCode(value);
    state = state.copyWith(
        permanentPinCode: value, isPermanentPinCodeValid: isValid);
  }

  bool validateForm() {
    final isAadhaarValid = _validateAadhaar(state.aadhaar);
    final isPanValid = _validatePan(state.pan);
    final isCheck = state.checkBoxTermsConditionGuarantor;

    state =
        state.copyWith(isAadhaarValid: isAadhaarValid, isPanValid: isPanValid);
    return isAadhaarValid && isPanValid && isCheck;
  }

  // Validate the form
  // bool validateForm() {
  //   final isKycValid = _validateKycDoc(state.kycDocument);
  //   final isPanValid = _validatePan(state.pan);
  //   final isMotherValid = _validateMother(state.mother);
  //   final isContactValid = _validateContact(state.contact);
  //   final isEmailValid = _validateEmail(state.email);
  //   final isMaritalValid = _validateMarital(state.marital);
  //   final isReligionValid = _validateReligion(state.religion);
  //   final isCasteValid = _validateCaste(state.caste);
  //   final isRelationWithApplicantValid =
  //       _validateRelationWithApplicant(state.relationWithApplicant);
  //   final isEducationOfApplicantValid =
  //       _validateEducationOfApplicant(state.educationOfApplicant);
  //   final isAgeValid = _validateAge(state.age);
  //   final isDobValid = _validateDob(state.dob);
  //   final isFatherNameValid = _validateFatherName(state.fatherName);
  //   final isFullNameValid = _validateFullName(state.fullName);
  //   final isGenderValid = _validateGender(state.gender);
  //   final isPermanentAddress1Valid =
  //       _validatePermanentAddress1(state.permanentAddress1);
  //   final isPermanentAddress2Valid =
  //       _validatePermanentAddress2(state.permanentAddress2);
  //   final isPermanentCityValid = _validatePermanentCity(state.permanentCity);
  //   final isPermanentStateValid = _validatePermanentState(state.permanentState);
  //   final isPermanentDistrictValid =
  //       _validatePermanentDistrict(state.permanentDistrict);
  //   final isPermanentPinCodeValid =
  //       _validatePermanentPinCode(state.permanentPinCode);
  //   final isCommunicationAddress1Valid =
  //       _validateCommunicationAddress1(state.communicationAddress1);
  //   final isCommunicationAddress2Valid =
  //       _validateCommunicationAddress2(state.communicationAddress2);
  //   final isCommunicationCityValid =
  //       _validateCommunicationCity(state.communicationCity);
  //   final isCommunicationStateValid =
  //       _validateCommunicationState(state.communicationState);
  //   final isCommunicationDistrictValid =
  //       _validateCommunicationDistrict(state.communicationDistrict);
  //   final isCommunicationPinCodeValid =
  //       _validateCommunicationPinCode(state.communicationPinCode);
  //
  //   state = state.copyWith(
  //       isPermanentAddress1Valid: isPermanentAddress1Valid,
  //       isPermanentAddress2Valid: isPermanentAddress2Valid,
  //       isPermanentStateValid: isPermanentStateValid,
  //       isPermanentPinCodeValid: isPermanentPinCodeValid,
  //       isPermanentDistrictValid: isPermanentDistrictValid,
  //       isPermanentCityValid: isPermanentCityValid,
  //       isCommunicationPinCodeValid: isCommunicationPinCodeValid,
  //       isCommunicationDistrictValid: isCommunicationDistrictValid,
  //       isCommunicationStateValid: isCommunicationStateValid,
  //       isCommunicationCityValid: isCommunicationCityValid,
  //       isCommunicationAddress2Valid: isCommunicationAddress2Valid,
  //       isCommunicationAddress1Valid: isCommunicationAddress1Valid,
  //       isKycValid: isKycValid,
  //       isPanValid: isPanValid,
  //       isCasteValid: isCasteValid,
  //       isContactValid: isContactValid,
  //       isMotherValid: isMotherValid,
  //       isMaritalValid: isMaritalValid,
  //       isEmailValid: isEmailValid,
  //       isReligionValid: isReligionValid,
  //       isRelationWithApplicantValid: isRelationWithApplicantValid,
  //       isEducationOfApplicantValid: isEducationOfApplicantValid,
  //       isAgeValid: isAgeValid,
  //       isGenderValid: isGenderValid,
  //       isFullNameValid: isFullNameValid,
  //       isDobValid: isDobValid,
  //       isFatherNameValid: isFatherNameValid);
  //   return isKycValid &&
  //       isPanValid &&
  //       isCasteValid &&
  //       isReligionValid &&
  //       isMaritalValid &&
  //       isEmailValid &&
  //       isContactValid &&
  //       isMotherValid &&
  //       isGenderValid &&
  //       isFullNameValid &&
  //       isFatherNameValid &&
  //       isDobValid &&
  //       isAgeValid &&
  //       isEducationOfApplicantValid &&
  //       isRelationWithApplicantValid &&
  //       isCommunicationPinCodeValid &&
  //       isCommunicationDistrictValid &&
  //       isCommunicationStateValid &&
  //       isCommunicationAddress2Valid &&
  //       isCommunicationCityValid &&
  //       isCommunicationAddress1Valid &&
  //       isPermanentAddress1Valid &&
  //       isPermanentAddress2Valid &&
  //       isPermanentCityValid &&
  //       isPermanentStateValid &&
  //       isPermanentDistrictValid &&
  //       isPermanentPinCodeValid;
  // }

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

  bool _validateAadhaar(String aadhaar) {
    return aadhaar.isNotEmpty && aadhaar.length >= 12;
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

class GuarantorFocusProvider extends StateNotifier<Map<String, bool>> {
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

  GuarantorFocusProvider()
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
        .addListener(() => _focusListener('licenseFocusNode', panFocusNode));
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

class GuarantorKycFormState {
  final bool isLoading;
  final String applicantPhotoFilePath;
  final String aadhaarPhotoFilePath1;
  final String aadhaarPhotoFilePath2;
  final bool checkBoxTermsConditionGuarantor;
  final String panDob;
  final String panGender;
  final String panName;
  final String panFather;
  final bool isApplicantFormSubmitted;
  final bool isOtpVerify;

  final String otp;
  final String aadhaar;
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

  GuarantorKycFormState({
    this.panFather = '',
    this.isOtpVerify = false,
    this.isApplicantFormSubmitted = false,
    this.panDob = '',
    this.panGender = '',
    this.panName = '',
    this.checkBoxTermsConditionGuarantor = false,
    this.isLoading = false,
    this.otp = '',
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

  GuarantorKycFormState copyWith(
      {String? panFather,
      bool? isOtpVerify,
      bool? isApplicantFormSubmitted,
      bool? isAadhaarValid,
      String? panDob,
      String? panGender,
      String? panName,
      bool? checkBoxTermsConditionGuarantor,
      bool? isLoading,
      String? otp,
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
    return GuarantorKycFormState(
        panFather: panFather ?? this.panFather,
        isOtpVerify: isOtpVerify ?? this.isOtpVerify,
        isApplicantFormSubmitted:
            isApplicantFormSubmitted ?? this.isApplicantFormSubmitted,
        panDob: panDob ?? this.panDob,
        panGender: panGender ?? this.panGender,
        panName: panName ?? this.panName,
        checkBoxTermsConditionGuarantor: checkBoxTermsConditionGuarantor ??
            this.checkBoxTermsConditionGuarantor,
        isAadhaarValid: isAadhaarValid ?? this.isAadhaarValid,
        isLoading: isLoading ?? this.isLoading,
        otp: otp ?? this.otp,
        applicantPhotoFilePath:
            applicantPhotoFilePath ?? this.applicantPhotoFilePath,
        aadhaarPhotoFilePath1:
            aadhaarPhotoFilePath1 ?? this.aadhaarPhotoFilePath1,
        aadhaarPhotoFilePath2:
            aadhaarPhotoFilePath2 ?? this.aadhaarPhotoFilePath2,
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

final guarantorController =
    StateNotifierProvider<FormDataControllerNotifier, GuarantorDataController>(
        (ref) {
  return FormDataControllerNotifier();
});

class FormDataControllerNotifier
    extends StateNotifier<GuarantorDataController> {
  FormDataControllerNotifier()
      : super(GuarantorDataController(
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
        ));

  @override
  void dispose() {
    state.panController.dispose();
    state.aadhaarController.dispose();
    state.kycDocumentController.dispose();
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
    state.ageController.dispose();
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

class GuarantorDataController {
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

  GuarantorDataController({
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
}

final paymentProvider = StateNotifierProvider.family<PaymentWithRazorPay,
    PaymentState, BuildContext>((ref, context) {
  return PaymentWithRazorPay(context);
});

class PaymentWithRazorPay extends StateNotifier<PaymentState> {
  final BuildContext context;
  final Razorpay _razorpay = Razorpay();

  PaymentWithRazorPay(this.context) : super(PaymentState(status: 'initial')) {
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
  }

  void payWithRazorPay(
      {required int amount, required String mobile, required String orderId}) {
    print(mobile);
    // String mobileNo = mobile;
    var options = {
      'key': 'rzp_live_qFjwtsJR2qTnPA',
      'amount': amount * 100,
      'order_id': orderId,
      // 'name': 'Acme Corp.',
      'description': 'Login Fees',
      'retry': {'enabled': true, 'max_count': 1},
      'send_sms_hash': true,
      'prefill': {'contact': mobile, 'email': 'test@razorpay.com'},
      'external': {
        'wallets': ['paytm']
      }
    };
    print(options['prefill']);
    try {
      _razorpay.open(options);
    } catch (e) {
      state = PaymentState(status: 'error', errorMessage: e.toString());
    }
  }

  @override
  void dispose() {
    _razorpay.clear();
    super.dispose();
  }

  // Handle payment success
  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    if (kDebugMode) {
      print('payment success');
    }
    FormSubmitDialog().formSubmitDialog(context: context);
    state = PaymentState(status: 'success', transactionId: response.paymentId);
  }

// Handle payment error
  void _handlePaymentError(PaymentFailureResponse response) {
    state = PaymentState(status: 'error', errorMessage: response.message);
  }

// Handle external wallet selection
  void _handleExternalWallet(ExternalWalletResponse response) {
    state = PaymentState(
        status: 'external_wallet', transactionId: response.walletName);
  }
}

class PaymentState {
  final String status;
  final String? transactionId;
  final String? errorMessage;

  PaymentState({
    required this.status,
    this.transactionId,
    this.errorMessage,
  });
}

enum GuarantorOptionRole { Yes, NO, NON }
