import 'dart:async';
import 'dart:developer';
import 'dart:io';
import 'package:finexe/feature/base/dialog/all_permission_dialog.dart';
import 'package:finexe/feature/base/utils/namespase/app_colors.dart';
import 'package:finexe/feature/base/utils/namespase/app_style.dart';
import 'package:finexe/feature/base/utils/namespase/font_size.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../base/routes/routes.dart';
import '../../../base/utils/namespase/display_size.dart';
import '../../../base/utils/widget/app_text_field.dart';
import '../../../base/utils/widget/app_text_filed_login.dart';
import '../view_model/login_view_model.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:app_settings/app_settings.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final DeviceInfoPlugin info = DeviceInfoPlugin();
  bool isLoggedIn = false;

  @override
  void initState() {
    // WidgetsBinding.instance
    //     .addPersistentFrameCallback((_) => _requestPermissions(context));
    super.initState();
    permit(); // Call the asynchronous method
  }

  Future<void> permit() async {
    log('checking permission');
    await _requestPermissions(context); // Your async work here
  }

  void startTokenExpiryTimer() {
    Timer(const Duration(hours: 12), removeToken);
  }

  Future<void> removeToken() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('token');
    // Optionally, handle token expiry UI update
    print("Token has been removed after 12 hours");
  }

  @override
  Widget build(BuildContext context) {
    log('isLoggedIn: ' + isLoggedIn.toString());
    // final checkPunchProvider = ref.watch(attendanceProvider);
    final isChecked = ref.watch(isRememberMeCheckedProvider);
    final checkUsernameValidation = ref.read(userValidationProvider.notifier);
    final checkPassValidation = ref.read(passwordValidationProvider.notifier);

    final focusStates = ref.watch(dualFocusProvider);
    final focusViewModel = ref.read(dualFocusProvider.notifier);
    final loginState = ref.watch(loginViewModelProvider);
    final loginStateViewModel = ref.read(loginViewModelProvider.notifier);
    //final selectedValue = ref.watch(radioProvider);
    final obscureValue = ref.watch(obscureTextProvider);
    final passwordValidations = ref.watch(passwordValidationProvider);
    final userValidations = ref.watch(userValidationProvider);
    log('loginState.isLoading:: ' + loginState.isLoading.toString());
    bool isRememberMeChecked = false;
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Container(
          width: displayWidth(context),
          decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/images/login_back.png'),
                  fit: BoxFit.fill)),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              // autovalidateMode: AutovalidateMode.onUserInteraction,
              key: _formKey,
              child: SizedBox(
                width: displayWidth(context),
                height: displayHeight(context),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: displayHeight(context) * 0.05,
                    ),
                    Container(
                      alignment: Alignment.center,
                      margin:
                          EdgeInsets.only(left: displayWidth(context) * 0.3),
                      height: displayHeight(context) * 0.15,
                      width: displayWidth(context) * 0.30,
                      // decoration: const BoxDecoration(
                      child: Image.asset('assets/images/login_logo.png'),
                    ),
                    SizedBox(
                      height: displayHeight(context) * 0.04,
                    ),
                    const Text(
                      'User Name',
                      //style: AppStyles.headingTextStyleXL,
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                      ),
                    ),
                    AppTextField(
                      onChange: (value) {
                        checkUsernameValidation.checkUsername(value);
                      },
                      // initialValue: 'dfgbfgbnx',
                      // focusNode: focusViewModel.userFocusNode,
                      // currentState: focusStates['userFocusNode'],
                      // focusNode: ,
                      // inerHint: 'Enter your user name',
                      height: userValidations
                          ? displayHeight(context) * 0.09
                          : null,
                      onFiledSubmitted: (value) {
                        log('onFiledSubmitted');
                        ref
                            .read(userValidationProvider.notifier)
                            .checkUsername(value.toString());
                      },
                      onValidate: (value) {
                        print(value);
                        if (value!.trim().isEmpty) {
                          return "username is a required field";
                        }
                        return '';
                      },
                      errorText: "username is a required field",
                      isError: userValidations,
                      controller: _emailController,
                      textInputAction: TextInputAction.next,
                    ),
                    SizedBox(height: displayHeight(context) * 0.02),
                    const Text(
                      'Password',
                      //style: AppStyles.headingTextStyleXL,
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                      ),
                    ),
                    AppTextField(
                      onChange: (value) {
                        checkPassValidation.checkPassword(value);
                      },
                      // initialValue: 'cvfcfbcvb',
                      // maxLine: 1,
                      // focusNode: focusViewModel.passFocusNode,
                      // currentState: focusStates['passFocusNode'],
                      height: passwordValidations
                          ? displayHeight(context) * 0.09
                          : null,
                      // focusNode: FocusNode(),
                      onValidate: (value) {
                        print(value);
                        if (value!.isEmpty) {
                          return "password is a required field";
                        }
                        return '';
                      },
                      onFiledSubmitted: (value) {
                        ref
                            .read(passwordValidationProvider.notifier)
                            .checkPassword(value);
                      },
                      // inerHint: 'Password',
                      errorText: "password is a required field",
                      isError: passwordValidations,
                      textInputAction: TextInputAction.next,
                      isSuffix: true,
                      obscureText: obscureValue,
                      suffixIcon: obscureValue
                          ? CupertinoIcons.eye_slash
                          : CupertinoIcons.eye,
                      suffixOnTap: () {
                        if (obscureValue != true) {
                          ref.read(obscureTextProvider.notifier).state = true;
                        } else {
                          ref.read(obscureTextProvider.notifier).state = false;
                        }
                      },
                      // hint: 'Password',
                      controller: _passwordController,
                    ),
                    Row(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Checkbox(
                                  value: isChecked,
                                  onChanged: (value) {
                                    print(isChecked);
                                    // Update the state using the provider
                                    ref
                                        .read(isRememberMeCheckedProvider
                                            .notifier)
                                        .state = value!;
                                  },
                                  side: const BorderSide(
                                    color: Colors.blue, // Blue border
                                    width: 2.0,
                                  ),
                                ),
                                const Text(
                                  "Remember me",
                                  style: TextStyle(
                                      fontSize: 16.0, color: Colors.blue),
                                ),
                              ],
                            ),
                            SizedBox(
                              width: displayWidth(context) * 0.05,
                            ),
                            TextButton(
                              onPressed: () {
                                // Navigate to the Forgot Password screen
                                print("Forgot Password tapped");
                              },
                              child: const Text(
                                "Forgot Password?",
                                style: TextStyle(
                                  fontSize: 16.0,
                                  color: Colors.blue,
                                  //decoration: TextDecoration.underline,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: displayHeight(context) * 0.04),
                    SizedBox(
                      height: displayHeight(context) * 0.06,
                      width: displayWidth(context),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.only(top: 10, bottom: 10),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        onPressed: () async {
                          // SharedPreferences preferences =
                          //     await SharedPreferences.getInstance();

                          final user = _emailController.text.isEmpty;
                          final pass = _passwordController.text.isEmpty;
                          if (user || pass) {
                            ref
                                .read(userValidationProvider.notifier)
                                .checkUsername(_emailController.text);
                            ref
                                .read(passwordValidationProvider.notifier)
                                .checkPassword(_passwordController.text);
                          } else {
                            loginStateViewModel.clickPunchInButton(
                                context: context,
                                email: _emailController.text.trim(),
                                password: _passwordController.text.trim(),
                                ref: ref);
                          }
                        },
                        child: loginState.isLoading
                            ? Center(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const SizedBox(
                                      width: 24, // Specify the width
                                      height: 24, // Specify the height
                                      child: CircularProgressIndicator(
                                        color: Colors.white,
                                        strokeWidth: 3,
                                        key: ValueKey(
                                            'loading'), // Key for progress indicator
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Text(
                                      'please wait..',
                                      style: AppStyles.smallTextStyleRich
                                          .copyWith(
                                              color: AppColors.white,
                                              fontSize: FontSize.fontSize16,
                                              fontWeight: FontWeight.w500),
                                    )
                                  ],
                                ),
                              )
                            : const Text(
                                'Login',
                                style: TextStyle(color: Colors.white),
                              ),
                      ),
                    ),
                    const Spacer(),
                    Container(
                      alignment: Alignment.center,
                      child: const Text('All Rights Reserved By',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.w400,
                              color: Color(0xff999999))),
                    ),
                    Container(
                      height: displayHeight(context) * 0.05,
                      width: displayWidth(context) * 0.4,
                      alignment: Alignment.center,
                      margin:
                          EdgeInsets.only(left: displayWidth(context) * 0.25),
                      child: Image.asset(
                        'assets/images/login_bottom.png',
                        fit: BoxFit.cover,
                        //  alignment: Alignment.center,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _requestPermissions(BuildContext context) async {
    // SharedPreferences preferences = await SessionService.getSession();
    if (await _checkPermissionStatus()) {
      log('_checkPermissionStatus>');
      AllPermissionDialog().allPermissionDialog(
          context: context,
          // controller: this,
          text: 'Permission required',
          icon: CupertinoIcons.bell_fill,
          height: 250,
          colors: Colors.blue,
          onButtonPressed: () {
            _getPermission();
          });
    } else {
      log('LLLLLL');
      // await _getCurrentLocation();
      // loadImages();
      // await _voskServiceInitialize();
      // WidgetsFlutterBinding.ensureInitialized();
      // if (!(preferences.containsKey('status'))) {
      //   await BackgroundService().initializeService();
      // }
      // await checkPath();
    }
  }

  Future<bool> _checkPermissionStatus() async {
    if (Platform.isAndroid) {
      final AndroidDeviceInfo androidInfo = await info.androidInfo;

      // Handle null safety for androidInfo fields
      final String? releaseVersion = androidInfo.version.release;
      if (releaseVersion != null) {
        final int androidVersion = int.parse(releaseVersion);

        if (androidVersion >= 13) {
          return await Permission.camera.status.isDenied ||
              await Permission.locationWhenInUse.status.isDenied ||
              await Permission.microphone.status.isDenied ||
              await Permission.videos.status.isDenied ||
              await Permission.photos.status.isDenied ||
              await Permission.systemAlertWindow.status.isDenied;
        } else {
          return await Permission.camera.status.isDenied ||
              await Permission.locationWhenInUse.status.isDenied ||
              await Permission.microphone.status.isDenied ||
              await Permission.storage.status.isDenied ||
              await Permission.systemAlertWindow.status.isDenied;
        }
      } else {
        debugPrint('Release version is null');
        return false; // Handle the case where release version is null
      }
    } else {
      // log();
      return await Permission.camera.status.isDenied ||
          await Permission.locationWhenInUse.status.isDenied ||
          await Permission.microphone.status.isDenied ||
          await Permission.storage.status.isDenied;
    }
  }

  Future<void> _getPermission() async {
    // import 'package:device_info_plus/device_info_plus.dart';
    if (Platform.isAndroid) {
      final AndroidDeviceInfo androidInfo = await info.androidInfo;
      debugPrint('releaseVersion : ${androidInfo.version.release}');
      final int androidVersion = int.parse(androidInfo.version.release);
      if (androidVersion >= 13) {
        await [
          Permission.microphone,
          Permission.camera,
          Permission.locationWhenInUse,
          Permission.videos,
          Permission.photos,
          Permission.systemAlertWindow
        ].request().then((value) async {
          if (kDebugMode) {
            print('permission status first processes  $value');
          }
          await _handlePermissions(value, true);
          // getStoragePermission();
        });
      } else {
        await [
          Permission.microphone,
          Permission.camera,
          Permission.locationWhenInUse,
          Permission.storage,
          Permission.systemAlertWindow
          //add more permission to request here.
        ].request().then((value) async {
          if (kDebugMode) {
            print('permission status first processes  $value');
          }
          await _handlePermissions(value, true);
        });
      }
    } else {
      await [
        Permission.microphone,
        Permission.camera,
        Permission.locationWhenInUse,
        Permission.storage,
        // Permission.notification,
        // Permission.systemAlertWindow
        //add more permission to request here.
      ].request().then((value) async {
        if (kDebugMode) {
          print('permission status first processes  $value');
        }
        await _handlePermissions(value, true);
      });
    }
  }

  Future<void> _handlePermissions(
      Map<Permission, PermissionStatus> statuses, bool check) async {
    List<Permission> deniedPermissions = [];
    List<Permission> permanentlyDeniedStatus = [];
    statuses.forEach((permission, status) {
      if (kDebugMode) {
        print('permission:- $permission $status');
      }
      if (status.isDenied || status.isLimited || status.isRestricted) {
        if (check) {
          if (kDebugMode) {
            print('======= permission status is isDenied ========');
          }
          deniedPermissions.add(permission);
        } else {
          if (kDebugMode) {
            print('======= permission status is permanentlyDenied ========');
          }
          permanentlyDeniedStatus.add(permission);
        }
      } else if (status.isPermanentlyDenied) {
        permanentlyDeniedStatus.add(permission);
        if (kDebugMode) {
          print('after openAppSetting');
        }
        return;
      }
    });

    if (deniedPermissions.isNotEmpty || permanentlyDeniedStatus.isNotEmpty) {
      if (kDebugMode) {
        print('permissions.isNotEmpty  ${deniedPermissions.isNotEmpty}');
        print(
            'permanentlyDeniedStatus.isNotEmpty  ${permanentlyDeniedStatus.isNotEmpty}');
      }

      await reRequestPermissions(deniedPermissions, permanentlyDeniedStatus);
    } else {
      // await _getCurrentLocation();
      // await loadImages();
      // _voskServiceInitialize();
      // WidgetsFlutterBinding.ensureInitialized();
      // await BackgroundService().initializeService();
      if (kDebugMode) {
        print("All permissions granted!");
      }
    }
  }

  Future<void> reRequestPermissions(List<Permission> permissions,
      List<Permission> permanentlyDeniedStatus) async {
    if (permissions.isNotEmpty) {
      if (kDebugMode) {
        print('denied dialog call');
      }
      AllPermissionDialog().allPermissionDialog(
          context: context,
          //  controller: this,
          text: 'Permission Denied',
          icon: Icons.warning,
          height: 250,
          colors: Colors.red,
          onButtonPressed: () {
            if (kDebugMode) {
              print('permissionDeniedFunction');
            }
            permissionDeniedFunction(permissions);
          });
    } else if (permanentlyDeniedStatus.isNotEmpty) {
      if (kDebugMode) {
        print('permanentlyDenied dialog call');
      }
      log('Permission Permanently Denied');
      AllPermissionDialog()
          .allPermissionDialog(
              context: context,
              // controller: this,
              text: 'Permission Permanently Denied',
              icon: Icons.warning,
              height: 250,
              colors: Colors.red,
              onButtonPressed: () => {})
          .then((value) {
        permanentlyDeniedCallFunction(permanentlyDeniedStatus);
      });
    }
    // Handle new statuses
  }

  Future<void> permissionDeniedFunction(List<Permission> permissions) async {
    Map<Permission, PermissionStatus> newStatuses =
        await permissions.request().then((value) async {
      if (kDebugMode) {
        print('== value == $value');
      }
      await _handlePermissions(value, false);
      return value;
    });
    if (kDebugMode) {
      print(" ===== newStatuses $newStatuses ");
    }
  }

  void permanentlyDeniedCallFunction(List<Permission> permanentlyDeniedStatus) {
    AppSettings.openAppSettings().then((value) {
      checkPermanentlyDeniedStatus(permanentlyDeniedStatus);
    });
    Fluttertoast.showToast(msg: 'Permission Permanently Denied');
  }

  Future<void> checkPermanentlyDeniedStatus(
      List<Permission> permanentlyDeniedStatus) async {
    Map<Permission, PermissionStatus> statuses =
        await permanentlyDeniedStatus.request();
    if (kDebugMode) {
      print(
          'check permanent denied statuses $permanentlyDeniedStatus : $statuses');
    }
    await _handlePermissions(statuses, false);
  }
}

Widget radio(
    {required BuildContext context,
    required Role selectedValue,
    required WidgetRef ref,
    required String title,
    required Role value}) {
  return SizedBox(
    width: MediaQuery.of(context).size.width * 0.30,
    child: Row(
      children: [
        Radio<Role>(
          value: value,
          groupValue: selectedValue,
          onChanged: (value) {
            if (value != null) {
              ref.read(radioProvider.notifier).select(value);
            }
          },
        ),
        Text(
          title,
        )
      ],
    ),
  );
}
