import 'dart:async';
import 'package:dio/dio.dart';
import 'package:finexe/feature/base/api/dio.dart';

import 'package:finexe/feature/base/utils/general/pref_utils.dart';
import 'package:finexe/feature/base/utils/widget/custom_snackbar.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geolocator/geolocator.dart';
import 'package:shared_preferences/shared_preferences.dart';
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
      {/*this.allRoleName,*/ this.token = false,
      this.role = '',
      this.puntchStatus = false,
      this.apkUrl = '',
      this.isUpdateRequired = false});
}

// final punchInRepositoryProvider = Provider.autoDispose<PunchInRepositoryImp>((ref) {
//   return PunchInRepositoryImp(); // Provides instance of PunchInRepository
// });

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

// class VersionCheckState {
//   final String? apkUrl;
//   final bool isUpdateRequired;
//  // static const String staticAppVersion = "1"; // Current app version
//
//   VersionCheckState({this.apkUrl, required this.isUpdateRequired});
// }

class SplashViewModel extends AsyncNotifier<SessionModel> {
  // SplashViewModel() : super(const AsyncValue.loading());
  final ApiService _apiService = ApiService();

  @override
  FutureOr<SessionModel> build() {
    return _apiService.fetchPosts(ref);
  }
  // void downloadApk(String apkUrl,context){
  //   _apiService.downloadAndInstallApk(apkUrl);
  // }
}

final downloadProvider = StateProvider.autoDispose<String>(
  (ref) {
    return '';
  },
);

class ApiService {
  ApiService();
  // static const platform = MethodChannel('apk_channel');
  // final PunchInRepositoryImp repositoryImp = PunchInRepositoryImp();
  // final Dio _dio = Dio();
  bool? punchStatus;
  String? apkUrl;
  bool isUpdateRequired = false;

  Future<SessionModel> fetchPosts(ref) async {
    List<String>? role = speciality.getRole();
    String? tokens = speciality.getToken();

    // Check location only if necessary
    Future<Position> positionFuture =  getCurrentLocation();

    // Fetch role and token from prefs

    // Fetch version data concurrently
    var versionFuture = fetchVersion();
    Position position = await positionFuture;
    var versionData = await versionFuture;
      
      Map<String, double> location = {
        "latitude": position.latitude,
        "longitude": position.longitude,
      };
      print('users current location ${location.toString()} ');

    if (tokens != null) {
      final dio = ref.watch(dioProvider);

    Map<String, String> token = {"token": tokens};
      try {
        Response response = await dio.get(Api.checkPunchIn,
            queryParameters: location, options: Options(headers: token));

        if (kDebugMode) {
          print('response data////// ${response}');
        }

        if (response.statusCode == 200) {
          CheckAttendanceResponseModel checkAttendanceResponse =
              CheckAttendanceResponseModel.fromJson(response.data);
          bool? punchStatus = checkAttendanceResponse.items.punchIn;

          return SessionModel(
            token: true,
            role: role?.first,
            puntchStatus: punchStatus,
            apkUrl: versionData['apkUrl'],
            isUpdateRequired: versionData['isUpdateRequired'],
          );
        } else {
          throw Exception('Failed to check punch-in status');
        }
      } catch (e) {
        if (e is DioException) {
          if (e.response?.statusCode == 400) {
            // Handle 400 response
            final errorMessage = e.response?.data['message'] ?? 'Bad Request';
            print("400 Error: $errorMessage");
            Fluttertoast.showToast(msg: errorMessage.toString());
            // showCustomSnackBar(ref, errorMessage, Colors.red);
          } else {
            // Handle other Dio errors
            // print("DioError: ${e.message}");
            Fluttertoast.showToast(msg: 'Somthing went wrong');
            // showCustomSnackBar(
            //     ref, "Something went wrong. Please try again.", Colors.red);
          }
        } else {
          // Handle non-Dio errors
          print("Error submitting form: $e");
          Fluttertoast.showToast(msg: e.toString());
        }
      }
    }
    return SessionModel(
      token: tokens != null,
      role: role?.first,
      puntchStatus: false,
      apkUrl: versionData['apkUrl'],
      isUpdateRequired: versionData['isUpdateRequired'],
    );
  }

  Future<Map<String, dynamic>> fetchVersion() async {
    final dio = Dio();
    try {
      Response versionResponse = await dio.get(Api.getVersion);
      final data = versionResponse.data['items'];
      final serverVersion = data['version'];
      final apkUrl = data['apkUrl'];
      bool isUpdateRequired = serverVersion != AppConstants.staticAppVersion;
      return {'apkUrl': apkUrl, 'isUpdateRequired': isUpdateRequired};
    } catch (e) {
      throw Exception('Error fetching version data: $e');
    }
  }

  // Future<void> downloadAndInstallApk(String apkUrl) async {
  //   try {
  //
  //     const apkPath = '/storage/emulated/0/Download/FinexeApp.apk';
  //         //
  //     final file = File(apkPath);
  //
  //     await _dio.download(apkUrl, file.path);
  //     // Install APK
  //     InstallPlugin.installApk(file.path, appId: "com.example.finexe")
  //         .then((_) => print("APK Installation Started"))
  //         .catchError((e) => print("Error installing APK: $e"));
  //   } catch (e) {
  //     print("Download failed: $e");
  //   }
  // }

  // Future<void> downloadApk(String apkUrl,ref,context) async {
  //   try {
  //     final dir = await getExternalStorageDirectory();
  //     final filePath = '${dir!.path}/app_update.apk';
  //     final permission = await Permission.requestInstallPackages.request();
  //     if (permission.isDenied) {
  //       await Permission.requestInstallPackages.request();
  //     } else {
  //       // Check and delete any existing file
  //       final file = File(filePath);
  //       if (await file.exists()) {
  //         await file.delete();
  //       }
  //       // final dio = ref.watch(dioProvider);
  //       await _dio.download(
  //         apkUrl,
  //         filePath,
  //         onReceiveProgress: (received, total) {
  //           if (total != -1) {
  //             final String val = (received / total * 100).toStringAsFixed(0);
  //             ref.watch(downloadProvider.notifier).state = val;
  //             print(
  //                 "Downloading: ${(received / total * 100).toStringAsFixed(0)}%");
  //           }
  //         },
  //       );
  //       // openApk(filePath,context);
  //       installApk(filePath);
  //     }
  //   } catch (e) {
  //     print("Download failed: $e");
  //   }
  // }
  // void openApk(String filePath,context) {
  //   print('openfile $filePath');
  //   OpenFile.open(filePath, type: '.apk').then((value) {
  //     Navigator.pop(context);
  //   },);
  // }
  //
  // Future<void> installApk(String apkPath) async {
  //   try {
  //     await platform.invokeMethod('installApk', {"apkPath": apkPath});
  //   } on PlatformException catch (e) {
  //     throw Exception("Failed to install APK: ${e.message}");
  //   }
  // }
}

// final isDialogVisible = StateProvider<bool>((ref) {
//   return false;
// },);


