import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../../../base/utils/namespase/app_colors.dart';
import '../../../../../../../base/utils/namespase/app_style.dart';
import '../../../../../../../base/utils/namespase/display_size.dart';
import '../../../../../../../base/utils/namespase/font_size.dart';
import '../../../../../../../base/utils/widget/app_button.dart';
import '../../../../../../../base/utils/widget/app_text_filed_login.dart';
import '../../../../view_model/application_form_view_model.dart';

class ApplicationBottomSheet extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final getOtpClicked = ref.watch(getOpt);
    final personalFormState = ref.watch(applicantViewModelProvider);
    final personalFormViewModel = ref.read(applicantViewModelProvider.notifier);
    final checkBoxTerms = ref.watch(checkBoxTermsConditionApplicant);
    final personalFocusStates = ref.watch(applicantFocusProvider);
    final personalFocusViewModel = ref.read(applicantFocusProvider.notifier);
    // final selectedValue = ref.watch(applicantRoleProvider);
    return Stack(
      children: [
        Visibility(
          replacement: Container(
            padding: const EdgeInsets.only(top: 50, left: 16, right: 16),
            width: displayWidth(context),
            child: Column(
              children: [
                Text(
                  'Enter OTP',
                  style: AppStyles.headingTextStyleXL,
                ),
                SizedBox(
                  height: displayHeight(context) * 0.02,
                ),
                const Flexible(
                    child: Text(
                  'We have just sent you 6 digit code Phone Number +7489455607',
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
                    showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: const Text("Verification Code"),
                            content: Text('Code entered is $verificationCode'),
                          );
                        });
                  },
                ),
                SizedBox(
                  height: displayHeight(context) * 0.04,
                ),
                AppButton(
                  textStyle: const TextStyle(color: AppColors.white),
                  onTap: () {
                    ref.read(applicantViewModelProvider.notifier).fetchOtp().then((value) {
                      if(value){
                        Navigator.pop(context);
                      }
                    },);
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
          visible: getOtpClicked == false,
          child: Container(
            padding: const EdgeInsets.only(top: 50, left: 16, right: 16),
            width: displayWidth(context),
            child: Column(
              children: [
                AppFloatTextField(
                  focusNode: personalFocusViewModel.aadhaarFocusNode,
                  currentState: personalFocusStates['aadhaarFocusNode'],
                  onChange: (value) {
                    personalFormViewModel.updateAadhaar(value);
                  },
                  height: !personalFormState.isAadhaarValid
                      ? displayHeight(context) * 0.09
                      : null,
                  inerHint: 'Enter Aadhaar Number',
                  errorText: "Aadhaar Number is a required field",
                  isError: !personalFormState.isAadhaarValid,
                  textInputAction: TextInputAction.done,
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
                          ref
                              .read(checkBoxTermsConditionApplicant.notifier)
                              .state = value;
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
                AppButton(
                  textStyle: const TextStyle(color: AppColors.white),
                  onTap: () async {
                    ref.read(applicantViewModelProvider.notifier).fetchAadhaarNumber().then((value) {
                      ref.read(getOpt.notifier).state = value;
                    },);
                  },
                  label: 'Get OTP',
                  width: displayWidth(context),
                ),
              ],
            ),
          ),
        ),

        // Positioned(
        //   top: -3,
        //   child: Container(
        //     child: const Icon(Icons.cancel),
        //   ),
        // )
      ],
    );
  }
}
