import 'package:finexe/feature/base/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../../../../base/utils/namespase/app_colors.dart';
import '../../../../../../../base/utils/namespase/app_style.dart';
import '../../../../../../../base/utils/namespase/display_size.dart';
import '../../../../../../../base/utils/namespase/font_size.dart';
import '../../../../../../../base/utils/widget/app_button.dart';
import '../../../../../../../base/utils/widget/custom_snackbar.dart';
import '../../../../view_model/application_form_view_model.dart';
import '../dialog/back_application_dialog.dart';

class ApplicationVerify extends ConsumerWidget {
  const ApplicationVerify({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // final formListController = ref.watch(applicantController);
    // final getOtpClicked = ref.watch(getOpt);
    final personalFormState = ref.watch(applicantViewModelProvider);
    final personalFormViewModel = ref.read(applicantViewModelProvider.notifier);
    // final checkBoxTerms = ref.watch(checkBoxTermsConditionApplicant);
    // final personalFocusStates = ref.watch(applicantFocusProvider);
    // final personalFocusViewModel = ref.read(applicantFocusProvider.notifier);
    // final selectedValue = ref.watch(applicantRoleProvider);
    return Scaffold(
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
          child: Visibility(
            visible: !personalFormState.isOtpVerify,
            replacement: Column(
              children: [
                Text(
                  'Aadhaar Details',
                  style: AppStyles.headingTextStyleXL2
                      .copyWith(color: AppColors.black),
                ),
                SizedBox(
                  height: displayHeight(context) * 0.04,
                ),

                Text(
                  'Applicant Aadhaar Details',
                  style: AppStyles.headingTextStyleXL2.copyWith(
                      color: AppColors.black,
                      fontSize: FontSize.fontSize16),
                ),
                SizedBox(
                  height: displayHeight(context) * 0.01,
                ),
                commonText(
                    context: context,
                    heading: 'Name',
                    value: personalFormState.fullName),
                commonText(
                    context: context,
                    heading: 'Care Of',
                    value: personalFormState.fatherName),
                commonText(
                    context: context,
                    heading: 'Date Of Birth',
                    value: personalFormState.dob),
                commonText(
                    context: context,
                    heading: 'Gender',
                    value: personalFormState.gender),
                commonText(
                    context: context,
                    heading: 'Age',
                    value: personalFormState.age),
                commonText(
                    context: context,
                    heading: 'Address',
                    value:
                        '${personalFormState.communicationAddress1} ${personalFormState.communicationAddress2} ${personalFormState.communicationCity} ${personalFormState.communicationDistrict} ${personalFormState.communicationPinCode}'),
                SizedBox(
                  height: displayHeight(context) * 0.01,
                ),
                Text(
                  'Applicant Pan Details',
                  style: AppStyles.headingTextStyleXL2.copyWith(
                      color: AppColors.black,
                      fontSize: FontSize.fontSize16),
                ),
                SizedBox(
                  height: displayHeight(context) * 0.01,
                ),
                commonText(
                    context: context,
                    heading: 'Name',
                    value: personalFormState.panName),
                commonText(
                    context: context,
                    heading: 'Father Name',
                    value: personalFormState.panFather),
                commonText(
                    context: context,
                    heading: 'Date Of Birth',
                    value: personalFormState.panDob),
                commonText(
                    context: context,
                    heading: 'Gender',
                    value: personalFormState.panGender),
                SizedBox(height: displayHeight(context)*0.05,),
                Visibility(
                  replacement: AppButton(
                    width: displayHeight(context),
                    label: 'Next',
                    textStyle: AppStyles.buttonLightTextStyle,
                    onTap: () {
                      Navigator.pushNamed(
                          context, AppRoutes.saleCoApplicationForm1);
                    },
                  ),
                  visible: !personalFormState.isApplicantFormSubmitted,
                  child: AppButton(
                    width: displayHeight(context),
                    textStyle: AppStyles.buttonLightTextStyle,
                    label: 'Submit',
                    onTap: () {
                      personalFormViewModel.submittedApplicantForm().then(
                        (value) {
                          if (value) {
                            showCustomSnackBar(context,
                                'Applicant form is Submitted', Colors.green);
                            personalFormViewModel
                                .updateApplicantFormSubmitted(value);
                            Navigator.pushNamed(
                                context, AppRoutes.saleCoApplicationForm1);
                          }
                        },
                      );
                    },
                  ),
                )
              ],
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                        onPressed: () {
                          ConfirmBackDialog()
                              .confirmBackToForm(context: context);
                        },
                        icon: Icon(Icons.arrow_back)),
                    Text(
                      'Enter OTP',
                      style: AppStyles.headingTextStyleXL,
                    ),
                    SizedBox(
                      width: displayWidth(context) * 0.10,
                    )
                  ],
                ),
                SizedBox(
                  height: displayHeight(context) * 0.02,
                ),
                const Flexible(
                    child: Text(
                  'We have just sent you 6 digit code Phone Number',
                  textAlign: TextAlign.center,
                )),
                SizedBox(
                  height: displayHeight(context) * 0.04,
                ),
                OtpTextField(
                  numberOfFields: 6,
                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                  borderColor: AppColors.buttonBorderGray,
                  showFieldAsBox: true,
                  onCodeChanged: (String code) {
                    print(code);
                  },
                  onSubmit: (String verificationCode) {
                    personalFormViewModel.otpUpdate(verificationCode);
                  },
                ),
                SizedBox(
                  height: displayHeight(context) * 0.04,
                ),
                AppButton(
                  textStyle: const TextStyle(color: AppColors.white),
                  onTap: () {
                    // Navigator.pushNamed(context, AppRoutes.saleCoApplicationForm1);
                    personalFormViewModel.submitOtp().then(
                      (value) {
                        if (value) {
                          showCustomSnackBar(
                              context, 'Otp is verified', Colors.green);
                          personalFormViewModel.verifyOtp(value);
                          // personalFormViewModel
                          //     .setAutoValueByAadhaar(formListController);
                          // Navigator.pop(context);
                          // Navigator.pushNamed(
                          //     context, AppRoutes.saleCoApplicationForm1);
                        }
                      },
                    );
                  },
                  label: 'Continue',
                  width: displayWidth(context),
                ),
                SizedBox(
                  height: displayHeight(context) * 0.01,
                ),
                RichText(
                  text: TextSpan(
                    text: 'Didn’t receive code? ',
                    style: AppStyles.buttonLightTextStyle.copyWith(
                        fontWeight: FontWeight.w500, color: AppColors.grayDark),
                    children: <TextSpan>[
                      TextSpan(
                          text: ' Resend Code',
                          style: AppStyles.cardTextStyle16
                              .copyWith(color: AppColors.primary)),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget commonText(
      {required BuildContext context,
      required String heading,
      required String value}) {
    return SizedBox(
      width: displayWidth(context),
      child: Row(
        children: [
          SizedBox(width: displayWidth(context) * 0.30, child: Text(heading)),
          SizedBox(
              width: displayWidth(context) * 0.50,
              child: Text(
                value,
                maxLines: 4,
              ))
        ],
      ),
    );
  }
}
