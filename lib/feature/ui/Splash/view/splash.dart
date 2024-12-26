import 'dart:async';
import 'dart:developer';
import 'package:finexe/feature/base/routes/routes.dart';
import 'package:finexe/feature/ui/Sales/OnBoarding/view_model/on_boarding_view_model.dart';
import 'package:finexe/feature/ui/Splash/view_model/splash_vew_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';


class SplashScreen extends ConsumerWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncValue = ref.watch(splashViewModelProvider);
    final splashViewModel = ref.read(splashViewModelProvider.notifier);
    final downloaded = ref.watch(downloadProvider);
    log('asyncValue on splash: ${asyncValue.toString()}');

    //  final versionCheck = ref.watch(versionViewModelProvider);

    return asyncValue.when(
        data: (isLoggedIn) {
          if (kDebugMode) {
            print('punch status :- ${isLoggedIn.puntchStatus}');
            print('token :- ${isLoggedIn.token}');
            print('role :- ${isLoggedIn.role}');
            print('isUpdateRequired :- ${isLoggedIn.isUpdateRequired}');
            print('apkUrl : - ${isLoggedIn.apkUrl}');
          }
          WidgetsBinding.instance.addPostFrameCallback((_) async {
            if (isLoggedIn.isUpdateRequired! && isLoggedIn.apkUrl != null) {
              // splashViewModel.downloadApk(isLoggedIn.apkUrl!);
              await downloadDialog(
                  apkUrl: isLoggedIn.apkUrl!,
                  context: context,
                  downloaded: downloaded,
                  SplashViewModel: splashViewModel);
            } else if (isLoggedIn.token!) {
              // ---------------------- isLoggedIn.value?.puntchStatus == false --------------------------------
              if (isLoggedIn.puntchStatus == false) {
                Navigator.pushNamedAndRemoveUntil(
                  context,
                  AppRoutes.attendance,
                      (route) => false,
                );
              } else
              {
                SharedPreferences prefs = await SharedPreferences.getInstance();
                List<String>? roles = prefs.getStringList('roleName');
                print('isLoggedIn.role- ${isLoggedIn.role} and roles-${roles} ');

                if (roles != null) {
                  if (roles.contains('admin')) {
                    log("Navigating to admin dashboard");
                    Navigator.pushNamedAndRemoveUntil(
                      context,
                      AppRoutes.dashBoard, // Admin dashboard route
                          (route) => false, // Remove all previous routes
                    );
                  } else if (roles.contains('sales')) {
                    log("Navigating to sales dashboard");
                    Navigator.pushNamedAndRemoveUntil(
                      context,
                      AppRoutes.dashBoard, // Sales dashboard route
                          (route) => false, // Remove all previous routes
                    );
                  } else if (roles.contains('collection')) {
                    log("Navigating to collection dashboard");
                    Navigator.pushNamedAndRemoveUntil(
                      context,
                      AppRoutes.collectionHome, // Collection dashboard route
                          (route) => false, // Remove all previous routes
                    );
                  } else if (roles.contains('salesAndCollection')) {
                    log("Navigating to sales and collection dashboard");
                    Navigator.pushNamedAndRemoveUntil(
                      context,
                      AppRoutes.dashBoard, // Sales and Collection dashboard route
                          (route) => false, // Remove all previous routes
                    );
                  } else if (roles.contains('salesPdAndCollection')) {
                    log("Navigating to sales PD and collection dashboard");
                    Navigator.pushNamedAndRemoveUntil(
                      context,
                      AppRoutes.dashBoard, // Sales PD and Collection dashboard route
                          (route) => false, // Remove all previous routes
                    );
                  } else if (roles.contains('cibil')) {
                    log("Navigating to CIBIL dashboard");
                    Navigator.pushNamedAndRemoveUntil(
                      context,
                      AppRoutes.dashBoard, // CIBIL dashboard route
                          (route) => false, // Remove all previous routes
                    );
                  } else {
                    // Default role navigation
                    log('No matching role found, navigating to HRMS');
                    Navigator.pushNamedAndRemoveUntil(
                      context,
                      AppRoutes.hrms, // Default route
                          (route) => false, // Remove all previous routes
                    );
                  }
                } else {
                  // Handle the case where roles are null
                  log('No roles found, navigating to HRMS');
                  Navigator.pushNamedAndRemoveUntil(
                    context,
                    AppRoutes.hrms, // Default route
                        (route) => false, // Remove all previous routes
                  );
                }



                /* switch (isLoggedIn.role) {
                  case 'admin':
                    log("Navigating to admin dashboard");
                    Navigator.pushNamedAndRemoveUntil(
                      context,
                      AppRoutes.dashBoard, // Admin dashboard route
                      (route) => false, // Remove all previous routes
                    );
                    break;
                  case 'sales':
                    log("Navigating to sales dashboard");
                    Navigator.pushNamedAndRemoveUntil(
                      context,
                      AppRoutes.dashBoard, // Sales dashboard route
                      (route) => false, // Remove all previous routes
                    );
                    break;
                  case 'collection':
                    log("Navigating to collection dashboard");
                    Navigator.pushNamedAndRemoveUntil(
                      context,
                      AppRoutes.collectionHome, // Collection dashboard route
                      (route) => false, // Remove all previous routes
                    );
                    break;
                  case 'salesAndCollection':
                    log("Navigating to collection dashboard");
                    Navigator.pushNamedAndRemoveUntil(
                      context,
                      AppRoutes.dashBoard, // Collection dashboard route
                      (route) => false, // Remove all previous routes
                    );
                    break;
                  case 'salesPdAndCollection':
                    log("Navigating to collection dashboard");
                    Navigator.pushNamedAndRemoveUntil(
                      context,
                      AppRoutes.dashBoard, // Collection dashboard route
                      (route) => false, // Remove all previous routes
                    );
                    break;
                  case 'cibil':
                    log("Navigating to collection dashboard");
                    Navigator.pushNamedAndRemoveUntil(
                      context,
                      AppRoutes.dashBoard, // Collection dashboard route
                      (route) => false, // Remove all previous routes
                    );
                    break;

                  default:
                    Navigator.pushNamedAndRemoveUntil(
                      context,
                      AppRoutes.hrms, // Collection dashboard route
                      (route) => false, // Remove all previous routes
                    );
                    // Handle unknown roles or navigate to a default screen
                    log('No matching role found');
                    break;
                }*/
              }
            } else {
              Navigator.pushNamedAndRemoveUntil(
                context,
                AppRoutes.login, // Collection dashboard route
                    (route) => false, // Remove all previous routes
              );
            }
          });
          // Future.microtask(() {
          //
          // });

          return Container(
            color: Colors.white,
            child: Center(
              child: Image.asset(
                'assets/images/login_bottom.png',
                width: MediaQuery.of(context).size.width * 0.65,
              ),
            ),
          );
        },
        error: (error, stack) => Center(child: Text('Error: $error')),
        loading: () => Container(
          color: Colors.white,
          child: Center(
            child: Image.asset(
              'assets/images/login_bottom.png',
              width: MediaQuery.of(context).size.width * 0.65,
            ),
          ),
        ));
  }

  Future<void> downloadDialog(
      {required BuildContext context,
        required String downloaded,
        required String apkUrl,
        required SplashViewModel SplashViewModel}) {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => AlertDialog(
        title: const Text("Update Required"),
        content: const Text(
            "A new version of the app is available. Please update to continue."),
        actions: [
          Visibility(
            replacement: const Text('Installing...'),
            visible: downloaded == '',
            child: TextButton(
              onPressed: () async {
                // SplashViewModel.downloadApk(apkUrl,context);
                if (apkUrl != null) {
                  try {
                    final Uri url = Uri.parse(apkUrl);
                    await launchUrl(url,mode: LaunchMode.externalApplication).then((value) {
                      Navigator.pop(context);
                    },);
                  } catch (e) {
                    throw Exception(e);
                  }
                  // _downloadFile(context,state.apkUrl!,'');
                  // downloadApk(state.apkUrl!);
                }
              },
              child: const Text("Download"),
            ),
          ),
        ],
      ),
    );
  }

}