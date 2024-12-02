import 'dart:async';
import 'dart:developer';
import 'package:finexe/feature/base/routes/routes.dart';
import 'package:finexe/feature/ui/Splash/view_model/splash_vew_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

class SplashScreen extends ConsumerStatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen> {


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    checkTokenExpiry();
    checkVersion(); // Check version as part of initialization
  }

  Future<void> checkTokenExpiry() async {
    final prefs = await SharedPreferences.getInstance();
    final int? loginTime = prefs.getInt('loginTime');

    if (loginTime != null) {
      final currentTime = DateTime.now().millisecondsSinceEpoch;
      final int timeDiffInHours = (currentTime - loginTime) ~/ (1000 * 60 * 60);

      if (timeDiffInHours >= 12) {
        await removeToken();
      } else {
        // If the token is still valid, start a timer for the remaining time
        final remainingTime = Duration(hours: 12 - timeDiffInHours);
        Timer(remainingTime, removeToken);
      }
    }
  }

  Future<void> removeToken() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('token');
    // Optionally, handle token expiry UI update
    print("Token has been removed after 12 hours");
  }

  Future<void> checkVersion() async {
    try {
      await ref.read(versionViewModelProvider.notifier).checkVersion();
    } catch (e) {
      print("Error checking version: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    final asyncValue = ref.watch(sessionProvider);
    final versionCheck = ref.watch(versionViewModelProvider);

    return asyncValue.when(
      data: (isLoggedIn) {
        return versionCheck.when(
          data: (state) {
            print('Version check state: ${state.isUpdateRequired}');
            // Show update dialog if needed
            if (state.isUpdateRequired) {
              WidgetsBinding.instance.addPostFrameCallback((_) {
                showDialog(
                  context: context,
                  barrierDismissible: false,
                  builder: (_) => AlertDialog(
                    title: const Text("Update Required"),
                    content: const Text("A new version of the app is available. Please update to continue."),
                    actions: [
                      TextButton(
                        onPressed: () {
                          if (state.apkUrl != null) {
                            launchUrl(Uri.parse(state.apkUrl!));
                          }
                        },
                        child: const Text("Download"),
                      ),
                    ],
                  ),
                );
              });
            }

            else {
              // Navigation logic for logged-in users
              Future.microtask(() {
                if (isLoggedIn.value!.token!) {
                  // ---------------------- isLoggedIn.value?.puntchStatus == false --------------------------------
                  if (isLoggedIn.value?.puntchStatus == false) {
                    Navigator.pushNamedAndRemoveUntil(
                      context,
                      AppRoutes.attendance,
                          (route) => false,
                    );
                  }
                  else {
                    switch (isLoggedIn.value?.role) {
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
                          AppRoutes.collectionHome,
                          // Collection dashboard route
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
                        case 'creditPd':
                        log("Navigating to collection dashboard");
                        Navigator.pushNamedAndRemoveUntil(
                          context,
                          AppRoutes.pdscreen, // Collection dashboard route
                              (route) => false, // Remove all previous routes
                        );
                        break;

                      default:
                      // Handle unknown roles or navigate to a default screen
                        log('No matching role found');
                        break;
                    }
                  }
                } else {
                  Navigator.pushNamedAndRemoveUntil(
                    context,
                    AppRoutes.login, // Collection dashboard route
                        (route) => false, // Remove all previous routes
                  );
                }
              });
            }

            return buildSplashScreen(context);
          },
          error: (error, stack) => Center(child: Text('Error: $error')),
          loading: () => buildSplashScreen(context),
        );
      },
      error: (error, stack) => Center(child: Text('Error: $error')),
      loading: () => buildSplashScreen(context),
    );
  }


  Widget buildSplashScreen(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Center(
        child: Image.asset(
          'assets/images/login_bottom.png',
          width: MediaQuery.of(context).size.width * 0.65,
        ),
      ),
    );
  }


/*@override
  Widget build(BuildContext context) {
    final asyncValue = ref.watch(sessionProvider);
    log('asyncValue: ${asyncValue.toString()}');

    final versionCheck = ref.watch(versionViewModelProvider);

    useEffect(() {
      ref.read(versionViewModelProvider.notifier).checkVersion();
      return null;
    }, []);

    return asyncValue.when(
        data: (isLoggedIn) {
          print(isLoggedIn.value?.puntchStatus);
          print(isLoggedIn.value?.token);
          print(isLoggedIn.value?.role);


          Future.microtask(() {
            if (isLoggedIn.value!.token!) {
              // ---------------------- isLoggedIn.value?.puntchStatus == false --------------------------------
              if (isLoggedIn.value?.puntchStatus == false) {
                Navigator.pushNamedAndRemoveUntil(
                  context,
                  AppRoutes.attendance,
                  (route) => false,
                );
              }
              else {
                switch (isLoggedIn.value?.role) {
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
                    // Handle unknown roles or navigate to a default screen
                    log('No matching role found');
                    break;
                }
              }
            } else {
              Navigator.pushNamedAndRemoveUntil(
                context,
                AppRoutes.login, // Collection dashboard route
                (route) => false, // Remove all previous routes
              );
            }
          });
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
  }*/

}
