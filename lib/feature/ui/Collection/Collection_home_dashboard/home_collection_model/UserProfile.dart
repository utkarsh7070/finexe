import 'package:flutter_riverpod/flutter_riverpod.dart';

// Create a user profile model
class UserProfile {
  final String name;
  final String email;
  final String employeeId;
  final String mobileNo;
  final String address;
  final String joiningDate;
  final String? imageUrl; // Add image URL (optional)


  UserProfile({
    required this.name,
    required this.email,
    required this.employeeId,
    required this.mobileNo,
    required this.address,
    required this.joiningDate,
    this.imageUrl, // Add this field to handle profile picture
  });
}

// State notifier to manage API data
class UserProfileNotifier extends StateNotifier<UserProfile?> {
  UserProfileNotifier() : super(null);

  Future<void> fetchUserProfile() async {
    // Call your API here and parse the response
    // Example: final response = await http.get('your_api_endpoint');

    // Simulate API response
    await Future.delayed(Duration(seconds: 2));
    state = UserProfile(
      name: "Nikit Sir",
      email: "rinkesh@270698@gmail.com",
      employeeId: "C171",
      mobileNo: "98765431234",
      address: "Indore",
      joiningDate: "July 28, 2024",
    );
  }
}

// Provider to access the state
final userProfileProvider = StateNotifierProvider<UserProfileNotifier, UserProfile?>(
      (ref) => UserProfileNotifier(),
);
