// user_profile_view_model.dart
import 'dart:async';

import 'package:finexe/feature/base/api/dio.dart';
import 'package:finexe/feature/base/api/dio_exception.dart';
import 'package:finexe/feature/base/utils/general/pref_utils.dart';
import 'package:finexe/feature/ui/HRMS/LeaveManagement/model/hrmsUserProfile.dart';
import 'package:flutter/Material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:dio/dio.dart';
import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../Punch_In_Out/model/check_attendance_responce_model.dart';
import '../../../../Punch_In_Out/repository/puch_In_repository_imp.dart';
import '../../../../Punch_In_Out/viewmodel/attendance_view_model.dart';
import '../../../../base/api/api.dart';
import '../../../../base/utils/Repo/image_upload.dart';
import '../../../../base/utils/widget/custom_snackbar.dart';
import '../model/image_upload_model.dart';

/*final loginUserProfileProvider = StateNotifierProvider<UserProfileNotifier, AsyncValue<LoginUserProfile>>((ref) {
  return UserProfileNotifier();
});

class UserProfileNotifier extends StateNotifier<AsyncValue<LoginUserProfile>> {
  UserProfileNotifier() : super(const AsyncLoading());

  Future<void> fetchLoginUserProfile() async {
    try {
<<<<<<< HEAD
      String? token = speciality.getToken();
=======
      String? token = speciality.getToken();
>>>>>>> origin/To_merge
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

Future<Position> _getCurrentLocation() async {
  bool serviceEnabled;
  LocationPermission permission;

  serviceEnabled = await Geolocator.isLocationServiceEnabled();
  if (!serviceEnabled) {}
  print('serviceEnabled $serviceEnabled');
  // Check location permissions
  permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {}
  }

  if (permission == LocationPermission.deniedForever) {
    // Permissions are permanently denied, handle this scenario

    // return null;
  }
  LocationSettings locationSettings = const LocationSettings(
    accuracy: LocationAccuracy.high,
    distanceFilter: 100,
  );
  // Get the current position
  Position position =
      await Geolocator.getCurrentPosition(locationSettings: locationSettings);

  return position;

  // await _calculateDistance();
}

Future<List<String>> checkPunchStatus(PunchInRepositoryImp punch) async {
  Position position = await _getCurrentLocation();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String? tokens = prefs.getString('token');
  List<String>? role = prefs.getStringList('roleName');
  bool? punchStatus;
  print(position.latitude);
  print(position.longitude);
  // log('stored token:: ' + tokens.toString());
  // log('stored role:: ' + role!.first??'');
  if (tokens != null) {
    Map<String, String> token = {"token": tokens};
    Map<String, double> location = {
      "latitude": position.latitude,
      "longitude": position.longitude,
    };
    try {
      var response = await punch.checkPunch(location, token);
      var checkAttendanceResponse =
          CheckAttendanceResponseModel.fromJson(response.data);
      List<String> responseData = [
        checkAttendanceResponse.items.punchInTime.toString(),
        checkAttendanceResponse.items.punchOutTime.toString()
      ];
      return responseData;
    } on DioException {
      // DioExceptions.fromDioError(error, context);
    }
  }
  return [];
}

String formatTime(String time) {
  print(time);
  try {
    if (time.isEmpty) return 'N/A';
    DateFormat format = DateFormat("yyyy-MM-dd'T'hh:mm:ss a");
    DateTime dateTime = format.parse(time);// Handle empty strings
    // final parsedTime = DateTime.parse(time);
    print('parse time $dateTime');
    return DateFormat.jm()
        .format(dateTime); // Format as 09:30 AM/PM
  } catch (e) {
    // Log or handle invalid date format
    // debugPrint("Error parsing date: $e");
    return 'Invalid Time';
  }
}

String formatDate(String time) {
  print(time);
  try {
    if (time.isEmpty) return 'N/A';
    DateFormat format = DateFormat("yyyy-MM-dd'T'hh:mm:ss a");
    DateTime dateTime = format.parse(time);// Handle empty strings
    // final parsedTime = DateTime.parse(time);
    print('parse time $dateTime');
    return DateFormat.yMMMMd()
        .format(dateTime); // Format as 09:30 AM/PM
  } catch (e) {
    // Log or handle invalid date format
    // debugPrint("Error parsing date: $e");
    return 'Invalid Time';
  }
}


final loginUserProfileProvider =
    FutureProvider.autoDispose<HRMSUserProfile>((ref) async {
  final punchInRepository = ref.watch(punchInRepositoryProvider);
  List<String> punchTime = await checkPunchStatus(punchInRepository);

  try {
    // Fetch the token
    String? token = speciality.getToken();

    // Make the API call
    final response = await Dio().get(
      Api.getEmployeeDetails,
      options: Options(headers: {"token": token}),
    );

    // Log the full response to debug
    print('Response user login: ${response.data}');

    // if (response.statusCode == 200) {
      // Parse the response and return the data
      final data = HRMSUserProfile.fromJson(response.data['items']);
      final returnData = HRMSUserProfile(designationId: data.designationId,
          punchInTime: punchTime.first,
          punchOutTime: punchTime.last,
          mobileNo: data.mobileNo,
          email: data.email,
          employeeId: data.employeeId,
          joiningDate: data.joiningDate,
          fatherName: data.fatherName,
          dateOfBirth: data.dateOfBirth,
          employeePhoto: data.employeePhoto,
          employeName: data.employeName,
          employeUniqueId: data.employeUniqueId);
      print('Login User data response: $data');
      return returnData;
  
  } catch (error) {
    ExceptionHandler().handleError(error);
    
    // Log the error for debugging
    print('Error: $error');
    rethrow; // The FutureProvider will handle this as an AsyncError
  }
});


//...............For Image update.........


final imageProvider = StateProvider<String?>((ref) => null);


final imageUploadViewModelProvider = StateNotifierProvider<ImageRequestViewModel ,String>((ref) {
  final dio = ref.watch(dioProvider);
  return ImageRequestViewModel(dio);
},);


class ImageRequestViewModel extends StateNotifier<String> {
final Dio _dio;
  ImageRequestViewModel(this._dio) :super('');

Future<void> clickImage() async {

  final imageUrl = await DocsUploader.uploadImage(dio: _dio,byCamera: true,compressedValue: 70,isCompressed: true);
  print('uloaded image $imageUrl');
  if (imageUrl != null) {
    state = imageUrl;
    //ref.read(imageProvider)?.state = imageUrl; // Update provider
    submitProfileUpdateImage(imageUrl);
  }
}
// Form submission logic
  Future<void> submitProfileUpdateImage(
      String imageUrl) async {
    final leaveData = ImageUploadModel(
      imageNew: imageUrl,
    );

    try {
      String? token = speciality.getToken();

      final response = await _dio.post(
        Api.updateProfileImage,
        data: leaveData.toJson(),
        options: Options(headers: {"token": token}),
      );

      print('image response $response');

      if (response.statusCode == 200) {
       // leaveSuccess(context);
       //  showCustomSnackBar(context, 'Image Update', Colors.green);
        // Navigator.pop(context, true);
      } else {
        throw Exception('Failed to submit leave request');
      }
    }
    catch (e) {
      if (e is DioException) {
        if (e.response?.statusCode == 400) {
          // Handle 400 response
          final errorMessage = e.response?.data['message'] ?? 'Bad Request';
          print("400 Error: $errorMessage");
          // showCustomSnackBar(context, errorMessage, Colors.red);
        } else {
          // Handle other Dio errors
          print("DioError: ${e.message}");
        //   showCustomSnackBar(
        //       context, "Something went wrong. Please try again.", Colors.red);
         }
      } else {
        // Handle non-Dio errors
        print("Error submitting form: $e");
        // showCustomSnackBar(
        //     context, "An unexpected error occurred.", Colors.red);
      }
    }
  }


}

