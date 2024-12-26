import 'dart:developer';

// import 'package:finexe_attendance/feature/EOD_Screen/controller/eod_controller.dart';
import 'package:flutter/material.dart';

import 'collection_logout_dialog_content.dart';

class CollectionLogOutDialog {
  static Future<void> collectionLogOutDialog({
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
          content: const CollectionLogoutDialogContent()

        );
      },
    );
  }
}
