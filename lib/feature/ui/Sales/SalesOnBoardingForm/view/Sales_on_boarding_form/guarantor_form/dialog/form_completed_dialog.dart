import 'package:finexe/feature/base/utils/namespase/app_colors.dart';
import 'package:finexe/feature/ui/Sales/SalesOnBoardingForm/view/Sales_on_boarding_form/guarantor_form/dialog/form_completed_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';


class FormSubmitDialog {
  FormSubmitDialog();

  Future<void> formSubmitDialog({
    required BuildContext context,
  }) async {
    return showDialog(
      context: context,
      builder: (context) {
        return  const AlertDialog(
          backgroundColor: AppColors.primary,
            // insetAnimationCurve: Easing.linear,
            // insetAnimationDuration: Duration(milliseconds: 1000),
            // insetPadding: EdgeInsets.all(20),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(10))),
            content: FormSubmitContentDialog());
      },
    );
  }
}