


//...............For Image update.........


import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../Punch_In_Out/model/check_attendance_responce_model.dart';
import '../../../../Punch_In_Out/repository/puch_In_repository_imp.dart';
import '../../../../Punch_In_Out/viewmodel/attendance_view_model.dart';
import '../../../../base/api/api.dart';
import '../../../../base/api/dio.dart';
import '../../../../base/api/dio_exception.dart';
import '../../../../base/utils/Repo/image_upload.dart';
import '../../../../base/utils/general/pref_utils.dart';
import '../../../Sales/SalesProfile/model/image_upload_model.dart';

import '../model/hrms_user_profile_model.dart';

final imageProvider = StateProvider<String?>((ref) => null);


final hrmsImageUploadViewModelProvider = StateNotifierProvider<HrmsImageRequestViewModel ,String>((ref) {
  final dio = ref.watch(dioProvider);
  return HrmsImageRequestViewModel(dio);
},);


class HrmsImageRequestViewModel extends StateNotifier<String> {
  final Dio _dio;
  HrmsImageRequestViewModel(this._dio) :super('');

  Future<void> clickImage() async {

    final imageUrl = await DocsUploader.uploadImage(dio: _dio,isCompressed: true,compressedValue: 50,byCamera: true);
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


//............Get Employee Detais.........

final hrmsLoginUserProfileProvider =
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
    final data = HRMSUserProfileResponseModel.fromJson(response.data);
    final returnData = HRMSUserProfile(
        designationId:data.items?.designationId?.name??'',
        punchInTime: punchTime.first,
        punchOutTime: punchTime.last,
        mobileNo: data.items?.mobileNo??0,
        email: data.items?.email??'',
        /* employeeId: data.items?.employeeTypeId?.id??'',*/
        employeeId: data.items?.id??'',
        joiningDate: data.items?.joiningDate.toString()??'',
        fatherName: data.items?.fatherName??'',
        dateOfBirth: data.items?.dateOfBirth.toString()??'',
        employeePhoto: data.items?.employeePhoto??'',
        employeName: data.items?.employeName??'',
        employeUniqueId: data.items?.employeUniqueId??'');
    print('Login User data response: $data');
    return returnData;

  } catch (error) {
    ExceptionHandler().handleError(error);

    // Log the error for debugging
    print('Error: $error');
    rethrow; // The FutureProvider will handle this as an AsyncError
  }
});


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