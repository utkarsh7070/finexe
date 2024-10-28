import 'dart:async';
import 'dart:developer';

import 'package:finexe/feature/base/api/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../base/api/api.dart';

import '../../../../base/service/session_service.dart';

import '../home_collection_model/user_profile_model.dart';
import '../home_collection_model/user_profile_response_model.dart';

class ApiResponseNotifier extends StateNotifier<AsyncValue<UserProfile>> {
  final Dio dio;

  ApiResponseNotifier(this.dio) : super(AsyncValue.loading());
  bool _isInitialized = false;
  bool isPunchOutStatus = true;
  Future<void> clickPunchOut() async {
    await employeePunchOut();
  }

  Future<void> fetchDashboardData() async {
    if (_isInitialized) return;
    String? token = await SessionService.getToken();
try{
  final response = await dio.get(Api.getAllocationDashboard,
      options: Options(headers: {"token": token}));
  print('Response status: ${response.statusCode}');
  print('Response body: ${response.data}');
  if (response.statusCode == 200) {
    final UserprofileResponseModel responseModel =
    UserprofileResponseModel.fromJson(response.data);
    state = AsyncValue.data(UserProfile(
        name: responseModel.items.employeeDetail.employeName!,
        visitRejected: responseModel.items.visitRejected,
        visitPendingForApproval: responseModel.items.visitPendingForApproval,
        visitAccepted: responseModel.items.visitAccepted,
        collectionRejectAmount: responseModel.items.collectionRejectAmount,
        collectionEmiAmountPendingForApproval:
        responseModel.items.collectionEmiAmountPendingForApproval,
        collectionAcceptAmount: responseModel.items.collectionAcceptAmount,
        employeeUniqueId: responseModel.items.employeeDetail.employeUniqueId!,
        joiningDate: responseModel.items.employeeDetail.joiningDate!,
        employeeId: responseModel.items.employeeDetail.id!,
        email: responseModel.items.employeeDetail.email!,
        imageUrl: responseModel.items.employeeDetail.employeePhoto ?? '',
        mobileNo: responseModel.items.employeeDetail.mobileNo.toString(),
        address: responseModel.items.employeeDetail.currentAddress!));

  }
} catch (error) {
    state = AsyncValue.error(error, StackTrace.current);
    }
  }
  void clearData() {
    state = const AsyncValue.loading(); // Reset the state
    _isInitialized = false; // Reset the flag for future data fetch
  }

  Future<dynamic> employeePunchOut() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String? token = sharedPreferences.getString('token');
    print('token of employee punchout $token');
    final response = await dio.get(Api.punchOut,
        options: Options(headers: {'token': token}));
    log('punchOut api: ${Api.punchOut.toString()}');
    print('punch out response $response');
    if (response.statusCode == 200) {
      isPunchOutStatus = false;
      return response;
    }
  }

  Future<void> logoutSession(WidgetRef ref) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.clear();
  }
}

final apiResponseProvider =
    StateNotifierProvider<ApiResponseNotifier, AsyncValue<UserProfile>>((ref) {
  final dio = ref.read(dioProvider);
  return ApiResponseNotifier(dio);
});

// final fetchEmployeeData = FutureProvider.autoDispose<UserprofileResponseModel>((
//     ref) async {
//   final dio = ref.read(dioProvider);
//   String? token = await SessionService.getToken();
//   print('token  $token');
//
//   final response = await dio.get(
//       Api.getAllocationDashboard, options: Options(headers: {"token": token}));
//   print('Response status: ${response.statusCode}');
//   print('Response body: ${response.data}');
//   if (response.statusCode == 200) {
//     final UserprofileResponseModel responseModel = UserprofileResponseModel
//         .fromJson(response.data);
//     return responseModel;
//   } else {
//     throw Exception('Failed to load data');
//   }
// },);

// class DashboardNotifier
//     extends StateNotifier<AsyncValue<UserprofileResponseModel>> {
//   DashboardNotifier(this.dio) : super(const AsyncValue.loading());
//   final Dio dio;
//
//   Future<void> fetchDashboardData() async {
//     String? token = await SessionService.getToken();
//     try {
//       final response = await dio.get(Api.getAllocationDashboard,
//           options: Options(headers: {"token": token}));
//       print('Response status: ${response.statusCode}');
//       print('Response body: ${response.data}');
//       if (response.statusCode == 200) {
//         final UserprofileResponseModel responseModel =
//             UserprofileResponseModel.fromJson(response.data);
//         state = AsyncValue.data(responseModel);
//       }
//     } catch (error) {
//       state = AsyncValue.error(error, StackTrace as StackTrace);
//     }
//     void clearData() {
//       state = const AsyncValue.loading(); // Reset the state
//     }
//   }
// }
//
// // Provide the StateNotifierProvider
// final dashboardDataProvider = StateNotifierProvider<DashboardNotifier,
//     AsyncValue<UserprofileResponseModel>>((ref) {
//   final dio = ref.read(dioProvider);
//   return DashboardNotifier(dio);
// });
