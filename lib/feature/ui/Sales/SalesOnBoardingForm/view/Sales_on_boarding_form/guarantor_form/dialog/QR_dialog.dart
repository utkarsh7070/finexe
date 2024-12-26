import 'package:finexe/feature/base/utils/namespase/app_colors.dart';
import 'package:flutter/material.dart';


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
