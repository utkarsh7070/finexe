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
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../Punch_In_Out/model/check_attendance_responce_model.dart';
import '../../../Punch_In_Out/repository/puch_In_repository_imp.dart';
import '../../../base/api/dio_exception.dart';
import '../../../base/routes/routes.dart';
import '../../../base/utils/widget/custom_snackbar.dart';
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
      required WidgetRef ref}) async {
    await login(email, password, ref,context).then(
      (value) {
        if (value) {
          print('check punch ${state.value!.checkPunch}');
          if (state.value!.checkPunch) {
            switch (state.value!.role) {
              case 'admin':
                log("Navigating to admin dashboard");

                Navigator.pushNamedAndRemoveUntil(
                  context,
                  AppRoutes.collectionHome, // Admin dashboard route
                  (route) => false, // Remove all previous routes
                );

                break;
              case 'sales':
                log("Navigating to sales dashboard");
                Navigator.pushNamedAndRemoveUntil(
                  context,
                  AppRoutes.saleApplicationForm, // Sales dashboard route
                  (route) => false, // Remove all previous routes
                );
                break;
              case 'cashCollection':
                log("Navigating to collection dashboard");
                Navigator.pushNamedAndRemoveUntil(
                  context,
                  AppRoutes.collectionHome, // Collection dashboard route
                  (route) => false, // Remove all previous routes
                );
                break;
              default:
                // Handle unknown roles or navigate to a default screen
                log('No matching role found');
                break;
            }
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

  Future<bool> login(String email, String password, WidgetRef ref,BuildContext context) async {
    isLoading = true;
    LoginRequestModel loginRequestModel =
        LoginRequestModel(userName: email, password: password);
    // Set state to loading
    state = const AsyncValue.loading();
    try {
      final response =
          await dio.post(Api.login, data: loginRequestModel.toJson());
      if (response.statusCode == 200) {
        isLoading = false;
        LoginResponseModel loginResponseModel =
            LoginResponseModel.fromJson(response.data);
        if (kDebugMode) {
          print("response:: ${response.data}");
        }
        if (kDebugMode) {
          print('role:: ${loginResponseModel.items.roleName}');
        }
        // Create session after login
        await SessionService.createSession(
            accessToken: loginResponseModel.items.token,
            employeeId: loginResponseModel.items.employeId,
            name: loginResponseModel.items.roleName,
            email: loginResponseModel.items.userName,
            role: loginResponseModel.items.roleName);
        ref.refresh(attendanceProvider);

        bool punchStatus = await punchStatusFunction(_punchInRepository,
            loginResponseModel.items.token, loginResponseModel.items.roleName,context);
        // Update state to indicate success
        state = AsyncValue.data(DataModel(
            checkPunch: punchStatus,
            loginStatus: 'Sucsses',
            role: loginResponseModel.items.roleName));
        SharedPreferences preferences = await SharedPreferences.getInstance();
        print(' inLogin set username ${preferences.get('email')}');
        showCustomSnackBar(context,
            loginResponseModel.message, Colors.green);
        return true;
  // Return true here to indicate success
      } else {
        showCustomSnackBar(context,
            response.data.message, Colors.red);
        // If status code is not 200, set state to error
        isLoading = false;
        state = AsyncValue.error(
            'Login failed with status: ${response.statusCode}',
            StackTrace.current);
        return false;
      }
    } catch (error, stackTrace) {
      DioExceptions.fromDioError(error as DioException,context);
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

Future<bool> punchStatusFunction(
    _punchInRepository, String token, String role,BuildContext context) async {
  log('stored token:: $token');
  log('stored role:: $role');
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
          CheckAttendanceResponseModel.fromJson(response.data);
      return checkAttendanceResponse.items.punchIn;
    } on DioException catch (error) {
      DioExceptions.fromDioError(error,context);
    }
  }
  return false;
  // SesstionModel(
  //   token: tokens != null, role: role, puntchStatus: punchStatus);
  // Return true if token exists (logged in), false otherwise (not logged in)
}

enum Role { Employee, Vendor, Lender }
