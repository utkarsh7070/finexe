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
import '../../../../../../../base/utils/widget/app_text_filed_login.dart';
import '../../../../../../../base/utils/widget/custom_snackbar.dart';
import '../../../../view_model/application_form_view_model.dart';
import '../../../../view_model/co_applicant_form_view_model.dart';

class CoApplicationBottomSheet extends ConsumerWidget {
  const CoApplicationBottomSheet({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    //---------------------controller--------------------
    final formListController = ref.watch(coApplicantController);
    // final formNotifierController = ref.read(coApplicantController.notifier);
    //----------------------------------------------[
    // final checkBoxTerms = ref.watch(checkBoxTermsConditionCoApplicant);
    // final getOtpClicked = ref.watch(getOptCoApp);
    final coApplicationFormState = ref.watch(coApplicantViewModelProvider);
    final coApplicationFormViewModel =
        ref.read(coApplicantViewModelProvider.notifier);
    // final coApplicationFocusStates = ref.watch(coApplicantFocusProvider);
    // final isCoApplicationRemember = ref.watch(rememberCoProvider);
    // final coApplicationFocusViewModel =
    //     ref.read(coApplicantFocusProvider.notifier);
    final index = ref.watch(listIndex);
    return  Container(
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
              // coApplicationFormViewModel.updateOtp(code, index);
            },
            onSubmit: (String verificationCode) {
              coApplicationFormViewModel.updateOtp(verificationCode, index);
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
              if(index < coApplicationFormState.length - 1 == false){
                Navigator.pop(context);
                Navigator.pushNamed(context, AppRoutes.saleGuarantorForm1);
              }
              coApplicationFormViewModel.fetchOtp(index).then(
                    (value) {
                  if (value) {
                    coApplicationFormViewModel.setAutoValueByAadhaar(
                        formListController, index);
                    Navigator.pop(context);
                    if(index < coApplicationFormState.length - 1 == false){
                      Navigator.pop(context);
                      showCustomSnackBar(context,
                          'Co-Applicant form is Submitted', Colors.green);
                      Navigator.pushNamed(context, AppRoutes.saleGuarantorForm1);
                    }
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
    );
  }
}
