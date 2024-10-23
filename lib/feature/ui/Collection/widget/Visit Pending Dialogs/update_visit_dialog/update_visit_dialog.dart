import 'package:finexe/feature/ui/Collection/Collection%20cases/model/visit_pending_items_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'update_visit_dialog_content.dart';

class UpdateVisitDialog {

  UpdateVisitDialog();

  Future<void> updateVisitDialog({
    required BuildContext context,
    required ItemsDetails item,
    required int index,
  }) async {
    return showDialog(barrierDismissible: false,
      context: context,
      builder: (context) {
        return Dialog(
            insetAnimationCurve: Easing.linear,
            insetAnimationDuration: const Duration(milliseconds: 1000),
            insetPadding: const EdgeInsets.all(20),
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(10))),
            child: UpdateVisitDialogContent(item: item,index: index,));
      },
    );
  }
}
