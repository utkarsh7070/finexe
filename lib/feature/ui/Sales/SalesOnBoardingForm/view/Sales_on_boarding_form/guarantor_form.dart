// import 'package:dropdown_textfield/dropdown_textfield.dart';
// import 'package:finexe/feature/base/routes/routes.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
//
// import '../../../../../base/utils/namespase/app_colors.dart';
// import '../../../../../base/utils/namespase/app_style.dart';
// import '../../../../../base/utils/namespase/display_size.dart';
// import '../../../../../base/utils/namespase/font_size.dart';
// import '../../../../../base/utils/widget/app_button.dart';
// import '../../../../../base/utils/widget/app_text_filed_login.dart';
// import '../../../../../base/utils/widget/upload_box.dart';
// import '../../view_model/guarantor_form_view_model.dart';
//
// class GuarantorForm extends ConsumerWidget {
//   const GuarantorForm({super.key});
//
//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final upload = ref.watch(uploadGuarantorDoc);
//     final checkBoxTerms = ref.watch(checkBoxTermsConditionGuarantor);
//     final selectedValue = ref.watch(guarantorRoleProvider);
//
//     final personalFormState = ref.watch(guarantorViewModelProvider);
//     final personalFormViewModel = ref.read(guarantorViewModelProvider.notifier);
//     final personalFocusStates = ref.watch(guarantorFocusProvider);
//     final isRemember = ref.watch(guarantorRememberProvider);
//     final personalFocusViewModel = ref.read(guarantorFocusProvider.notifier);
//
//     return Scaffold(
//         appBar: AppBar(
//             title: const Text(
//               'Guarantor Details',
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
//                   visible: selectedValue == GuarantorOptionRole.NON,
//                   replacement: selectedValue == GuarantorOptionRole.Yes
//                       ? ifYesLinkedAadhaar(
//                       ref: ref,
//                       context: context,
//                       // aadhaarController: _aadhaarController,
//                       formState: personalFormState,
//                       formViewModel: personalFormViewModel,
//                       aadhaarFocusStates: personalFocusStates,
//                       aadhaarFocusViewModel: personalFocusViewModel,
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
//                               value: GuarantorOptionRole.Yes,
//                               ref: ref,
//                               selectedValue: selectedValue),
//                           aadhaarLinkRadios(
//                               context: context,
//                               title: 'No',
//                               value: GuarantorOptionRole.NO,
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
//                         personalFocusViewModel.kycDocFocusNode,
//                         textFieldDecoration: InputDecoration(
//                           hintStyle: const TextStyle(color: AppColors.textGray),
//                           floatingLabelStyle:
//                           personalFocusStates['kycDocFocusNode']!
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
//                                   color: !personalFormState.isKycValid
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
//                       //   focusNode: personalFocusViewModel.licenseFocusNode,
//                       //   currentState: personalFocusStates['licenseFocusNode'],
//                       //   // controller: licenseController,
//                       //   onChange: (value) {
//                       //     personalFormViewModel.updateLicense(value);
//                       //   },
//                       //   height: !personalFormState.isLicenseValid
//                       //       ? displayHeight(context) * 0.09
//                       //       : null,
//                       //   inerHint: 'Driving Licence No.',
//                       //   errorText: "Driving Licence No. is a required field",
//                       //   isError: !personalFormState.isLicenseValid,
//                       //   textInputAction: TextInputAction.done,
//                       // ),
//                       // SizedBox(
//                       //   height: displayHeight(context) * 0.02,
//                       // ),
//                       // AppFloatTextField(
//                       //   focusNode: personalFocusViewModel.motherFocusNode,
//                       //   currentState: personalFocusStates['motherFocusNode'],
//                       //   // controller: motherController,
//                       //   onChange: (value) {
//                       //     personalFormViewModel.updateMother(value);
//                       //   },
//                       //   height: !personalFormState.isMotherValid
//                       //       ? displayHeight(context) * 0.09
//                       //       : null,
//                       //   inerHint: 'Mother Name',
//                       //   errorText: "Mother Name is a required field",
//                       //   isError: !personalFormState.isMotherValid,
//                       //   textInputAction: TextInputAction.done,
//                       // ),
//                       SizedBox(
//                         height: displayHeight(context) * 0.02,
//                       ),
//                       AppFloatTextField(
//                         focusNode: personalFocusViewModel.contactFocusNode,
//                         currentState: personalFocusStates['contactFocusNode'],
//                         // controller: contactController,
//                         onChange: (value) {
//                           personalFormViewModel.updateContact(value);
//                         },
//                         height: !personalFormState.isContactValid
//                             ? displayHeight(context) * 0.09
//                             : null,
//                         inerHint: 'Contact Number',
//                         errorText: "Contact No. is a required field",
//                         isError: !personalFormState.isContactValid,
//                         textInputAction: TextInputAction.done,
//                       ),
//                       SizedBox(
//                         height: displayHeight(context) * 0.02,
//                       ),
//                       AppFloatTextField(
//                         focusNode: personalFocusViewModel.emailFocusNode,
//                         currentState: personalFocusStates['emailFocusNode'],
//                         // controller: emailController,
//                         onChange: (value) {
//                           personalFormViewModel.updateEmail(value);
//                         },
//                         height: !personalFormState.isEmailValid
//                             ? displayHeight(context) * 0.09
//                             : null,
//                         inerHint: 'Email ID',
//                         errorText: "Email ID is a required field",
//                         isError: !personalFormState.isEmailValid,
//                         textInputAction: TextInputAction.done,
//                       ),
//                       SizedBox(
//                         height: displayHeight(context) * 0.02,
//                       ),
//                       AppFloatTextField(
//                         focusNode: personalFocusViewModel.maritalFocusNode,
//                         currentState: personalFocusStates['maritalFocusNode'],
//                         // controller: maritalController,
//                         onChange: (value) {
//                           personalFormViewModel.updateMarital(value);
//                         },
//                         height: !personalFormState.isMaritalValid
//                             ? displayHeight(context) * 0.09
//                             : null,
//                         inerHint: 'Marital Status',
//                         errorText: "Marital Status is a required field",
//                         isError: !personalFormState.isMaritalValid,
//                         textInputAction: TextInputAction.done,
//                       ),
//                       SizedBox(
//                         height: displayHeight(context) * 0.02,
//                       ),
//                       AppFloatTextField(
//                         focusNode: personalFocusViewModel.religionFocusNode,
//                         currentState: personalFocusStates['religionFocusNode'],
//                         // controller: religionController,
//                         onChange: (value) {
//                           personalFormViewModel.updateReligion(value);
//                         },
//                         height: !personalFormState.isReligionValid
//                             ? displayHeight(context) * 0.09
//                             : null,
//                         inerHint: 'Religion',
//                         errorText: "Religion is a required field",
//                         isError: !personalFormState.isReligionValid,
//                         textInputAction: TextInputAction.done,
//                       ),
//                       SizedBox(
//                         height: displayHeight(context) * 0.02,
//                       ),
//                       AppFloatTextField(
//                         focusNode: personalFocusViewModel.casteFocusNode,
//                         currentState: personalFocusStates['casteFocusNode'],
//                         // controller: casteController,
//                         onChange: (value) {
//                           personalFormViewModel.updateCaste(value);
//                         },
//                         height: !personalFormState.isCasteValid
//                             ? displayHeight(context) * 0.09
//                             : null,
//                         inerHint: 'Caste',
//                         errorText: "Caste is a required field",
//                         isError: !personalFormState.isCasteValid,
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
//                         focusNode: personalFocusViewModel
//                             .educationOfApplicantFocusNode,
//                         currentState: personalFocusStates[
//                         'educationOfApplicantFocusNode'],
//                         // controller: educationOfApplicantController,
//                         onChange: (value) {
//                           personalFormViewModel
//                               .updateEducationOfApplicant(value);
//                         },
//                         height: !personalFormState.isEducationOfApplicantValid
//                             ? displayHeight(context) * 0.09
//                             : null,
//                         inerHint: 'Education of Applicant',
//                         errorText: "Driving Licence No. is a required field",
//                         isError: !personalFormState.isEducationOfApplicantValid,
//                         textInputAction: TextInputAction.done,
//                       ),
//                       SizedBox(
//                         height: displayHeight(context) * 0.02,
//                       ),
//                       AppFloatTextField(
//                         focusNode: personalFocusViewModel.genderFocusNode,
//                         currentState: personalFocusStates['genderFocusNode'],
//                         // controller: motherController,
//                         onChange: (value) {
//                           personalFormViewModel.updateGender(value);
//                         },
//                         height: !personalFormState.isGenderValid
//                             ? displayHeight(context) * 0.09
//                             : null,
//                         inerHint: 'Gender',
//                         errorText: "Gender is a required field",
//                         isError: !personalFormState.isGenderValid,
//                         textInputAction: TextInputAction.done,
//                       ),
//                       SizedBox(
//                         height: displayHeight(context) * 0.02,
//                       ),
//                       AppFloatTextField(
//                         focusNode: personalFocusViewModel.fullNameFocusNode,
//                         currentState: personalFocusStates['fullNameFocusNode'],
//                         // controller: contactController,
//                         onChange: (value) {
//                           personalFormViewModel.updateFullName(value);
//                         },
//                         height: !personalFormState.isFullNameValid
//                             ? displayHeight(context) * 0.09
//                             : null,
//                         inerHint: 'Full Name',
//                         errorText: "Full Name is a required field",
//                         isError: !personalFormState.isFullNameValid,
//                         textInputAction: TextInputAction.done,
//                       ),
//                       SizedBox(
//                         height: displayHeight(context) * 0.02,
//                       ),
//                       AppFloatTextField(
//                         focusNode: personalFocusViewModel.fatherNameFocusNode,
//                         currentState:
//                         personalFocusStates['fatherNameFocusNode'],
//                         // controller: emailController,
//                         onChange: (value) {
//                           personalFormViewModel.updateEmail(value);
//                         },
//                         height: !personalFormState.isFatherNameValid
//                             ? displayHeight(context) * 0.09
//                             : null,
//                         inerHint: 'Father Name',
//                         errorText: "Father Name is a required field",
//                         isError: !personalFormState.isFatherNameValid,
//                         textInputAction: TextInputAction.done,
//                       ),
//                       SizedBox(
//                         height: displayHeight(context) * 0.02,
//                       ),
//                       AppFloatTextField(
//                         focusNode: personalFocusViewModel.dobFocusNode,
//                         currentState: personalFocusStates['dobFocusNode'],
//                         // controller: maritalController,
//                         onChange: (value) {
//                           personalFormViewModel.updateDob(value);
//                         },
//                         height: !personalFormState.isDobValid
//                             ? displayHeight(context) * 0.09
//                             : null,
//                         inerHint: 'DOB',
//                         errorText: "DOB is a required field",
//                         isError: !personalFormState.isDobValid,
//                         textInputAction: TextInputAction.done,
//                       ),
//                       SizedBox(
//                         height: displayHeight(context) * 0.02,
//                       ),
//                       AppFloatTextField(
//                         focusNode: personalFocusViewModel.ageFocusNode,
//                         currentState: personalFocusStates['ageFocusNode'],
//                         // controller: religionController,
//                         onChange: (value) {
//                           personalFormViewModel.updateAge(value);
//                         },
//                         height: !personalFormState.isAgeValid
//                             ? displayHeight(context) * 0.09
//                             : null,
//                         inerHint: 'Age',
//                         errorText: "Age is a required field",
//                         isError: !personalFormState.isAgeValid,
//                         textInputAction: TextInputAction.done,
//                       ),
//                       SizedBox(
//                         height: displayHeight(context) * 0.02,
//                       ),
//                       AppFloatTextField(
//                         focusNode: personalFocusViewModel
//                             .relationWithApplicantFocusNode,
//                         currentState: personalFocusStates[
//                         'relationWithApplicantFocusNode'],
//                         // controller: casteController,
//                         onChange: (value) {
//                           personalFormViewModel.updateRelationWithApplicant(
//                             value,
//                           );
//                         },
//                         height: !personalFormState.isRelationWithApplicantValid
//                             ? displayHeight(context) * 0.09
//                             : null,
//                         inerHint: 'Relation with Applicant',
//                         errorText:
//                         "Relation with Applicant is a required field",
//                         isError:
//                         !personalFormState.isRelationWithApplicantValid,
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
//                         focusNode: personalFocusViewModel
//                             .communicationAddress1FocusNode,
//                         currentState: personalFocusStates[
//                         'communicationAddress1FocusNode'],
//                         // controller: educationOfApplicantController,
//                         onChange: (value) {
//                           personalFormViewModel
//                               .updateCommunicationAddress1(value);
//                         },
//                         height: !personalFormState.isCommunicationAddress1Valid
//                             ? displayHeight(context) * 0.10
//                             : displayHeight(context) * 0.10,
//                         inerHint: 'Address1',
//                         errorText: "Address1 is a required field",
//                         isError:
//                         !personalFormState.isCommunicationAddress1Valid,
//                         textInputAction: TextInputAction.done,
//                       ),
//                       SizedBox(
//                         height: displayHeight(context) * 0.02,
//                       ),
//                       AppFloatTextField(
//                         focusNode: personalFocusViewModel
//                             .communicationAddress2FocusNode,
//                         currentState: personalFocusStates[
//                         'communicationAddress2FocusNode'],
//                         // controller: motherController,
//                         onChange: (value) {
//                           personalFormViewModel
//                               .updateCommunicationAddress2(value);
//                         },
//                         height: !personalFormState.isGenderValid
//                             ? displayHeight(context) * 0.09
//                             : null,
//                         inerHint: 'Address2',
//                         errorText: "Address2 is a required field",
//                         isError:
//                         !personalFormState.isCommunicationAddress2Valid,
//                         textInputAction: TextInputAction.done,
//                       ),
//                       SizedBox(
//                         height: displayHeight(context) * 0.02,
//                       ),
//                       AppFloatTextField(
//                         focusNode:
//                         personalFocusViewModel.communicationCityFocusNode,
//                         currentState:
//                         personalFocusStates['communicationCityFocusNode'],
//                         // controller: contactController,
//                         onChange: (value) {
//                           personalFormViewModel.updateCommunicationCity(value);
//                         },
//                         height: !personalFormState.isCommunicationCityValid
//                             ? displayHeight(context) * 0.09
//                             : null,
//                         inerHint: 'City',
//                         errorText: "City is a required field",
//                         isError: !personalFormState.isCommunicationCityValid,
//                         textInputAction: TextInputAction.done,
//                       ),
//                       SizedBox(
//                         height: displayHeight(context) * 0.02,
//                       ),
//                       AppFloatTextField(
//                         focusNode:
//                         personalFocusViewModel.communicationStateFocusNode,
//                         currentState:
//                         personalFocusStates['communicationStateFocusNode'],
//                         // controller: emailController,
//                         onChange: (value) {
//                           personalFormViewModel.updateCommunicationState(value);
//                         },
//                         height: !personalFormState.isCommunicationStateValid
//                             ? displayHeight(context) * 0.09
//                             : null,
//                         inerHint: 'State',
//                         errorText: "State is a required field",
//                         isError: !personalFormState.isCommunicationStateValid,
//                         textInputAction: TextInputAction.done,
//                       ),
//                       SizedBox(
//                         height: displayHeight(context) * 0.02,
//                       ),
//                       AppFloatTextField(
//                         focusNode: personalFocusViewModel
//                             .communicationDistrictFocusNode,
//                         currentState: personalFocusStates[
//                         'communicationDistrictFocusNode'],
//                         // controller: maritalController,
//                         onChange: (value) {
//                           personalFormViewModel
//                               .updateCommunicationDistrict(value);
//                         },
//                         height: !personalFormState.isCommunicationDistrictValid
//                             ? displayHeight(context) * 0.09
//                             : null,
//                         inerHint: 'District',
//                         errorText: "District is a required field",
//                         isError:
//                         !personalFormState.isCommunicationDistrictValid,
//                         textInputAction: TextInputAction.done,
//                       ),
//                       SizedBox(
//                         height: displayHeight(context) * 0.02,
//                       ),
//                       AppFloatTextField(
//                         focusNode: personalFocusViewModel
//                             .communicationPinCodeFocusNode,
//                         currentState: personalFocusStates[
//                         'communicationPinCodeFocusNode'],
//                         // controller: religionController,
//                         onChange: (value) {
//                           personalFormViewModel
//                               .updateCommunicationPinCode(value);
//                         },
//                         height: !personalFormState.isCommunicationPinCodeValid
//                             ? displayHeight(context) * 0.09
//                             : null,
//                         inerHint: 'PinCode',
//                         errorText: "PinCode is a required field",
//                         isError: !personalFormState.isCommunicationPinCodeValid,
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
//                       value: isRemember,
//                       onChanged: (value) {
//                         if (isRemember != true) {
//                           ref.read(guarantorRememberProvider.notifier).state = true;
//                         } else {
//                           ref.read(guarantorRememberProvider.notifier).state = false;
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
//                         personalFocusViewModel.permanentAddress1FocusNode,
//                         currentState:
//                         personalFocusStates['permanentAddress1FocusNode'],
//                         // controller: educationOfApplicantController,
//                         onChange: (value) {
//                           personalFormViewModel.updatePermanentAddress1(value);
//                         },
//                         height: !personalFormState.isPermanentAddress1Valid
//                             ? displayHeight(context) * 0.10
//                             : displayHeight(context) * 0.10,
//                         inerHint: 'Address1',
//                         errorText: "Address1 is a required field",
//                         isError: !personalFormState.isPermanentAddress1Valid,
//                         textInputAction: TextInputAction.done,
//                       ),
//                       SizedBox(
//                         height: displayHeight(context) * 0.02,
//                       ),
//                       AppFloatTextField(
//                         focusNode:
//                         personalFocusViewModel.permanentAddress2FocusNode,
//                         currentState:
//                         personalFocusStates['permanentAddress2FocusNode'],
//                         // controller: motherController,
//                         onChange: (value) {
//                           personalFormViewModel.updatePermanentAddress2(value);
//                         },
//                         height: !personalFormState.isPermanentAddress2Valid
//                             ? displayHeight(context) * 0.09
//                             : null,
//                         inerHint: 'Address2',
//                         errorText: "Address2 is a required field",
//                         isError: !personalFormState.isPermanentAddress2Valid,
//                         textInputAction: TextInputAction.done,
//                       ),
//                       SizedBox(
//                         height: displayHeight(context) * 0.02,
//                       ),
//                       AppFloatTextField(
//                         focusNode:
//                         personalFocusViewModel.permanentCityFocusNode,
//                         currentState:
//                         personalFocusStates['permanentCityFocusNode'],
//                         // controller: contactController,
//                         onChange: (value) {
//                           personalFormViewModel.updatePermanentCity(value);
//                         },
//                         height: !personalFormState.isPermanentCityValid
//                             ? displayHeight(context) * 0.09
//                             : null,
//                         inerHint: 'City',
//                         errorText: "City is a required field",
//                         isError: !personalFormState.isPermanentCityValid,
//                         textInputAction: TextInputAction.done,
//                       ),
//                       SizedBox(
//                         height: displayHeight(context) * 0.02,
//                       ),
//                       AppFloatTextField(
//                         focusNode:
//                         personalFocusViewModel.permanentStateFocusNode,
//                         currentState:
//                         personalFocusStates['permanentStateFocusNode'],
//                         // controller: emailController,
//                         onChange: (value) {
//                           personalFormViewModel.updatePermanentState(value);
//                         },
//                         height: !personalFormState.isPermanentStateValid
//                             ? displayHeight(context) * 0.09
//                             : null,
//                         inerHint: 'State',
//                         errorText: "State is a required field",
//                         isError: !personalFormState.isPermanentStateValid,
//                         textInputAction: TextInputAction.done,
//                       ),
//                       SizedBox(
//                         height: displayHeight(context) * 0.02,
//                       ),
//                       AppFloatTextField(
//                         focusNode:
//                         personalFocusViewModel.permanentDistrictFocusNode,
//                         currentState:
//                         personalFocusStates['permanentDistrictFocusNode'],
//                         // controller: maritalController,
//                         onChange: (value) {
//                           personalFormViewModel.updatePermanentDistrict(value);
//                         },
//                         height: !personalFormState.isPermanentDistrictValid
//                             ? displayHeight(context) * 0.09
//                             : null,
//                         inerHint: 'District',
//                         errorText: "District is a required field",
//                         isError: !personalFormState.isPermanentDistrictValid,
//                         textInputAction: TextInputAction.done,
//                       ),
//                       SizedBox(
//                         height: displayHeight(context) * 0.02,
//                       ),
//                       AppFloatTextField(
//                         focusNode:
//                         personalFocusViewModel.permanentPinCodeFocusNode,
//                         currentState:
//                         personalFocusStates['permanentPinCodeFocusNode'],
//                         // controller: religionController,
//                         onChange: (value) {
//                           personalFormViewModel.updatePermanentPinCode(value);
//                         },
//                         height: !personalFormState.isPermanentPinCodeValid
//                             ? displayHeight(context) * 0.09
//                             : null,
//                         inerHint: 'PinCode',
//                         errorText: "PinCode is a required field",
//                         isError: !personalFormState.isPermanentPinCodeValid,
//                         textInputAction: TextInputAction.done,
//                       ),
//                     ],
//                   ),
//                 ),
//                 Align(
//                     alignment: Alignment.centerRight,
//                     child: TextButton(
//                         onPressed: () {
//                           ref.read(uploadGuarantorDoc.notifier).state = true;
//                         },
//                         child: const Text('*Upload Applicant Document'))),
//                 Visibility(
//                   visible: upload,
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       const Text('Guarantor Document'),
//                       const Text('Upload for Kyc'),
//                       SizedBox(
//                         height: displayHeight(context) * 0.01,
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
//                         height: displayHeight(context) * 0.01,
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
//                         height: displayHeight(context) * 0.01,
//                       ),
//
//                     ],
//                   ),
//                 ),
//
//                 const SizedBox(child: Row(children: [
//                   Text('Skip'),
//                   RotatedBox(quarterTurns: 2,
//                       child: Icon(CupertinoIcons.back))
//                 ],),),
//                 AppButton(
//                   textStyle: const TextStyle(color: AppColors.white),
//                   width: displayWidth(context),
//                   label: 'Back',
//                   onTap: () {},
//                 ),
//                 SizedBox(
//                   height: displayHeight(context) * 0.01,
//                 ),
//                 AppButton(
//                   textStyle: const TextStyle(color: AppColors.white),
//                   width: displayWidth(context),
//                   label: 'Next',
//                   onTap: () {
//                     Navigator.pushNamed(context, AppRoutes.saleReferenceForm);
//                   },
//                 )
//               ],
//             ),
//           ),
//         ));
//   }
//
//   Widget aadhaarLinkRadios(
//       {required BuildContext context,
//         required GuarantorOptionRole selectedValue,
//         required WidgetRef ref,
//         required String title,
//         required GuarantorOptionRole value}) {
//     return SizedBox(
//       width: MediaQuery.of(context).size.width * 0.30,
//       child: Row(
//         children: [
//           Radio<GuarantorOptionRole>(
//             value: value,
//             groupValue: selectedValue,
//             onChanged: (value) {
//               if (value != null) {
//                 ref.read(guarantorRoleProvider.notifier).select(value);
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
//         required  formState,
//         required  formViewModel,
//         required Map<String, bool> aadhaarFocusStates,
//         required  aadhaarFocusViewModel,
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
//                     ref.read(checkBoxTermsConditionGuarantor.notifier).state =
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
// enum ApplicantOptionRole { Yes, NO, NON }
