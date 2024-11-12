

// user_profile_view_model.dart
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:dio/dio.dart';

import '../../../../base/api/api.dart';
import '../../../../base/service/session_service.dart';
import '../model/login_user_profile.dart';

final loginUserProfileProvider = StateNotifierProvider<UserProfileNotifier, AsyncValue<LoginUserProfile>>((ref) {
  return UserProfileNotifier();
});

class UserProfileNotifier extends StateNotifier<AsyncValue<LoginUserProfile>> {
  UserProfileNotifier() : super(const AsyncLoading());

  Future<void> fetchLoginUserProfile() async {
    try {
      String? token = await SessionService.getToken();
      final response = await Dio().get(
        Api.getEmployeeDetails,
        options: Options(headers: {"token": token}),
      );

      // Log the full response to understand the error
      print('Response user login: ${response.data}');

      if (response.statusCode == 200) {
        final data = LoginUserProfile.fromJson(response.data['items']);
        state = AsyncData(data);
        print('User data response: $data');
      } else {
        throw Exception('Failed to load user profile');
      }
    } catch (error, stackTrace) {
      print('Error: $error');
      state = AsyncError(error, stackTrace);
    }

    /*try {
      // Replace with your actual API URL
      String? token = await SessionService.getToken();
      print('Token retrieved: $token');
      final response = await Dio().get(Api.getEmployeeDetails,options: Options(headers: {"token": token}),);

      print('user response ${response.statusCode}');
      print('user response ${response.data}');
      if (response.statusCode == 200) {
      // Parsing response
      final data = LoginUserProfile.fromJson(response.data['items']);
      state = AsyncData(data);
      print('user data response ${data}');
      } else {
        throw Exception('Failed to load pending lead');
      }
    } catch (error, stackTrace) {
      state = AsyncError(error, stackTrace);
    }*/
  }
}
