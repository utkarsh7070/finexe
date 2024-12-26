import 'package:finexe/feature/base/routes/routes.dart';
import 'package:finexe/feature/ui/Sales/SalesOnBoardingForm/view/Sales_on_boarding_form/co-applicant_form/bottom_sheet/submit_co_applicant_form.dart';
import 'package:flutter/foundation.dart';
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
    final formNotifierController = ref.read(coApplicantController.notifier);
    //----------------------------------------------[
    // final indexAdd = ref.watch(listIndex.notifier);
    final coApplicationFormState = ref.watch(coApplicantViewModelProvider);
    final coApplicationFormViewModel =
        ref.read(coApplicantViewModelProvider.notifier);
    // final isSubmit = ref.watch(submitCoApplicantForm);
    // final isSubmitViewModel = ref.read(submitCoApplicantForm.notifier);
    final index = ref.watch(listIndex);

    return Container(
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
            keyboardType: TextInputType.phone,
            onCodeChanged: (String code) {
              // coApplicationFormViewModel.updateOtp(code, index);
            },
            onSubmit: (String verificationCode) {
              coApplicationFormViewModel.updateOtp(verificationCode, index);
            },
          ),
          SizedBox(
            height: displayHeight(context) * 0.04,
          ),
          coApplicationFormState[index].isLoading
              ? const CircularProgressIndicator()
              : AppButton(
                  textStyle: const TextStyle(color: AppColors.white),
                  onTap: () {
                    coApplicationFormViewModel.fetchOtp(index,context).then(
                      (value) {
                        if (value) {
                          // coApplicationFormViewModel.updateIsOtpVerified(
                          //     value, index);
                          // coApplicationFormViewModel.setAutoValueByAadhaar(
                          //     formListController, index);
                          // Navigator.pop(context);
                          // if (index < coApplicationFormState.length - 1 ==
                          //     false) {
                          //---------------------------------------------------------
                          coApplicationFormViewModel.updateIsOtpVerified(
                              value, index);
                          Navigator.pop(context);
                          showCustomSnackBar(
                              context, 'Otp is Verified', Colors.green);
                          //-----------------------------------------------------------
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

  Widget commonText(
      {required BuildContext context,
      required String heading,
      required String value}) {
    return SizedBox(
      width: displayWidth(context),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
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
