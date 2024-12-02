
import 'package:flutter/material.dart';

import '../../../../../../../base/utils/namespase/app_colors.dart';
import '../../../../../../../base/utils/namespase/display_size.dart';
import 'back_to_dashboard.dart';

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
          actions: const [ConfirmBackToDashBoard()],
          content: Container(
            height: displayHeight(context) * 0.19,
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
                const Text('Are you sure?'),
                SizedBox(
                  height: displayHeight(context) * 0.01,
                ),
                const Text(
                  'If you do this Process, you will have to start the process again.',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: AppColors.gray),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

