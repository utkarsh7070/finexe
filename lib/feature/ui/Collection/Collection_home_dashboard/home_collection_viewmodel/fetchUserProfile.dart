import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../base/api/api.dart';
import '../../../../base/api/dio.dart';

class UserProfile {
  final String name;
  final String email;
  final String employeeId;
  final String mobileNo;
  final String address;
  final String joiningDate;

  UserProfile({
    this.name = '',
    this.email = '',
    this.employeeId = '',
    this.mobileNo = '',
    this.address = '',
    this.joiningDate = '',
  });

  copyWith(
      {String? name,
      String? email,
      String? employeeId,
      String? mobileNo,
      String? address,
      String? joiningDate}) {
    UserProfile(
        name: name ?? this.name,
        mobileNo: mobileNo ?? this.mobileNo,
        email: email ?? this.email,
        employeeId: employeeId ?? this.employeeId,
        address: address ?? this.address,
        joiningDate: joiningDate ?? this.joiningDate);
  }
}

// UserProfileNotifier (ViewModel)
class UserProfileNotifier extends StateNotifier<UserProfile?> {
  final Dio dio;
  UserProfileNotifier(this.dio) : super(UserProfile());

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

  // Function to fetch the user profile data
  Future<void> fetchUserProfile() async {
    try {
      // Simulate a delay for API call
      await Future.delayed(Duration(seconds: 2));

      // Update state after fetching data (replace this with your actual API call logic)
      state = UserProfile(
        name: "Nikit Sir",
        email: "rinkesh@270698@gmail.com",
        employeeId: "C171",
        mobileNo: "98765431234",
        address: "Indore",
        joiningDate: "July 28, 2024",
      );
    } catch (e) {
      // Handle any errors that occur during the fetch
      print("Error fetching user profile: $e");
    }
  }
}

// Provider to expose UserProfileNotifier
final userProfileProvider =
    StateNotifierProvider<UserProfileNotifier, UserProfile?>((ref) {
      final dio = ref.read(dioProvider);
  return UserProfileNotifier(dio);
});
