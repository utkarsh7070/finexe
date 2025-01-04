import 'package:finexe/feature/ui/Collection/widget/Visit%20Pending%20Dialogs/map/map_content.dart';
import 'package:flutter/material.dart';

/*import 'map_content.dart';*/

class MapDialog {
  MapDialog();

  Future<void> mapDialog({
    required BuildContext context,
    required String lat,
    required String log,
  }) async {
    return showDialog(
      context: context,
      builder: (context) {
        double latitude = double.parse(lat);
        double longitude = double.parse(log);
        return Dialog(
            insetAnimationCurve: Easing.linear,
            insetAnimationDuration: const Duration(milliseconds: 1000),
            insetPadding: const EdgeInsets.all(20),
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(10))),
            child: MapContent(latitude: latitude.toDouble(),longitude: longitude.toDouble()));
      },
    );
  }
}
