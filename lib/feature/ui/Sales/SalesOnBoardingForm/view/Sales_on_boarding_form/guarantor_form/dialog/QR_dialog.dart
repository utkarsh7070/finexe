import 'package:finexe/feature/base/utils/namespase/app_colors.dart';
import 'package:finexe/feature/ui/Sales/SalesOnBoardingForm/view/Sales_on_boarding_form/guarantor_form/dialog/form_completed_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';

import 'QR_dialog_content.dart';

class ShowQRDialog {
  ShowQRDialog();

  Future<void> showQRDialog({
    required BuildContext context,
    required String img
  }) async {
    return showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return AlertDialog(
            backgroundColor: AppColors.primary,
            // insetAnimationCurve: Easing.linear,
            // insetAnimationDuration: Duration(milliseconds: 1000),
            // insetPadding: EdgeInsets.all(20),
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(10))),
            content: Container(child: Image.network(img),));
      },
    );
  }
}
