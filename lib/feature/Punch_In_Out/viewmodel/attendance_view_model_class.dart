// import 'dart:developer';
//
// import 'package:dio/dio.dart';
// import 'package:finexe/feature/base/api/dio.dart';
// import 'package:flutter/foundation.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:geolocator/geolocator.dart';
// import 'package:shared_preferences/shared_preferences.dart';
//
// import '../../base/api/api.dart';
// import '../model/check_attendance_responce_model.dart';
//
// class AttendanceState {
//   final String employeeName;
//   final bool isLoading;
//   final bool punchAllowed;
//   final bool punchStatus;
//   final Position? currentPosition;
//   final String? distanceMessage;
//   final String taskTitle;
//   final String taskDescription;
//   final CheckAttendanceResponseModel? checkAttendanceResponse;
//   final String employeeId;
//   final String token;
//
//   AttendanceState(
//       {this.taskTitle = '',
//       this.taskDescription = '',
//       this.punchAllowed = false,
//       this.employeeName = '',
//       this.isLoading = false,
//       this.punchStatus = false,
//       this.currentPosition,
//       this.distanceMessage,
//       this.checkAttendanceResponse,
//       this.employeeId = '',
//       this.token = ''});
//
//   AttendanceState copyWith({
//     String? taskTitle,
//     String? taskDescription,
//     String? employeeId,
//     String? token,
//     String? employeeName,
//     bool? isLoading,
//     bool? punchAllowed,
//     bool? punchStatus,
//     Position? currentPosition,
//     String? distanceMessage,
//     CheckAttendanceResponseModel? checkAttendanceResponse,
//   }) {
//     return AttendanceState(
//       punchAllowed: punchAllowed ?? this.punchAllowed,
//       taskDescription: taskDescription ?? this.taskDescription,
//       taskTitle: taskTitle ?? this.taskTitle,
//       employeeId: employeeId ?? this.employeeId,
//       token: token ?? this.token,
//       employeeName: employeeName ?? this.employeeName,
//       isLoading: isLoading ?? this.isLoading,
//       punchStatus: punchStatus ?? this.punchStatus,
//       currentPosition: currentPosition ?? this.currentPosition,
//       distanceMessage: distanceMessage ?? this.distanceMessage,
//       checkAttendanceResponse:
//           checkAttendanceResponse ?? this.checkAttendanceResponse,
//     );
//   }
// }
//
// Future<Position> getCurrentLocation() async {
//   await Geolocator.requestPermission();
//   LocationSettings locationSettings = const LocationSettings(
//     accuracy: LocationAccuracy.high,
//     distanceFilter: 100,
//   );
//   return Geolocator.getCurrentPosition(locationSettings: locationSettings);
// }
//
// final attendanceFutureProvider = FutureProvider(
//   (ref) async {
//     final dio = ref.watch(dioProvider);
//     SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
//     String? storedToken = sharedPreferences.getString('token');
//     Position position = await getCurrentLocation();
//
//     if (storedToken != null) {
//       Map<String, String> token = {"token": storedToken};
//       Map<String, double> location = {
//         "latitude": position.latitude,
//         "longitude": position.longitude,
//       };
//
//       try {
//         Response response = await dio.get(Api.checkPunchIn,
//             queryParameters: location, options: Options(headers: token));
//         print(response.data);
//         CheckAttendanceResponseModel checkAttendanceResponse =
//             CheckAttendanceResponseModel.fromJson(response.data);
//         log('punchIn Status: ${checkAttendanceResponse.items.punchIn}');
//         return PunchAttendanceModel(
//             allowed: checkAttendanceResponse.items.allowed,
//             punchIn: checkAttendanceResponse.items.punchIn);
//       } on DioException catch (error) {
//         if (kDebugMode) {
//           print(error);
//         }
//         throw Exception(error);
//         // state = state.copyWith(isLoading: false);
//         // DioExceptions.fromDioError(error,context);
//       }
//     }
//     return null;
//   },
// );
//
// class PunchAttendanceModel{
//   final bool allowed;
//   final bool punchIn;
//
//   PunchAttendanceModel({required this.allowed, required this.punchIn});
// }
