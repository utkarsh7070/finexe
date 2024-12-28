




import 'package:finexe/feature/base/utils/namespase/app_colors.dart';
import 'package:finexe/feature/base/utils/namespase/app_style.dart';
import 'package:finexe/feature/base/utils/namespase/display_size.dart';
import 'package:finexe/feature/ui/PD/dialog/RejectPDFile/rejectpd_file_dialogue_content.dart';
import 'package:finexe/feature/ui/PD/dialog/RivertPDFile/rivert_pd_dialogue_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../Common Widgets/common_textfield.dart';

class PdRijectDialogue {
  static Future<void> requestRijectDialogue(
      {required BuildContext context, required String customerID,
      }) async {
    return showDialog<void>(
      useSafeArea: true,
      context: context,
      barrierDismissible: true, // user must tap button!
      builder: (BuildContext context) {

        return AlertDialog(
          scrollable: true,
          backgroundColor: AppColors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25),
          ),
          content: Container(
            width: displayWidth(context), // 80% of screen width
            // height: displayHeight(context) * 0.58, // 55% of screen height
            padding: const EdgeInsets.all(12),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'Are You sure?',
                    style: AppStyles.blacktext14,
                  ),
                  SizedBox(
                    height: displayHeight(context) * 0.01,
                  ),
                  Text(
                    'IF you proceed,Then File will be rejected.',
                    textAlign: TextAlign.center,
                    style: AppStyles.blacktext14,
                  ),
                  SizedBox(
                    height: displayHeight(context) * 0.04,
                  ),
                  RejectpdFileDialogueContent(customerId:customerID ,)
                  // PdRivertDialogContent(id: id,reasonOfRivert: rivertReasonController,)
                  // PdRequestDialogContent(id:id)
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
