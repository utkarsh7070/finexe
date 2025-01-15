import 'dart:async';

import 'package:dio/dio.dart';
import 'package:finexe/feature/base/api/dio.dart';
import 'package:finexe/feature/base/api/dio_exception.dart';
import 'package:finexe/feature/base/utils/general/pref_utils.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart';

import '../../../Punch_In_Out/model/check_attendance_responce_model.dart';
import '../../../base/api/api.dart';
import '../../../base/utils/namespase/app_constants.dart';

// final sessionProvider = FutureProvider((ref) async {
//   final _punchInRepository = ref.watch(punchInRepositoryProvider);
//   final dio = ref.watch(dioProvider);
//   final position = await getCurrentLocation();
//   // Fetch the token from SharedPreferences
//   SharedPreferences prefs = await SharedPreferences.getInstance();
//   String? tokens = prefs.getString('token');
//   List<String>? role = prefs.getStringList('roleName');
//   bool? punchStatus;
//   String? apkUrl;
//   bool isUpdateRequired =  false;
//   print(position.latitude);
//   print(position.longitude);
//   // log('stored token:: ' + tokens.toString());
//   // log('stored role:: ' + role!.first??'');
//   if (position != null && tokens != null) {
//     Map<String, String> token = {"token": tokens};
//     Map<String, double> location = {
//       "latitude": position.latitude,
//       "longitude": position.longitude,
//     };
//
//     try {
//       var response = await _punchInRepository.checkPunch(location, token);
//       final versionResponse = await dio.get(Api.getVersion);
//       var checkAttendanceResponse =
//           CheckAttendanceResponseModel.fromJson(response.data);
//       print(response.data);
//       punchStatus = checkAttendanceResponse.items.punchIn;
//       final data = versionResponse.data['items'];
//       final serverVersion = data['version'];
//       apkUrl = data['apkUrl'];
//       print(response.data);
//
//       print('app server version- ${serverVersion} and App version-${AppConstants.staticAppVersion}');
//        isUpdateRequired = serverVersion != AppConstants.staticAppVersion;
//
//     } on DioException catch (error) {
//       // DioExceptions.fromDioError(error,context);
//     }
//   }
//   return AsyncValue.data(SesstionModel(
//       token: tokens != null, role: role?.first, puntchStatus: punchStatus,apkUrl: apkUrl,isUpdateRequired: isUpdateRequired));
//   // SesstionModel(
//   //   token: tokens != null, role: role, puntchStatus: punchStatus);
//   // Return true if token exists (logged in), false otherwise (not logged in)
// });

class SessionModel {
  final bool? token;
  final String? role;
  final bool? puntchStatus;
  final String? apkUrl;
  final bool? isUpdateRequired;

  // final List<String>?allRoleName;

  SessionModel(
      {this.token = false,
      this.role = '',
      this.puntchStatus = false,
      this.apkUrl = '',
      this.isUpdateRequired = false});
}

Future<Position> getCurrentLocation() async {
  await Geolocator.requestPermission();
  LocationSettings locationSettings = const LocationSettings(
    accuracy: LocationAccuracy.high,
    distanceFilter: 100,
  );
  return Geolocator.getCurrentPosition(locationSettings: locationSettings);
}

// .................Version Api.............

final splashViewModelProvider =
    AsyncNotifierProvider<SplashViewModel, SessionModel>(() {
  return SplashViewModel();
});

final restart = StateProvider<bool>(
  (ref) => false,
);


final showLogoProvider = StateProvider<bool>((ref) => true);
final showWelcomeImageProvider = StateProvider<bool>((ref) => false);
final addressProvider = StateProvider<String>((ref) => "Fetching your location...");


class SplashViewModel extends AsyncNotifier<SessionModel> {
  // SplashViewModel() : super(const AsyncValue.loading());
  final ApiService _apiService = ApiService();

  @override
  FutureOr<SessionModel> build() {
    return _apiService.fetchPosts(ref);
  }


  // Update address in the view model
  void updateAddress(WidgetRef ref, String newAddress) {
    ref.read(addressProvider.notifier).state = newAddress;
  }

  // Toggle logo and welcome image
  void toggleLogoAndImage(WidgetRef ref) {
    ref.read(showLogoProvider.notifier).state = false;
    ref.read(showWelcomeImageProvider.notifier).state = true;
  }
}

final downloadProvider = StateProvider.autoDispose<String>(
  (ref) {
    return '';
  },
);

class ApiService {
  ApiService();



  bool? punchStatus;
  String? apkUrl;
  bool isUpdateRequired = false;

  Future<SessionModel> fetchPosts(ref) async {
    final dio = ref.watch(dioProvider);
    List<String>? role = speciality.getRole();
    String? tokens = speciality.getToken();

    // Check location only if necessary
    Future<Position> positionFuture = getCurrentLocation();

    // Fetch version data concurrently
    Future<Map<String, dynamic>> versionFuture = fetchVersion(dio);
    Position position = await positionFuture;
    Map<String, dynamic> versionData = await versionFuture;
    if (kDebugMode) {
      print(versionData.toString());
    }
    Map<String, double> location = {
      "latitude": position.latitude,
      "longitude": position.longitude,
    };
    print('User\'s current location: ${location.toString()}');

    if (tokens != null && versionData['isUpdateRequired'] != null) {
      Map<String, String> token = {"token": tokens};
      try {
        Response response = await dio.get(Api.checkPunchIn,
            queryParameters: location, options: Options(headers: token));

        if (kDebugMode) {
          print('Response data: $response');
        }

        // if (response.statusCode == 200) {
        CheckAttendanceResponseModel checkAttendanceResponse =
            CheckAttendanceResponseModel.fromJson(response.data);
        bool? punchStatus = checkAttendanceResponse.items.punchIn;

        return SessionModel(
          token: true,
          role: role?.first,
          puntchStatus: punchStatus,
          apkUrl: versionData['apkUrl'],
          isUpdateRequired: versionData['isUpdateRequired']??false,
        );

    } catch (e) {
      ExceptionHandler().handleError(e);

    }
    return SessionModel(
      token: tokens != null,
      role: role?.first,
      puntchStatus: null,
      apkUrl: versionData['apkUrl'],
      isUpdateRequired: versionData['isUpdateRequired'],
    );
  }

     return SessionModel(
    token: tokens != null,
    role: role?.first,
    puntchStatus: null,
    apkUrl: versionData['apkUrl'],
    isUpdateRequired: versionData['isUpdateRequired'],
  );

}

 Future<Map<String, dynamic>> fetchVersion(Dio dio) async {

  try {
    Response versionResponse = await dio.get(Api.getVersion);
    final data = versionResponse.data['items'];
    final serverVersion = data['version'];
    final apkUrl = data['apkUrl'];
    bool isUpdateRequired = serverVersion != AppConstants.staticAppVersion;


  Future<Map<String, dynamic>> fetchVersion(Dio dio) async {
    try {
      Response versionResponse = await dio.get(Api.getVersion);
      final data = versionResponse.data['items'];
      final serverVersion = data['version'];
      final apkUrl = data['apkUrl'];
      bool isUpdateRequired = serverVersion != AppConstants.staticAppVersion;

      return {'apkUrl': apkUrl, 'isUpdateRequired': isUpdateRequired};
    } catch (e) {
      // Use the ExceptionHandler to handle the error uniformly
      ExceptionHandler().handleError(e);
      // Return a default value in case of error
      return {
        'apkUrl': null,
        'isUpdateRequired': null,
      };
    }
  }

}

}



