import 'package:flutter/material.dart';
import '../../../../../../../base/utils/namespase/display_size.dart';
import 'add_co_applicant_dialog_content.dart';

class ConfirmBackDialog{

  Future<void> confirmBackToForm({required BuildContext context}) {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          // insetAnimationCurve: Easing.linear,
          // insetAnimationDuration: Duration(milliseconds: 1000),
          // insetPadding: EdgeInsets.all(20),
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10))),
          actions: const [AddCoApplicantDialog()],
          content: SizedBox(
            height: displayHeight(context) * 0.17,
            child: Column(
              children: [
                Image.asset(
                  'assets/images/alert.png',
                  height: displayHeight(context) * 0.05,
                  width: displayWidth(context) * 0.10,
                ),
                SizedBox(
                  height: displayHeight(context) * 0.03,
                ),
                const Text('You want to add co-Applicant'),
                SizedBox(
                  height: displayHeight(context) * 0.01,
                ),
                // const Text(
                //   'If you do this Process, you will have to start the process again.',
                //   textAlign: TextAlign.center,
                //   style: TextStyle(color: AppColors.gray),
                // ),
              ],
            ),
          ),
        );
      },
    );
  }
}

