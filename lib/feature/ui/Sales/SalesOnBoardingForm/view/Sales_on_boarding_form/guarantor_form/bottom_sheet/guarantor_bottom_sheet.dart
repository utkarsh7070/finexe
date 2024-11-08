import 'package:finexe/feature/base/routes/routes.dart';
import 'package:finexe/feature/base/utils/widget/custom_snackbar.dart';
import 'package:finexe/feature/ui/Sales/SalesOnBoardingForm/view_model/guarantor_form_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../../../base/utils/namespase/app_colors.dart';
import '../../../../../../../base/utils/namespase/app_style.dart';
import '../../../../../../../base/utils/namespase/display_size.dart';
import '../../../../../../../base/utils/widget/app_button.dart';
import '../../../../../../../base/utils/widget/app_text_filed_login.dart';
import '../../../../view_model/application_form_view_model.dart';
import '../dialog/form_completed_dialog.dart';

class GuarantorBottomSheet extends ConsumerWidget {
  const GuarantorBottomSheet({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final formListController = ref.watch(guarantorController);
    final upload = ref.watch(uploadGuarantorDoc);
    final checkBoxTerms = ref.watch(checkBoxTermsConditionGuarantor);
    final selectedValue = ref.watch(guarantorRoleProvider);

    final personalFormState = ref.watch(guarantorViewModelProvider);
    final personalFormViewModel = ref.read(guarantorViewModelProvider.notifier);
    final personalFocusStates = ref.watch(guarantorFocusProvider);
    final isRemember = ref.watch(guarantorRememberProvider);
    final personalFocusViewModel = ref.read(guarantorFocusProvider.notifier);

    final getOtpClicked = ref.watch(getOptGuarantor);

    // final selectedValue = ref.watch(applicantRoleProvider);
    return
      Container(
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
              numberOfFields: 5,
              borderRadius: const BorderRadius.all(Radius.circular(10)),
              borderColor: AppColors.buttonBorderGray,
              showFieldAsBox: true,
              onCodeChanged: (String code) {
                // applicantFormViewModel.updateOtp(code);
              },
              onSubmit: (String verificationCode) {
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
                // FormSubmitDialog().formSubmitDialog(context: context);
                // Navigator.pushNamedAndRemoveUntil(context, AppRoutes.dashBoard,(route) => false,);
                personalFormViewModel.fetchOtp().then((value) {
                  if(value){
                    Navigator.pop(context);
                    FormSubmitDialog().formSubmitDialog(context: context);
                    // Navigator.pushNamedAndRemoveUntil(context, AppRoutes.dashBoard,(route) => false,);
                    // personalFormViewModel.setAutoValueByAadhaar(formListController);
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
      );
  }
}
