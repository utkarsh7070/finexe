import 'dart:async';
import 'dart:developer';
import 'package:finexe/feature/base/routes/routes.dart';
import 'package:finexe/feature/ui/Splash/view_model/splash_vew_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';

// class SplashScreen extends ConsumerStatefulWidget {
//   const SplashScreen({super.key});
//
//   @override
//   _SplashScreenState createState() => _SplashScreenState();
// }

class SplashScreen extends ConsumerWidget {
  const SplashScreen({super.key});

  // @override
  // void initState() {
  //   // TODO: implement initState
  //   super.initState();
  //   // checkTokenExpiry();
  //   //  checkVersion(); // Check version as part of initialization
  // }

  // Future<void> checkTokenExpiry() async {
  //   final prefs = await SharedPreferences.getInstance();
  //   final int? loginTime = prefs.getInt('loginTime');
  //
  //   if (loginTime != null) {
  //     final currentTime = DateTime.now().millisecondsSinceEpoch;
  //     final int timeDiffInHours = (currentTime - loginTime) ~/ (1000 * 60 * 60);
  //
  //     if (timeDiffInHours >= 12) {
  //       await removeToken();
  //     } else {
  //       // If the token is still valid, start a timer for the remaining time
  //       final remainingTime = Duration(hours: 12 - timeDiffInHours);
  //       Timer(remainingTime, removeToken);
  //     }
  //   }
  // }

  // Future<void> removeToken() async {
  //   final prefs = await SharedPreferences.getInstance();
  //   await prefs.remove('token');
  //   // Optionally, handle token expiry UI update
  //   print("Token has been removed after 12 hours");
  // }

  // Future<void> checkVersion() async {
  //   try {
  //     await ref.read(versionViewModelProvider.notifier).checkVersion();
  //   } catch (e) {
  //     print("Error checking version: $e");
  //   }
  // }

  // Future<void> _downloadFile(BuildContext context, String url, String documentName) async {
  //   try {
  //    final dio = ref.watch(dioProvider);
  //
  //     // Use the "Downloads" directory to make it more accessible
  //     Directory downloadDir = Directory('/storage/emulated/0/Download/Finexe Apk');
  //     if (!await downloadDir.exists()) {
  //       await downloadDir.create(recursive: true);  // Create the folder if it doesn't exist
  //     }
  //
  //     // Set the file name and path
  //     if (documentName.isEmpty) {
  //       documentName = url.split('/').last;  // Extract file name from URL if not provided
  //     }
  //     String filePath = '${downloadDir.path}/$documentName';
  //    final file = File(filePath);
  //    if (await file.exists()) {
  //      await file.delete();
  //    }
  //     // Start downloading the file
  //     await dio.download(url, filePath);
  //
  //     // Show the file path when download is complete
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       SnackBar(content: Text('Downloaded to: $filePath')),
  //     );
  //   } catch (e) {
  //     // Handle any errors during download
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       SnackBar(content: Text('Error downloading file: $e')),
  //     );
  //   }
  // }

  // void openApk(String filePath) {
  //   print('openfile $filePath');
  //   OpenFile.open(filePath, type: '.apk');
  // }

  // @override
  // Widget build(BuildContext context) {
  //   final asyncValue = ref.watch(sessionProvider);
  //   final versionCheck = ref.watch(versionViewModelProvider);
  //   final downloaded = ref.watch(downloadProvider);
  //
  //   return asyncValue.when(
  //     data: (isLoggedIn) {
  //       return versionCheck.when(
  //         data: (state) {
  //           print('Version check state: ${state.isUpdateRequired}');
  //           // Show update dialog if needed
  //           if (state.isUpdateRequired) {
  //             WidgetsBinding.instance.addPostFrameCallback((_) {
  //               showDialog(
  //                 context: context,
  //                 barrierDismissible: false,
  //                 builder: (_) => AlertDialog(
  //                   title: const Text("Update Required"),
  //                   content: const Text(
  //                       "A new version of the app is available. Please update to continue."),
  //                   actions: [
  //                     Visibility(
  //                       replacement: const Text('Installing...'),
  //                       visible: downloaded == '',
  //                       child: TextButton(
  //                         onPressed: () {
  //                           if (state.apkUrl != null) {
  //                             try{
  //                               final Uri url =Uri.parse(state.apkUrl!);
  //                               launchUrl(url);
  //                             }catch(e){
  //                               throw Exception(e);
  //                             }
  //                             // _downloadFile(context,state.apkUrl!,'');
  //                             // downloadApk(state.apkUrl!);
  //
  //                           }
  //                         },
  //                         child: const Text("Download"),
  //                       ),
  //                     ),
  //                   ],
  //                 ),
  //               );
  //             });
  //           } else {
  //             // Navigation logic for logged-in users
  //             WidgetsBinding.instance.addPostFrameCallback((_) {
  //               if (isLoggedIn.value!.token!) {
  //                 // ---------------------- isLoggedIn.value?.puntchStatus == false --------------------------------
  //                 if (isLoggedIn.value?.puntchStatus == false) {
  //                   Navigator.pushNamedAndRemoveUntil(
  //                     context,
  //                     AppRoutes.attendance,
  //                     (route) => false,
  //                   );
  //                 } else {
  //                   switch (isLoggedIn.value?.role) {
  //                     case 'admin':
  //                       log("Navigating to admin dashboard");
  //                       Navigator.pushNamedAndRemoveUntil(
  //                         context,
  //                         AppRoutes.dashBoard, // Admin dashboard route
  //                         (route) => false, // Remove all previous routes
  //                       );
  //                       break;
  //                     case 'sales':
  //                       log("Navigating to sales dashboard");
  //                       Navigator.pushNamedAndRemoveUntil(
  //                         context,
  //                         AppRoutes.dashBoard, // Sales dashboard route
  //                         (route) => false, // Remove all previous routes
  //                       );
  //                       break;
  //                     case 'collection':
  //                       log("Navigating to collection dashboard");
  //                       Navigator.pushNamedAndRemoveUntil(
  //                         context,
  //                         AppRoutes.collectionHome,
  //                         // Collection dashboard route
  //                         (route) => false, // Remove all previous routes
  //                       );
  //                       break;
  //                     case 'salesAndCollection':
  //                       log("Navigating to collection dashboard");
  //                       Navigator.pushNamedAndRemoveUntil(
  //                         context,
  //                         AppRoutes.dashBoard, // Collection dashboard route
  //                         (route) => false, // Remove all previous routes
  //                       );
  //                       break;
  //                     case 'salesPdAndCollection':
  //                       log("Navigating to collection dashboard");
  //                       Navigator.pushNamedAndRemoveUntil(
  //                         context,
  //                         AppRoutes.dashBoard, // Collection dashboard route
  //                         (route) => false, // Remove all previous routes
  //                       );
  //                       break;
  //                     case 'cibil':
  //                       log("Navigating to collection dashboard");
  //                       Navigator.pushNamedAndRemoveUntil(
  //                         context,
  //                         AppRoutes.dashBoard, // Collection dashboard route
  //                         (route) => false, // Remove all previous routes
  //                       );
  //                       break;
  //                     case 'creditPd':
  //                       log("Navigating to collection dashboard");
  //                       Navigator.pushNamedAndRemoveUntil(
  //                         context,
  //                         AppRoutes.pdscreen, // Collection dashboard route
  //                         (route) => false, // Remove all previous routes
  //                       );
  //                       break;
  //
  //                     default:
  //                       Navigator.pushNamedAndRemoveUntil(
  //                         context,
  //                         AppRoutes.hrms, // Collection dashboard route
  //                         (route) => false, // Remove all previous routes
  //                       );
  //                       // Handle unknown roles or navigate to a default screen
  //                       log('No matching role found');
  //                       break;
  //                   }
  //                 }
  //               } else {
  //                 Navigator.pushNamedAndRemoveUntil(
  //                   context,
  //                   AppRoutes.login, // Collection dashboard route
  //                   (route) => false, // Remove all previous routes
  //                 );
  //               }
  //             });
  //           }
  //
  //           return buildSplashScreen(context);
  //         },
  //         error: (error, stack) => Center(child: Text('Error: $error')),
  //         loading: () => buildSplashScreen(context),
  //       );
  //     },
  //     error: (error, stack) => Center(child: Text('Error: $error')),
  //     loading: () => buildSplashScreen(context),
  //   );
  // }
  //
  // Widget buildSplashScreen(BuildContext context) {
  //   return Container(
  //     color: Colors.white,
  //     child: Center(
  //       child: Image.asset(
  //         'assets/images/login_bottom.png',
  //         width: MediaQuery.of(context).size.width * 0.65,
  //       ),
  //     ),
  //   );
  // }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncValue = ref.watch(splashViewModelProvider);
    final splashViewModel = ref.read(splashViewModelProvider.notifier);
    final downloaded = ref.watch(downloadProvider);
    log('asyncValue: ${asyncValue.toString()}');

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
              }else if (isLoggedIn.role != null) {
                if (isLoggedIn.role!.contains('admin')) {
                  log("Navigating to admin dashboard");
                  Navigator.pushNamedAndRemoveUntil(
                    context,
                    AppRoutes.dashBoard, // Admin dashboard route
                        (route) => false, // Remove all previous routes
                  );
                } else if (isLoggedIn.role!.contains('sales')) {
                  log("Navigating to sales dashboard");
                  Navigator.pushNamedAndRemoveUntil(
                    context,
                    AppRoutes.dashBoard, // Sales dashboard route
                        (route) => false, // Remove all previous routes
                  );
                } else if (isLoggedIn.role!.contains('collection')) {
                  log("Navigating to collection dashboard");
                  Navigator.pushNamedAndRemoveUntil(
                    context,
                    AppRoutes.collectionHome, // Collection dashboard route
                        (route) => false, // Remove all previous routes
                  );
                } else if (isLoggedIn.role!.contains('salesAndCollection')) {
                  log("Navigating to sales and collection dashboard");
                  Navigator.pushNamedAndRemoveUntil(
                    context,
                    AppRoutes.dashBoard, // Sales and Collection dashboard route
                        (route) => false, // Remove all previous routes
                  );
                } else if (isLoggedIn.role!.contains('salesPdAndCollection')) {
                  log("Navigating to sales PD and collection dashboard");
                  Navigator.pushNamedAndRemoveUntil(
                    context,
                    AppRoutes.dashBoard,
                    // Sales PD and Collection dashboard route
                        (route) => false, // Remove all previous routes
                  );
                } else if (isLoggedIn.role!.contains('cibil')) {
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


              //   switch (isLoggedIn.role) {
              //     case 'admin':
              //       log("Navigating to admin dashboard");
              //       Navigator.pushNamedAndRemoveUntil(
              //         context,
              //         AppRoutes.dashBoard, // Admin dashboard route
              //         (route) => false, // Remove all previous routes
              //       );
              //       break;
              //     case 'sales':
              //       log("Navigating to sales dashboard");
              //       Navigator.pushNamedAndRemoveUntil(
              //         context,
              //         AppRoutes.dashBoard, // Sales dashboard route
              //         (route) => false, // Remove all previous routes
              //       );
              //       break;
              //     case 'collection':
              //       log("Navigating to collection dashboard");
              //       Navigator.pushNamedAndRemoveUntil(
              //         context,
              //         AppRoutes.collectionHome, // Collection dashboard route
              //         (route) => false, // Remove all previous routes
              //       );
              //       break;
              //     case 'salesAndCollection':
              //       log("Navigating to collection dashboard");
              //       Navigator.pushNamedAndRemoveUntil(
              //         context,
              //         AppRoutes.dashBoard, // Collection dashboard route
              //         (route) => false, // Remove all previous routes
              //       );
              //       break;
              //     case 'salesPdAndCollection':
              //       log("Navigating to collection dashboard");
              //       Navigator.pushNamedAndRemoveUntil(
              //         context,
              //         AppRoutes.dashBoard, // Collection dashboard route
              //         (route) => false, // Remove all previous routes
              //       );
              //       break;
              //     case 'cibil':
              //       log("Navigating to collection dashboard");
              //       Navigator.pushNamedAndRemoveUntil(
              //         context,
              //         AppRoutes.dashBoard, // Collection dashboard route
              //         (route) => false, // Remove all previous routes
              //       );
              //       break;
              //
              //     default:
              //       Navigator.pushNamedAndRemoveUntil(
              //         context,
              //         AppRoutes.hrms, // Collection dashboard route
              //         (route) => false, // Remove all previous routes
              //       );
              //       // Handle unknown roles or navigate to a default screen
              //       log('No matching role found');
              //       break;
              //   }
              // }
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
