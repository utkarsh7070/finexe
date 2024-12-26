import 'package:finexe/feature/ui/Sales/SalesOnBoardingForm/view_model/guarantor_form_view_model.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../../../../base/utils/namespase/app_colors.dart';
import '../../../../../../../base/utils/namespase/app_style.dart';
import '../../../../../../../base/utils/namespase/display_size.dart';
import '../../../../../../../base/utils/namespase/font_size.dart';
import '../../../../../../../base/utils/widget/app_button.dart';
import '../../../../../../../base/utils/widget/custom_snackbar.dart';
import '../../../../../NewLone/view_model/new_loan_view_model.dart';
import '../dialog/form_completed_dialog.dart';

class GuarantorBottomSheet extends ConsumerWidget {
  const GuarantorBottomSheet({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final getMobileNo = ref.watch(personalDetailViewModelProvider);
    final paymentViewModel = ref.read(paymentProvider(context).notifier);
    final personalFormState = ref.watch(guarantorViewModelProvider);
    final personalFormViewModel = ref.read(guarantorViewModelProvider.notifier);

    return Visibility(
      visible: !personalFormState.isOtpVerify,
      replacement: Container(
        width: displayWidth(context),
        height: displayHeight(context),
        color: AppColors.primary,
        padding: const EdgeInsets.only(top: 80),
        // padding: EdgeInsets.only(top: displayHeight(context)*0.10,left: 16,right: 16),
        child: Container(
          height: displayHeight(context),
          padding: const EdgeInsets.all(20),
          decoration: const BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30), topRight: Radius.circular(30))),
          child: Column(
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
                'Guarantor Aadhaar Details',
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
                'Guarantor Pan Details',
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
              SizedBox(height: displayHeight(context)*0.04,),
              Visibility(
                replacement: AppButton(
                  width: displayHeight(context),
                  label: 'Payment',
                  textStyle: AppStyles.buttonLightTextStyle,
                  onTap: () {
                    personalFormViewModel.paymentInitiate().then(
                          (value) {
                        Navigator.pop(context);
                        if (kDebugMode) {
                          print(getMobileNo.phoneNumber);
                        }
                        if (value.items.customerDetail.loginFees != 0) {
                          paymentViewModel.payWithRazorPay(
                              amount: value.items.customerDetail.loginFees,
                              mobile: getMobileNo.phoneNumber,
                              orderId: value.items.customerDetail.orderId);
                          // FormSubmitDialog().formSubmitDialog(context: context);
                        } else {
                          FormSubmitDialog().formSubmitDialog(context: context);
                        }
                      },
                    );
                    // Navigator.pushNamed(
                    //     context, AppRoutes.saleCoApplicationForm1);
                  },
                ),
                visible: !personalFormState.isApplicantFormSubmitted,
                child: Visibility(
                  visible: !personalFormState.isLoading,
                  replacement: const Center(child: CircularProgressIndicator()),
                  child: AppButton(
                    width: displayWidth(context),
                    textStyle: AppStyles.buttonLightTextStyle,
                    label: 'Submit',
                    onTap: () {
                      personalFormViewModel.submitGuarantorForm().then(
                            (value) {
                          if (value) {
                            showCustomSnackBar(context,
                                'Applicant form is Submitted', Colors.green);
                            personalFormViewModel
                                .updateApplicantFormSubmitted(value);
                            // Navigator.pushNamed(
                            //     context, AppRoutes.saleCoApplicationForm1);
                          }
                        },
                      );
                    },
                  ),
                ),
              )
            ],
          ),
        ),
      ),
      child: Container(
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
              keyboardType:TextInputType.phone,
              onCodeChanged: (String code) {
                //
              },
              onSubmit: (String verificationCode) {
                personalFormViewModel.updateOtp(verificationCode);
              },
            ),
            SizedBox(
              height: displayHeight(context) * 0.04,
            ),
            Visibility(
              visible: !personalFormState.isLoading,
              replacement: const Center(child: CircularProgressIndicator()),
              child: AppButton(
                textStyle: const TextStyle(color: AppColors.white),
                onTap: () {
                  personalFormViewModel.fetchOtp().then(
                    (value) {
                      if (value) {
                        personalFormViewModel.verifyOtp(value);
                        //--------------------payment -----------------------

                        // --------------------------------------------------------------
                        // Navigator.pushNamedAndRemoveUntil(context, AppRoutes.dashBoard,(route) => false,);
                        // personalFormViewModel.setAutoValueByAadhaar(formListController);
                      }
                    },
                  );
                },
                label: 'Continue',
                width: displayWidth(context),
              ),
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
