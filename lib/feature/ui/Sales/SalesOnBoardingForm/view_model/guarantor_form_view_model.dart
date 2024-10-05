

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';


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

final checkBoxTermsConditionGuarantor = StateProvider(
      (ref) {
    return false;
  },
);

final guarantorAddressRoleProvider =
StateNotifierProvider<OptionAddressRoleNotifier, GuarantorOptionRole>((ref) {
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
    state= value;
  }
}


final guarantorRememberProvider = StateProvider<bool>(
      (ref) {
    return false;
  },
);

final guarantorFocusProvider =
StateNotifierProvider<GuarantorFocusProvider, Map<String, bool>>(
        (ref) {
      return GuarantorFocusProvider();
    });

final guarantorViewModelProvider =
StateNotifierProvider<GuarantorViewModel, GuarantorKycFormState>(
        (ref) => GuarantorViewModel());

class GuarantorViewModel extends StateNotifier<GuarantorKycFormState> {
  GuarantorViewModel() : super(GuarantorKycFormState());
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

  Future<void> pickImages() async {


    // var video = await Permission.storage.status;
    if (await Permission.photos.status.isDenied && await Permission.videos.status.isDenied) {
      await Permission.photos.request();
      await Permission.videos.request();
      // We haven't asked for permission yet or the permission has been denied before, but not permanently.
    }
    if(await Permission.photos.status.isGranted && await Permission.videos.status.isGranted){
      try {
        XFile? pickedImage = await picker.pickImage(source: ImageSource.gallery);
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

  // void clearImage() {
  //   state = null;
  // }

  Future<void> pickAadhaar1Images() async {


    // var video = await Permission.storage.status;
    if (await Permission.photos.status.isDenied && await Permission.videos.status.isDenied) {
      await Permission.photos.request();
      await Permission.videos.request();
      // We haven't asked for permission yet or the permission has been denied before, but not permanently.
    }
    if(await Permission.photos.status.isGranted && await Permission.videos.status.isGranted){
      try {
        XFile? pickedImage = await picker.pickImage(source: ImageSource.gallery);
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


    // var video = await Permission.storage.status;
    if (await Permission.photos.status.isDenied && await Permission.videos.status.isDenied) {
      await Permission.photos.request();
      await Permission.videos.request();
      // We haven't asked for permission yet or the permission has been denied before, but not permanently.
    }
    if(await Permission.photos.status.isGranted && await Permission.videos.status.isGranted){
      try {
        XFile? pickedImage = await picker.pickImage(source: ImageSource.gallery);
        print('image before null condition  ${pickedImage!.path.toString()}');
        if (pickedImage != null) {
          print('image ${pickedImage.path}');
          state = state.copyWith(aadhaarPhotoFilePath2: pickedImage.path);
          // File(pickedImage.path) as AadhaarFormState;
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
    print('permanent add ${state.permanentAddress1}, ${state.permanentAddress2}');
  }

  void updateAadhar(String value){
    // final isValid = _validateAadhaar(value);
    state =
        state.copyWith(aadhaar: value);
  }
  void updateKycDoc(String value) {
    final isValid = _validateKycDoc(value);
    state =
        state.copyWith(kycDocument: value, isKycValid: isValid);
    // copyWith(kycDocument: value, isKycValid: isValid);
  }

  void updatePan(String value) {
    final isValid = _validatePan(value);
    state =
        state.copyWith(kycDocument: value, isKycValid: isValid);
  }

  void updateMother(String value) {
    final isValid = _validateMother(value);
    state = state.copyWith(mother: value, isMotherValid: isValid);
  }

  void updateContact(String value) {
    final isValid = _validateContact(value);
    state =
        state.copyWith(contact: value, isContactValid: isValid);
  }

  void updateEmail(String value) {
    final isValid = _validateEmail(value);
    state = state.copyWith(email: value, isEmailValid: isValid);
  }

  void updateMarital(String value) {
    final isValid = _validateMarital(value);
    state =
        state.copyWith(marital: value, isMaritalValid: isValid);
  }

  void updateReligion(String value) {
    final isValid = _validateReligion(value);
    state =
        state.copyWith(religion: value, isReligionValid: isValid);
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
    state =
        state.copyWith(fullName: value, isFullNameValid: isValid);
  }

  void updateFatherName(String value) {
    final isValid = _validateFatherName(value);
    state =
        state.copyWith(fatherName: value, isFatherNameValid: isValid);
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
    state = state
        .copyWith(communicationCity: value, isCommunicationCityValid: isValid);
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
    state = state
        .copyWith(permanentAddress1: value, isPermanentAddress1Valid: isValid);
  }

  void updatePermanentAddress2(String value) {
    final isValid = _validatePermanentAddress2(value);
    state = state
        .copyWith(permanentAddress2: value, isPermanentAddress2Valid: isValid);
  }

  void updatePermanentCity(String value) {
    final isValid = _validatePermanentCity(value);
    state = state
        .copyWith(permanentCity: value, isPermanentCityValid: isValid);
  }

  void updatePermanentDistrict(String value) {
    final isValid = _validatePermanentDistrict(value);
    state = state
        .copyWith(permanentDistrict: value, isPermanentDistrictValid: isValid);
  }

  void updatePermanentState(String value) {
    final isValid = _validatePermanentState(value);
    state = state
        .copyWith(permanentState: value, isPermanentStateValid: isValid);
  }

  void updatePermanentPinCode(String value) {
    final isValid = _validatePermanentPinCode(value);
    state = state
        .copyWith(permanentPinCode: value, isPermanentPinCodeValid: isValid);
  }

  // Validate the form
  bool validateForm(int index) {
    final isKycValid = _validateKycDoc(state.kycDocument);
    final isPanValid = _validatePan(state.pan);
    final isMotherValid = _validateMother(state.mother);
    final isContactValid = _validateContact(state.contact);
    final isEmailValid = _validateEmail(state.email);
    final isMaritalValid = _validateMarital(state.marital);
    final isReligionValid = _validateReligion(state.religion);
    final isCasteValid = _validateCaste(state.caste);
    final isRelationWithApplicantValid =
    _validateRelationWithApplicant(state.relationWithApplicant);
    final isEducationOfApplicantValid =
    _validateEducationOfApplicant(state.educationOfApplicant);
    final isAgeValid = _validateAge(state.age);
    final isDobValid = _validateDob(state.dob);
    final isFatherNameValid = _validateFatherName(state.fatherName);
    final isFullNameValid = _validateFullName(state.fullName);
    final isGenderValid = _validateGender(state.gender);
    final isPermanentAddress1Valid =
    _validatePermanentAddress1(state.permanentAddress1);
    final isPermanentAddress2Valid =
    _validatePermanentAddress2(state.permanentAddress2);
    final isPermanentCityValid =
    _validatePermanentCity(state.permanentCity);
    final isPermanentStateValid =
    _validatePermanentState(state.permanentState);
    final isPermanentDistrictValid =
    _validatePermanentDistrict(state.permanentDistrict);
    final isPermanentPinCodeValid =
    _validatePermanentPinCode(state.permanentPinCode);
    final isCommunicationAddress1Valid =
    _validateCommunicationAddress1(state.communicationAddress1);
    final isCommunicationAddress2Valid =
    _validateCommunicationAddress2(state.communicationAddress2);
    final isCommunicationCityValid =
    _validateCommunicationCity(state.communicationCity);
    final isCommunicationStateValid =
    _validateCommunicationState(state.communicationState);
    final isCommunicationDistrictValid =
    _validateCommunicationDistrict(state.communicationDistrict);
    final isCommunicationPinCodeValid =
    _validateCommunicationPinCode(state.communicationPinCode);

    state = state.copyWith(
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
        isFatherNameValid: isFatherNameValid);
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

// License validation logic
  bool _validatePan(String pan) {
    return pan.length >= 12;
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
    panFocusNode.addListener(
            () => _focusListener('licenseFocusNode', panFocusNode));
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
    panFocusNode.removeListener(
            () => _focusListener('panFocusNode', panFocusNode));
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
  final String applicantPhotoFilePath;
  final String aadhaarPhotoFilePath1;
  final String aadhaarPhotoFilePath2;

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
      {
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
      applicantPhotoFilePath: applicantPhotoFilePath??this.applicantPhotoFilePath,
        aadhaarPhotoFilePath1: aadhaarPhotoFilePath1??this.aadhaarPhotoFilePath1,
        aadhaarPhotoFilePath2: aadhaarPhotoFilePath2??this.aadhaarPhotoFilePath2,
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

enum GuarantorOptionRole { Yes, NO, NON }



