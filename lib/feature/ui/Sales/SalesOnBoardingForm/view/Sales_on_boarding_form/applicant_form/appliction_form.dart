import 'dart:io';
import 'package:finexe/feature/base/internetConnection/networklistener.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../../../base/utils/namespase/app_colors.dart';
import '../../../../../../base/utils/namespase/app_style.dart';
import '../../../../../../base/utils/namespase/display_size.dart';
import '../../../../../../base/utils/namespase/font_size.dart';
import '../../../../../../base/utils/widget/app_button.dart';
import '../../../../../../base/utils/widget/app_text_filed_login.dart';
import '../../../../../../base/utils/widget/upload_box.dart';
import '../../../view_model/application_form_view_model.dart';
import 'bottom_sheet/applicant_if_no_bottom_sheet.dart';
import 'dialog/back_application_dialog.dart';

class ApplicationDetails extends ConsumerWidget {
  final Map<String, dynamic> arguments;

  const ApplicationDetails(this.arguments, {super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    //----------------------------controllers-------------------------
    // final formListController = ref.watch(applicantController);
    // final formNotifierController = ref.read(applicantController.notifier);
    //-----------------------------------------------------
    // final selectedValue = ref.watch(applicantRoleProvider);
    // // final checkBoxTerms = ref.watch(checkBoxTermsConditionApplicant);
    // final isPanIconChange = ref.watch(isPanLoading);
    // final colorChangeState = ref.watch(isTickColorChange);
    final personalFormState = ref.watch(applicantViewModelProvider);
    final personalFormViewModel = ref.read(applicantViewModelProvider.notifier);
    final personalFocusStates = ref.watch(applicantFocusProvider);
    final personalFocusViewModel = ref.read(applicantFocusProvider.notifier);
    final phoneNumber = arguments['phoneNumber'];
    print('Phone Number: $phoneNumber');
    //
    // Access specific argument
    return NetworkListener(
      context: context,
      child: Scaffold(
          body: Container(
        width: displayWidth(context),
        height: displayHeight(context),
        color: AppColors.primary,
        padding: const EdgeInsets.only(top: 80),
        child: Container(
          height: displayHeight(context),
          padding: const EdgeInsets.all(20),
          decoration: const BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30), topRight: Radius.circular(30))),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                      onPressed: () {
                        ConfirmBackDialog().confirmBackToForm(context: context);
                      },
                      icon: const Icon(Icons.arrow_back)),
                  const Text(
                    textAlign: TextAlign.center,
                    'Applicant Details',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(
                    width: displayWidth(context) * 0.10,
                  )
                ],
              ),
              SizedBox(
                height: displayHeight(context) * 0.01,
              ),
              Expanded(
                child: SingleChildScrollView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  child: Wrap(
                    crossAxisAlignment: WrapCrossAlignment.center,
                    verticalDirection: VerticalDirection.down,
                    runSpacing: displayHeight(context) * 0.04,
                    clipBehavior: Clip.none,
                    children: [
                      GestureDetector(
                        onTap: () async {
                          await personalFormViewModel.pickImages();
                        },
                        child: Visibility(
                          visible: personalFormState.applicantPhotoFilePath == '',
                          replacement: SizedBox(
                            height: displayHeight(context) * 0.16,
                            width: displayWidth(context),
                            child: Image.file(
                                File(personalFormState.applicantPhotoFilePath)),
                          ),
                          child: UploadBox(
                            isError: !personalFormState.isApplicantPhoto,
                            isImage: true,
                            height: displayHeight(context) * 0.16,
                            width: displayWidth(context),
                            color: AppColors.buttonBorderGray,
                            iconData: Icons.file_upload_outlined,
                            textColor: AppColors.gray5,
                            subTextColor: AppColors.primary,
                            title: 'Support: JPG, PNG',
                            subTitle: 'Click Applicant Image',
                          ),
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Customer Mobile No. Is Must Be Linked With Aadhaar.',
                            maxLines: 2,
                          ),
                          SizedBox(
                            height: displayHeight(context) * 0.02,
                          ),
                          Column(
                            children: [
                              AppFloatTextField(
                                focusNode:
                                    personalFocusViewModel.aadhaarFocusNode,
                                currentState:
                                    personalFocusStates['aadhaarFocusNode'],
                                onChange: (value) {
                                  personalFormViewModel.updateAadhaar(value);
                                },
                                height: !personalFormState.isAadhaarValid
                                    ? displayHeight(context) * 0.09
                                    : null,
                                inerHint: 'Enter Aadhaar Number',
                                errorText: "Aadhaar Number is a required field",
                                isError: !personalFormState.isAadhaarValid,
                                textInputType: TextInputType.number,
                                textInputAction: TextInputAction.done,
                              ),
                              SizedBox(
                                height: displayHeight(context) * 0.02,
                              ),
                              AppFloatTextField(
                                focusNode: personalFocusViewModel.panFocusNode,
                                currentState: personalFocusStates['panFocusNode'],
                                onChange: (value) {
                                  personalFormViewModel.updatePan(value);
                                },
                                height: !personalFormState.isPanValid
                                    ? displayHeight(context) * 0.09
                                    : null,
                                inerHint: 'Enter Pan No',
                                errorText: "Id is a required field",
                                isError: !personalFormState.isPanValid,
                                textCapitalize: TextCapitalization.characters,
                                textInputType: TextInputType.text,
                                textInputAction: TextInputAction.next,
                              ),
                              Row(
                                children: [
                                  Checkbox(
                                    side: const BorderSide(
                                        color: AppColors.boxBorderGray,
                                        width: 1.5),
                                    // semanticLabel: 'jkdhsjk',
                                    value: personalFormState
                                        .checkBoxTermsConditionApplicant,
                                    onChanged: (value) {
                                      if (value != null) {
                                        personalFormViewModel
                                            .updateCheckBox(value);
                                      }
                                    },
                                  ),
                                  SizedBox(
                                    height: displayHeight(context) * 0.02,
                                  ),
                                  SizedBox(
                                      width: displayWidth(context) * 0.68,
                                      child: Text(
                                        'I have read the Terms and Conditions and give my consent for the same.',
                                        style: AppStyles.termsConditionText,
                                      )),
                                ],
                              ),
                              SizedBox(
                                height: displayHeight(context) * 0.02,
                              ),
                              personalFormState.isLoading
                                  ? const CircularProgressIndicator()
                                  : AppButton(
                                      textStyle:
                                          const TextStyle(color: AppColors.white),
                                      onTap: () async {
                                        personalFormViewModel.onClickGetOtpButton(
                                            context: context,
                                            phoneNumber: phoneNumber);
                                      },
                                      label: 'Get OTP',
                                      width: displayWidth(context),
                                    ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      )),
    );
  }

  // Widget aadhaarLinkRadios(
  //     {required BuildContext context,
  //     required ApplicantOptionRole selectedValue,
  //     required WidgetRef ref,
  //     required String title,
  //     required ApplicantOptionRole value,
  //     required AadhaarFormState formState,
  //     required FormViewModel formViewModel,
  //     required Map<String, bool> aadhaarFocusStates,
  //     required AadhaarFocusViewModel aadhaarFocusViewModel,
  //     required bool checkBoxTerms}) {
  //   return SizedBox(
  //     width: MediaQuery.of(context).size.width * 0.30,
  //     child: Row(
  //       children: [
  //         Radio<ApplicantOptionRole>(
  //           value: value,
  //           groupValue: selectedValue,
  //           onChanged: (value) {
  //             if (value != null) {
  //               ref.read(applicantRoleProvider.notifier).select(value);
  //             }
  //           },
  //         ),
  //         Text(
  //           title,
  //         )
  //       ],
  //     ),
  //   );
  // }

  // Widget ifYesLinkedAadhaar(
  //     {required WidgetRef ref,
  //     required BuildContext context,
  //     required AadhaarFormState formState,
  //     required FormViewModel formViewModel,
  //     required Map<String, bool> aadhaarFocusStates,
  //     required AadhaarFocusViewModel aadhaarFocusViewModel,
  //     required bool checkBoxTerms}) {
  //   return Container(
  //     padding: const EdgeInsets.only(left: 16, right: 16, top: 30, bottom: 16),
  //     decoration: BoxDecoration(
  //       border: Border.all(color: AppColors.boxBorderGray),
  //       borderRadius: const BorderRadius.all(Radius.circular(10)),
  //     ),
  //     width: displayWidth(context),
  //     child: Column(
  //       children: [
  //         // const Text('Aadhar Number'),
  //         AppFloatTextField(
  //           focusNode: aadhaarFocusViewModel.aadhaarFocusNode,
  //           currentState: aadhaarFocusStates['aadhaarFocusNode'],
  //           // controller: aadhaarController,
  //           onChange: (value) {
  //             formViewModel.updateAadhaar(value);
  //           },
  //           height: !formState.isAadhaarValid
  //               ? displayHeight(context) * 0.09
  //               : null,
  //           inerHint: 'Enter Aadhaar Number',
  //           errorText: "Aadhaar Number is a required field",
  //           isError: !formState.isAadhaarValid,
  //           textInputAction: TextInputAction.next,
  //           // hint: 'Password',
  //         ),
  //         Row(
  //           children: [
  //             Checkbox(
  //               side: const BorderSide(
  //                   color: AppColors.boxBorderGray, width: 1.5),
  //               // semanticLabel: 'jkdhsjk',
  //               value: checkBoxTerms,
  //               onChanged: (value) {
  //                 if (value != null) {
  //                   ref.read(checkBoxTermsConditionApplicant.notifier).state =
  //                       value;
  //                 }
  //               },
  //             ),
  //             SizedBox(
  //                 width: displayWidth(context) * 0.68,
  //                 child: Text(
  //                   'I have read the Terms and Conditions and give my consent for the same.',
  //                   style: AppStyles.termsConditionText,
  //                 )),
  //           ],
  //         ),
  //         Align(
  //           alignment: Alignment.centerRight,
  //           child: TextButton(
  //               onPressed: () {
  //                 ref.read(getOpt.notifier).state = true;
  //               },
  //               child: const Text('Get OTP')),
  //         )
  //       ],
  //     ),
  //   );
  // }

  Widget ifNoLinkedAadhaar(BuildContext context) {
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
          borderColor: AppColors.primary,
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

  // Future<void> showBottomSheetIfYes({
  //   required WidgetRef ref,
  //   required BuildContext context,
  // }) {
  //   return showModalBottomSheet(
  //     isScrollControlled: true,
  //     context: context,
  //     shape: const RoundedRectangleBorder(
  //       borderRadius: BorderRadius.only(
  //           topLeft: Radius.circular(10.0), topRight: Radius.circular(10.0)),
  //     ),
  //     builder: (ctx) {
  //       return const ApplicationBottomSheet();
  //     },
  //   );
  // }

  Future<void> showBottomSheetIfNo({
    required WidgetRef ref,
    required BuildContext context,
  }) {
    return showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(10.0), topRight: Radius.circular(10.0)),
      ),
      builder: (ctx) {
        return const ApplicationPhotoBottomSheet();
      },
    );
  }
}

enum ApplicantOptionRole { Yes, NO, NON }
