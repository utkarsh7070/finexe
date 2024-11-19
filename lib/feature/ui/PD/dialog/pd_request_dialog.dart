import 'package:finexe/feature/base/routes/routes.dart';
import 'package:finexe/feature/base/utils/namespase/app_colors.dart';
import 'package:finexe/feature/base/utils/namespase/app_style.dart';
import 'package:finexe/feature/base/utils/namespase/display_size.dart';
import 'package:flutter/material.dart';

class PdRequestDialogue {
  // final indexCtrl = Get.find<EODController>();
  static Future<void> requestAcceptDialogue({
    required BuildContext context,
  }) async {
    return showDialog<void>(
      useSafeArea: true,
      context: context,
      barrierDismissible: true, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: AppColors.primary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25),
          ),
          content: Container(
            width: displayWidth(context), // 80% of screen width
            height: displayHeight(context) * 0.46, // 40% of screen height
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/images/Verification.png',
                  height: displayHeight(context) * 0.1,
                  width: displayWidth(context) * 0.2,
                  alignment: Alignment.center,
                ),
                SizedBox(
                  height: displayHeight(context) * 0.01,
                ),
                Text(
                  'Are You sure?',
                  style: AppStyles.whiteText24,
                ),
                SizedBox(
                  height: displayHeight(context) * 0.03,
                ),
                Text(
                  'IF you proceed, you will jump on PD process  and will continue process ',
                  textAlign: TextAlign.center,
                  style: AppStyles.headingTextStyleFooter,
                ),
                SizedBox(
                  height: displayHeight(context) * 0.02,
                ),
                SizedBox(
                  width: displayWidth(context) * 0.8,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.white,
                      padding: EdgeInsets.zero,
                      // backgroundColor: colors,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    onPressed: () {
                      Navigator.of(context).pop();
                      Navigator.pushNamedAndRemoveUntil(
                        context,
                        AppRoutes.pdscreen, // Name of your login route
                            (route) =>
                        false, // Remove all routes until the login route
                      );
                    },
                    child: const Text('Accept',
                        style: TextStyle(color: AppColors.primary)),
                  ),
                ),
                SizedBox(
                  height: displayHeight(context) * 0.01,
                ),
                SizedBox(
                  width: displayWidth(context) * 0.8,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.transparent,
                      padding: EdgeInsets.zero,
                      // backgroundColor: colors,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text('Reject',
                        style: TextStyle(color: AppColors.gray)),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
