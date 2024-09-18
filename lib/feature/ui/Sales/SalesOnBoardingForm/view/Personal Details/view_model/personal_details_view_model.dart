import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


final rememberProvider = StateProvider<bool>(
      (ref) {
    return false;
  },
);

final personalDetailFocusProvider =
    StateNotifierProvider<PersonalDetailFocusProvider, Map<String, bool>>(
        (ref) {
  return PersonalDetailFocusProvider();
});

final personalDetailViewModelProvider =
    StateNotifierProvider<PersonalDetailsViewModel, List<KycFormState>>(
        (ref) => PersonalDetailsViewModel());

class PersonalDetailsViewModel extends StateNotifier<List<KycFormState>> {
  PersonalDetailsViewModel() : super([KycFormState()]);

// Add a new text field
  void addTextField() {
    state = [...state, KycFormState()];
  }

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
  void updateKycDoc(String value, int index) {
    final isValid = _validateKycDoc(value);
    state[index] =
        state[index].copyWith(kycDocument: value, isKycValid: isValid);
    // copyWith(kycDocument: value, isKycValid: isValid);
  }

  void updateLicense(String value, int index) {
    final isValid = _validateLicense(value);
    state[index] =
        state[index].copyWith(kycDocument: value, isKycValid: isValid);
  }

  void updateMother(String value, int index) {
    final isValid = _validateMother(value);
    state[index] = state[index].copyWith(mother: value, isMotherValid: isValid);
  }

  void updateContact(String value, int index) {
    final isValid = _validateContact(value);
    state[index] =
        state[index].copyWith(contact: value, isContactValid: isValid);
  }

  void updateEmail(String value, int index) {
    final isValid = _validateEmail(value);
    state[index] = state[index].copyWith(email: value, isEmailValid: isValid);
  }

  void updateMarital(String value, int index) {
    final isValid = _validateMarital(value);
    state[index] =
        state[index].copyWith(marital: value, isMaritalValid: isValid);
  }

  void updateReligion(String value, int index) {
    final isValid = _validateReligion(value);
    state[index] =
        state[index].copyWith(religion: value, isReligionValid: isValid);
  }

  void updateCaste(String value, int index) {
    final isValid = _validateCaste(value);
    state[index] = state[index].copyWith(caste: value, isCasteValid: isValid);
  }

  void updateEducationOfApplicant(String value, int index) {
    final isValid = _validateEducationOfApplicant(value);
    state[index] = state[index].copyWith(
        educationOfApplicant: value, isEducationOfApplicantValid: isValid);
  }

  void updateGender(String value, int index) {
    final isValid = _validateGender(value);
    state[index] = state[index].copyWith(gender: value, isGenderValid: isValid);
  }

  void updateFullName(String value, int index) {
    final isValid = _validateFullName(value);
    state[index] =
        state[index].copyWith(fullName: value, isFullNameValid: isValid);
  }

  void updateFatherName(String value, int index) {
    final isValid = _validateFatherName(value);
    state[index] =
        state[index].copyWith(fatherName: value, isFatherNameValid: isValid);
  }

  void updateAge(String value, int index) {
    final isValid = _validateAge(value);
    state[index] = state[index].copyWith(age: value, isAgeValid: isValid);
  }

  void updateRelationWithApplicant(String value, int index) {
    final isValid = _validateRelationWithApplicant(value);
    state[index] = state[index].copyWith(
        relationWithApplicant: value, isRelationWithApplicantValid: isValid);
  }

  void updateDob(String value, int index) {
    final isValid = _validateDob(value);
    state[index] = state[index].copyWith(dob: value, isDobValid: isValid);
  }

  void updateCommunicationAddress1(String value, int index) {
    final isValid = _validateCommunicationAddress1(value);
    state[index] = state[index].copyWith(
        communicationAddress1: value, isCommunicationAddress1Valid: isValid);
  }

  void updateCommunicationAddress2(String value, int index) {
    final isValid = _validateCommunicationAddress2(value);
    state[index] = state[index].copyWith(
        communicationAddress2: value, isCommunicationAddress2Valid: isValid);
  }

  void updateCommunicationCity(String value, int index) {
    final isValid = _validateCommunicationCity(value);
    state[index] = state[index]
        .copyWith(communicationCity: value, isCommunicationCityValid: isValid);
  }

  void updateCommunicationDistrict(String value, int index) {
    final isValid = _validateCommunicationDistrict(value);
    state[index] = state[index].copyWith(
        communicationDistrict: value, isCommunicationDistrictValid: isValid);
  }

  void updateCommunicationState(String value, int index) {
    final isValid = _validateCommunicationState(value);
    state[index] = state[index].copyWith(
        communicationState: value, isCommunicationStateValid: isValid);
  }

  void updateCommunicationPinCode(String value, int index) {
    final isValid = _validateCommunicationPinCode(value);
    state[index] = state[index].copyWith(
        communicationPinCode: value, isCommunicationPinCodeValid: isValid);
  }

  void updatePermanentAddress1(String value, int index) {
    final isValid = _validatePermanentAddress1(value);
    state[index] = state[index]
        .copyWith(permanentAddress1: value, isPermanentAddress1Valid: isValid);
  }

  void updatePermanentAddress2(String value, int index) {
    final isValid = _validatePermanentAddress2(value);
    state[index] = state[index]
        .copyWith(permanentAddress2: value, isPermanentAddress2Valid: isValid);
  }

  void updatePermanentCity(String value, int index) {
    final isValid = _validatePermanentCity(value);
    state[index] = state[index]
        .copyWith(permanentCity: value, isPermanentCityValid: isValid);
  }

  void updatePermanentDistrict(String value, int index) {
    final isValid = _validatePermanentDistrict(value);
    state[index] = state[index]
        .copyWith(permanentDistrict: value, isPermanentDistrictValid: isValid);
  }

  void updatePermanentState(String value, int index) {
    final isValid = _validatePermanentState(value);
    state[index] = state[index]
        .copyWith(permanentState: value, isPermanentStateValid: isValid);
  }

  void updatePermanentPinCode(String value, int index) {
    final isValid = _validatePermanentPinCode(value);
    state[index] = state[index]
        .copyWith(permanentPinCode: value, isPermanentPinCodeValid: isValid);
  }

  // Validate the form
  bool validateForm(int index) {
    final isKycValid = _validateKycDoc(state[index].kycDocument);
    final isLicenseValid = _validateLicense(state[index].license);
    final isMotherValid = _validateMother(state[index].mother);
    final isContactValid = _validateContact(state[index].contact);
    final isEmailValid = _validateEmail(state[index].email);
    final isMaritalValid = _validateMarital(state[index].marital);
    final isReligionValid = _validateReligion(state[index].religion);
    final isCasteValid = _validateCaste(state[index].caste);
    final isRelationWithApplicantValid =
        _validateRelationWithApplicant(state[index].relationWithApplicant);
    final isEducationOfApplicantValid =
        _validateEducationOfApplicant(state[index].educationOfApplicant);
    final isAgeValid = _validateAge(state[index].age);
    final isDobValid = _validateDob(state[index].dob);
    final isFatherNameValid = _validateFatherName(state[index].fatherName);
    final isFullNameValid = _validateFullName(state[index].fullName);
    final isGenderValid = _validateGender(state[index].gender);
    final isPermanentAddress1Valid =
        _validatePermanentAddress1(state[index].permanentAddress1);
    final isPermanentAddress2Valid =
        _validatePermanentAddress2(state[index].permanentAddress2);
    final isPermanentCityValid =
        _validatePermanentCity(state[index].permanentCity);
    final isPermanentStateValid =
        _validatePermanentState(state[index].permanentState);
    final isPermanentDistrictValid =
        _validatePermanentDistrict(state[index].permanentDistrict);
    final isPermanentPinCodeValid =
        _validatePermanentPinCode(state[index].permanentPinCode);
    final isCommunicationAddress1Valid =
        _validateCommunicationAddress1(state[index].communicationAddress1);
    final isCommunicationAddress2Valid =
        _validateCommunicationAddress2(state[index].communicationAddress2);
    final isCommunicationCityValid =
        _validateCommunicationCity(state[index].communicationCity);
    final isCommunicationStateValid =
        _validateCommunicationState(state[index].communicationState);
    final isCommunicationDistrictValid =
        _validateCommunicationDistrict(state[index].communicationDistrict);
    final isCommunicationPinCodeValid =
        _validateCommunicationPinCode(state[index].communicationPinCode);

    state = state[index].copyWith(
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
        isLicenseValid: isLicenseValid,
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
        isFatherNameValid: isFatherNameValid) as List<KycFormState>;
    return isKycValid &&
        isLicenseValid &&
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
  bool _validateLicense(String license) {
    return license.length >= 12;
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

class PersonalDetailFocusProvider extends StateNotifier<Map<String, bool>> {
  final FocusNode aadhaarFocusNode;
  final FocusNode kycDocFocusNode;
  final FocusNode licenseFocusNode;
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

  PersonalDetailFocusProvider()
      : aadhaarFocusNode = FocusNode(),
        kycDocFocusNode = FocusNode(),
        licenseFocusNode = FocusNode(),
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
          'licenseFocusNode': false,
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
    licenseFocusNode.addListener(
        () => _focusListener('licenseFocusNode', licenseFocusNode));
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
    licenseFocusNode.removeListener(
        () => _focusListener('licenseFocusNode', licenseFocusNode));
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
    licenseFocusNode.dispose();
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

class KycFormState {
  final String applicantPhotoFilePath;
  final String aadhaarPhotoFilePath1;
  final String aadhaarPhotoFilePath2;

  final String aadhaar;
  final String kycDocument;
  final String license;
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
  final bool isLicenseValid;
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
    this.license = '',
    this.isKycValid = true,
    this.isLicenseValid = true,
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
      {String? aadhaar,
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
      String? license,
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
      bool? isLicenseValid,
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
        aadhaar: aadhaar ?? this.aadhaar,
        kycDocument: kycDocument ?? this.kycDocument,
        license: license ?? this.license,
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
        isLicenseValid: isLicenseValid ?? this.isLicenseValid,
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

//
// class TextFieldControllerModel {
//   final SingleValueDropDownController _kycDocumentController ;
//   // = SingleValueDropDownController();
//   final TextEditingController licenseController;
//   // = TextEditingController();
//   final motherController = TextEditingController();
//   final contactController = TextEditingController();
//   final emailController = TextEditingController();
//   final maritalController = TextEditingController();
//   final religionController = TextEditingController();
//   final casteController = TextEditingController();
//   final educationOfApplicantController = TextEditingController();
//
// }
// class FormModel {
//   List<KycFormState> textFields; // 10 text fields
//   String dropdownValue; // Dropdown selected value
//   int radioButtonValue; // Radio button selected index
//   List<String> filePaths; // File holder paths
//   FormModel({
//     required this.textFields,
//     required this.dropdownValue,
//     required this.radioButtonValue,
//     required this.filePaths,
//   });
//
//   // Factory constructor to create an initial empty form
//   factory FormModel.initial() {
//     return FormModel(
//       textFields: List.filled(28, KycFormState()),
//       dropdownValue: '',
//       radioButtonValue: -1,
//       filePaths: List.filled(3, ''),
//     );
//   }
//
//   // Update the form model immutably
//   FormModel copyWith({
//     List<String>? textFields,
//     String? dropdownValue,
//     int? radioButtonValue,
//     List<String>? filePaths,
//   }) {
//     return FormModel(
//       textFields: textFields ?? this.textFields,
//       dropdownValue: dropdownValue ?? this.dropdownValue,
//       radioButtonValue: radioButtonValue ?? this.radioButtonValue,
//       filePaths: filePaths ?? this.filePaths,
//     );
//   }
// }
