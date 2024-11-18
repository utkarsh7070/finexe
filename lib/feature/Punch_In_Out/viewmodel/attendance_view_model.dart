import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:finexe/feature/Punch_In_Out/model/check_attendance_responce_model.dart';
import 'package:finexe/feature/Punch_In_Out/repository/puch_In_repository_imp.dart';
import 'package:finexe/feature/base/api/dio_exception.dart';
import 'package:finexe/feature/base/routes/routes.dart';
import 'package:finexe/feature/base/service/session_service.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../model/response_model.dart';

class AttendanceState {
  final String employeeName;
  final bool isLoading;
  final bool punchStatus;
  final Position? currentPosition;
  final String? distanceMessage;
  final CheckAttendanceResponseModel? checkAttendanceResponse;

  AttendanceState({
    this.employeeName = '',
    this.isLoading = false,
    this.punchStatus = false,
    this.currentPosition,
    this.distanceMessage,
    this.checkAttendanceResponse,
  });

  AttendanceState copyWith({
    String? employeeName,
    bool? isLoading,
    bool? punchStatus,
    Position? currentPosition,
    String? distanceMessage,
    CheckAttendanceResponseModel? checkAttendanceResponse,
  }) {
    return AttendanceState(
      employeeName: employeeName ?? this.employeeName,
      isLoading: isLoading ?? this.isLoading,
      punchStatus: punchStatus ?? this.punchStatus,
      currentPosition: currentPosition ?? this.currentPosition,
      distanceMessage: distanceMessage ?? this.distanceMessage,
      checkAttendanceResponse:
          checkAttendanceResponse ?? this.checkAttendanceResponse,
    );
  }
}

// Define the AttendanceNotifier
class AttendanceNotifier extends StateNotifier<AttendanceState> {
  final PunchInRepositoryImp _punchInRepository;

  AttendanceNotifier(this._punchInRepository) : super(AttendanceState()) {
    getCurrentLocation();
  }

  final double targetLatitude = 22.724366;
  final double targetLongitude = 75.882175;
  String? storedToken;

  Future<void> getCurrentLocation() async {
    state = state.copyWith(isLoading: true);

    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      state = state.copyWith(
          isLoading: false, distanceMessage: 'Location services are disabled.');
      return;
    }

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        log('location denied');
        state = state.copyWith(
            isLoading: false,
            distanceMessage: 'Location permissions are denied.');
        return;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      log('LocationPermission.deniedForever');
      state = state.copyWith(
          isLoading: false,
          distanceMessage: 'Location permissions are permanently denied.');
      return;
    }

    Position position = await Geolocator.getCurrentPosition(
      locationSettings: const LocationSettings(
        accuracy: LocationAccuracy.high,
        distanceFilter: 100,
      ),
    );
    state = state.copyWith(currentPosition: position);
    await getToken();
    await checkPunch().then(
      (value) {
        state = state.copyWith(isLoading: false);
        if (kDebugMode) {
          print('puch>>>>>>>> ');
          log('puch>>>>>>>> ');
        }
      },
    );
  }

  Future<void> getToken() async {
    SharedPreferences preferences = await SessionService.getSession();
    final String? name = preferences.getString('email');
    if (kDebugMode) {
      print('set in pinchin screen name $name');
    }

    storedToken = preferences.getString('token');
    // final name = preferences.getString('email');
    state = state.copyWith(isLoading: false);
    state = state.copyWith(employeeName: preferences.getString('email'));
    log("storedToken: $storedToken");
  }

  Future<bool?> checkPunch() async {
    if (state.currentPosition != null && storedToken != null) {
      Map<String, String> token = {"token": storedToken!};
      Map<String, double> location = {
        "latitude": state.currentPosition!.latitude,
        "longitude": state.currentPosition!.longitude,
      };

      try {
        Response response =
            await _punchInRepository.checkPunch(location, token);
        print(response.data);
        CheckAttendanceResponseModel checkAttendanceResponse =
            CheckAttendanceResponseModel.fromJson(response.data);
        state =
            state.copyWith(checkAttendanceResponse: checkAttendanceResponse);
        state = state.copyWith(
            punchStatus: checkAttendanceResponse.items.punchIn);
        log('punchIn Status: ${checkAttendanceResponse.items.punchIn}');
        return checkAttendanceResponse.items.viewButton;
      } on DioException catch (error) {
        print(error);
        throw Exception(error);
        state = state.copyWith(isLoading: false);
        // DioExceptions.fromDioError(error,context);
      }
    }
    return null;
  }

  Future<void> clickPunch(BuildContext context) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    List<String>? role = preferences.getStringList('roleName');
    if (kDebugMode) {
      print(role?.first);
    }
    state = state.copyWith(isLoading: true);
    // if (state.punchStatus) {
    await onPunchIn(context).then(
      (value) async {
        if (kDebugMode) {
          print(value);
        }
        if (value!) {
          await checkPunch().then(
            (value) {
              state = state.copyWith(punchStatus: value);
            },
          );
        }
        if (value) {
          switch (role?.first.toString()) {
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
                (route) => false,
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
            default:
              // Handle unknown roles or navigate to a default screen
              log('No matching role found');
              break;
          }
        }
      },
    );
    // } else {
    //   // await onPunchOut().then((value) async {
    //   //   if(value!){
    //   //     await checkPunch().then((value) {
    //   //       state = state.copyWith(punchStatus: value);
    //   //     },);
    //   //   }
    //   // },);
    // }
    state = state.copyWith(isLoading: false);
  }

  Future<bool?> onPunchIn(BuildContext context) async {
    Map<String, String> token = {"token": "$storedToken"};

    try {
      log('onPunchIn');
      state = state.copyWith(isLoading: true);
      Response response = await _punchInRepository.punchIn(token);
      log('onPunchIn after');
      PunchInModel punchInModel = PunchInModel.fromJson(response.data);
      // SharedPreferences preferences = await SessionService.getSession();
      // preferences.setBool('punchIn', punchInModel.items.);
      log(">>>punchin: ${response.data}");
      Fluttertoast.showToast(
        msg: punchInModel.message.toString(),
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.TOP,
        backgroundColor: Colors.white,
        textColor: Colors.blue,
        fontSize: 16.0,
      );

      await checkPunch();
      state = state.copyWith(
        isLoading: false,
        // punchStatus: false
      );
      return true;
      // Navigator.pushNamed(context, AppRoutes.eod);
    } on DioException catch (error) {
      DioExceptions.fromDioError(error, context);
      state = state.copyWith(isLoading: false);
    }
    return false;
  }

  Future<bool?> onPunchOut(BuildContext context) async {
    print(storedToken);
    Map<String, String> token = {"token": storedToken!};
    // Map<String, String> tokens = {"token": token!};
    print(token.values);
    try {
      log('onPunchOut');
      var response = await _punchInRepository.punchOut(token);
      print('punch out response  ${response.data}');
      // log("onPunchOut response: " + response.);
      log('puch');
      // Punch punchInModel = PunchInModel.fromJson(response.data);
      if (response.subCode == 200) {
        // PunchInModel punchInModel = PunchInModel.fromJson(response.data);
        Fluttertoast.showToast(
          msg: response.message.toString(),
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.TOP,
          backgroundColor: Colors.white,
          textColor: Colors.blue,
          fontSize: 16.0,
        );
      } else {
        Fluttertoast.showToast(
          msg: response.message.toString(),
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.TOP,
          backgroundColor: Colors.white,
          textColor: Colors.blue,
          fontSize: 16.0,
        );
      }

      await checkPunch();
      return true;
    } on DioException catch (error) {
      DioExceptions.fromDioError(error, context);
    }
    return null;
  }
}

final punchInRepositoryProvider = Provider.autoDispose<PunchInRepositoryImp>((ref) {
  return PunchInRepositoryImp(); // Provides instance of PunchInRepository
});

// Create the AttendanceNotifierProvider
final attendanceProvider =
    StateNotifierProvider<AttendanceNotifier, AttendanceState>((ref) {
  return AttendanceNotifier(ref.watch(punchInRepositoryProvider));
});

//
// class UserSession extends AsyncNotifier<String?> {
//   @override
//   Future<String?> build() async {
//     final prefs = await SharedPreferences.getInstance();
//     return prefs.getString('email'); // Loads username if available
//   }
//
//   // Future<void> setUser(String username) async {
//   //   final prefs = await SharedPreferences.getInstance();
//   //   await prefs.setString('username', username);
//   //   state = AsyncData(username);
//   // }
//   //
//   // Future<void> clearUser() async {
//   //   final prefs = await SharedPreferences.getInstance();
//   //   await prefs.clear();
//   //   state = const AsyncData(null);
//   // }
// }
//
// final userSessionProvider = AsyncNotifierProvider<UserSession, String?>(UserSession.new);

// final checkCurrentLocation = FutureProvider<String>(
//   (ref) async {
//     SharedPreferences preferences = await SessionService.getSession();
//     final String? name = await preferences.getString('email');
//     print('set in punch in screen name $name');
//     return name!;
//   },
// );
//
// Future<Position> getCurrentLocation() async {
//   await Geolocator.requestPermission();
//   LocationSettings locationSettings = const LocationSettings(
//     accuracy: LocationAccuracy.high,
//     distanceFilter: 100,
//   );
//   return Geolocator.getCurrentPosition(locationSettings: locationSettings);
// }
