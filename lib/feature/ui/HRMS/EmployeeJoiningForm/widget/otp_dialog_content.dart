import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../base/utils/namespase/app_colors.dart';
import '../../../../base/utils/namespase/app_style.dart';
import '../../../../base/utils/namespase/display_size.dart';
import '../../../../base/utils/widget/app_button.dart';
import '../view_model/employee_basic_details_view_model.dart';

class OtpDialogContent extends ConsumerWidget{
  const OtpDialogContent({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final employeeDataViewModel =  ref.read(employeeViewModelProvider.notifier);
   return Container(
     height: displayHeight(context)*0.45,
     padding: EdgeInsets.all(16),
     child:  Column(
       children: [
         Row(
           mainAxisAlignment: MainAxisAlignment.spaceBetween,
           children: [
             SizedBox(
               width: displayWidth(context) * 0.10,
             ),
             Text(
               'Enter OTP',
               style: AppStyles.headingTextStyleXL
             ),

             IconButton(
                 onPressed: () {
               Navigator.pop(context);
                 },
                 icon: const Icon(Icons.cancel_sharp,color: AppColors.red,)),
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
           keyboardType: TextInputType.number,
           focusedBorderColor: AppColors.primary,
           borderRadius: const BorderRadius.all(Radius.circular(10)),
           borderColor: AppColors.buttonBorderGray,
           showFieldAsBox: true,
           onCodeChanged: (String code) {
             print(code);
           },
           onSubmit: (String verificationCode) {
             employeeDataViewModel.otpUpdate(verificationCode);
           },
         ),
         SizedBox(
           height: displayHeight(context) * 0.04,
         ),
         // Visibility(
          //   visible: !personalFormState.isLoading,
          //   replacement: const Center(child: CircularProgressIndicator()),
          //   child:
          AppButton(
             textStyle: const TextStyle(color: AppColors.white),
             onTap: () {
               employeeDataViewModel.submitOtp().then((value) {
                 Navigator.pop(context);
               },);
             },
             label: 'Continue',
             width: displayWidth(context),
           ),
         // ),
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