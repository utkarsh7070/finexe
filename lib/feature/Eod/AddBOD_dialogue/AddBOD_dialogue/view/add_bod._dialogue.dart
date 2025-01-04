
import 'package:flutter/material.dart';

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
