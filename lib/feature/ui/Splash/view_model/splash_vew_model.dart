import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../Punch_In_Out/model/check_attendance_responce_model.dart';
import '../../../Punch_In_Out/repository/puch_In_repository_imp.dart';
import '../../../Punch_In_Out/viewmodel/attendance_view_model.dart';
import '../../../base/api/dio_exception.dart';
import '../../../base/service/session_service.dart';

final sessionProvider = FutureProvider.autoDispose((ref) async {
  final _punchInRepository = ref.watch(punchInRepositoryProvider);
  final position = await getCurrentLocation();
  // Fetch the token from SharedPreferences
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String? tokens = prefs.getString('token');
  String? role = prefs.getString('roleName');
  bool? punchStatus;
  print( position.latitude);
  print( position.longitude);
  log('stored token:: ' + tokens.toString());
  log('stored role:: ' + role.toString());
  if (position != null && tokens != null) {
    Map<String, String> token = {"token": tokens};
    Map<String, double> location = {
      "latitude": position.latitude,
      "longitude": position.longitude,
    };

    try {
      var response = await _punchInRepository.checkPunch(location, token);
      var checkAttendanceResponse =
      CheckAttendanceResponseModel.fromJson(response.data);
      punchStatus =  checkAttendanceResponse.items.punchIn;
    } on DioException catch (error) {
      // DioExceptions.fromDioError(error,context);
    }
  }
  return AsyncValue.data(SesstionModel(
      token: tokens != null, role: role, puntchStatus: punchStatus));
    // SesstionModel(
    //   token: tokens != null, role: role, puntchStatus: punchStatus);
  // Return true if token exists (logged in), false otherwise (not logged in)
});

class SesstionModel {
  bool? token;
  String? role;
  bool? puntchStatus;

  SesstionModel(
      {this.token = false, this.role = '', this.puntchStatus = false});
}

final punchInRepositoryProvider = Provider<PunchInRepositoryImp>((ref) {
  return PunchInRepositoryImp(); // Provides instance of PunchInRepository
});


Future<Position> getCurrentLocation() async {
  await Geolocator.requestPermission();
  LocationSettings locationSettings = const LocationSettings(
    accuracy: LocationAccuracy.high,
    distanceFilter: 100,
  );
  return Geolocator.getCurrentPosition(locationSettings: locationSettings);
}