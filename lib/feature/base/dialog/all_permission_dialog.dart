//import 'package:finexe_attendance/feature/Login/controller/login_contoller.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_exit_app/flutter_exit_app.dart';
// import 'package:flutter_exit_app/flutter_exit_app.dart';

class AllPermissionDialog {
  Future<void> allPermissionDialog(
      {required BuildContext context,
      required String text,
      required IconData icon,
      required double height,
      required Color colors,
      required Function() onButtonPressed}) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return PopScope(
          canPop: false,
          onPopInvoked: (didPop) {
            if (didPop) {
              return;
            }
          },
          child: AlertDialog(
            actions: [
              TextButton(
                child: const Text('Disagree',
                    style: TextStyle(color: Colors.blue)),
                onPressed: () async {
                  Navigator.of(context).pop();
                  FlutterExitApp.exitApp();
                },
              ),
              TextButton(
                child:
                    const Text('Agree', style: TextStyle(color: Colors.blue)),
                onPressed: () {
                  if (kDebugMode) {
                    print('hii');
                  }
                  Navigator.of(context).pop();
                  onButtonPressed();
                  // controller.getPermission();
                },
              ),
            ],
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(25),
            ),
            icon: Icon(icon, color: colors, size: 25),
            title: Text(text,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 20,
                )),
            //const Text('Add User Phrase /n/n Say user phrase aloud or type in manually'),
            content: SizedBox(
              width: MediaQuery.of(context).size.width,
              height: height,
              child: SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(
                      height: 10,
                    ),
                    iconText(Icons.perm_media_sharp, 'Storge Permission'),
                    const SizedBox(
                      height: 15,
                    ),
                    iconText(Icons.keyboard_voice, 'Audio Permission'),
                    const SizedBox(
                      height: 15,
                    ),
                    iconText(Icons.location_on_rounded, 'Location Permission'),
                    const SizedBox(
                      height: 15,
                    ),
                    iconText(Icons.camera_alt, 'Camera Permission'),
                    const SizedBox(
                      height: 15,
                    ),
                    iconText(
                        Icons.notifications_active, 'Notification Permission'),
                    const SizedBox(
                      height: 15,
                    ),
                    iconText(Icons.system_security_update_good,
                        'System Alert Window \nPermission'),
                    //
                    // TextButton(
                    //   child: const Text('CANCEL'),
                    //   onPressed: () {
                    //     Navigator.of(context).pop();
                    //   },
                    // ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget iconText(IconData icon, String text) {
    return Row(
      children: [
        Icon(icon, color: Colors.blue),
        const SizedBox(
          width: 15,
        ),
        Text(text)
      ],
    );
  }
}
