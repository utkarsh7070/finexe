import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:finexe/feature/base/utils/general/pref_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../Punch_In_Out/repository/puch_In_repository_imp.dart';
import '../../../../Punch_In_Out/viewmodel/attendance_view_model.dart';
import '../../../../base/api/dio.dart';
import '../../../../base/api/dio_exception.dart';
import '../../../../base/utils/namespase/app_colors.dart';
import '../../../../base/utils/widget/custom_snackbar.dart';

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
    // SharedPreferences sharedPreferences = await  SharedPreferences.getInstance();
    // final String? storedToken = sharedPreferences.getString('token');
    final String? storedToken = speciality.getToken();

    
    Map<String, String> token = {"token": storedToken!};
    print(token.values);
    try {
      log('onPunchOut');
      var response = await _punchInRepository.punchOut(token);
      print('punch out response  ${response.data}');
// log("onPunchOut response: " + response.);
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
  RoleListNotifier() : super(RoleListModel(role: [])){
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

final roleListProvider = StateNotifierProvider.autoDispose<RoleListNotifier, RoleListModel>(
      (ref) => RoleListNotifier(),
);