import 'dart:async';
import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:finexe/feature/base/api/dio.dart';
import 'package:finexe/feature/base/utils/general/pref_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../base/api/api.dart';
import '../../base/routes/routes.dart';
import '../../base/service/session_service.dart';
import '../../base/utils/widget/custom_snackbar.dart';

final punchInOutSideViewModelProvider = StateProvider.autoDispose((ref) {
  final dio = ref.watch(dioProvider);
  return PunchInOutSideViewModel(dio);
} );

class PunchInOutSideViewModel {
  PunchInOutSideViewModel(this._dio);
  final Dio _dio ;
  // late Timer trackingTimer;

  Future<void> punchInOutSideRequestWithRole(String reasonForPunch, BuildContext context) async {
    bool isSuccess = await punchInOutSideRequest(reasonForPunch, context);

    if (isSuccess) {
      // Fetch roles and handle navigation
      SharedPreferences preferences = await SharedPreferences.getInstance();
      List<String>? role = preferences.getStringList('roleName');
      // String? name = preferences.getString('name');
       // initialiseRoamSdk(context,name??'');

      if (role != null && role.isNotEmpty) {
        navigateBasedOnRole(role.first, context);
      } else {
        log('No roles found for user.');
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Unable to determine user role.")),
        );
      }
    }
  }

  Future<bool> punchInOutSideRequest(String reasonForPunch, BuildContext context) async {
    try {
      // String? token = speciality.getToken();
      String? token = speciality.getToken();


      final requestData = {
        "remark": reasonForPunch,
      };

      final response = await _dio.post(
        Api.punchOutSide,
        data: requestData,
        options: Options(headers: {"token": token}),
      );

      if (response.statusCode == 200) {
        showCustomSnackBar(context, 'Punch In Successfully', Colors.green);
        return true;
      } else {
        showCustomSnackBar(context, 'Failed to punch in. Try again.', Colors.red);
        return false;
      }
    } catch (e) {
      showCustomSnackBar(context, 'An error occurred. Please try again.', Colors.red);
      print("Error submitting form: $e");
      return false;
    }
  }

  void navigateBasedOnRole(String role, BuildContext context) {
    switch (role) {
      case 'admin':
        log("Navigating to admin dashboard");
        Navigator.pushNamedAndRemoveUntil(
          context,
          AppRoutes.dashBoard,
              (route) => false,
        );
        break;
      case 'sales':
        log("Navigating to sales dashboard");
        Navigator.pushNamedAndRemoveUntil(
          context,
          AppRoutes.dashBoard,
              (route) => false,
        );
        break;
      case 'collection':
        log("Navigating to collection dashboard");
        Navigator.pushNamedAndRemoveUntil(
          context,
          AppRoutes.collectionHome,
              (route) => false,
        );
        break;
      case 'salesAndCollection':
        log("Navigating to collection dashboard");
        Navigator.pushNamedAndRemoveUntil(
          context,
          AppRoutes.dashBoard, // Collection dashboard route
              (route) => false, // Remove all previous routes
        );
        break;

      case 'cibil':
        log("Navigating to collection dashboard");
        Navigator.pushNamedAndRemoveUntil(
          context,
          AppRoutes.dashBoard, // Collection dashboard route
              (route) => false, // Remove all previous routes
        );
        break;

      case 'salesPdAndCollection':
        log("Navigating to collection dashboard");
        Navigator.pushNamedAndRemoveUntil(
          context,
          AppRoutes.dashBoard, // Collection dashboard route
              (route) => false, // Remove all previous routes
        );
        break;
      default:
        Navigator.pushNamedAndRemoveUntil(
          context,
          AppRoutes.hrms, // Collection dashboard route
              (route) => false, // Remove all previous routes
        );
        break;
    }
  }

  // Future<void> initialiseRoamSdk(BuildContext context,String name) async {
  //   if (kDebugMode) {
  //     print("Attempting to initialize Roam SDK...");
  //   }
  //   try {
  //     await requestLocationPermissions();
  //     if (kDebugMode) {
  //       print("Permissions granted, initializing Roam SDK...");
  //     }
  //
  //     Roam.initialize(
  //       publishKey: '58f73be503e069888cf19289bf728c14c2e841c47e5842a1054f9e5f12f52583',
  //     );
  //     if(kDebugMode) {
  //       print("Roam SDK initialized.");
  //     }
  //
  //     Roam.getUser(userId:'672b16d23e8a8f5a915d743e', callBack: ({user}) {
  //       if (kDebugMode) {
  //         print('User name - $user');
  //       }
  //     });
  //
  //     Map<String, dynamic> fitnessTracking = {
  //       "timeInterval": 10
  //     };
  //     Roam.startTracking(trackingMode: "custom", customMethods: fitnessTracking);
  //     if (kDebugMode) {
  //       print("Custom tracking started with 10-second interval.");
  //     }
  //     listenToLocationUpdates(context);
  //     trackingTimer = Timer(Duration(hours: 12), () {
  //       Roam.stopTracking();
  //       print("Tracking stopped after 15 minutes.");
  //     });
  //
  //   } catch (e) {
  //     print("Failed to initialize Roam SDK: $e");
  //   }
  // }
  //
  // Future<void> listenToLocationUpdates(BuildContext context) async {
  //   print("Setting location listener...");
  //   Roam.onLocation((location) {
  //     print("Received location from Roam SDK: ${jsonEncode(location)}");
  //     showCustomSnackBar(
  //         context, "Received location from Roam SDK: ${jsonEncode(location)}", Colors.green);
  //   });
  //   print("Location listener set.");
  // }
  //
  // Future<void> requestLocationPermissions() async {
  //   final locationWhenInUse = await Permission.locationWhenInUse.request();
  //   if (locationWhenInUse.isGranted) {
  //     final locationAlways = await Permission.locationAlways.request();
  //     if (!locationAlways.isGranted) {
  //       print("Location always permission not granted.");
  //     } else {
  //       print("Location permissions granted.");
  //       await getCurrentLocation();
  //     }
  //   } else {
  //     print("Location permission denied.");
  //   }
  // }
  // Future<Position> getCurrentLocation() async {
  //   await Geolocator.requestPermission();
  //   LocationSettings locationSettings = const LocationSettings(
  //     accuracy: LocationAccuracy.high,
  //     distanceFilter: 100,
  //   );
  //   return Geolocator.getCurrentPosition(locationSettings: locationSettings);
  // }
}