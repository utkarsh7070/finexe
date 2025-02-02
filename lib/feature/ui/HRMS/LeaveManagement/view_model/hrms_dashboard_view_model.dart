import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:finexe/feature/base/utils/general/pref_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import '../../../../Punch_In_Out/repository/puch_In_repository_imp.dart';
import '../../../../Punch_In_Out/viewmodel/attendance_view_model.dart';
import '../../../../base/api/dio.dart';
import '../../../../base/api/dio_exception.dart';
import '../../../../base/utils/namespase/app_colors.dart';
import '../../../../base/utils/widget/custom_snackbar.dart';
import '../../../Sales/SalesProfile/view_model/sales_user_view_model.dart';

final hrmsDashBordProvider =
    StateNotifierProvider<HRMSDashBoardViewModel, bool>(
  (ref) {
    final dio = ref.watch(dioProvider);
    return HRMSDashBoardViewModel(ref.watch(punchInRepositoryProvider), dio);
  },
);

class HRMSDashBoardViewModel extends StateNotifier<bool> {
  HRMSDashBoardViewModel(this._punchInRepository, this.dio) : super(false);
  final PunchInRepositoryImp _punchInRepository;
  final Dio dio;

  Future<bool?> onPunchOut(BuildContext context) async {
    final String? storedToken = speciality.getToken();

    Map<String, String> token = {"token": storedToken!};
    print(token.values);
    try {
      log('onPunchOut');
      var response = await _punchInRepository.punchOut(token);
      print('punch out response  ${response.data}');
      log('puch');
      var responseData = response.data; // Assuming response.data is a Map
      var message = responseData['message'];
// Punch punchInModel = PunchInModel.fromJson(response.data);
      if (response.statusCode == 200) {
        showCustomSnackBar(context, message, AppColors.green);
// PunchInModel punchInModel = PunchInModel.fromJson(response.data);
      } else {
        showCustomSnackBar(context, message, AppColors.green);
      }

      // await checkPunch(storedToken);
      return true;
    } on DioException catch (error) {
      DioExceptions.fromDioError(error, context);
    }
    return null;
  }

  String calculateHoursDifference(String startTime, String endTime) {
    print('$startTime $endTime');
    startTime = startTime.replaceAll('\u202F', ' ').trim();
    endTime = endTime.replaceAll('\u202F', ' ').trim();
    try {
      DateFormat format = DateFormat('hh:mm a');
      // Parse the start and end times
      DateTime start = format.parse(startTime);
      DateTime end = format.parse(endTime);

      // Calculate the difference
      Duration difference = end.difference(start);

      // Get the hours and minutes from the difference
      int hours = difference.inHours;
      int minutes = difference.inMinutes % 60;

      return "$hours:$minutes";
    } catch (e) {
      // throw Exception(e);
      // Handle invalid input
      return "00:00";
    }
    // DateFormat timeFormat = DateFormat("h:mm a");
    // DateTime dateTime1 = timeFormat.parse(startTime);
    // DateTime dateTime2 = timeFormat.parse(endTime);
    // Duration difference = dateTime2.difference(dateTime1);
    // print(
    //     "Difference: ${difference.inHours} hours and ${difference.inMinutes % 60} minutes");

    // Define the format
    // print('$startTime  ,  $endTime' );
    // final DateFormat format = DateFormat('hh:mm a'); // 12-hour format
    //
    // // Parse the times
    // final DateTime start = format.parse(startTime);
    // final DateTime end = format.parse(endTime);
    //
    // // Calculate difference
    // final Duration difference = end.difference(start);
    //
    // final int hours = difference.inHours;
    // final int minutes = difference.inMinutes % 60;
    //


    // print('Difference: $hours hours and $minutes minutes.');
  }

  String hoursCalculate(String? punchinTime, String? punchOutTime) {
    String punchIn = formatTime(punchinTime!);
    print('punchOutTime :  $punchOutTime');
    if (punchOutTime != '') {
      String punchOut = formatTime(punchOutTime!);
      return calculateHoursDifference(punchIn, punchOut);
    } else {
      DateTime now = DateTime.now();

      // Define your desired format (e.g., 12-hour clock)
      DateFormat format = DateFormat('hh:mm a'); // Example: 12:00 AM
      // Convert DateTime.now() to the desired format
      String formattedTime = format.format(now);
      return calculateHoursDifference(punchIn, formattedTime);
    }
  }

//   Future<PunchAttendanceModel?> checkPunch(String storedToken) async {
//     if (state.currentPosition != null && storedToken != null) {
//       Map<String, String> token = {"token": storedToken!};
//       Map<String, double> location = {
//         "latitude": state.currentPosition!.latitude,
//         "longitude": state.currentPosition!.longitude,
//       };
//
//       try {
//         Response response =
//             await _punchInRepository.checkPunch(location, token);
//         print(response.data);
//         CheckAttendanceResponseModel checkAttendanceResponse =
//             CheckAttendanceResponseModel.fromJson(response.data);
//         // state =
//         //     state.copyWith(checkAttendanceResponse: checkAttendanceResponse);
//         // state = state.copyWith(
//         //     punchStatus: checkAttendanceResponse.items.punchIn,
//         //     punchAllowed: checkAttendanceResponse.items.allowed);
//         log('punchIn Status: ${checkAttendanceResponse.items.punchIn}');
//         return PunchAttendanceModel(
//             allowed: checkAttendanceResponse.items.allowed,
//             punchIn: checkAttendanceResponse.items.punchIn);
//       } on DioException catch (error) {
//         if (kDebugMode) {
//           print(error);
//         }
//         throw Exception(error);
//         state = state.copyWith(isLoading: false);
// // DioExceptions.fromDioError(error,context);
//       }
//     }
//     return null;
//   }
}

//...............

class RoleListModel {
  final List<String> role;

  RoleListModel({required this.role});
}

class RoleListNotifier extends StateNotifier<RoleListModel> {
  RoleListNotifier() : super(RoleListModel(role: [])) {
    loadRoles();
  }

  // Initialize SharedPreferences and load roles
  Future<void> loadRoles() async {
    // final prefs = await SharedPreferences.getInstance();
    // List<String>? role = prefs.getStringList('roleName');
    List<String>? role = speciality.getRole();

    speciality.getRole();
    state = RoleListModel(role: role ?? []);
    print('Roles loaded: ${state.role}'); // Debug log
  }

  // Update roles in SharedPreferences and state
  Future<void> updateRoles(List<String> newRoles) async {
    speciality.setRole(newRoles);
    // final prefs = await SharedPreferences.getInstance();
    // await prefs.setStringList('roleName', newRoles);
    state = RoleListModel(role: newRoles);
  }
}

final roleListProvider =
    StateNotifierProvider.autoDispose<RoleListNotifier, RoleListModel>(
  (ref) => RoleListNotifier(),
);
// final AttendanceCountStateProvider = StateProvider<List<AttendanceCountModel>>((ref) {
//   return [
//
//   ];
// },);
//
// class AttendanceCountModel{
//   final String label;
//   final String count;
//   AttendanceCountModel(this.label, this.count);
//
// }
