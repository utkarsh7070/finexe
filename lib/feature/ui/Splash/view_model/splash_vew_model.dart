import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../Punch_In_Out/model/check_attendance_responce_model.dart';
import '../../../Punch_In_Out/repository/puch_In_repository_imp.dart';
import '../../../base/api/api.dart';
import '../../../base/utils/namespase/app_constants.dart';

final sessionProvider = FutureProvider((ref) async {
  final _punchInRepository = ref.watch(punchInRepositoryProvider);
  final position = await getCurrentLocation();
  // Fetch the token from SharedPreferences
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String? tokens = prefs.getString('token');
  List<String>? role = prefs.getStringList('roleName');
  bool? punchStatus;
  print(position.latitude);
  print(position.longitude);
  // log('stored token:: ' + tokens.toString());
  // log('stored role:: ' + role!.first??'');
  if (position != null && tokens != null) {
    Map<String, String> token = {"token": tokens};
    Map<String, double> location = {
      "latitude": position.latitude,
      "longitude": position.longitude,
    };

    try {
      var response = await _punchInRepository.checkPunch(location, token);
      var checkAttendanceResponse =
          CheckAttendanceResponseModel.fromJson(response.data);
      print(response.data);
      punchStatus = checkAttendanceResponse.items.punchIn;
    } on DioException catch (error) {
      // DioExceptions.fromDioError(error,context);
    }
  }
  return AsyncValue.data(SesstionModel(
      token: tokens != null, role: role?.first, puntchStatus: punchStatus));
  // SesstionModel(
  //   token: tokens != null, role: role, puntchStatus: punchStatus);
  // Return true if token exists (logged in), false otherwise (not logged in)
});

class SesstionModel {
  bool? token;
  String? role;
  bool? puntchStatus;

  SesstionModel(
      {this.token = false, this.role = '', this.puntchStatus = false});
}

final punchInRepositoryProvider = Provider<PunchInRepositoryImp>((ref) {
  return PunchInRepositoryImp(); // Provides instance of PunchInRepository
});

Future<Position> getCurrentLocation() async {
  await Geolocator.requestPermission();
  LocationSettings locationSettings = const LocationSettings(
    accuracy: LocationAccuracy.high,
    distanceFilter: 100,
  );
  return Geolocator.getCurrentPosition(locationSettings: locationSettings);
}

// .................Version Api.............

final versionViewModelProvider = StateNotifierProvider.autoDispose<VersionViewModel, AsyncValue<VersionCheckState>>((ref) {
  return VersionViewModel();
});

class VersionCheckState {
  final String? apkUrl;
  final bool isUpdateRequired;
 // static const String staticAppVersion = "1"; // Current app version

  VersionCheckState({this.apkUrl, required this.isUpdateRequired});
}

class VersionViewModel extends StateNotifier<AsyncValue<VersionCheckState>> {
  VersionViewModel() : super(const AsyncValue.loading());

  Future<void> checkVersion() async {
    try {
      final response = await Dio().get(Api.getVersion);
      final data = response.data['items'];
      final serverVersion = data['version'];
      final apkUrl = data['apkUrl'];
      print(response.data);

      print('app server version- ${serverVersion} and App version-${AppConstants.staticAppVersion}');
      final isUpdateRequired = serverVersion != AppConstants.staticAppVersion;

      state = AsyncValue.data(VersionCheckState(apkUrl: apkUrl, isUpdateRequired: isUpdateRequired));
    } catch (e, stackTrace) {
      state = AsyncValue.error(e, stackTrace);
    }
  }
}

final downloadProvider =  StateProvider<String>((ref) {
  return '';
},);

// final isDialogVisible = StateProvider<bool>((ref) {
//   return false;
// },);


