// import 'package:flutter/material.dart';
// import 'package:flutter/src/widgets/framework.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import '../../../../../../../base/routes/routes.dart';
// import '../../../../../../../base/utils/namespase/app_colors.dart';
// import '../../../../../../../base/utils/namespase/app_style.dart';
// import '../../../../../../../base/utils/namespase/display_size.dart';
// import '../../../../../../../base/utils/namespase/font_size.dart';
// import '../../../../../../../base/utils/widget/app_button.dart';
// import '../../../../view_model/application_form_view_model.dart';
// import '../../../../view_model/co_applicant_form_view_model.dart';
//
// class CoApplicationReviewForm extends ConsumerWidget {
//   const CoApplicationReviewForm({super.key});
//
//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final isSubmit = ref.watch(submitCoApplicantForm);
//     final applicantFormState = ref.watch(coApplicantViewModelProvider);
//     final applicantFormViewModel =
//         ref.read(coApplicantViewModelProvider.notifier);
//     // final checkBoxTerms = ref.watch(checkBoxTermsConditionApplicant);
//     // final selectedValue = ref.watch(applicantRoleProvider);
//     final index = ref.watch(listIndex);
//     return
//       Container(
//       padding: const EdgeInsets.all(16),
//       child: Column(
//         children: [
//           const Text('Aadhaar Details'),
//           SizedBox(
//             height: displayHeight(context) * 0.04,
//           ),
//           Expanded(
//             child: ListView.builder(
//               itemCount: applicantFormState.length,
//               itemBuilder: (context, index) {
//               return Column(children: [
//                 Text('Co-Applicant Aadhaar Details',style: AppStyles.headingTextStyle,),
//                 SizedBox(height: displayHeight(context)*0.01,),
//                 commonText(
//                     context: context,
//                     heading: 'Name',
//                     value: applicantFormState[index].fullName),
//                 commonText(
//                     context: context,
//                     heading: 'Care Of',
//                     value: applicantFormState[index].careOf),
//                 commonText(
//                     context: context,
//                     heading: 'Date Of Birth',
//                     value: applicantFormState[index].dob),
//                 commonText(
//                     context: context,
//                     heading: 'Gender',
//                     value: applicantFormState[index].gender),
//                 commonText(
//                     context: context,
//                     heading: 'Age',
//                     value: applicantFormState[index].age),
//                 commonText(
//                     context: context,
//                     heading: 'Address',
//                     value:
//                     '${applicantFormState[index].communicationAddress1} ${applicantFormState[index].communicationAddress2} ${applicantFormState[index].communicationCity} ${applicantFormState[index].communicationDistrict} ${applicantFormState[index].communicationPinCode}'),
//               ],);
//             },),
//           ),
//
//           Visibility(
//             visible: !isSubmit,
//             replacement:  AppButton(
//               isFill: true,
//               bgColor: AppColors.primaryLight,
//               borderColor: AppColors.primary,
//               onTap: () {
//                 Navigator.pushNamed(
//                     context, AppRoutes.saleGuarantorForm1);
//                 // applicantFormViewModel.fetchAadhaarWithPhoto(index);
//                 // applicantFormViewModel.submitCoApplicantForm(index);
//               },
//               label: 'Next',
//               textStyle: AppStyles.smallTextStyleRich.copyWith(
//                   color: AppColors.white,
//                   fontSize: FontSize.fontSize16,
//                   fontWeight: FontWeight.w500),
//               width: displayWidth(context),
//               height: displayHeight(context) * 0.06,
//             ),
//             child:
//             AppButton(
//               isFill: true,
//               bgColor: AppColors.primaryLight,
//               borderColor: AppColors.primary,
//               onTap: () {
//                 // applicantFormViewModel.fetchAadhaarWithPhoto(index);
//                 applicantFormViewModel.submitCoApplicantForm(index).then((value) {
//                   if(value){
//                     Navigator.pushNamed(
//                         context, AppRoutes.saleGuarantorForm1);
//                     // Navigator.pushNamed(context, routeName)
//                   }
//
//                 },);
//               },
//               label: 'Submit',
//               textStyle: AppStyles.smallTextStyleRich.copyWith(
//                   color: AppColors.white,
//                   fontSize: FontSize.fontSize16,
//                   fontWeight: FontWeight.w500),
//               width: displayWidth(context),
//               height: displayHeight(context) * 0.06,
//             ),
//           )
//         ],
//       ),
//     );
//   }
//
//   Widget commonText(
//       {required BuildContext context,
//         required String heading,
//         required String value}) {
//     return SizedBox(
//       width: displayWidth(context),
//       child: Row(
//         children: [
//           SizedBox(width: displayWidth(context) * 0.30, child: Text(heading)),
//           SizedBox(
//               width: displayWidth(context) * 0.50,
//               child: Text(
//                 value,
//                 maxLines: 4,
//               ))
//         ],
//       ),
//     );
//   }
// }
