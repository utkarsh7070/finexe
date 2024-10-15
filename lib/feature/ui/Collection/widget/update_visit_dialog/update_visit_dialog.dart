import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'update_visit_dialog_content.dart';

class UpdateVisitDialog {
  UpdateVisitDialog();

  Future<void> updateVisitDialog({
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
            child: UpdateVisitDialogContent());
      },
    );
  }
}
