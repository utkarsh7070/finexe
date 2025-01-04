import 'package:flutter/material.dart';

import 'otp_dialog_content.dart';


class OtpDialog {
  OtpDialog();

  Future<void> otpDialog({
    required BuildContext context,
  }) async {
    return showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return const Dialog(
            insetAnimationCurve: Easing.linear,
            insetAnimationDuration: Duration(milliseconds: 1000),
            insetPadding: EdgeInsets.all(20),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(10))),
            child: OtpDialogContent());
      },
    );
  }
}