import 'package:finexe/feature/base/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../../../../base/utils/namespase/app_colors.dart';
import '../../../../../../../base/utils/namespase/app_style.dart';
import '../../../../../../../base/utils/namespase/display_size.dart';
import '../../../../../../../base/utils/widget/app_button.dart';
import '../../../../view_model/application_form_view_model.dart';

class ApplicationBottomSheet extends ConsumerWidget {
  const ApplicationBottomSheet({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final formListController = ref.watch(applicantController);
    final getOtpClicked = ref.watch(getOpt);
    final personalFormState = ref.watch(applicantViewModelProvider);
    final personalFormViewModel = ref.read(applicantViewModelProvider.notifier);
    final checkBoxTerms = ref.watch(checkBoxTermsConditionApplicant);
    final personalFocusStates = ref.watch(applicantFocusProvider);
    final personalFocusViewModel = ref.read(applicantFocusProvider.notifier);
    // final selectedValue = ref.watch(applicantRoleProvider);
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
              Navigator.pushNamed(context, AppRoutes.saleCoApplicationForm1);
              ref
                  .read(applicantViewModelProvider.notifier)
                  .submitOtp()
                  .then(
                    (value) {
                  if (value) {
                    personalFormViewModel.verifyOtp(value);
                    personalFormViewModel
                        .setAutoValueByAadhaar(formListController);
                    Navigator.pop(context);
                    Navigator.pushNamed(context, AppRoutes.saleCoApplicationForm1);
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
