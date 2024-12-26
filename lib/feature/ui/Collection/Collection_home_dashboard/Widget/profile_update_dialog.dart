import 'package:finexe/feature/ui/Collection/Collection_home_dashboard/Widget/profile_update.dart';
import 'package:finexe/feature/ui/Collection/Collection_home_dashboard/home_collection_model/user_profile_model.dart';
import 'package:flutter/material.dart';


class ProfileUpdateDialog {
  static Future<void> profileUpdateDialog({
    required BuildContext context,
    required UserProfile userProfile
  }) async {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
            insetAnimationCurve: Easing.linear,
            insetAnimationDuration: Duration(milliseconds: 1000),
            insetPadding: EdgeInsets.all(20),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(25),
            ),
            child: ProfileUpdateContent(userProfile: userProfile,)

        );
      },
    );
  }
}
