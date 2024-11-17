

// user_profile_view_model.dart
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:dio/dio.dart';

import '../../../../base/api/api.dart';
import '../../../../base/service/session_service.dart';
import '../model/login_user_profile.dart';

/*final loginUserProfileProvider = StateNotifierProvider<UserProfileNotifier, AsyncValue<LoginUserProfile>>((ref) {
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

  }
}*/

final loginUserProfileProvider = FutureProvider.autoDispose<LoginUserProfile>((ref) async {
  try {
    // Fetch the token
    String? token = await SessionService.getToken();

    // Make the API call
    final response = await Dio().get(
      Api.getEmployeeDetails,
      options: Options(headers: {"token": token}),
    );

    // Log the full response to debug
    print('Response user login: ${response.data}');

    if (response.statusCode == 200) {
      // Parse the response and return the data
      final data = LoginUserProfile.fromJson(response.data['items']);
      print('Login User data response: $data');
      return data;
    } else {
      throw Exception('Failed to load user profile');

    }
  } catch (error) {
    // Log the error for debugging
    print('Error: $error');
    throw error; // The FutureProvider will handle this as an AsyncError
  }
});
