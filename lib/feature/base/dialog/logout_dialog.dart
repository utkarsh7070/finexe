import 'dart:developer';
import 'dart:io';

import 'package:finexe/feature/base/routes/routes.dart';
import 'package:finexe/feature/base/service/session_service.dart';
import 'package:finexe/feature/base/utils/namespase/app_colors.dart';
// import 'package:finexe_attendance/feature/EOD_Screen/controller/eod_controller.dart';
import 'package:flutter/material.dart';

class LogOutDialog {
  // final indexCtrl = Get.find<EODController>();
  static Future<void> logOutDialog({
    required BuildContext context,
  }) async {
    log('LogOutDialog');
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25),
          ),
          title:
              const Text('Are you sure you want to Logout \n your Finexe ID?',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 14,
                  )),
          //const Text('Add User Phrase /n/n Say user phrase aloud or type in manually'),
          content: SizedBox(
            height: 110,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  width: 200,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      padding: EdgeInsets.zero,
                      // backgroundColor: colors,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    onPressed: () {
                      SessionService.deleteSession();
                      Navigator.of(context).pop();
                      Navigator.pushNamedAndRemoveUntil(
                        context,
                        AppRoutes.login, // Name of your login route
                        (route) =>
                            false, // Remove all routes until the login route
                      );
                    },
                    child: const Text('Logout',
                        style: TextStyle(color: AppColors.white)),
                  ),
                ),
                TextButton(
                  child: const Text('CANCEL',
                      style: TextStyle(color: AppColors.primary)),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
