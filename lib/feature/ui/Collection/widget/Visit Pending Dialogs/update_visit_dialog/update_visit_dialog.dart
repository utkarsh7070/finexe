import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'update_visit_dialog_content.dart';

class UpdateVisitDialog {

  UpdateVisitDialog();

  Future<void> updateVisitDialog({required BuildContext context,
    required String? customerName,
    required String? collectionType,
    required String? emiAmount,
    required String? netDue,
    required String? oldDue,
    required String? finId,
    required String? partner,
    required String? father,
    required int? index
  }) async {
    return showDialog(
      context: context,
      builder: (context) {
        return Dialog(
            insetAnimationCurve: Easing.linear,
            insetAnimationDuration: const Duration(milliseconds: 1000),
            insetPadding: const EdgeInsets.all(20),
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(10))),
            child: UpdateVisitDialogContent(finId: finId,partner: partner,father: father,
                oldDue: oldDue, collection: collectionType, netDue: netDue,
                emiAmount: emiAmount, customerName: customerName,index: index,));
      },
    );
  }
}
