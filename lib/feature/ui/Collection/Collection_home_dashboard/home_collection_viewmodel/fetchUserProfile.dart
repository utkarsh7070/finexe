import 'dart:developer';

import 'package:finexe/feature/base/api/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../base/api/api.dart';

import '../../../../base/service/session_service.dart';

import '../home_collection_model/UserProfile.dart';

class ApiResponseNotifier extends StateNotifier<ApiResponse?> {
  final Dio dio;
  ApiResponseNotifier(this.dio) : super(null);


  Future<void> clickPunchOut() async {
    await employeePunchOut();
  }

  Future<dynamic> employeePunchOut() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String? token = sharedPreferences.getString('token');
    print('token of employee punchout $token');
    final response = await dio.get(Api.punchOut, options: Options(headers: {'token': token}));
    log('punchOut api: ${Api.punchOut.toString()}');
    print('punch out response $response');
    if (response.statusCode == 200) {
      return response;
    }
  }

  Future<void> logoutSession() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.clear();
  }

  Future<void> fetchEmployeeDetails() async {
    try {
      String? token = await SessionService.getToken();
      final response = await Dio().get(Api.getAllocationDashboard,options: Options(headers: {"token": token}));
      print('Response status: ${response.statusCode}');
      print('Response body: ${response.data}');
      if (response.statusCode == 200) {
        state = ApiResponse.fromJson(response.data);
        print('dashboard response $response');
      } else {
        throw Exception('Failed to load data');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }
}

final apiResponseProvider =
StateNotifierProvider<ApiResponseNotifier, ApiResponse?>((ref) {
  final dio = ref.read(dioProvider);
  return ApiResponseNotifier(dio);
});
