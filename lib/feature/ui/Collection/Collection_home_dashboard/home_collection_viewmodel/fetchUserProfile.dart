import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:dio/dio.dart';

import '../../../../base/api/api.dart';
import '../../../../base/service/session_service.dart';
import '../home_collection_model/UserProfile.dart';

class ApiResponseNotifier extends StateNotifier<ApiResponse?> {
  ApiResponseNotifier() : super(null);

  Future<void> fetchEmployeeDetails() async {
    try {
      String? token = await SessionService.getToken();
      /*final String token =
          "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJJZCI6IjY2ODUwZjdkMzc0NDI1ZTkzNzExNDE4MCIsInJvbGVOYW1lIjoiYWRtaW4iLCJpYXQiOjE3MjY3Mzc2Njd9.exsdAWj9fWc5LiOcAkFmlgade-POlU8orE8xvgfYXZU";
*/
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
  return ApiResponseNotifier();
});
