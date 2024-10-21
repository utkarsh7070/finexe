import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'dart:async';

// UserProfile model class
class UserProfile {
  final String name;
  final String email;
  final String employeeId;
  final String mobileNo;
  final String address;
  final String joiningDate;

  UserProfile({
    required this.name,
    required this.email,
    required this.employeeId,
    required this.mobileNo,
    required this.address,
    required this.joiningDate,
  });
}

// UserProfileNotifier (ViewModel)
class UserProfileNotifier extends StateNotifier<UserProfile?> {
  // Initialize the state as null in the constructor
  UserProfileNotifier() : super(null);

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
final userProfileProvider = StateNotifierProvider<UserProfileNotifier, UserProfile?>(
      (ref) => UserProfileNotifier(),
);
