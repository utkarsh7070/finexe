import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:finexe/feature/Punch_In_Out/viewmodel/attendance_view_model.dart';
import 'package:finexe/feature/base/api/api.dart';
import 'package:finexe/feature/base/api/dio.dart';
import 'package:finexe/feature/base/service/session_service.dart';
import 'package:finexe/feature/ui/authenticate/model/login_request_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../Punch_In_Out/model/check_attendance_responce_model.dart';
import '../../../Punch_In_Out/repository/puch_In_repository_imp.dart';
import '../../../base/api/dio_exception.dart';
import '../../../base/routes/routes.dart';
import '../../../base/service/background_service.dart';
import '../../../base/utils/widget/custom_snackbar.dart';
import '../model/login_response_model.dart';

final userValidationProvider =
StateNotifierProvider.autoDispose<UserValidationNotifier, bool>(
      (ref) {
    return UserValidationNotifier();
  },
);
final passwordValidationProvider =
StateNotifierProvider.autoDispose<PasswordValidationNotifier, bool>(
      (ref) {
    return PasswordValidationNotifier();
  },
);
final selectVendorProvider = StateProvider.autoDispose<bool>((ref) => false);

final dualFocusProvider =
StateNotifierProvider.autoDispose<FocusViewModel, Map<String, bool>>((ref) {
  return FocusViewModel();
});

final obscureTextProvider = StateProvider.autoDispose<bool>(
      (ref) {
    return false;
  },
);

final isRememberMeCheckedProvider = StateProvider.autoDispose<bool>((ref) => false);

final loginViewModelProvider =
StateNotifierProvider.autoDispose<LoginViewModel, AsyncValue<DataModel>>((ref) {
  final punchInRepository = ref.watch(punchInRepositoryProvider);
  final dio = ref.read(dioProvider);
  return LoginViewModel(
      AsyncValue.data(DataModel(loginStatus: '', checkPunch: false, role: [],allowed: false)),
      dio,
      punchInRepository);
});

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
      {required BuildContext context,
        required String email,
        required String password,
        required String role,
        required WidgetRef ref}) async {
    await login(email: email, password: password, ref: ref,role: role,context: context).then(
          (value) async {
        if (value) {
          if (kDebugMode) {
            print('check punch ${state.value?.checkPunch}');
            print('check punchCheck punch ${state.value?.role}');
          }
          if (state.value!.checkPunch) {
            SharedPreferences prefs = await SharedPreferences.getInstance();
            List<String>? roles = prefs.getStringList('roleName');
            print('Login screen roles-${roles} ');

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
            /*switch (state.value?.role) {
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

              case 'cibil':
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
          } else {
            Navigator.pushNamedAndRemoveUntil(
              context,
              AppRoutes.attendance,
                  (route) => false,
            );
          }
        }
      },
    );
  }

  Future<bool> login(
      {required String email,
        required String password,
        required String role,
        required WidgetRef ref,
        required BuildContext context}) async {
    isLoading = true;
    LoginRequestModel loginRequestModel =
    LoginRequestModel(userName: email, password: password,employeeRole: role);
    // Set state to loading
    state = const AsyncValue.loading();

    print("login Input: ${loginRequestModel.toJson()}");
    try {
      final response =
      await dio.post(Api.login, data: loginRequestModel.toJson());

      var responseData = response.data;
      print('Login response: ${responseData}');
      var message = responseData['message'];

      if (response.statusCode == 200) {
        isLoading = false;

        LoginResponseModel loginResponseModel =
        LoginResponseModel.fromJson(response.data);
        if (kDebugMode) {
          print("response:: ${response.data}");
        }
        if (kDebugMode) {
          print('role:: ${loginResponseModel.items.roleName}');
          print('role:: ${loginResponseModel.items}');
        }
        //------------------------------start background service----------------
        // SocketService().startTracking(loginResponseModel.items.employeId);
        // FlutterBackgroundService().invoke("startService");
        //----------------------------------------------------------------------
        // Create session after login
        await SessionService.createSession(
            role:  loginResponseModel.items.roleName,
            accessToken: loginResponseModel.items.token,
            employeeId: loginResponseModel.items.employeId,
            email: loginResponseModel.items.userName,
            name: loginResponseModel.items.userName,
            romId: loginResponseModel.items.roamId,
            trakingMode: loginResponseModel.items.trackingMode
        );
        ref.refresh(attendanceProvider);
        //------------------------background service----------------------------
        await BackgroundService().initializeService();
        //---------------------------------------------------------------------
        PunchModel punchStatus = await punchStatusFunction(
            _punchInRepository,
            loginResponseModel.items.token,
            // loginResponseModel.items.roleName.first.toString(),
            context);
        // Update state to indicate success
        state = AsyncValue.data(DataModel(
            allowed: punchStatus.allowed,
            checkPunch: punchStatus.punchIn,
            loginStatus: 'Sucsses',
            role: loginResponseModel.items.roleName));
        showCustomSnackBar(context, loginResponseModel.message, Colors.green);
        return true;
        // Return true here to indicate success
      }
      else if(response.statusCode==400){
        isLoading = false;
        showCustomSnackBar(context, message, Colors.red);
        return true;
      }
      else {
        showCustomSnackBar(context, response.data.message, Colors.red);
        // If status code is not 200, set state to error
        isLoading = false;
        state = AsyncValue.error(
            'Login failed with status: ${response.statusCode}',
            StackTrace.current);
        return false;
      }
    } catch (error, stackTrace) {
      print(error);
      isLoading = false;
      DioExceptions.fromDioError(error as DioException, context);
      // Handle exceptions and set state to error
      state = AsyncValue.error(error, stackTrace);
      return false;
    }
  }
}

class DataModel {
  final String loginStatus;
 // final String role;
  final List<String> role;
  final bool checkPunch;
  final bool allowed;


  DataModel(
      {required this.loginStatus,
        required this.checkPunch,
        required this.role,
        required this.allowed,
      });
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
      log('state: $state');
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

Future<PunchModel> punchStatusFunction(
    _punchInRepository, String token, BuildContext context) async {
  log('stored token:: $token');
  Position position = await _getCurrentLocation();
  if (position != null && token != null) {
    Map<String, String> tokens = {"token": token};
    Map<String, double> location = {
      "latitude": position.latitude,
      "longitude": position.longitude,
    };
    try {
      Response response = await _punchInRepository.checkPunch(location, tokens);
      var checkAttendanceResponse =
      CheckAttendanceResponseModel.fromJson(response.data);
      return PunchModel(punchIn: checkAttendanceResponse.items.punchIn,allowed: checkAttendanceResponse.items.allowed);
    } on DioException catch (error) {
      DioExceptions.fromDioError(error, context);
    }
  }
  return PunchModel(allowed: false,punchIn: false);
  // SesstionModel(
  //   token: tokens != null, role: role, puntchStatus: punchStatus);
  // Return true if token exists (logged in), false otherwise (not logged in)
}

class PunchModel{
  final bool allowed;
  final bool punchIn;

  PunchModel({required this.allowed, required this.punchIn});


}

enum Role { Employee, Vendor, Lender }