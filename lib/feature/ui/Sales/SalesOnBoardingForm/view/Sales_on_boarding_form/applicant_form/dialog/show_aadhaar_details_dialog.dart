import 'package:finexe/feature/ui/Sales/SalesOnBoardingForm/view/Sales_on_boarding_form/applicant_form/dialog/show_aadhaar_detail_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';

class AadhaarDialog {
  AadhaarDialog();

  Future<void> aadhaarDialog({
    required BuildContext context,
  }) async {
    return showDialog(
      context: context,
      builder: (context) {
        return Dialog(
            insetAnimationCurve: Easing.linear,
            insetAnimationDuration: Duration(milliseconds: 1000),
            insetPadding: EdgeInsets.all(20),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(10))),
            child: AadhaarDetailsContent());
      },
    );
  }
}