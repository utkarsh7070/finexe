import 'package:finexe/feature/base/routes/routes.dart';
import 'package:finexe/feature/base/utils/namespase/app_colors.dart';
import 'package:finexe/feature/base/utils/namespase/display_size.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../NewLone/view_model/new_loan_view_model.dart';
import '../../../../view_model/guarantor_form_view_model.dart';

class FormSubmitContentDialog extends ConsumerWidget {
  const FormSubmitContentDialog({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    return SizedBox(
      height: displayHeight(context) * 0.40,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: displayHeight(context)*0.02,),
          CircleAvatar(
            radius: 30,
            child: Image.asset('assets/images/Verification.png'),
          ),
          SizedBox(height: displayHeight(context)*0.04,),
          const Text('Your Application is Done',style: TextStyle(color: AppColors.white)),
          SizedBox(height: displayHeight(context)*0.02,),
          const Text(
              'We Will Update you for further process by call, Text Message, Email Etc.',style: TextStyle(color: AppColors.white),textAlign: TextAlign.center,),
          SizedBox(height: displayHeight(context)*0.03,),
          SizedBox(
            width: displayWidth(context),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: AppColors.white),
                onPressed: () {
                Navigator.pop(context);
                ref.invalidate(personalDetailViewModelProvider);
                ref.invalidate(paymentProvider);
                  Navigator.pushNamedAndRemoveUntil(context, AppRoutes.dashBoard, (route) => false,);
                }, child: const Text('Done')),
          )
        ],
      ),
    );
  }
}
