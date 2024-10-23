import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:finexe/feature/Punch_In_Out/model/check_attendance_responce_model.dart';
import 'package:finexe/feature/Punch_In_Out/repository/puch_In_repository_imp.dart';
import 'package:finexe/feature/Punch_In_Out/repository/punch_in_repository.dart';
import 'package:finexe/feature/base/api/dio_exception.dart';
import 'package:finexe/feature/base/routes/routes.dart';
import 'package:finexe/feature/base/service/session_service.dart';
// import 'package:finexe_attendance/feature/attendance/repository/punch_in_repository.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// import '../../Login/model/check_attendance_responce_model.dart';
// import '../../constant/api/dio_exception.dart';
// import '../../constant/route/app_routes.dart';
// import '../../constant/service/session.dart';
import '../model/response_model.dart';

// Define the Attendance State
class AttendanceState {
  final bool isLoading;
  final bool punchStatus;
  final Position? currentPosition;
  final String? distanceMessage;
  final CheckAttendanceResponceModel? checkAttendanceResponse;

  AttendanceState({
    this.isLoading = true,
    this.punchStatus = true,
    this.currentPosition,
    this.distanceMessage,
    this.checkAttendanceResponse,
  });

  AttendanceState copyWith({
    bool? isLoading,
    bool? punchStatus,
    Position? currentPosition,
    String? distanceMessage,
    CheckAttendanceResponceModel? checkAttendanceResponse,
  }) {
    return AttendanceState(
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
    _getCurrentLocation();
  }

  final double targetLatitude = 22.724366;
  final double targetLongitude = 75.882175;
  String? storedToken;

  Future<void> _getCurrentLocation() async {
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
        log('puch>>>>>>>> ');
      },
    );
  }

  Future<void> getToken() async {
    SharedPreferences preferences = await SessionService.getSession();
    storedToken = preferences.getString('token');
    state = state.copyWith(isLoading: false);
  }

  Future<void> checkPunch() async {
    if (state.currentPosition != null && storedToken != null) {
      Map<String, String> token = {"token": storedToken!};
      Map<String, double> location = {
        "latitude": state.currentPosition!.latitude,
        "longitude": state.currentPosition!.longitude,
      };

      try {
        var response = await _punchInRepository.checkPunch(location, token);
        var checkAttendanceResponse =
            CheckAttendanceResponceModel.fromJson(response.data);

        state =
            state.copyWith(checkAttendanceResponse: checkAttendanceResponse);
        if (checkAttendanceResponse != null) {
          state = state.copyWith(
              punchStatus: checkAttendanceResponse.items.viewButton!);
        }
      } on DioException catch (error) {
        state = state.copyWith(isLoading: false);
        DioExceptions.fromDioError(error);
      }
    }
  }

  Future<void> clickPunch(BuildContext context) async {
    state = state.copyWith(isLoading: true);
    if (state.punchStatus) {
      await onPunchIn(context).then(
        (value) async {
          SharedPreferences preferences = await SharedPreferences.getInstance();
          String? role = await preferences.getString('roleName');

          switch (role) {
            case 'admin':
              log("Navigating to admin dashboard");

              // Navigator.pushNamedAndRemoveUntil(
              //   context,
              //   AppRoutes.dashBoard, // Admin dashboard route
              //   (route) => false, // Remove all previous routes
              // );
              Navigator.pushNamed(context, AppRoutes.collectionHome);

              break;
            case 'sales':
              log("Navigating to sales dashboard");
              // Navigator.pushNamedAndRemoveUntil(
              //   context,
              //   AppRoutes.saleApplicationForm, // Sales dashboard route
              //   (route) => false, // Remove all previous routes
              // );
              Navigator.pushNamed(context, AppRoutes.dashBoard);

              break;
            case 'collection':
              log("Navigating to collection dashboard");
              Navigator.pushNamed(context, AppRoutes.collectionHome);
              break;
            default:
              // Handle unknown roles or navigate to a default screen
              log('No matching role found');
              break;
          }
        },
      );
    } else {
      await onPunchOut();
    }
    state = state.copyWith(isLoading: false);
  }

  Future<void> onPunchIn(BuildContext context) async {
    Map<String, String> token = {"token": "$storedToken"};

    try {
      log('onPunchIn');

      var response = await _punchInRepository.punchIn(token);
      log('onPunchIn after');
      PunchInModel punchInModel = PunchInModel.fromJson(response.data);

      SharedPreferences preferences = await SessionService.getSession();
      preferences.setBool('punchIn', true);
      log(">>>punchin: " + response.toString());
      Fluttertoast.showToast(
        msg: punchInModel!.message.toString(),
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.TOP,
        backgroundColor: Colors.white,
        textColor: Colors.blue,
        fontSize: 16.0,
      );

      await checkPunch();
      // Navigator.pushNamed(context, AppRoutes.eod);
    } on DioException catch (error) {
      DioExceptions.fromDioError(error);
    }
  }

  Future<void> onPunchOut() async {
    Map<String, String> token = {"token": "$storedToken"};

    try {
      log('onPunchOut');

      var response = await _punchInRepository.punchOut(token);
      PunchInModel punchInModel = PunchInModel.fromJson(response.data);

      Fluttertoast.showToast(
        msg: punchInModel!.message.toString(),
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.TOP,
        backgroundColor: Colors.white,
        textColor: Colors.blue,
        fontSize: 16.0,
      );

      await checkPunch();
    } on DioException catch (error) {
      DioExceptions.fromDioError(error);
    }
  }
}

final punchInRepositoryProvider = Provider<PunchInRepositoryImp>((ref) {
  return PunchInRepositoryImp(); // Provides instance of PunchInRepository
});

// Create the AttendanceNotifierProvider
final attendanceProvider =
    StateNotifierProvider<AttendanceNotifier, AttendanceState>((ref) {
  return AttendanceNotifier(ref.watch(punchInRepositoryProvider));
});
