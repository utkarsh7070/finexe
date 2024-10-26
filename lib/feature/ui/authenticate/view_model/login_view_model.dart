import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:finexe/feature/base/api/api.dart';
import 'package:finexe/feature/base/api/dio.dart';
import 'package:finexe/feature/base/service/session_service.dart';
import 'package:finexe/feature/ui/authenticate/model/login_request_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../Punch_In_Out/model/check_attendance_responce_model.dart';
import '../../../Punch_In_Out/repository/puch_In_repository_imp.dart';
import '../../../base/api/dio_exception.dart';
import '../../../base/routes/routes.dart';
import '../model/login_response_model.dart';

final radioProvider = StateNotifierProvider<RadioNotifier, Role>((ref) {
  return RadioNotifier();
});

final userValidationProvider =
    StateNotifierProvider<UserValidationNotifier, bool>(
  (ref) {
    return UserValidationNotifier();
  },
);
final passwordValidationProvider =
    StateNotifierProvider<PasswordValidationNotifier, bool>(
  (ref) {
    return PasswordValidationNotifier();
  },
);

final dualFocusProvider =
    StateNotifierProvider<FocusViewModel, Map<String, bool>>((ref) {
  return FocusViewModel();
});

final obscureTextProvider = StateProvider<bool>(
  (ref) {
    return false;
  },
);
final loginViewModelProvider =
    StateNotifierProvider<LoginViewModel, AsyncValue<DataModel>>((ref) {
  final punchInRepository = ref.watch(punchInRepositoryProvider);
  final dio = ref.read(dioProvider);
  return LoginViewModel(
      AsyncValue.data(DataModel(loginStatus: '', checkPunch: false, role: '')),
      dio,
      punchInRepository);
});

// final permissionProvider =
//     StateNotifierProvider<PermissionNotifier, PermissionState>(
//   (ref) => PermissionNotifier(),
// );

// class PermissionNotifier extends StateNotifier<PermissionState> {
//   PermissionNotifier() : super(PermissionState.initial()) {
//     requestPermissions();
//   }
// Future<void> requestPermissions() async {
//     // Simulating SharedPreferences
//     // SharedPreferences preferences = await SessionService.getSession();
//     if (await _checkPermissionStatus()) {
//       state = state.copyWith(
//         isPermissionDenied: true,
//         dialogVisible: true,
//       );
//       // Show permission dialog (adjust accordingly)

//       AllPermissionDialog().allPermissionDialog(
//         context: Get.context!, // Ensure context handling correctly
//        // controller: this, // Or pass necessary state reference
//         text: 'Permission required',
//         icon: CupertinoIcons.bell_fill,
//         height: 250,
//         colors: Colors.blue,
//         onButtonPressed: () {
//           _getPermission();
//         },
//       );
//     } else {
//       // Execute your additional tasks when permission is granted
//       // Example:
//       // await _getCurrentLocation();
//       // loadImages();
//       // await _voskServiceInitialize();
//     }
//   }

//  Future<bool> _checkPermissionStatus() async {
//     if (Platform.isAndroid) {
//       final AndroidDeviceInfo androidInfo = await info.androidInfo;
//       debugPrint('releaseVersion : ${androidInfo.version.release}');
//       final int androidVersion = int.parse(androidInfo.version.release);

//       if (androidVersion >= 13) {
//         return await Permission.camera.status.isDenied ||
//             await Permission.locationWhenInUse.status.isDenied ||
//             await Permission.microphone.status.isDenied ||
//             await Permission.videos.status.isDenied ||
//             await Permission.photos.status.isDenied ||
//             await Permission.systemAlertWindow.status.isDenied;
//       } else {
//         return await Permission.camera.status.isDenied ||
//             await Permission.locationWhenInUse.status.isDenied ||
//             await Permission.microphone.status.isDenied ||
//             await Permission.storage.status.isDenied ||
//             await Permission.systemAlertWindow.status.isDenied;
//       }
//     } else {
//       return await Permission.camera.status.isDenied ||
//               await Permission.locationWhenInUse.status.isDenied ||
//               await Permission.microphone.status.isDenied ||
//               await Permission.storage.status.isDenied
//           // ||
//           // await Permission.systemAlertWindow.status.isDenied
//           // ||
//           // await Permission.notification.status.isDenied
//           ;
//     }
//   }

//  Future<void> _getPermission() async {
//     // import 'package:device_info_plus/device_info_plus.dart';
//     if (Platform.isAndroid) {
//       final AndroidDeviceInfo androidInfo = await info.androidInfo;
//       debugPrint('releaseVersion : ${androidInfo.version.release}');
//       final int androidVersion = int.parse(androidInfo.version.release);
//       if (androidVersion >= 13) {
//         await [
//           Permission.microphone,
//           Permission.camera,
//           Permission.locationWhenInUse,
//           Permission.videos,
//           Permission.photos,
//           Permission.systemAlertWindow
//         ].request().then((value) async {
//           if (kDebugMode) {
//             print('permission status first processes  $value');
//           }
//           await _handlePermissions(value, true);
//           // getStoragePermission();
//         });
//       } else {
//         await [
//           Permission.microphone,
//           Permission.camera,
//           Permission.locationWhenInUse,
//           Permission.storage,
//           Permission.systemAlertWindow
//           //add more permission to request here.
//         ].request().then((value) async {
//           if (kDebugMode) {
//             print('permission status first processes  $value');
//           }
//           await _handlePermissions(value, true);
//         });
//       }
//     } else {
//       await [
//         Permission.microphone,
//         Permission.camera,
//         Permission.locationWhenInUse,
//         Permission.storage,
//         // Permission.notification,
//         // Permission.systemAlertWindow
//         //add more permission to request here.
//       ].request().then((value) async {
//         if (kDebugMode) {
//           print('permission status first processes  $value');
//         }
//         await _handlePermissions(value, true);
//       });
//     }
//   }

//   Future<void> _handlePermissions(
//       Map<Permission, PermissionStatus> statuses, bool check) async {
//     List<Permission> deniedPermissions = [];
//     List<Permission> permanentlyDeniedStatus = [];
//     statuses.forEach((permission, status) {
//       if (kDebugMode) {
//         print('permission:- $permission $status');
//       }
//       if (status.isDenied || status.isLimited || status.isRestricted) {
//         if (check) {
//           if (kDebugMode) {
//             print('======= permission status is isDenied ========');
//           }
//           deniedPermissions.add(permission);
//         } else {
//           if (kDebugMode) {
//             print('======= permission status is permanentlyDenied ========');
//           }
//           permanentlyDeniedStatus.add(permission);
//         }
//       } else if (status.isPermanentlyDenied) {
//         permanentlyDeniedStatus.add(permission);
//         if (kDebugMode) {
//           print('after openAppSetting');
//         }
//         return;
//       }
//     });

//     if (deniedPermissions.isNotEmpty || permanentlyDeniedStatus.isNotEmpty) {
//       if (kDebugMode) {
//         print('permissions.isNotEmpty  ${deniedPermissions.isNotEmpty}');
//         print(
//             'permanentlyDeniedStatus.isNotEmpty  ${permanentlyDeniedStatus.isNotEmpty}');
//       }

//       await reRequestPermissions(deniedPermissions, permanentlyDeniedStatus);
//     } else {
//       // await _getCurrentLocation();
//       // await loadImages();
//       // _voskServiceInitialize();
//       // WidgetsFlutterBinding.ensureInitialized();
//       // await BackgroundService().initializeService();
//       if (kDebugMode) {
//         print("All permissions granted!");
//       }
//     }
//   }

//     Future<void> reRequestPermissions(List<Permission> permissions,
//       List<Permission> permanentlyDeniedStatus) async {
//     if (permissions.isNotEmpty) {
//       if (kDebugMode) {
//         print('denied dialog call');
//       }
//       AllPermissionDialog().allPermissionDialog(
//           context: Get.context!,
//          // controller: this,
//           text: 'Permission Denied',
//           icon: Icons.warning,
//           height: 250,
//           colors: Colors.red,
//           onButtonPressed: () {
//             if (kDebugMode) {
//               print('permissionDeniedFunction');
//             }
//             permissionDeniedFunction(permissions);
//           });
//     } else if (permanentlyDeniedStatus.isNotEmpty) {
//       if (kDebugMode) {
//         print('permanentlyDenied dialog call');
//       }
//       AllPermissionDialog()
//           .allPermissionDialog(
//               context: Get.context!,
//               controller: this,
//               text: 'Permission Permanently Denied',
//               icon: Icons.warning,
//               height: 250,
//               colors: Colors.red,
//               onButtonPressed: () => {})
//           .then((value) {
//         permanentlyDeniedCallFunction(permanentlyDeniedStatus);
//       });
//     }
//     // Handle new statuses
//   }

//   void permanentlyDeniedCallFunction(List<Permission> permanentlyDeniedStatus) {
//     AppSettings.openAppSettings().then((value) {
//       checkPermanentlyDeniedStatus(permanentlyDeniedStatus);
//     });
//     Fluttertoast.showToast(msg: 'Permission Permanently Denied');
//   }

//   Future<void> permissionDeniedFunction(List<Permission> permissions) async {
//     Map<Permission, PermissionStatus> newStatuses =
//         await permissions.request().then((value) async {
//       if (kDebugMode) {
//         print('== value == $value');
//       }
//       await _handlePermissions(value, false);
//       return value;
//     });
//     if (kDebugMode) {
//       print(" ===== newStatuses $newStatuses ");
//     }
//   }

//    Future<void> checkPermanentlyDeniedStatus(
//       List<Permission> permanentlyDeniedStatus) async {
//     Map<Permission, PermissionStatus> statuses =
//         await permanentlyDeniedStatus.request();
//     if (kDebugMode) {
//       print(
//           'check permanent denied statuses $permanentlyDeniedStatus : $statuses');
//     }
//     await _handlePermissions(statuses, false);
//   }

// }

class FocusViewModel extends StateNotifier<Map<String, bool>> {
  final FocusNode userFocusNode;
  final FocusNode passFocusNode;

  FocusViewModel()
      : userFocusNode = FocusNode(),
        passFocusNode = FocusNode(),
        super({
          'userFocusNode': false,
          'passFocusNode': false,
        }) {
    userFocusNode
        .addListener(() => _focusListener('userFocusNode', userFocusNode));
    passFocusNode
        .addListener(() => _focusListener('passFocusNode', passFocusNode));
  }

  void _focusListener(String field, FocusNode focusNode) {
    state = {
      ...state,
      field: focusNode.hasFocus,
    };
  }

  @override
  void dispose() {
    userFocusNode
        .removeListener(() => _focusListener('userFocusNode', userFocusNode));
    passFocusNode
        .removeListener(() => _focusListener('passFocusNode', passFocusNode));
    userFocusNode.dispose();
    passFocusNode.dispose();
    super.dispose();
  }
}

class LoginViewModel extends StateNotifier<AsyncValue<DataModel>> {
  final PunchInRepositoryImp _punchInRepository;
  final Dio dio;

  //final bool isLoading;
  LoginViewModel(super.state, this.dio, this._punchInRepository);

  bool? isLoading = false;
  bool? punchStatus = false;

  Future<void> clickPunchInButton(
      {required BuildContext context,required String email,required String password}) async {
  await login(email,password).then((value) {
    if(value){
      if(!state.value!.checkPunch){
        switch (state.value!.role) {
          case 'admin':
            log("Navigating to admin dashboard");

            Navigator.pushNamedAndRemoveUntil(
              context,
              AppRoutes
                  .dashBoard, // Admin dashboard route
                  (route) =>
              false, // Remove all previous routes
            );

            break;
          case 'sales':
            log("Navigating to sales dashboard");
            Navigator.pushNamedAndRemoveUntil(
              context,
              AppRoutes
                  .saleApplicationForm, // Sales dashboard route
                  (route) =>
              false, // Remove all previous routes
            );
            break;
          case 'collection':
            log("Navigating to collection dashboard");
            Navigator.pushNamedAndRemoveUntil(
              context,
              AppRoutes
                  .collectionHome, // Collection dashboard route
                  (route) =>
              false, // Remove all previous routes
            );
            break;
          default:
          // Handle unknown roles or navigate to a default screen
            log('No matching role found');
            break;
        }
      }else{
        Navigator.pushNamedAndRemoveUntil(context, AppRoutes.attendance, (route) => false,);
      }
    }
  },);


  }


  Future<bool> login(String email, String password) async {
    isLoading = true;
    LoginRequestModel loginRequestModel =
        LoginRequestModel(userName: email, password: password);
    // Set state to loading
    state = const AsyncValue.loading();

    try {
      final response =
          await dio.post(Api.login, data: loginRequestModel.toJson());

      if (response.statusCode == 200) {
        //--------------- ------------------------cm xckv;sd ,.c vs,.d
        isLoading = false;

        // Parse the response and save the session data
        LoginResponseModel loginResponseModel =
            LoginResponseModel.fromJson(response.data);

        log('response:: ' + response.data.toString());
        log('role:: ' + loginResponseModel.items.roleName.toString());

        // Create session after login
        SessionService.createSession(
            accessToken: loginResponseModel.items.token,
            employeeId: loginResponseModel.items.employeId,
            name: loginResponseModel.items.roleName,
            email: loginResponseModel.items.userName,
            role: loginResponseModel.items.roleName);
        bool punchStatus = await punchStatusFunction(_punchInRepository, loginResponseModel.items.token, loginResponseModel.items.roleName);
        // Update state to indicate success
        state = AsyncValue.data(DataModel(
            checkPunch: punchStatus,
            loginStatus: 'Sucsses',
            role: loginResponseModel.items.roleName));

        return true; // Return true here to indicate success
      } else {
        // If status code is not 200, set state to error
        isLoading = false;
        state = AsyncValue.error(
            'Login failed with status: ${response.statusCode}',
            StackTrace.current);
        return false;
      }
    } catch (error, stackTrace) {
      // Handle exceptions and set state to error
      isLoading = false;
      state = AsyncValue.error(error, stackTrace);
      return false;
    }
  }
}

class DataModel {
  final String loginStatus;
  final String role;
  final bool checkPunch;

  DataModel(
      {required this.loginStatus,
      required this.checkPunch,
      required this.role});
}

class RadioNotifier extends StateNotifier<Role> {
  RadioNotifier() : super(Role.Employee); // Default value for the radio buttons

  // Method to update the selected value
  void select(Role value) {
    state = value;
  }
}

class UserValidationNotifier extends StateNotifier<bool> {
  UserValidationNotifier()
      : super(false); // Default value for the radio buttons

  void checkUsername(value) {
    if (value == '' || value.isEmpty) {
      state = true;
      // return true;
    } else {
      state = false;
    }
  }
// Method to update the selected value
// void select(Role value) {
//   state = value;
// }
}

class PasswordValidationNotifier extends StateNotifier<bool> {
  PasswordValidationNotifier()
      : super(false); // Default value for the radio buttons

  void checkPassword(value) {
    if (value == '' || value.isEmpty) {
      state = true;
    } else {
      state = false;
      log('state: ' + state.toString());
    }
  }
// Method to update the selected value
// void select(Role value) {
//   state = value;
// }
}

final punchInRepositoryProvider = Provider<PunchInRepositoryImp>((ref) {
  return PunchInRepositoryImp(); // Provides instance of PunchInRepository
});

Future<Position> _getCurrentLocation() async {
  bool serviceEnabled;
  LocationPermission permission;

  serviceEnabled = await Geolocator.isLocationServiceEnabled();
  if (!serviceEnabled) {}
  print('serviceEnabled $serviceEnabled');
  // Check location permissions
  permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {}
  }

  if (permission == LocationPermission.deniedForever) {
    // Permissions are permanently denied, handle this scenario

    // return null;
  }
  LocationSettings locationSettings = const LocationSettings(
    accuracy: LocationAccuracy.high,
    distanceFilter: 100,
  );
  // Get the current position
  Position position =
      await Geolocator.getCurrentPosition(locationSettings: locationSettings);

  return position;

  // await _calculateDistance();
}

Future<bool> punchStatusFunction(_punchInRepository,String token ,String role) async {

  log('stored token:: ' + token.toString());
  log('stored role:: ' + role.toString());
  Position position = await _getCurrentLocation();
  if (position != null && token != null) {
    Map<String, String> tokens = {"token": token};
    Map<String, double> location = {
      "latitude": position.latitude,
      "longitude": position.longitude,
    };
    try {
      var response = await _punchInRepository.checkPunch(location, tokens);
      var checkAttendanceResponse =
          CheckAttendanceResponceModel.fromJson(response.data);
     return checkAttendanceResponse.items.viewButton;
    } on DioException catch (error) {
      DioExceptions.fromDioError(error);
    }
  }
  return false;
  // SesstionModel(
  //   token: tokens != null, role: role, puntchStatus: punchStatus);
  // Return true if token exists (logged in), false otherwise (not logged in)
}

enum Role { Employee, Vendor, Lender }
