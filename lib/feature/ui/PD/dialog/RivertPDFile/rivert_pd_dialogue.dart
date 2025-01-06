


import 'package:finexe/feature/base/utils/namespase/app_colors.dart';
import 'package:finexe/feature/base/utils/namespase/app_style.dart';
import 'package:finexe/feature/base/utils/namespase/display_size.dart';
import 'package:finexe/feature/ui/PD/dialog/RivertPDFile/rivert_pd_dialogue_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


class PdRivertDialogue {
  static Future<void> requestRivertDialogue(
      {required BuildContext context, required String id,
        required WidgetRef ref,
        // required String rivertReason,
        //  required TextEditingController educationalDetailsController,
      }) async {
    // final rivertReasonController =
    //     ref.watch(rivertPDRequestProvider).rivertReasonController;
    // rivertReasonController.clear(); // This ensures the text field is empty.
    return showDialog<void>(
      useSafeArea: true,
      context: context,
      barrierDismissible: true, // user must tap button!
      builder: (BuildContext context) {

        return AlertDialog(
          backgroundColor: AppColors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25),
          ),
          content: Container(
            width: displayWidth(context), // 80% of screen width
            height: displayHeight(context) * 0.47, // 40% of screen height
            padding: const EdgeInsets.all(12),
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
                  'IF you proceed,Then File will be reivert.',
                  textAlign: TextAlign.center,
                  style: AppStyles.blacktext14,
                ),
                SizedBox(
                  height: displayHeight(context) * 0.02,
                ),

                PdRivertDialogContent(id: id,)
                // PdRequestDialogContent(id:id)
              ],
            ),
          ),
        );
      },
    );
  }
}
