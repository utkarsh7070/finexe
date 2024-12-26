import 'package:flutter/material.dart';
import '../../../Collection cases/model/visit_pending_items_model.dart';
import 'closuer_dialog_content.dart';

class ClosuerDialog {
  ClosuerDialog();

  Future<void> closuerDialog({
    required BuildContext context,
    required ItemsDetails item,
    required int index,
  }) async {
    return showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return Dialog(
            insetAnimationCurve: Easing.linear,
            insetAnimationDuration: const Duration(milliseconds: 1000),
            insetPadding: const EdgeInsets.all(20),
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(10))),
            child: ClosuerDialogContent(item: item,index: index,));
      },
    );
  }
}