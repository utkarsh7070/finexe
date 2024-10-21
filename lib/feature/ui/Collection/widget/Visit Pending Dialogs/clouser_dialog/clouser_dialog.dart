import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'closuer_dialog_content.dart';

class ClosuerDialog {
  ClosuerDialog();

  Future<void> closuerDialog({
    required BuildContext context,
  }) async {
    return showDialog(
      context: context,
      builder: (context) {
        return const Dialog(
            insetAnimationCurve: Easing.linear,
            insetAnimationDuration: Duration(milliseconds: 1000),
            insetPadding: EdgeInsets.all(20),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(10))),
            child: ClosuerDialogContent());
      },
    );
  }
}