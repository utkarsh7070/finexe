import 'dart:async';
import 'dart:developer';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:finexe/feature/base/api/dio_exception.dart';
import 'package:finexe/feature/base/internetConnection/connection_overlay.dart';
import 'package:finexe/feature/base/internetConnection/connectivity.dart';
import 'package:finexe/feature/base/routes/routes.dart';
import 'package:finexe/feature/base/utils/namespase/display_size.dart';
import 'package:finexe/feature/base/utils/widget/app_button.dart';
import 'package:finexe/feature/ui/Splash/view_model/splash_vew_model.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:lottie/lottie.dart';
import 'package:restart_app/restart_app.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:video_player/video_player.dart';

/*class SplashScreen extends ConsumerStatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen> {
  bool showLogo = true;
  bool showWelcomeImage = false;
 // String address = "Fetching your location...";
  late VideoPlayerController _controller;


  @override
  void initState() {
    super.initState();
  //  _fetchAddress();
   // _startSplashSequence();
    _controller = VideoPlayerController.asset('assets/video/splash_new.mp4')
      ..initialize().then((_) {
        // Ensure the video starts playing when ready
        setState(() {
          _controller.play();
        });
      });
    _controller.setLooping(true); // Loop the video if needed

  }

  @override
  void dispose() {
    _controller.dispose(); // Dispose of the controller to free resources
    super.dispose();
  }

  @override
  Widget _buildSplashLogo(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SizedBox.expand(
            child: FittedBox(
              fit: BoxFit.cover,
              child: SizedBox(
                width: _controller.value.size?.width ?? 0,
                height: _controller.value.size?.height ?? 0,
                child: VideoPlayer(_controller),
              ),
            ),
          ),
          // Optional: Add overlay or logo
         *//* Center(
            child: Image.asset(
              'assets/images/login_bottom.png',
              width: MediaQuery.of(context).size.width * 0.65,
            ),
          ),*//*
        ],
      ),
    );
  }


  Future<void> _fetchAddress() async {
    Position? position = await getCurrentLocation();
    if (position != null) {
      try {
        List<Placemark> placemarks = await placemarkFromCoordinates(
          position.latitude,
          position.longitude,
        );
        Placemark place = placemarks[0];
        // Update the address state in Riverpod
        ref.read(addressProvider.notifier).state = "${place.street}, ${place.locality}, ${place.administrativeArea}, ${place.country}";
      } catch (e) {
        ref.read(addressProvider.notifier).state = "Could not fetch address.";
      }
    } else {
      ref.read(addressProvider.notifier).state = "Location not available.";
    }
  }

  void _startSplashSequence() async {
    // Show logo for 2 seconds
    await Future.delayed(const Duration(seconds: 3));
    // Update state to hide the logo and show the welcome image
    ref.read(showLogoProvider.notifier).state = false;
    ref.read(showWelcomeImageProvider.notifier).state = true;

    // Show welcome image for 3 seconds
    await Future.delayed(const Duration(seconds: 10));
    ref.read(showWelcomeImageProvider.notifier).state = false;
  }

  @override
  Widget build(BuildContext context) {
    bool isOffline = false;
    final retry = ref.watch(restart);
    final showLogo = ref.watch(showLogoProvider);
    final showWelcomeImage = ref.watch(showWelcomeImageProvider);
    final address = ref.watch(addressProvider);

    return ConnectivityBuilder(builder: (_, connectivityResult) {
      isOffline = connectivityResult.contains(ConnectivityResult.none);
      if (!isOffline) {
        final retryViewModel = ref.read(restart.notifier);
        final asyncValue = ref.watch(splashViewModelProvider);
        final splashViewModel = ref.read(splashViewModelProvider.notifier);

        final downloaded = ref.watch(downloadProvider);

        asyncValue.when(
          data: (isLoggedIn) async {
            // Wait for the splash sequence to complete
            await Future.delayed(const Duration(seconds: 3)); // Total splash sequence delay (4 + 8 seconds)
            WidgetsBinding.instance.addPostFrameCallback((_) async {
              if (isLoggedIn.isUpdateRequired! && isLoggedIn.apkUrl != null) {
                await downloadDialog(
                  apkUrl: isLoggedIn.apkUrl!,
                  context: context,
                  downloaded: downloaded,
                  SplashViewModel: splashViewModel,
                );
              } else if (isLoggedIn.token!) {
                    if (isLoggedIn.puntchStatus == false) {
                          Navigator.pushNamedAndRemoveUntil(
                            context,
                            AppRoutes.attendance,
                                (route) => false,
                          );
                        }
                        else if (isLoggedIn.puntchStatus == null) {
                              retryViewModel.state = true;
                        } else {
                          _navigateBasedOnRole(isLoggedIn,context);
                        }
              } else {
                Navigator.pushNamedAndRemoveUntil(
                  context,
                  AppRoutes.login,
                      (route) => false,
                );
              }
            });
          },
          error: (error, stack) {
            debugPrint('Error: $error');
            return Scaffold(
              body: Text('Error: $error'),
            );
          },
          loading: () => _buildLoadingScreen(context),
        );
      }

      return Stack(
        alignment: AlignmentDirectional.bottomCenter,
        children: [
          if (showLogo)
            _buildSplashLogo(context),
         *//* if (showWelcomeImage)
            _buildWelcomeScreen(context,address),*//*
          retry
              ? _buildRetrySection()
              : _buildLoadingIndicator(context),
          if (isOffline)
            _buildOfflineOverlay(connectivityResult),
        ],
      );
    });
  }

  *//*Widget _buildSplashLogo(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Center(
        child: Image.asset(
          'assets/images/login_bottom.png',
          width: MediaQuery.of(context).size.width * 0.65,
        ),
      ),
    );
  }*//*

  *//*Widget _buildWelcomeScreen(BuildContext context, String address) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          // Full-screen background image
          *//**//*Image.asset(
            'assets/images/welcome_bg_full_image.png', // Replace with your background image
            fit: BoxFit.cover,
          ),*//**//*

         *//**//* Lottie.asset(
            'assets/images/map_lottie_gif.json', // Replace with your background image
            fit: BoxFit.cover,
          ),*//**//*

          Lottie.asset(
              'assets/lottie/map_lottie_gif1.json',
             *//**//* width: displayWidth(context),
              height: displayHeight(context),*//**//*
               fit: BoxFit.cover,
            ),


          // Centered content
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Centered small image
             *//**//* Image.asset(
                'assets/images/welcome_logo.png', // Replace with your centered image
                width: 100,
                height: 100,
              ),*//**//*
              const SizedBox(height: 30),

              // Address below the image
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Text(
                  address,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.black,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }*//*

}

  Widget _buildLoadingScreen(BuildContext context) {
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

  Widget _buildRetrySection() {
    return Positioned(
      bottom: 150,
      child: Material(
        child: Column(
          children: [
            const Text(
              'Something Went Wrong',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            AppButton(
              textStyle: const TextStyle(color: Colors.white),
              label: 'Retry',
              onTap: () async {
                await Restart.restartApp();
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLoadingIndicator(BuildContext context) {
    return Positioned(
      bottom: 10,
      child: SizedBox(
        height: displayHeight(context) * 0.1,
        width: displayHeight(context) * 0.1,
        child: Lottie.asset('assets/lottie/loading_indicator.json',
            fit: BoxFit.contain),
      ),
    );
  }

  Widget _buildOfflineOverlay(List<ConnectivityResult> connectivityResults) {
    final isCompletelyOffline = connectivityResults.contains(ConnectivityResult.none);

    return AnimatedOpacity(
      opacity: isCompletelyOffline ? 1 : 0,
      duration: const Duration(milliseconds: 1000),
      curve: Curves.easeInOut,
      child: AnimatedScale(
        scale: isCompletelyOffline ? 1 : 0,
        duration: const Duration(milliseconds: 100),
        curve: Curves.easeInOut,
        child: const NoConnectionOverlay(),
      ),
    );
  }

  Future<void> _navigateBasedOnRole(isLoggedIn, BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? roles = prefs.getStringList('roleName');
    if (roles != null) {
      if (roles.contains('admin')) {
        Navigator.pushNamedAndRemoveUntil(
          context,
          AppRoutes.dashBoard,
              (route) => false,
        );
      } else if (roles.contains('sales')) {
        Navigator.pushNamedAndRemoveUntil(
          context,
          AppRoutes.dashBoard,
              (route) => false,
        );
      } else {
        Navigator.pushNamedAndRemoveUntil(
          context,
          AppRoutes.hrms,
              (route) => false,
        );
      }
    } else {
      Navigator.pushNamedAndRemoveUntil(
        context,
        AppRoutes.hrms,
            (route) => false,
      );
    }
  }

  Future<void> downloadDialog({
    required BuildContext context,
    required String downloaded,
    required String apkUrl,
    required SplashViewModel SplashViewModel,
  }) {
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
                try {
                  final Uri url = Uri.parse(apkUrl);
                  await launchUrl(url, mode: LaunchMode.externalApplication)
                      .then((value) {
                    Navigator.pop(context);
                  });
                } catch (e) {
                  ExceptionHandler().handleError(e);
                }
              },
              child: const Text("Download"),
            ),
          ),
        ],
      ),
    );
  }*/


class SplashScreen extends ConsumerStatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen> {
  late VideoPlayerController _controller;
  bool showLogo = true;


  @override
  void initState() {
    super.initState();
    //  _fetchAddress();
    // _startSplashSequence();
    _controller = VideoPlayerController.asset('assets/video/splash_new.mp4')
      ..initialize().then((_) {
        // Ensure the video starts playing when ready
        setState(() {
          _controller.play();
        });
      });
    _controller.setLooping(false); // Loop the video if needed

  }

  @override
  void dispose() {
    _controller.dispose(); // Dispose of the controller to free resources
    super.dispose();
  }


  @override
  Widget _buildSplashLogo(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SizedBox.expand(
            child: FittedBox(
              fit: BoxFit.cover,
              child: SizedBox(
                width: _controller.value.size?.width ?? 0,
                height: _controller.value.size?.height ?? 0,
                child: VideoPlayer(_controller),
              ),
            ),
          ),
          // Optional: Add overlay or logo

        ],
      ),
    );
  }


  @override
  Widget build(BuildContext context) {
    bool isOffline = false;
    // bool retry =false;
    final retry = ref.watch(restart);

    //  final versionCheck = ref.watch(versionViewModelProvider);
    return ConnectivityBuilder(builder: (_, conectivityresult) {
      isOffline = conectivityresult.contains(ConnectivityResult.none);
      if (isOffline == false) {
        final retryviewmodel = ref.read(restart.notifier);

        final asyncValue = ref.watch(splashViewModelProvider);
        final splashViewModel = ref.read(splashViewModelProvider.notifier);
        final downloaded = ref.watch(downloadProvider);
        if (kDebugMode) {
          log('asyncValue on splash: ${asyncValue.toString()}');
        }
        asyncValue.when(
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
                  }
                  else if (isLoggedIn.puntchStatus == null) {
                    retryviewmodel.state = true;
                  } else {
                    SharedPreferences prefs =
                    await SharedPreferences.getInstance();
                    List<String>? roles = prefs.getStringList('roleName');
                    if (kDebugMode) {
                      print(
                          'isLoggedIn.role- ${isLoggedIn.role} and roles-$roles ');
                    }

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
                      }
                      //  else if (roles.contains('creditPd')) {
                      //   log("Navigating to pd dashboard");
                      //   Navigator.pushNamedAndRemoveUntil(
                      //     context,
                      //     AppRoutes.pdscreen, // CIBIL dashboard route
                      //     (route) => false, // Remove all previous routes
                      //   );
                      // }
                      else if (roles.contains('collection')) {
                        log("Navigating to collection dashboard");
                        Navigator.pushNamedAndRemoveUntil(
                          context,
                          AppRoutes
                              .collectionHome, // Collection dashboard route
                              (route) => false, // Remove all previous routes
                        );
                      } else if (roles.contains('salesAndCollection')) {
                        log("Navigating to sales and collection dashboard");
                        Navigator.pushNamedAndRemoveUntil(
                          context,
                          AppRoutes
                              .dashBoard, // Sales and Collection dashboard route
                              (route) => false, // Remove all previous routes
                        );
                      } else if (roles.contains('salesPdAndCollection')) {
                        log("Navigating to sales PD and collection dashboard");
                        Navigator.pushNamedAndRemoveUntil(
                          context,
                          AppRoutes
                              .dashBoard, // Sales PD and Collection dashboard route
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


                  }
                } else {
                  Navigator.pushNamedAndRemoveUntil(
                    context,
                    AppRoutes.login, // Collection dashboard route
                        (route) => false, // Remove all previous routes
                  );
                }
              });

            },
            error: (error, stack) {
              print('error>>>>???? $error');
              // DioExceptions.fromDioError( error   , context);
              return Scaffold(
                body: Text('error $error'),
              );
            },
            loading: () => Container(

            ));

            /*loading: () => Container(
              color: Colors.white,
              child: Center(
                child: Image.asset(
                  'assets/images/login_bottom.png',
                  width: MediaQuery.of(context).size.width * 0.65,
                ),
              ),
            ));*/
      }

      return Stack(alignment: AlignmentDirectional.bottomCenter, children: [
        if (showLogo)
          _buildSplashLogo(context),
         /* Container(
            color: Colors.white,
            child: Center(
              child: Image.asset(
                'assets/images/login_bottom.png',
                width: MediaQuery.of(context).size.width * 0.65,
              ),
            ),
          ),*/
        retry
            ? Positioned(
          bottom: 150,
          child: Material(
            child: Column(
              children: [
                const Text(
                  'Something Went Wrong',
                  style: TextStyle(
                      fontSize: 18, fontWeight: FontWeight.bold),
                ),
                AppButton(
                  textStyle: const TextStyle(color: Colors.white),
                  label: 'Retry',
                  onTap: () async{
                    await Restart.restartApp( );
                    // Restart.restartApp(
                    //   notificationTitle: 'Restarting App',
                    //   notificationBody:
                    //       'Please tap here to open the app again.',
                    // );
                  },
                )
              ],
            ),
          ),
        )
            : Positioned(
          bottom: 10,
          child: SizedBox(
            height: displayHeight(context) * 0.1,
            width: displayHeight(context) * 0.1,
            child: Lottie.asset('assets/lottie/loading_indicator.json',
                fit: BoxFit.contain),
          ),
        ),
        if (isOffline)
          AnimatedOpacity(
              opacity:
              (conectivityresult.contains(ConnectivityResult.none)) ? 1 : 0,
              duration: const Duration(milliseconds: 1000),
              curve: Curves.easeInOut,
              child: AnimatedScale(
                scale: (conectivityresult.contains(ConnectivityResult.none))
                    ? 1
                    : 0,
                duration: const Duration(milliseconds: 100),
                curve: Curves.easeInOut,
                child: const NoConnectionOverlay(),
              ))
      ]);
    });
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
                try {
                  final Uri url = Uri.parse(apkUrl);
                  await launchUrl(url, mode: LaunchMode.externalApplication)
                      .then(
                        (value) {
                      Navigator.pop(context);
                    },
                  );
                } catch (e) {
                  ExceptionHandler().handleError(e);
                }
                // _downloadFile(context,state.apkUrl!,'');
                // downloadApk(state.apkUrl!);
              },
              child: const Text("Download"),
            ),
          ),
        ],
      ),
    );
  }
}

/*
class SplashScreen extends ConsumerWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    bool isOffline = false;
    // bool retry =false;
    final retry = ref.watch(restart);

    //  final versionCheck = ref.watch(versionViewModelProvider);
    return ConnectivityBuilder(builder: (_, conectivityresult) {
      isOffline = conectivityresult.contains(ConnectivityResult.none);
      if (isOffline == false) {
        final retryviewmodel = ref.read(restart.notifier);

        final asyncValue = ref.watch(splashViewModelProvider);
        final splashViewModel = ref.read(splashViewModelProvider.notifier);
        final downloaded = ref.watch(downloadProvider);
        if (kDebugMode) {
          log('asyncValue on splash: ${asyncValue.toString()}');
        }
        asyncValue.when(
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
                  }
                  else if (isLoggedIn.puntchStatus == null) {
                    retryviewmodel.state = true;
                  } else {
                    SharedPreferences prefs =
                    await SharedPreferences.getInstance();
                    List<String>? roles = prefs.getStringList('roleName');
                    if (kDebugMode) {
                      print(
                          'isLoggedIn.role- ${isLoggedIn.role} and roles-$roles ');
                    }

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
                      }
                      //  else if (roles.contains('creditPd')) {
                      //   log("Navigating to pd dashboard");
                      //   Navigator.pushNamedAndRemoveUntil(
                      //     context,
                      //     AppRoutes.pdscreen, // CIBIL dashboard route
                      //     (route) => false, // Remove all previous routes
                      //   );
                      // }
                      else if (roles.contains('collection')) {
                        log("Navigating to collection dashboard");
                        Navigator.pushNamedAndRemoveUntil(
                          context,
                          AppRoutes
                              .collectionHome, // Collection dashboard route
                              (route) => false, // Remove all previous routes
                        );
                      } else if (roles.contains('salesAndCollection')) {
                        log("Navigating to sales and collection dashboard");
                        Navigator.pushNamedAndRemoveUntil(
                          context,
                          AppRoutes
                              .dashBoard, // Sales and Collection dashboard route
                              (route) => false, // Remove all previous routes
                        );
                      } else if (roles.contains('salesPdAndCollection')) {
                        log("Navigating to sales PD and collection dashboard");
                        Navigator.pushNamedAndRemoveUntil(
                          context,
                          AppRoutes
                              .dashBoard, // Sales PD and Collection dashboard route
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


                  }
                } else {
                  Navigator.pushNamedAndRemoveUntil(
                    context,
                    AppRoutes.login, // Collection dashboard route
                        (route) => false, // Remove all previous routes
                  );
                }
              });

            },
            error: (error, stack) {
              print('error>>>>???? $error');
              // DioExceptions.fromDioError( error   , context);
              return Scaffold(
                body: Text('error $error'),
              );
            },
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

      return Stack(alignment: AlignmentDirectional.bottomCenter, children: [
        if (showLogo)
          Container(
            color: Colors.white,
            child: Center(
              child: Image.asset(
                'assets/images/login_bottom.png',
                width: MediaQuery.of(context).size.width * 0.65,
              ),
            ),
          ),
        retry
            ? Positioned(
          bottom: 150,
          child: Material(
            child: Column(
              children: [
                const Text(
                  'Something Went Wrong',
                  style: TextStyle(
                      fontSize: 18, fontWeight: FontWeight.bold),
                ),
                AppButton(
                  textStyle: const TextStyle(color: Colors.white),
                  label: 'Retry',
                  onTap: () async{
                    await Restart.restartApp( );
                    // Restart.restartApp(
                    //   notificationTitle: 'Restarting App',
                    //   notificationBody:
                    //       'Please tap here to open the app again.',
                    // );
                  },
                )
              ],
            ),
          ),
        )
            : Positioned(
          bottom: 10,
          child: SizedBox(
            height: displayHeight(context) * 0.1,
            width: displayHeight(context) * 0.1,
            child: Lottie.asset('assets/lottie/loading_indicator.json',
                fit: BoxFit.contain),
          ),
        ),
        if (isOffline)
          AnimatedOpacity(
              opacity:
              (conectivityresult.contains(ConnectivityResult.none)) ? 1 : 0,
              duration: const Duration(milliseconds: 1000),
              curve: Curves.easeInOut,
              child: AnimatedScale(
                scale: (conectivityresult.contains(ConnectivityResult.none))
                    ? 1
                    : 0,
                duration: const Duration(milliseconds: 100),
                curve: Curves.easeInOut,
                child: const NoConnectionOverlay(),
              ))
      ]);
    });
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
                try {
                  final Uri url = Uri.parse(apkUrl);
                  await launchUrl(url, mode: LaunchMode.externalApplication)
                      .then(
                        (value) {
                      Navigator.pop(context);
                    },
                  );
                } catch (e) {
                  ExceptionHandler().handleError(e);
                }
                // _downloadFile(context,state.apkUrl!,'');
                // downloadApk(state.apkUrl!);
              },
              child: const Text("Download"),
            ),
          ),
        ],
      ),
    );
  }
}*/
