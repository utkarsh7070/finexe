//
//
// import 'package:dropdown_textfield/dropdown_textfield.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import '../../../../../base/routes/routes.dart';
// import '../../../../../base/utils/namespase/app_colors.dart';
// import '../../../../../base/utils/namespase/app_style.dart';
// import '../../../../../base/utils/namespase/display_size.dart';
// import '../../../../../base/utils/namespase/font_size.dart';
// import '../../../../../base/utils/widget/app_button.dart';
// import '../../../../../base/utils/widget/app_text_filed_login.dart';
// import '../../../../../base/utils/widget/upload_box.dart';
// import '../../view_model/co_applicant_form_view_model.dart';
//
// class CoApplicationForm extends ConsumerWidget {
//    CoApplicationForm({super.key});
//
//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final uploadCoDocs = ref.watch(uploadCoDoc);
//     final checkBoxTerms = ref.watch(checkBoxTermsConditionCoApplicant);
//     final selectedValue = ref.watch(coApplicantRoleProvider);
//
//     final coApplicationFormState = ref.watch(coApplicantViewModelProvider);
//     final coApplicationFormViewModel = ref.read(coApplicantViewModelProvider.notifier);
//     final coApplicationFocusStates = ref.watch(coApplicantFocusProvider);
//     final isCoApplicationRemember = ref.watch(rememberCoProvider);
//     final coApplicationFocusViewModel = ref.read(coApplicantFocusProvider.notifier);
//
//     // final applicationFormState = ref.watch(applicationViewModelProvider);
//     // final applicationFormViewModel =
//     //     ref.read(applicationViewModelProvider.notifier);
//     // final applicationFocusViewModel =
//     //     ref.read(applicationFocusProvider.notifier);
//     // final applicationFocusStates = ref.watch(applicationFocusProvider);
//     return Scaffold(
//         appBar: AppBar(
//             title: const Text(
//               'Co-Applicant Details',
//             )),
//         body: SafeArea(
//           child: SingleChildScrollView(
//             padding: const EdgeInsets.all(16),
//             physics: const AlwaysScrollableScrollPhysics(),
//             child: Column(
//               children: [
//                 UploadBox(
//                   height: displayHeight(context) * 0.15,
//                   width: displayWidth(context),
//                   color: AppColors.buttonBorderGray,
//                   iconData: Icons.file_upload_outlined,
//                   textColor: AppColors.buttonBorderGray,
//                   subTextColor: AppColors.subTextColor,
//                   title: 'Max size: 10MB',
//                   subTitle: 'Applicant Photo',
//                 ),
//                 SizedBox(
//                   height: displayHeight(context) * 0.04,
//                 ),
//                 Visibility(
//                   visible: selectedValue == CoApplicantOptionRole.NON,
//                   replacement: selectedValue == CoApplicantOptionRole.Yes
//                       ? ifYesLinkedAadhaar(
//                       ref: ref,
//                       context: context,
//                       // aadhaarController: _aadhaarController,
//                       formState: coApplicationFormState,
//                       formViewModel: coApplicationFormViewModel,
//                       aadhaarFocusStates: coApplicationFocusStates,
//                       aadhaarFocusViewModel: coApplicationFocusViewModel,
//                       checkBoxTerms: checkBoxTerms)
//                       : ifNoLinkedAadhaar(context),
//                   child: Column(
//                     children: [
//                       const Text(
//                           'Is Customer Mobile No. Linked With Aadhaar ?'),
//                       Row(
//                         children: [
//                           aadhaarLinkRadios(
//                               context: context,
//                               title: 'Yes',
//                               value: CoApplicantOptionRole.Yes,
//                               ref: ref,
//                               selectedValue: selectedValue),
//                           aadhaarLinkRadios(
//                               context: context,
//                               title: 'No',
//                               value: CoApplicantOptionRole.NO,
//                               ref: ref,
//                               selectedValue: selectedValue),
//                         ],
//                       ),
//                     ],
//                   ),
//                 ),
//                 SizedBox(
//                   height: displayHeight(context) * 0.05,
//                 ),
//                 const Text('Personal Detail’s'),
//                 Container(
//                   padding: const EdgeInsets.all(16),
//                   decoration: BoxDecoration(
//                     border: Border.all(color: AppColors.boxBorderGray),
//                     borderRadius: const BorderRadius.all(Radius.circular(10)),
//                   ),
//                   child: Column(
//                     children: [
//                       DropDownTextField(
//                         // controller: _kycDocumentController,
//                         // initialValue: "name4",
//                         listSpace: 20,
//                         listPadding: ListPadding(top: 20),
//                         enableSearch: false,
//                         dropDownList: const [
//                           DropDownValueModel(
//                               name: 'PAN Card', value: "PANCard"),
//                           DropDownValueModel(
//                               name: 'Driving License', value: "DrivingLicense"),
//                           DropDownValueModel(name: 'VoterId', value: "VoterId"),
//                         ],
//                         listTextStyle:
//                         const TextStyle(color: AppColors.primary),
//                         dropDownItemCount: 3,
//                         onChanged: (val) {
//                           // formViewModel.updateKycDoc(val);
//                         },
//                         textFieldFocusNode:
//                         coApplicationFocusViewModel.kycDocFocusNode,
//                         textFieldDecoration: InputDecoration(
//                           hintStyle: const TextStyle(color: AppColors.textGray),
//                           floatingLabelStyle:
//                           coApplicationFocusStates['kycDocFocusNode']!
//                               ? AppStyles.subHeading
//                               .copyWith(color: AppColors.primary)
//                               : AppStyles.subHeading,
//                           label: const Text(
//                             'Kyc Document',
//                             // style: const TextStyle(color: AppColors.textGray),
//                           ),
//
//                           // errorText: isError! ? errorText : null,
//                           enabledBorder: const OutlineInputBorder(
//                               borderSide:
//                               BorderSide(color: AppColors.gray, width: 2),
//                               borderRadius:
//                               BorderRadius.all(Radius.circular(10))),
//                           // filled: true,
//                           // fillColor: AppColors.gray,
//                           border: const OutlineInputBorder(
//                             borderSide:
//                             BorderSide(color: AppColors.gray, width: 2),
//                             borderRadius: BorderRadius.all(Radius.circular(10)),
//                           ),
//
//                           focusedBorder: OutlineInputBorder(
//                               borderSide: BorderSide(
//                                   color: !coApplicationFormState.isKycValid
//                                       ? Colors.red
//                                       : Colors.blue,
//                                   width: 2),
//                               borderRadius:
//                               const BorderRadius.all(Radius.circular(10))),
//                           // ),
//                           // focusedErrorBorder: isError!
//                           //     ? const OutlineInputBorder(
//                           //     borderRadius: BorderRadius.all(Radius.circular(10)),
//                           //     borderSide: BorderSide(color: Colors.red, width: 2))
//                           //     : null       borderRadius: const BorderRadius.all(Radius.circular(10)),
//                         ),
//                       ),
//                       SizedBox(
//                         height: displayHeight(context) * 0.02,
//                       ),
//                       // AppFloatTextField(
//                       //   focusNode: coApplicationFocusViewModel.licenseFocusNode,
//                       //   currentState: coApplicationFocusStates['licenseFocusNode'],
//                       //   // controller: licenseController,
//                       //   onChange: (value) {
//                       //     coApplicationFormViewModel.updateLicense(value);
//                       //   },
//                       //   height: !coApplicationFormState.isLicenseValid
//                       //       ? displayHeight(context) * 0.09
//                       //       : null,
//                       //   inerHint: 'Driving Licence No.',
//                       //   errorText: "Driving Licence No. is a required field",
//                       //   isError: !coApplicationFormState.isLicenseValid,
//                       //   textInputAction: TextInputAction.done,
//                       // ),
//                       SizedBox(
//                         height: displayHeight(context) * 0.02,
//                       ),
//                       AppFloatTextField(
//                         focusNode: coApplicationFocusViewModel.motherFocusNode,
//                         currentState: coApplicationFocusStates['motherFocusNode'],
//                         // controller: motherController,
//                         onChange: (value) {
//                           coApplicationFormViewModel.updateMother(value);
//                         },
//                         height: !coApplicationFormState.isMotherValid
//                             ? displayHeight(context) * 0.09
//                             : null,
//                         inerHint: 'Mother Name',
//                         errorText: "Mother Name is a required field",
//                         isError: !coApplicationFormState.isMotherValid,
//                         textInputAction: TextInputAction.done,
//                       ),
//                       SizedBox(
//                         height: displayHeight(context) * 0.02,
//                       ),
//                       AppFloatTextField(
//                         focusNode: coApplicationFocusViewModel.contactFocusNode,
//                         currentState: coApplicationFocusStates['contactFocusNode'],
//                         // controller: contactController,
//                         onChange: (value) {
//                           coApplicationFormViewModel.updateContact(value);
//                         },
//                         height: !coApplicationFormState.isContactValid
//                             ? displayHeight(context) * 0.09
//                             : null,
//                         inerHint: 'Contact Number',
//                         errorText: "Contact No. is a required field",
//                         isError: ! coApplicationFormState.isContactValid,
//                         textInputAction: TextInputAction.done,
//                       ),
//                       SizedBox(
//                         height: displayHeight(context) * 0.02,
//                       ),
//                       AppFloatTextField(
//                         focusNode: coApplicationFocusViewModel.emailFocusNode,
//                         currentState:  coApplicationFocusStates['emailFocusNode'],
//                         // controller: emailController,
//                         onChange: (value) {
//                           coApplicationFormViewModel.updateEmail(value);
//                         },
//                         height: ! coApplicationFormState.isEmailValid
//                             ? displayHeight(context) * 0.09
//                             : null,
//                         inerHint: 'Email ID',
//                         errorText: "Email ID is a required field",
//                         isError: !coApplicationFormState.isEmailValid,
//                         textInputAction: TextInputAction.done,
//                       ),
//                       SizedBox(
//                         height: displayHeight(context) * 0.02,
//                       ),
//                       AppFloatTextField(
//                         focusNode: coApplicationFocusViewModel.maritalFocusNode,
//                         currentState: coApplicationFocusStates['maritalFocusNode'],
//                         // controller: maritalController,
//                         onChange: (value) {
//                           coApplicationFormViewModel.updateMarital(value);
//                         },
//                         height: !coApplicationFormState.isMaritalValid
//                             ? displayHeight(context) * 0.09
//                             : null,
//                         inerHint: 'Marital Status',
//                         errorText: "Marital Status is a required field",
//                         isError: !coApplicationFormState.isMaritalValid,
//                         textInputAction: TextInputAction.done,
//                       ),
//                       SizedBox(
//                         height: displayHeight(context) * 0.02,
//                       ),
//                       AppFloatTextField(
//                         focusNode: coApplicationFocusViewModel.religionFocusNode,
//                         currentState: coApplicationFocusStates['religionFocusNode'],
//                         // controller: religionController,
//                         onChange: (value) {
//                           coApplicationFormViewModel.updateReligion(value);
//                         },
//                         height: !coApplicationFormState.isReligionValid
//                             ? displayHeight(context) * 0.09
//                             : null,
//                         inerHint: 'Religion',
//                         errorText: "Religion is a required field",
//                         isError: !coApplicationFormState.isReligionValid,
//                         textInputAction: TextInputAction.done,
//                       ),
//                       SizedBox(
//                         height: displayHeight(context) * 0.02,
//                       ),
//                       AppFloatTextField(
//                         focusNode: coApplicationFocusViewModel.casteFocusNode,
//                         currentState: coApplicationFocusStates['casteFocusNode'],
//                         // controller: casteController,
//                         onChange: (value) {
//                           coApplicationFormViewModel.updateCaste(value);
//                         },
//                         height: !coApplicationFormState.isCasteValid
//                             ? displayHeight(context) * 0.09
//                             : null,
//                         inerHint: 'Caste',
//                         errorText: "Caste is a required field",
//                         isError: !coApplicationFormState.isCasteValid,
//                         textInputAction: TextInputAction.done,
//                       ),
//                     ],
//                   ),
//                 ),
//                 SizedBox(
//                   height: displayHeight(context) * 0.05,
//                 ),
//                 Container(
//                   padding: const EdgeInsets.all(16),
//                   decoration: BoxDecoration(
//                     border: Border.all(color: AppColors.boxBorderGray),
//                     borderRadius: const BorderRadius.all(Radius.circular(10)),
//                   ),
//                   child: Column(
//                     children: [
//                       SizedBox(
//                         height: displayHeight(context) * 0.02,
//                       ),
//                       AppFloatTextField(
//                         focusNode: coApplicationFocusViewModel
//                             .educationOfApplicantFocusNode,
//                         currentState: coApplicationFocusStates[
//                         'educationOfApplicantFocusNode'],
//                         // controller: educationOfApplicantController,
//                         onChange: (value) {
//                           coApplicationFormViewModel
//                               .updateEducationOfApplicant(value);
//                         },
//                         height: !coApplicationFormState.isEducationOfApplicantValid
//                             ? displayHeight(context) * 0.09
//                             : null,
//                         inerHint: 'Education of Applicant',
//                         errorText: "Driving Licence No. is a required field",
//                         isError: !coApplicationFormState.isEducationOfApplicantValid,
//                         textInputAction: TextInputAction.done,
//                       ),
//                       SizedBox(
//                         height: displayHeight(context) * 0.02,
//                       ),
//                       AppFloatTextField(
//                         focusNode: coApplicationFocusViewModel.genderFocusNode,
//                         currentState: coApplicationFocusStates['genderFocusNode'],
//                         // controller: motherController,
//                         onChange: (value) {
//                           coApplicationFormViewModel.updateGender(value);
//                         },
//                         height: !coApplicationFormState.isGenderValid
//                             ? displayHeight(context) * 0.09
//                             : null,
//                         inerHint: 'Gender',
//                         errorText: "Gender is a required field",
//                         isError: !coApplicationFormState.isGenderValid,
//                         textInputAction: TextInputAction.done,
//                       ),
//                       SizedBox(
//                         height: displayHeight(context) * 0.02,
//                       ),
//                       AppFloatTextField(
//                         focusNode: coApplicationFocusViewModel.fullNameFocusNode,
//                         currentState: coApplicationFocusStates['fullNameFocusNode'],
//                         // controller: contactController,
//                         onChange: (value) {
//                           coApplicationFormViewModel.updateFullName(value);
//                         },
//                         height: !coApplicationFormState.isFullNameValid
//                             ? displayHeight(context) * 0.09
//                             : null,
//                         inerHint: 'Full Name',
//                         errorText: "Full Name is a required field",
//                         isError: !coApplicationFormState.isFullNameValid,
//                         textInputAction: TextInputAction.done,
//                       ),
//                       SizedBox(
//                         height: displayHeight(context) * 0.02,
//                       ),
//                       AppFloatTextField(
//                         focusNode: coApplicationFocusViewModel.fatherNameFocusNode,
//                         currentState:
//                         coApplicationFocusStates['fatherNameFocusNode'],
//                         // controller: emailController,
//                         onChange: (value) {
//                           coApplicationFormViewModel.updateEmail(value);
//                         },
//                         height: !coApplicationFormState.isFatherNameValid
//                             ? displayHeight(context) * 0.09
//                             : null,
//                         inerHint: 'Father Name',
//                         errorText: "Father Name is a required field",
//                         isError: !coApplicationFormState.isFatherNameValid,
//                         textInputAction: TextInputAction.done,
//                       ),
//                       SizedBox(
//                         height: displayHeight(context) * 0.02,
//                       ),
//                       AppFloatTextField(
//                         focusNode: coApplicationFocusViewModel.dobFocusNode,
//                         currentState: coApplicationFocusStates['dobFocusNode'],
//                         // controller: maritalController,
//                         onChange: (value) {
//                           coApplicationFormViewModel.updateDob(value);
//                         },
//                         height: !coApplicationFormState.isDobValid
//                             ? displayHeight(context) * 0.09
//                             : null,
//                         inerHint: 'DOB',
//                         errorText: "DOB is a required field",
//                         isError: !coApplicationFormState.isDobValid,
//                         textInputAction: TextInputAction.done,
//                       ),
//                       SizedBox(
//                         height: displayHeight(context) * 0.02,
//                       ),
//                       AppFloatTextField(
//                         focusNode: coApplicationFocusViewModel.ageFocusNode,
//                         currentState: coApplicationFocusStates['ageFocusNode'],
//                         // controller: religionController,
//                         onChange: (value) {
//                           coApplicationFormViewModel.updateAge(value);
//                         },
//                         height: !coApplicationFormState.isAgeValid
//                             ? displayHeight(context) * 0.09
//                             : null,
//                         inerHint: 'Age',
//                         errorText: "Age is a required field",
//                         isError: !coApplicationFormState.isAgeValid,
//                         textInputAction: TextInputAction.done,
//                       ),
//                       SizedBox(
//                         height: displayHeight(context) * 0.02,
//                       ),
//                       AppFloatTextField(
//                         focusNode: coApplicationFocusViewModel
//                             .relationWithApplicantFocusNode,
//                         currentState: coApplicationFocusStates[
//                         'relationWithApplicantFocusNode'],
//                         // controller: casteController,
//                         onChange: (value) {
//                           coApplicationFormViewModel.updateRelationWithApplicant(
//                             value,
//                           );
//                         },
//                         height: !coApplicationFormState.isRelationWithApplicantValid
//                             ? displayHeight(context) * 0.09
//                             : null,
//                         inerHint: 'Relation with Applicant',
//                         errorText:
//                         "Relation with Applicant is a required field",
//                         isError:
//                         !coApplicationFormState.isRelationWithApplicantValid,
//                         textInputAction: TextInputAction.done,
//                       ),
//                     ],
//                   ),
//                 ),
//                 const Align(
//                     alignment: Alignment.centerLeft, child: Text('Address')),
//                 const Align(
//                   alignment: Alignment.centerLeft,
//                   child: Text('Communication Address'),
//                 ),
//                 Container(
//                   padding: const EdgeInsets.all(16),
//                   decoration: BoxDecoration(
//                     border: Border.all(color: AppColors.boxBorderGray),
//                     borderRadius: const BorderRadius.all(Radius.circular(10)),
//                   ),
//                   child: Column(
//                     children: [
//                       SizedBox(
//                         height: displayHeight(context) * 0.02,
//                       ),
//                       AppFloatTextField(
//                         focusNode: coApplicationFocusViewModel
//                             .communicationAddress1FocusNode,
//                         currentState: coApplicationFocusStates[
//                         'communicationAddress1FocusNode'],
//                         // controller: educationOfApplicantController,
//                         onChange: (value) {
//                           coApplicationFormViewModel
//                               .updateCommunicationAddress1(value);
//                         },
//                         height: !coApplicationFormState.isCommunicationAddress1Valid
//                             ? displayHeight(context) * 0.10
//                             : displayHeight(context) * 0.10,
//                         inerHint: 'Address1',
//                         errorText: "Address1 is a required field",
//                         isError:
//                         !coApplicationFormState.isCommunicationAddress1Valid,
//                         textInputAction: TextInputAction.done,
//                       ),
//                       SizedBox(
//                         height: displayHeight(context) * 0.02,
//                       ),
//                       AppFloatTextField(
//                         focusNode: coApplicationFocusViewModel
//                             .communicationAddress2FocusNode,
//                         currentState: coApplicationFocusStates[
//                         'communicationAddress2FocusNode'],
//                         // controller: motherController,
//                         onChange: (value) {
//                           coApplicationFormViewModel
//                               .updateCommunicationAddress2(value);
//                         },
//                         height: !coApplicationFormState.isGenderValid
//                             ? displayHeight(context) * 0.09
//                             : null,
//                         inerHint: 'Address2',
//                         errorText: "Address2 is a required field",
//                         isError:
//                         !coApplicationFormState.isCommunicationAddress2Valid,
//                         textInputAction: TextInputAction.done,
//                       ),
//                       SizedBox(
//                         height: displayHeight(context) * 0.02,
//                       ),
//                       AppFloatTextField(
//                         focusNode:
//                         coApplicationFocusViewModel.communicationCityFocusNode,
//                         currentState:
//                         coApplicationFocusStates['communicationCityFocusNode'],
//                         // controller: contactController,
//                         onChange: (value) {
//                           coApplicationFormViewModel.updateCommunicationCity(value);
//                         },
//                         height: !coApplicationFormState.isCommunicationCityValid
//                             ? displayHeight(context) * 0.09
//                             : null,
//                         inerHint: 'City',
//                         errorText: "City is a required field",
//                         isError: !coApplicationFormState.isCommunicationCityValid,
//                         textInputAction: TextInputAction.done,
//                       ),
//                       SizedBox(
//                         height: displayHeight(context) * 0.02,
//                       ),
//                       AppFloatTextField(
//                         focusNode:
//                         coApplicationFocusViewModel.communicationStateFocusNode,
//                         currentState:
//                         coApplicationFocusStates['communicationStateFocusNode'],
//                         // controller: emailController,
//                         onChange: (value) {
//                           coApplicationFormViewModel.updateCommunicationState(value);
//                         },
//                         height: !coApplicationFormState.isCommunicationStateValid
//                             ? displayHeight(context) * 0.09
//                             : null,
//                         inerHint: 'State',
//                         errorText: "State is a required field",
//                         isError: !coApplicationFormState.isCommunicationStateValid,
//                         textInputAction: TextInputAction.done,
//                       ),
//                       SizedBox(
//                         height: displayHeight(context) * 0.02,
//                       ),
//                       AppFloatTextField(
//                         focusNode: coApplicationFocusViewModel
//                             .communicationDistrictFocusNode,
//                         currentState: coApplicationFocusStates[
//                         'communicationDistrictFocusNode'],
//                         // controller: maritalController,
//                         onChange: (value) {
//                           coApplicationFormViewModel
//                               .updateCommunicationDistrict(value);
//                         },
//                         height: !coApplicationFormState.isCommunicationDistrictValid
//                             ? displayHeight(context) * 0.09
//                             : null,
//                         inerHint: 'District',
//                         errorText: "District is a required field",
//                         isError:
//                         !coApplicationFormState.isCommunicationDistrictValid,
//                         textInputAction: TextInputAction.done,
//                       ),
//                       SizedBox(
//                         height: displayHeight(context) * 0.02,
//                       ),
//                       AppFloatTextField(
//                         focusNode: coApplicationFocusViewModel
//                             .communicationPinCodeFocusNode,
//                         currentState: coApplicationFocusStates[
//                         'communicationPinCodeFocusNode'],
//                         // controller: religionController,
//                         onChange: (value) {
//                           coApplicationFormViewModel
//                               .updateCommunicationPinCode(value);
//                         },
//                         height: !coApplicationFormState.isCommunicationPinCodeValid
//                             ? displayHeight(context) * 0.09
//                             : null,
//                         inerHint: 'PinCode',
//                         errorText: "PinCode is a required field",
//                         isError: !coApplicationFormState.isCommunicationPinCodeValid,
//                         textInputAction: TextInputAction.done,
//                       ),
//                     ],
//                   ),
//                 ),
//                 const Text('Address'),
//                 const Text('Communication Address'),
//                 Row(
//                   children: [
//                     Checkbox(
//                       value: isCoApplicationRemember,
//                       onChanged: (value) {
//                         if (isCoApplicationRemember != true) {
//                           ref.read(rememberCoProvider.notifier).state = true;
//                         } else {
//                           ref.read(rememberCoProvider.notifier).state = false;
//                         }
//                       },
//                     ),
//                     const Text('Same as permanent address'),
//                   ],
//                 ),
//                 Container(
//                   padding: const EdgeInsets.all(16),
//                   decoration: BoxDecoration(
//                     border: Border.all(color: AppColors.boxBorderGray),
//                     borderRadius: const BorderRadius.all(Radius.circular(10)),
//                   ),
//                   child: Column(
//                     children: [
//                       SizedBox(
//                         height: displayHeight(context) * 0.02,
//                       ),
//                       AppFloatTextField(
//                         focusNode:
//                         coApplicationFocusViewModel.permanentAddress1FocusNode,
//                         currentState:
//                         coApplicationFocusStates['permanentAddress1FocusNode'],
//                         // controller: educationOfApplicantController,
//                         onChange: (value) {
//                           coApplicationFormViewModel.updatePermanentAddress1(value);
//                         },
//                         height: !coApplicationFormState.isPermanentAddress1Valid
//                             ? displayHeight(context) * 0.10
//                             : displayHeight(context) * 0.10,
//                         inerHint: 'Address1',
//                         errorText: "Address1 is a required field",
//                         isError: !coApplicationFormState.isPermanentAddress1Valid,
//                         textInputAction: TextInputAction.done,
//                       ),
//                       SizedBox(
//                         height: displayHeight(context) * 0.02,
//                       ),
//                       AppFloatTextField(
//                         focusNode:
//                         coApplicationFocusViewModel.permanentAddress2FocusNode,
//                         currentState:
//                         coApplicationFocusStates['permanentAddress2FocusNode'],
//                         // controller: motherController,
//                         onChange: (value) {
//                           coApplicationFormViewModel.updatePermanentAddress2(value);
//                         },
//                         height: !coApplicationFormState.isPermanentAddress2Valid
//                             ? displayHeight(context) * 0.09
//                             : null,
//                         inerHint: 'Address2',
//                         errorText: "Address2 is a required field",
//                         isError: !coApplicationFormState.isPermanentAddress2Valid,
//                         textInputAction: TextInputAction.done,
//                       ),
//                       SizedBox(
//                         height: displayHeight(context) * 0.02,
//                       ),
//                       AppFloatTextField(
//                         focusNode:
//                         coApplicationFocusViewModel.permanentCityFocusNode,
//                         currentState:
//                         coApplicationFocusStates['permanentCityFocusNode'],
//                         // controller: contactController,
//                         onChange: (value) {
//                           coApplicationFormViewModel.updatePermanentCity(value);
//                         },
//                         height: !coApplicationFormState.isPermanentCityValid
//                             ? displayHeight(context) * 0.09
//                             : null,
//                         inerHint: 'City',
//                         errorText: "City is a required field",
//                         isError: !coApplicationFormState.isPermanentCityValid,
//                         textInputAction: TextInputAction.done,
//                       ),
//                       SizedBox(
//                         height: displayHeight(context) * 0.02,
//                       ),
//                       AppFloatTextField(
//                         focusNode:
//                         coApplicationFocusViewModel.permanentStateFocusNode,
//                         currentState:
//                         coApplicationFocusStates['permanentStateFocusNode'],
//                         // controller: emailController,
//                         onChange: (value) {
//                           coApplicationFormViewModel.updatePermanentState(value);
//                         },
//                         height: !coApplicationFormState.isPermanentStateValid
//                             ? displayHeight(context) * 0.09
//                             : null,
//                         inerHint: 'State',
//                         errorText: "State is a required field",
//                         isError: !coApplicationFormState.isPermanentStateValid,
//                         textInputAction: TextInputAction.done,
//                       ),
//                       SizedBox(
//                         height: displayHeight(context) * 0.02,
//                       ),
//                       AppFloatTextField(
//                         focusNode:
//                         coApplicationFocusViewModel.permanentDistrictFocusNode,
//                         currentState:
//                         coApplicationFocusStates['permanentDistrictFocusNode'],
//                         // controller: maritalController,
//                         onChange: (value) {
//                           coApplicationFormViewModel.updatePermanentDistrict(value);
//                         },
//                         height: !coApplicationFormState.isPermanentDistrictValid
//                             ? displayHeight(context) * 0.09
//                             : null,
//                         inerHint: 'District',
//                         errorText: "District is a required field",
//                         isError: !coApplicationFormState.isPermanentDistrictValid,
//                         textInputAction: TextInputAction.done,
//                       ),
//                       SizedBox(
//                         height: displayHeight(context) * 0.02,
//                       ),
//                       AppFloatTextField(
//                         focusNode:
//                         coApplicationFocusViewModel.permanentPinCodeFocusNode,
//                         currentState:
//                         coApplicationFocusStates['permanentPinCodeFocusNode'],
//                         // controller: religionController,
//                         onChange: (value) {
//                           coApplicationFormViewModel.updatePermanentPinCode(value);
//                         },
//                         height: !coApplicationFormState.isPermanentPinCodeValid
//                             ? displayHeight(context) * 0.09
//                             : null,
//                         inerHint: 'PinCode',
//                         errorText: "PinCode is a required field",
//                         isError: !coApplicationFormState.isPermanentPinCodeValid,
//                         textInputAction: TextInputAction.done,
//                       ),
//                     ],
//                   ),
//                 ),
//                 Align(
//                     alignment: Alignment.centerRight,
//                     child: TextButton(
//                         onPressed: () {
//                           ref.read(uploadCoDoc.notifier).state = true;
//                         },
//                         child: const Text('*Upload Applicant Document'))),
//                 Visibility(
//                   visible: uploadCoDocs,
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       const Text('Application Document'),
//                       const Text('Upload for Kyc'),
//                       SizedBox(
//                         height: displayHeight(context) * 0.02,
//                       ),
//                       UploadBox(
//                         height: displayHeight(context) * 0.15,
//                         width: displayWidth(context),
//                         color: AppColors.buttonBorderGray,
//                         iconData: Icons.file_upload_outlined,
//                         textColor: AppColors.buttonBorderGray,
//                         subTextColor: AppColors.subTextColor,
//                         title: 'Max size: 10MB',
//                         subTitle: 'Aadhaar Front Photo',
//                       ),
//                       SizedBox(
//                         height: displayHeight(context) * 0.02,
//                       ),
//                       UploadBox(
//                         height: displayHeight(context) * 0.15,
//                         width: displayWidth(context),
//                         color: AppColors.buttonBorderGray,
//                         iconData: Icons.file_upload_outlined,
//                         textColor: AppColors.buttonBorderGray,
//                         subTextColor: AppColors.subTextColor,
//                         title: 'Max size: 10MB',
//                         subTitle: 'Aadhaar Back Photo',
//                       ),
//                       SizedBox(
//                         height: displayHeight(context) * 0.01,
//                       ),
//                       const Text('Pan Card'),
//                       UploadBox(
//                         height: displayHeight(context) * 0.15,
//                         width: displayWidth(context),
//                         color: AppColors.buttonBorderGray,
//                         iconData: Icons.file_upload_outlined,
//                         textColor: AppColors.buttonBorderGray,
//                         subTextColor: AppColors.subTextColor,
//                         title: 'Max size: 10MB',
//                         subTitle: 'Pan Card Front Photo',
//                       ),
//                       SizedBox(
//                         height: displayHeight(context) * 0.02,
//                       ),
//                       InkWell(onTap: () {
//
//                       },
//                         child: const SizedBox(child: Row(children: [
//                           Icon(Icons.add),
//                           Text('Add more co-applicant')
//                         ],),),
//                       ),
//                       SizedBox(
//                         height: displayHeight(context) * 0.03,
//                       ),
//                       AppButton(
//                         textStyle: const TextStyle(color: AppColors.white),
//                         width: displayWidth(context),
//                         label: 'Back',
//                         onTap: () {},
//                       ),
//                       SizedBox(
//                         height: displayHeight(context) * 0.02,
//                       ),
//                       AppButton(
//                         textStyle: const TextStyle(color: AppColors.white),
//                         width: displayWidth(context),
//                         label: 'Next',
//                         onTap: () {
//                           Navigator.pushNamed(context, AppRoutes.saleGuarantorForm);
//                         },
//                       )
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ));
//   }
//
//   Widget aadhaarLinkRadios(
//       {required BuildContext context,
//         required CoApplicantOptionRole selectedValue,
//         required WidgetRef ref,
//         required String title,
//         required CoApplicantOptionRole value}) {
//     return SizedBox(
//       width: MediaQuery.of(context).size.width * 0.30,
//       child: Row(
//         children: [
//           Radio<CoApplicantOptionRole>(
//             value: value,
//             groupValue: selectedValue,
//             onChanged: (value) {
//               if (value != null) {
//                 ref.read(coApplicantRoleProvider.notifier).select(value);
//               }
//             },
//           ),
//           Text(
//             title,
//           )
//         ],
//       ),
//     );
//   }
//
//   Widget ifYesLinkedAadhaar(
//       {required WidgetRef ref,
//         required BuildContext context,
//         // required TextEditingController aadhaarController,
//         required formState,
//         required formViewModel,
//         required Map<String, bool> aadhaarFocusStates,
//         required aadhaarFocusViewModel,
//         required bool checkBoxTerms}) {
//     return Container(
//       padding: const EdgeInsets.only(left: 16, right: 16, top: 30, bottom: 16),
//       decoration: BoxDecoration(
//         border: Border.all(color: AppColors.boxBorderGray),
//         borderRadius: const BorderRadius.all(Radius.circular(10)),
//       ),
//       width: displayWidth(context),
//       child: Column(
//         children: [
//           // const Text('Aadhar Number'),
//           AppFloatTextField(
//             focusNode: aadhaarFocusViewModel.aadhaarFocusNode,
//             currentState: aadhaarFocusStates['aadhaarFocusNode'],
//             // controller: aadhaarController,
//             onChange: (value) {
//               formViewModel.updateAadhaar(value);
//             },
//             height: !formState.isAadhaarValid
//                 ? displayHeight(context) * 0.09
//                 : null,
//             inerHint: 'Enter Aadhaar Number',
//             errorText: "Aadhaar Number is a required field",
//             isError: !formState.isAadhaarValid,
//             textInputAction: TextInputAction.done,
//             // hint: 'Password',
//           ),
//           Row(
//             children: [
//               Checkbox(
//                 side: const BorderSide(
//                     color: AppColors.boxBorderGray, width: 1.5),
//                 // semanticLabel: 'jkdhsjk',
//                 value: checkBoxTerms,
//                 onChanged: (value) {
//                   if (value != null) {
//                     ref.read(checkBoxTermsConditionCoApplicant.notifier).state =
//                         value;
//                   }
//                 },
//               ),
//               SizedBox(
//                   width: displayWidth(context) * 0.68,
//                   child: Text(
//                     'I have read the Terms and Conditions and give my consent for the same.',
//                     style: AppStyles.termsConditionText,
//                   )),
//             ],
//           ),
//           Align(
//             alignment: Alignment.centerRight,
//             child: TextButton(onPressed: () {}, child: const Text('Get OTP')),
//           )
//         ],
//       ),
//     );
//   }
//
//   Widget ifNoLinkedAadhaar(BuildContext context) {
//     return Column(
//       children: [
//         Container(
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               UploadBox(
//                 height: displayHeight(context) * 0.15,
//                 width: displayWidth(context) * 0.35,
//                 color: AppColors.buttonBorderGray,
//                 iconData: Icons.file_upload_outlined,
//                 textColor: AppColors.titleGray,
//                 subTextColor: AppColors.textDarkGray,
//                 title: 'Max size: 10MB',
//                 subTitle: 'Front Image',
//               ),
//               view(),
//               UploadBox(
//                 height: displayHeight(context) * 0.15,
//                 width: displayWidth(context) * 0.35,
//                 color: AppColors.buttonBorderGray,
//                 iconData: Icons.file_upload_outlined,
//                 textColor: AppColors.titleGray,
//                 subTextColor: AppColors.textDarkGray,
//                 title: 'Max size: 10MB',
//                 subTitle: 'Front Image',
//               ),
//             ],
//           ),
//         ),
//         SizedBox(
//           height: displayHeight(context) * 0.05,
//         ),
//         AppButton(
//           isFill: true,
//           bgColor: AppColors.primaryLight,
//           borderColor: AppColors.primary,
//           onTap: () {},
//           label: 'Confirm',
//           textStyle: AppStyles.smallTextStyleRich.copyWith(
//               fontSize: FontSize.fontSize16, fontWeight: FontWeight.w500),
//           width: displayWidth(context),
//           height: displayHeight(context) * 0.07,
//         )
//       ],
//     );
//   }
//
//   Widget view() {
//     return Column(
//       children: [
//         const Icon(
//           Icons.remove_red_eye_outlined,
//           color: AppColors.gray10,
//         ),
//         Text(
//           'View',
//           style: AppStyles.subTextStyle.copyWith(color: AppColors.gray10),
//         )
//       ],
//     );
//   }
// }
//
// // enum CoApplicantOptionRole { Yes, NO, NON }
