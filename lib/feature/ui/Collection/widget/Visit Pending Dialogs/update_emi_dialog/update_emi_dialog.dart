import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';

import '../../../Collection cases/model/visit_pending_items_model.dart';
import 'update_emi_dialog_content.dart';

class UpdateEmiDialog {
  UpdateEmiDialog();

  Future<void> updateEmiDialog({
    required BuildContext context,
    required ItemsDetails item,
    required int index,
  }) async {
    return showDialog(
      context: context,
      builder: (context) {
        return  Dialog(
            insetAnimationCurve: Easing.linear,
            insetAnimationDuration: const Duration(milliseconds: 1000),
            insetPadding: const EdgeInsets.all(20),
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(10))),
            child: UpdateEmiDialogContent(item: item,index: index,));
      },
    );
  }
}