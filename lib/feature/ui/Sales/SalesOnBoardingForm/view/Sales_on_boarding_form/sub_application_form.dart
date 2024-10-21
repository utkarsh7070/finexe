// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/src/widgets/framework.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
//
// import '../../../../../base/utils/namespase/app_colors.dart';
// import '../../../../../base/utils/namespase/display_size.dart';
// import '../../../../../base/utils/widget/app_text_filed_login.dart';
// import '../../view_model/application_form_view_model.dart';
//
// class SubApplicationDetails extends ConsumerWidget{
//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final personalFormState = ref.watch(applicantViewModelProvider);
//     final personalFormViewModel = ref.read(applicantViewModelProvider.notifier);
//     final personalFocusStates = ref.watch(applicantFocusProvider);
//     final personalFocusViewModel = ref.read(applicantFocusProvider.notifier);
//     return Scaffold(
//       appBar: AppBar(),
//       body: Column(children: [
//         const Text('Personal Detail’s'),
//         SizedBox(
//           height: displayHeight(context) * 0.05,
//         ),
//         Container(
//           padding: const EdgeInsets.all(16),
//           decoration: BoxDecoration(
//             border: Border.all(color: AppColors.boxBorderGray),
//             borderRadius: const BorderRadius.all(Radius.circular(10)),
//           ),
//           child:
//           Column(
//             children: [
//               SizedBox(
//                 height: displayHeight(context) * 0.02,
//               ),
//               SizedBox(
//                 height: displayHeight(context) * 0.02,
//               ),
//
//               AppFloatTextField(
//                 focusNode: personalFocusViewModel.fullNameFocusNode,
//                 currentState: personalFocusStates['fullNameFocusNode'],
//                 // controller: contactController,
//                 onChange: (value) {
//                   personalFormViewModel.updateFullName(value);
//                 },
//                 height: !personalFormState.isFullNameValid
//                     ? displayHeight(context) * 0.09
//                     : null,
//                 inerHint: 'Full Name',
//                 errorText: "Full Name is a required field",
//                 isError: !personalFormState.isFullNameValid,
//                 textInputAction: TextInputAction.done,
//               ),
//               SizedBox(
//                 height: displayHeight(context) * 0.02,
//               ),
//               AppFloatTextField(
//                 focusNode: personalFocusViewModel.fatherNameFocusNode,
//                 currentState:
//                 personalFocusStates['fatherNameFocusNode'],
//                 // controller: emailController,
//                 onChange: (value) {
//                   personalFormViewModel.updateEmail(value);
//                 },
//                 height: !personalFormState.isFatherNameValid
//                     ? displayHeight(context) * 0.09
//                     : null,
//                 inerHint: 'Father Name',
//                 errorText: "Father Name is a required field",
//                 isError: !personalFormState.isFatherNameValid,
//                 textInputAction: TextInputAction.done,
//               ),
//               SizedBox(
//                 height: displayHeight(context) * 0.02,
//               ),
//               AppFloatTextField(
//                 focusNode: personalFocusViewModel.dobFocusNode,
//                 currentState: personalFocusStates['dobFocusNode'],
//                 // controller: maritalController,
//                 onChange: (value) {
//                   personalFormViewModel.updateDob(value);
//                 },
//                 height: !personalFormState.isDobValid
//                     ? displayHeight(context) * 0.09
//                     : null,
//                 inerHint: 'DOB',
//                 errorText: "DOB is a required field",
//                 isError: !personalFormState.isDobValid,
//                 textInputAction: TextInputAction.done,
//               ),
//               SizedBox(
//                 height: displayHeight(context) * 0.02,
//               ),
//               AppFloatTextField(
//                 focusNode: personalFocusViewModel.ageFocusNode,
//                 currentState: personalFocusStates['ageFocusNode'],
//                 // controller: religionController,
//                 onChange: (value) {
//                   personalFormViewModel.updateAge(value);
//                 },
//                 height: !personalFormState.isAgeValid
//                     ? displayHeight(context) * 0.09
//                     : null,
//                 inerHint: 'Age',
//                 errorText: "Age is a required field",
//                 isError: !personalFormState.isAgeValid,
//                 textInputAction: TextInputAction.done,
//               ),
//               SizedBox(
//                 height: displayHeight(context) * 0.02,
//               ),
//               AppFloatTextField(
//                 focusNode: personalFocusViewModel.genderFocusNode,
//                 currentState: personalFocusStates['genderFocusNode'],
//                 // controller: motherController,
//                 onChange: (value) {
//                   personalFormViewModel.updateGender(value);
//                 },
//                 height: !personalFormState.isGenderValid
//                     ? displayHeight(context) * 0.09
//                     : null,
//                 inerHint: 'Gender',
//                 errorText: "Gender is a required field",
//                 isError: !personalFormState.isGenderValid,
//                 textInputAction: TextInputAction.done,
//               ),
//               SizedBox(
//                 height: displayHeight(context) * 0.02,
//               ),
//               AppFloatTextField(
//                 focusNode: personalFocusViewModel.emailFocusNode,
//                 currentState: personalFocusStates['emailFocusNode'],
//                 // controller: emailController,
//                 onChange: (value) {
//                   personalFormViewModel.updateEmail(value);
//                 },
//                 height: !personalFormState.isEmailValid
//                     ? displayHeight(context) * 0.09
//                     : null,
//                 inerHint: 'Email ID',
//                 errorText: "Email ID is a required field",
//                 isError: !personalFormState.isEmailValid,
//                 textInputAction: TextInputAction.done,
//               ),
//             ],
//           ),
//         ),
//       ],),
//     );
//   }
//
// }