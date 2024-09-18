import 'package:dropdown_textfield/dropdown_textfield.dart';
import 'package:finexe/feature/base/utils/namespase/app_colors.dart';
import 'package:finexe/feature/base/utils/widget/app_text_filed_login.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../../../base/utils/namespase/app_style.dart';
import '../../../../../../base/utils/namespase/display_size.dart';
import '../../../../../../base/utils/namespase/font_size.dart';
import '../../../../../../base/utils/widget/app_button.dart';
import '../../../../../../base/utils/widget/upload_box.dart';
import '../../../view_model/sales_on_boarding_form.dart';
import '../../widget/stepper_content.dart';
import '../view_model/personal_details_view_model.dart';

class PersonalDetails extends ConsumerWidget {
  PersonalDetails({super.key, required this.index});

  final int index;

  // List<TextEditingController> listController;
  //  final _aadhaarController = TextEditingController();
  // final _kycDocumentController = SingleValueDropDownController();
  // final licenseController = TextEditingController();
  // final motherController = TextEditingController();
  // final contactController = TextEditingController();
  // final emailController = TextEditingController();
  // final maritalController = TextEditingController();
  // final religionController = TextEditingController();
  // final casteController = TextEditingController();
  // final educationOfApplicantController = TextEditingController();
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final formState = ref.watch(formViewModelProvider);
    final formViewModel = ref.read(formViewModelProvider.notifier);
    final aadhaarFocusStates = ref.watch(aadhaarFocusProvider);
    final aadhaarFocusViewModel = ref.read(aadhaarFocusProvider.notifier);
    final checkBoxTerms = ref.watch(checkBoxTermsCondition);
    final selectedValue = ref.watch(optionRoleProvider);

    final personalFormState = ref.watch(personalDetailViewModelProvider);
    final personalFormViewModel =
        ref.read(personalDetailViewModelProvider.notifier);
    final personalFocusStates = ref.watch(personalDetailFocusProvider);
    final isRemember = ref.watch(rememberProvider);
    final personalFocusViewModel =
        ref.read(personalDetailFocusProvider.notifier);
    return Column(
      children: [
        UploadBox(
          height: displayHeight(context) * 0.15,
          width: displayWidth(context),
          color: AppColors.buttonBorderGray,
          iconData: Icons.file_upload_outlined,
          textColor: AppColors.buttonBorderGray,
          subTextColor: AppColors.subTextColor,
          title: 'Max size: 10MB',
          subTitle: 'Co-Applicant Photo',
        ),
        SizedBox(
          height: displayHeight(context) * 0.04,
        ),
        Visibility(
          visible: selectedValue == OptionRole.NON,
          replacement: selectedValue == OptionRole.Yes
              ? ifYesLinkedAadhaar(index,
                  ref: ref,
                  context: context,
                  // aadhaarController: _aadhaarController,
                  formState: formState,
                  formViewModel: formViewModel,
                  aadhaarFocusStates: aadhaarFocusStates,
                  aadhaarFocusViewModel: aadhaarFocusViewModel,
                  checkBoxTerms: checkBoxTerms)
              : ifNoLinkedAadhaar(context, index),
          child: Column(
            children: [
              const Text('Is Customer Mobile No. Linked With Aadhaar ?'),
              Row(
                children: [
                  aadhaarLinkRadios(index,
                      context: context,
                      title: 'Yes',
                      value: OptionRole.Yes,
                      ref: ref,
                      selectedValue: selectedValue),
                  aadhaarLinkRadios(index,
                      context: context,
                      title: 'No',
                      value: OptionRole.NO,
                      ref: ref,
                      selectedValue: selectedValue),
                ],
              ),
            ],
          ),
        ),
        SizedBox(
          height: displayHeight(context) * 0.05,
        ),
        const Text('Personal Detail’s'),
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            border: Border.all(color: AppColors.boxBorderGray),
            borderRadius: const BorderRadius.all(Radius.circular(10)),
          ),
          child: Column(
            children: [
              DropDownTextField(
                // controller: _kycDocumentController,
                // initialValue: "name4",
                listSpace: 20,
                listPadding: ListPadding(top: 20),
                enableSearch: false,
                dropDownList: const [
                  DropDownValueModel(name: 'PAN Card', value: "PANCard"),
                  DropDownValueModel(
                      name: 'Driving License', value: "DrivingLicense"),
                  DropDownValueModel(name: 'VoterId', value: "VoterId"),
                ],
                listTextStyle: const TextStyle(color: AppColors.primery),
                dropDownItemCount: 3,
                onChanged: (val) {
                  // formViewModel.updateKycDoc(val);
                },
                textFieldFocusNode: personalFocusViewModel.kycDocFocusNode,
                textFieldDecoration: InputDecoration(
                  hintStyle: const TextStyle(color: AppColors.textGray),
                  floatingLabelStyle: personalFocusStates['kycDocFocusNode']!
                      ? AppStyles.subHeading.copyWith(color: AppColors.primery)
                      : AppStyles.subHeading,
                  label: const Text(
                    'Kyc Document',
                    // style: const TextStyle(color: AppColors.textGray),
                  ),

                  // errorText: isError! ? errorText : null,
                  enabledBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: AppColors.gray, width: 2),
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  // filled: true,
                  // fillColor: AppColors.gray,
                  border: const OutlineInputBorder(
                    borderSide: BorderSide(color: AppColors.gray, width: 2),
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),

                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: !personalFormState[index].isKycValid
                              ? Colors.red
                              : Colors.blue,
                          width: 2),
                      borderRadius:
                          const BorderRadius.all(Radius.circular(10))),
                  // ),
                  // focusedErrorBorder: isError!
                  //     ? const OutlineInputBorder(
                  //     borderRadius: BorderRadius.all(Radius.circular(10)),
                  //     borderSide: BorderSide(color: Colors.red, width: 2))
                  //     : null       borderRadius: const BorderRadius.all(Radius.circular(10)),
                ),
              ),
              SizedBox(
                height: displayHeight(context) * 0.02,
              ),
              AppFloatTextField(
                focusNode: personalFocusViewModel.licenseFocusNode,
                currentState: personalFocusStates['licenseFocusNode'],
                // controller: licenseController,
                onChange: (value) {
                  personalFormViewModel.updateLicense(value, index);
                },
                height: !personalFormState[index].isLicenseValid
                    ? displayHeight(context) * 0.09
                    : null,
                inerHint: 'Driving Licence No.',
                errorText: "Driving Licence No. is a required field",
                isError: !personalFormState[index].isLicenseValid,
                textInputAction: TextInputAction.done,
              ),
              SizedBox(
                height: displayHeight(context) * 0.02,
              ),
              AppFloatTextField(
                focusNode: personalFocusViewModel.motherFocusNode,
                currentState: personalFocusStates['motherFocusNode'],
                // controller: motherController,
                onChange: (value) {
                  personalFormViewModel.updateMother(value, index);
                },
                height: !personalFormState[index].isMotherValid
                    ? displayHeight(context) * 0.09
                    : null,
                inerHint: 'Mother Name',
                errorText: "Mother Name is a required field",
                isError: !personalFormState[index].isMotherValid,
                textInputAction: TextInputAction.done,
              ),
              SizedBox(
                height: displayHeight(context) * 0.02,
              ),
              AppFloatTextField(
                focusNode: personalFocusViewModel.contactFocusNode,
                currentState: personalFocusStates['contactFocusNode'],
                // controller: contactController,
                onChange: (value) {
                  personalFormViewModel.updateContact(value, index);
                },
                height: !personalFormState[index].isContactValid
                    ? displayHeight(context) * 0.09
                    : null,
                inerHint: 'Contact Number',
                errorText: "Contact No. is a required field",
                isError: !personalFormState[index].isContactValid,
                textInputAction: TextInputAction.done,
              ),
              SizedBox(
                height: displayHeight(context) * 0.02,
              ),
              AppFloatTextField(
                focusNode: personalFocusViewModel.emailFocusNode,
                currentState: personalFocusStates['emailFocusNode'],
                // controller: emailController,
                onChange: (value) {
                  personalFormViewModel.updateEmail(value, index);
                },
                height: !personalFormState[index].isEmailValid
                    ? displayHeight(context) * 0.09
                    : null,
                inerHint: 'Email ID',
                errorText: "Email ID is a required field",
                isError: !personalFormState[index].isEmailValid,
                textInputAction: TextInputAction.done,
              ),
              SizedBox(
                height: displayHeight(context) * 0.02,
              ),
              AppFloatTextField(
                focusNode: personalFocusViewModel.maritalFocusNode,
                currentState: personalFocusStates['maritalFocusNode'],
                // controller: maritalController,
                onChange: (value) {
                  personalFormViewModel.updateMarital(value, index);
                },
                height: !personalFormState[index].isMaritalValid
                    ? displayHeight(context) * 0.09
                    : null,
                inerHint: 'Marital Status',
                errorText: "Marital Status is a required field",
                isError: !personalFormState[index].isMaritalValid,
                textInputAction: TextInputAction.done,
              ),
              SizedBox(
                height: displayHeight(context) * 0.02,
              ),
              AppFloatTextField(
                focusNode: personalFocusViewModel.religionFocusNode,
                currentState: personalFocusStates['religionFocusNode'],
                // controller: religionController,
                onChange: (value) {
                  personalFormViewModel.updateReligion(value, index);
                },
                height: !personalFormState[index].isReligionValid
                    ? displayHeight(context) * 0.09
                    : null,
                inerHint: 'Religion',
                errorText: "Religion is a required field",
                isError: !personalFormState[index].isReligionValid,
                textInputAction: TextInputAction.done,
              ),
              SizedBox(
                height: displayHeight(context) * 0.02,
              ),
              AppFloatTextField(
                focusNode: personalFocusViewModel.casteFocusNode,
                currentState: personalFocusStates['casteFocusNode'],
                // controller: casteController,
                onChange: (value) {
                  personalFormViewModel.updateCaste(value, index);
                },
                height: !personalFormState[index].isCasteValid
                    ? displayHeight(context) * 0.09
                    : null,
                inerHint: 'Caste',
                errorText: "Caste is a required field",
                isError: !personalFormState[index].isCasteValid,
                textInputAction: TextInputAction.done,
              ),
            ],
          ),
        ),
        SizedBox(
          height: displayHeight(context) * 0.05,
        ),
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            border: Border.all(color: AppColors.boxBorderGray),
            borderRadius: const BorderRadius.all(Radius.circular(10)),
          ),
          child: Column(
            children: [
              SizedBox(
                height: displayHeight(context) * 0.02,
              ),
              AppFloatTextField(
                focusNode: personalFocusViewModel.educationOfApplicantFocusNode,
                currentState:
                    personalFocusStates['educationOfApplicantFocusNode'],
                // controller: educationOfApplicantController,
                onChange: (value) {
                  personalFormViewModel.updateEducationOfApplicant(
                      value, index);
                },
                height: !personalFormState[index].isEducationOfApplicantValid
                    ? displayHeight(context) * 0.09
                    : null,
                inerHint: 'Education of Applicant',
                errorText: "Driving Licence No. is a required field",
                isError: !personalFormState[index].isEducationOfApplicantValid,
                textInputAction: TextInputAction.done,
              ),
              SizedBox(
                height: displayHeight(context) * 0.02,
              ),
              AppFloatTextField(
                focusNode: personalFocusViewModel.genderFocusNode,
                currentState: personalFocusStates['genderFocusNode'],
                // controller: motherController,
                onChange: (value) {
                  personalFormViewModel.updateGender(value, index);
                },
                height: !personalFormState[index].isGenderValid
                    ? displayHeight(context) * 0.09
                    : null,
                inerHint: 'Gender',
                errorText: "Gender is a required field",
                isError: !personalFormState[index].isGenderValid,
                textInputAction: TextInputAction.done,
              ),
              SizedBox(
                height: displayHeight(context) * 0.02,
              ),
              AppFloatTextField(
                focusNode: personalFocusViewModel.fullNameFocusNode,
                currentState: personalFocusStates['fullNameFocusNode'],
                // controller: contactController,
                onChange: (value) {
                  personalFormViewModel.updateFullName(value, index);
                },
                height: !personalFormState[index].isFullNameValid
                    ? displayHeight(context) * 0.09
                    : null,
                inerHint: 'Full Name',
                errorText: "Full Name is a required field",
                isError: !personalFormState[index].isFullNameValid,
                textInputAction: TextInputAction.done,
              ),
              SizedBox(
                height: displayHeight(context) * 0.02,
              ),
              AppFloatTextField(
                focusNode: personalFocusViewModel.fatherNameFocusNode,
                currentState: personalFocusStates['fatherNameFocusNode'],
                // controller: emailController,
                onChange: (value) {
                  personalFormViewModel.updateEmail(value, index);
                },
                height: !personalFormState[index].isFatherNameValid
                    ? displayHeight(context) * 0.09
                    : null,
                inerHint: 'Father Name',
                errorText: "Father Name is a required field",
                isError: !personalFormState[index].isFatherNameValid,
                textInputAction: TextInputAction.done,
              ),
              SizedBox(
                height: displayHeight(context) * 0.02,
              ),
              AppFloatTextField(
                focusNode: personalFocusViewModel.dobFocusNode,
                currentState: personalFocusStates['dobFocusNode'],
                // controller: maritalController,
                onChange: (value) {
                  personalFormViewModel.updateDob(value, index);
                },
                height: !personalFormState[index].isDobValid
                    ? displayHeight(context) * 0.09
                    : null,
                inerHint: 'DOB',
                errorText: "DOB is a required field",
                isError: !personalFormState[index].isDobValid,
                textInputAction: TextInputAction.done,
              ),
              SizedBox(
                height: displayHeight(context) * 0.02,
              ),
              AppFloatTextField(
                focusNode: personalFocusViewModel.ageFocusNode,
                currentState: personalFocusStates['ageFocusNode'],
                // controller: religionController,
                onChange: (value) {
                  personalFormViewModel.updateAge(value, index);
                },
                height: !personalFormState[index].isAgeValid
                    ? displayHeight(context) * 0.09
                    : null,
                inerHint: 'Age',
                errorText: "Age is a required field",
                isError: !personalFormState[index].isAgeValid,
                textInputAction: TextInputAction.done,
              ),
              SizedBox(
                height: displayHeight(context) * 0.02,
              ),
              AppFloatTextField(
                focusNode:
                    personalFocusViewModel.relationWithApplicantFocusNode,
                currentState:
                    personalFocusStates['relationWithApplicantFocusNode'],
                // controller: casteController,
                onChange: (value) {
                  personalFormViewModel.updateRelationWithApplicant(
                      value, index);
                },
                height: !personalFormState[index].isRelationWithApplicantValid
                    ? displayHeight(context) * 0.09
                    : null,
                inerHint: 'Relation with Applicant',
                errorText: "Relation with Applicant is a required field",
                isError: !personalFormState[index].isRelationWithApplicantValid,
                textInputAction: TextInputAction.done,
              ),
            ],
          ),
        ),
        Align(
          alignment: Alignment.centerLeft,
            child: Text('Address')),
        Align(
          alignment: Alignment.centerLeft,
        child:Text('Communication Address'),),
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            border: Border.all(color: AppColors.boxBorderGray),
            borderRadius: const BorderRadius.all(Radius.circular(10)),
          ),
          child: Column(
            children: [
              SizedBox(
                height: displayHeight(context) * 0.02,
              ),
              AppFloatTextField(
                focusNode:
                    personalFocusViewModel.communicationAddress1FocusNode,
                currentState:
                    personalFocusStates['communicationAddress1FocusNode'],
                // controller: educationOfApplicantController,
                onChange: (value) {
                  personalFormViewModel.updateCommunicationAddress1(
                      value, index);
                },
                height: !personalFormState[index].isCommunicationAddress1Valid
                    ? displayHeight(context) * 0.10
                    : displayHeight(context) * 0.10,
                inerHint: 'Address1',
                errorText: "Address1 is a required field",
                isError: !personalFormState[index].isCommunicationAddress1Valid,
                textInputAction: TextInputAction.done,
              ),
              SizedBox(
                height: displayHeight(context) * 0.02,
              ),
              AppFloatTextField(
                focusNode:
                    personalFocusViewModel.communicationAddress2FocusNode,
                currentState:
                    personalFocusStates['communicationAddress2FocusNode'],
                // controller: motherController,
                onChange: (value) {
                  personalFormViewModel.updateCommunicationAddress2(
                      value, index);
                },
                height: !personalFormState[index].isGenderValid
                    ? displayHeight(context) * 0.09
                    : null,
                inerHint: 'Address2',
                errorText: "Address2 is a required field",
                isError: !personalFormState[index].isCommunicationAddress2Valid,
                textInputAction: TextInputAction.done,
              ),
              SizedBox(
                height: displayHeight(context) * 0.02,
              ),
              AppFloatTextField(
                focusNode: personalFocusViewModel.communicationCityFocusNode,
                currentState: personalFocusStates['communicationCityFocusNode'],
                // controller: contactController,
                onChange: (value) {
                  personalFormViewModel.updateCommunicationCity(value, index);
                },
                height: !personalFormState[index].isCommunicationCityValid
                    ? displayHeight(context) * 0.09
                    : null,
                inerHint: 'City',
                errorText: "City is a required field",
                isError: !personalFormState[index].isCommunicationCityValid,
                textInputAction: TextInputAction.done,
              ),
              SizedBox(
                height: displayHeight(context) * 0.02,
              ),
              AppFloatTextField(
                focusNode: personalFocusViewModel.communicationStateFocusNode,
                currentState:
                    personalFocusStates['communicationStateFocusNode'],
                // controller: emailController,
                onChange: (value) {
                  personalFormViewModel.updateCommunicationState(value, index);
                },
                height: !personalFormState[index].isCommunicationStateValid
                    ? displayHeight(context) * 0.09
                    : null,
                inerHint: 'State',
                errorText: "State is a required field",
                isError: !personalFormState[index].isCommunicationStateValid,
                textInputAction: TextInputAction.done,
              ),
              SizedBox(
                height: displayHeight(context) * 0.02,
              ),
              AppFloatTextField(
                focusNode:
                    personalFocusViewModel.communicationDistrictFocusNode,
                currentState:
                    personalFocusStates['communicationDistrictFocusNode'],
                // controller: maritalController,
                onChange: (value) {
                  personalFormViewModel.updateCommunicationDistrict(
                      value, index);
                },
                height: !personalFormState[index].isCommunicationDistrictValid
                    ? displayHeight(context) * 0.09
                    : null,
                inerHint: 'District',
                errorText: "District is a required field",
                isError: !personalFormState[index].isCommunicationDistrictValid,
                textInputAction: TextInputAction.done,
              ),
              SizedBox(
                height: displayHeight(context) * 0.02,
              ),
              AppFloatTextField(
                focusNode: personalFocusViewModel.communicationPinCodeFocusNode,
                currentState:
                    personalFocusStates['communicationPinCodeFocusNode'],
                // controller: religionController,
                onChange: (value) {
                  personalFormViewModel.updateCommunicationPinCode(
                      value, index);
                },
                height: !personalFormState[index].isCommunicationPinCodeValid
                    ? displayHeight(context) * 0.09
                    : null,
                inerHint: 'PinCode',
                errorText: "PinCode is a required field",
                isError: !personalFormState[index].isCommunicationPinCodeValid,
                textInputAction: TextInputAction.done,
              ),
            ],
          ),
        ),
        Text('Address'),
        Text('Communication Address'),
        Row(
          children: [
            Checkbox(
              value: isRemember,
              onChanged: (value) {
                if (isRemember != true) {
                  ref.read(rememberProvider.notifier).state = true;
                } else {
                  ref.read(rememberProvider.notifier).state = false;
                }
              },
            ),
            Text('Same as permanent address'),
          ],
        ),
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            border: Border.all(color: AppColors.boxBorderGray),
            borderRadius: const BorderRadius.all(Radius.circular(10)),
          ),
          child: Column(
            children: [
              SizedBox(
                height: displayHeight(context) * 0.02,
              ),
              AppFloatTextField(
                focusNode: personalFocusViewModel.permanentAddress1FocusNode,
                currentState: personalFocusStates['permanentAddress1FocusNode'],
                // controller: educationOfApplicantController,
                onChange: (value) {
                  personalFormViewModel.updatePermanentAddress1(value, index);
                },
                height: !personalFormState[index].isPermanentAddress1Valid
                    ? displayHeight(context) * 0.10
                    : displayHeight(context) * 0.10,
                inerHint: 'Address1',
                errorText: "Address1 is a required field",
                isError: !personalFormState[index].isPermanentAddress1Valid,
                textInputAction: TextInputAction.done,
              ),
              SizedBox(
                height: displayHeight(context) * 0.02,
              ),
              AppFloatTextField(
                focusNode: personalFocusViewModel.permanentAddress2FocusNode,
                currentState: personalFocusStates['permanentAddress2FocusNode'],
                // controller: motherController,
                onChange: (value) {
                  personalFormViewModel.updatePermanentAddress2(value, index);
                },
                height: !personalFormState[index].isPermanentAddress2Valid
                    ? displayHeight(context) * 0.09
                    : null,
                inerHint: 'Address2',
                errorText: "Address2 is a required field",
                isError: !personalFormState[index].isPermanentAddress2Valid,
                textInputAction: TextInputAction.done,
              ),
              SizedBox(
                height: displayHeight(context) * 0.02,
              ),
              AppFloatTextField(
                focusNode: personalFocusViewModel.permanentCityFocusNode,
                currentState: personalFocusStates['permanentCityFocusNode'],
                // controller: contactController,
                onChange: (value) {
                  personalFormViewModel.updatePermanentCity(value, index);
                },
                height: !personalFormState[index].isPermanentCityValid
                    ? displayHeight(context) * 0.09
                    : null,
                inerHint: 'City',
                errorText: "City is a required field",
                isError: !personalFormState[index].isPermanentCityValid,
                textInputAction: TextInputAction.done,
              ),
              SizedBox(
                height: displayHeight(context) * 0.02,
              ),
              AppFloatTextField(
                focusNode: personalFocusViewModel.permanentStateFocusNode,
                currentState: personalFocusStates['permanentStateFocusNode'],
                // controller: emailController,
                onChange: (value) {
                  personalFormViewModel.updatePermanentState(value, index);
                },
                height: !personalFormState[index].isPermanentStateValid
                    ? displayHeight(context) * 0.09
                    : null,
                inerHint: 'State',
                errorText: "State is a required field",
                isError: !personalFormState[index].isPermanentStateValid,
                textInputAction: TextInputAction.done,
              ),
              SizedBox(
                height: displayHeight(context) * 0.02,
              ),
              AppFloatTextField(
                focusNode: personalFocusViewModel.permanentDistrictFocusNode,
                currentState: personalFocusStates['permanentDistrictFocusNode'],
                // controller: maritalController,
                onChange: (value) {
                  personalFormViewModel.updatePermanentDistrict(value, index);
                },
                height: !personalFormState[index].isPermanentDistrictValid
                    ? displayHeight(context) * 0.09
                    : null,
                inerHint: 'District',
                errorText: "District is a required field",
                isError: !personalFormState[index].isPermanentDistrictValid,
                textInputAction: TextInputAction.done,
              ),
              SizedBox(
                height: displayHeight(context) * 0.02,
              ),
              AppFloatTextField(
                focusNode: personalFocusViewModel.permanentPinCodeFocusNode,
                currentState: personalFocusStates['permanentPinCodeFocusNode'],
                // controller: religionController,
                onChange: (value) {
                  personalFormViewModel.updatePermanentPinCode(value, index);
                },
                height: !personalFormState[index].isPermanentPinCodeValid
                    ? displayHeight(context) * 0.09
                    : null,
                inerHint: 'PinCode',
                errorText: "PinCode is a required field",
                isError: !personalFormState[index].isPermanentPinCodeValid,
                textInputAction: TextInputAction.done,
              ),
            ],
          ),
        ),
        Align(
          alignment: Alignment.centerRight,
            child: TextButton(onPressed: () {}, child: Text('*Upload Applicant Document'))),
      ],
    );
  }

  Widget aadhaarLinkRadios(int index,
      {required BuildContext context,
      required OptionRole selectedValue,
      required WidgetRef ref,
      required String title,
      required OptionRole value}) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.30,
      child: Row(
        children: [
          Radio<OptionRole>(
            value: value,
            groupValue: selectedValue,
            onChanged: (value) {
              if (value != null) {
                ref.read(optionRoleProvider.notifier).select(value, index);
              }
            },
          ),
          Text(
            title,
          )
        ],
      ),
    );
  }

  Widget ifYesLinkedAadhaar(index,
      {required WidgetRef ref,
      required BuildContext context,
      // required TextEditingController aadhaarController,
      required AadhaarFormState formState,
      required FormViewModel formViewModel,
      required Map<String, bool> aadhaarFocusStates,
      required AadhaarFocusViewModel aadhaarFocusViewModel,
      required bool checkBoxTerms}) {
    return Container(
      padding: const EdgeInsets.only(left: 16, right: 16, top: 30, bottom: 16),
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.boxBorderGray),
        borderRadius: const BorderRadius.all(Radius.circular(10)),
      ),
      width: displayWidth(context),
      child: Column(
        children: [
          // const Text('Aadhar Number'),
          AppFloatTextField(
            focusNode: aadhaarFocusViewModel.aadhaarFocusNode,
            currentState: aadhaarFocusStates['aadhaarFocusNode'],
            // controller: aadhaarController,
            onChange: (value) {
              formViewModel.updateAadhaar(value);
            },
            height: !formState.isAadhaarValid
                ? displayHeight(context) * 0.09
                : null,
            inerHint: 'Enter Aadhaar Number',
            errorText: "Aadhaar Number is a required field",
            isError: !formState.isAadhaarValid,
            textInputAction: TextInputAction.done,
            // hint: 'Password',
          ),
          Row(
            children: [
              Checkbox(
                side: const BorderSide(
                    color: AppColors.boxBorderGray, width: 1.5),
                // semanticLabel: 'jkdhsjk',
                value: checkBoxTerms,
                onChanged: (value) {
                  if (value != null) {
                    ref.read(checkBoxTermsCondition.notifier).state = value;
                  }
                },
              ),
              SizedBox(
                  width: displayWidth(context) * 0.68,
                  child: Text(
                    'I have read the Terms and Conditions and give my consent for the same.',
                    style: AppStyles.termsConditionText,
                  )),
            ],
          ),
          Align(
            alignment: Alignment.centerRight,
            child: TextButton(onPressed: () {}, child: const Text('Get OTP')),
          )
        ],
      ),
    );
  }

  Widget ifNoLinkedAadhaar(BuildContext context, index) {
    return Column(
      children: [
        Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              UploadBox(
                height: displayHeight(context) * 0.15,
                width: displayWidth(context) * 0.35,
                color: AppColors.buttonBorderGray,
                iconData: Icons.file_upload_outlined,
                textColor: AppColors.titleGray,
                subTextColor: AppColors.textDarkGray,
                title: 'Max size: 10MB',
                subTitle: 'Front Image',
              ),
              view(),
              UploadBox(
                height: displayHeight(context) * 0.15,
                width: displayWidth(context) * 0.35,
                color: AppColors.buttonBorderGray,
                iconData: Icons.file_upload_outlined,
                textColor: AppColors.titleGray,
                subTextColor: AppColors.textDarkGray,
                title: 'Max size: 10MB',
                subTitle: 'Front Image',
              ),
            ],
          ),
        ),
        SizedBox(
          height: displayHeight(context) * 0.05,
        ),
        AppButton(
          isFill: true,
          bgColor: AppColors.primaryLight,
          borderColor: AppColors.primery,
          onTap: () {},
          label: 'Confirm',
          textStyle: AppStyles.smallTextStyleRich.copyWith(
              fontSize: FontSize.fontSize16, fontWeight: FontWeight.w500),
          width: displayWidth(context),
          height: displayHeight(context) * 0.07,
        )
      ],
    );
  }

  Widget view() {
    return Column(
      children: [
        const Icon(
          Icons.remove_red_eye_outlined,
          color: AppColors.gray10,
        ),
        Text(
          'View',
          style: AppStyles.subTextStyle.copyWith(color: AppColors.gray10),
        )
      ],
    );
  }
}

enum OptionRole { Yes, NO, NON }
