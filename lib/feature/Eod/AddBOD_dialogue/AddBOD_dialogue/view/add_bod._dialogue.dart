import 'package:finexe/feature/Eod/view_model/bodlist_viewmodel.dart';

import 'package:finexe/feature/base/service/session_service.dart';
import 'package:finexe/feature/base/utils/namespase/app_colors.dart';
import 'package:finexe/feature/base/utils/widget/app_text_field.dart';
import 'package:finexe/feature/base/utils/widget/custom_snackbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:finexe/feature/Eod/model/add_task_request_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../model/add_task_request_model.dart';
import '../viewmdoel/add_bod_viewmodel.dart';
import 'add_bod_dialog_content.dart';

class AddBodDialog {
  Future<void> addAlbumDialog(
    BuildContext context,
  ) async {

    return showDialog<void>(
      context: context,
      barrierDismissible: false, // User must tap a button to dismiss
      builder: (BuildContext context) {
        return
          const Dialog(
            insetPadding: EdgeInsets.all(16),
            insetAnimationCurve: Easing.linear,
            insetAnimationDuration: Duration(milliseconds: 1000),
                  child:  AddBodContent(),
          );
      },
    );
  }
}
