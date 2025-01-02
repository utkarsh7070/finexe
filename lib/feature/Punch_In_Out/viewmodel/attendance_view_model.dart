import 'dart:async';
import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:finexe/feature/Punch_In_Out/model/check_attendance_responce_model.dart';
import 'package:finexe/feature/Punch_In_Out/repository/puch_In_repository_imp.dart';
import 'package:finexe/feature/base/api/dio.dart';
import 'package:finexe/feature/base/api/dio_exception.dart';
import 'package:finexe/feature/base/routes/routes.dart';
import 'package:finexe/feature/base/utils/general/pref_utils.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../Eod/AddBOD_dialogue/AddBOD_dialogue/model/add_task_request_model.dart';
import '../../Eod/AddBOD_dialogue/AddBOD_dialogue/model/add_task_response_model.dart';
import '../../base/api/api.dart';
import '../../base/utils/namespase/app_colors.dart';
import '../../base/utils/widget/custom_snackbar.dart';
import '../model/response_model.dart';

class AttendanceState {
  final String employeeName;
  final bool isLoading;
  final bool? punchAllowed;
  final bool punchStatus;
  final Position? currentPosition;
  final String? distanceMessage;
  final String taskTitle;
  final String taskDescription;
  final CheckAttendanceResponseModel? checkAttendanceResponse;
  final String employeeId;
  final String token;

  AttendanceState(
      {this.taskTitle = '',
        this.taskDescription = '',
        this.punchAllowed ,
        this.employeeName = '',
        this.isLoading = false,
        this.punchStatus = false,
        this.currentPosition,
        this.distanceMessage,
        this.checkAttendanceResponse,
        this.employeeId = '',
        this.token = ''});

  AttendanceState copyWith({
    String? taskTitle,
    String? taskDescription,
    String? employeeId,
    String? token,
    String? employeeName,
    bool? isLoading,
    bool? punchAllowed,
    bool? punchStatus,
    Position? currentPosition,
    String? distanceMessage,
    CheckAttendanceResponseModel? checkAttendanceResponse,
  }) {
    return AttendanceState(
      punchAllowed: punchAllowed??this.punchAllowed,
      taskDescription: taskDescription ?? this.taskDescription,
      taskTitle: taskTitle ?? this.taskTitle,
      employeeId: employeeId ?? this.employeeId,
      token: token ?? this.token,
      employeeName: employeeName ?? this.employeeName,
      isLoading: isLoading ?? this.isLoading,
      punchStatus: punchStatus ?? this.punchStatus,
      currentPosition: currentPosition ?? this.currentPosition,
      distanceMessage: distanceMessage ?? this.distanceMessage,
      checkAttendanceResponse:
      checkAttendanceResponse ?? this.checkAttendanceResponse,
    );
  }
}

// Define the AttendanceNotifier
class AttendanceNotifier extends StateNotifier<AttendanceState> {
  final PunchInRepositoryImp _punchInRepository;
  final Dio dio;
  late Timer trackingTimer;

  AttendanceNotifier(this._punchInRepository, this.dio)
      : super(AttendanceState()) {
    getCurrentLocation();
  }

  final TextEditingController taskTitleController = TextEditingController();
  final TextEditingController taskDescriptionController =
  TextEditingController();
  String? storedToken;

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  void updateTaskTitle(String value) {
    state = state.copyWith(taskTitle: value);
  }

  void updateTaskDescription(String value) {
    state = state.copyWith(taskTitle: value);
  }

  Future<void> onAddTask(BuildContext context) async {
    // SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    // String? token = sharedPreferences.getString('token');
    String? token =speciality.getToken();

    state = state.copyWith(isLoading: true);
    // state = const AsyncValue.loading();
    final headers = {"token": token};
    if (kDebugMode) {
      print(headers.values);
    }
    AddTaskRequestModel addTaskRequestModel = AddTaskRequestModel(
        assignBy: state.employeeId,
        employeeId: [state.employeeId],
        task: state.taskTitle,
        description: state.taskDescription);
    // if (kDebugMode) {
    //   print("Authorization Token: $token");
    //   print("API Endpoint: ${Api.addTask}");
    //   print("Request Data: ${addTaskRequestModel.toJson()}");
    // }

    try {
      final response = await dio.post(
        Api.addTask,
        data: addTaskRequestModel.toJson(),
        options: Options(
          headers: headers,
          // validateStatus: (status) => status != null && status < 500,
        ),
      );

      if (response.statusCode == 200) {
        final addTaskResponseModel =
        AddTaskResponseModel.fromJson(response.data);
        if (kDebugMode) {
          print("Add Task Response: ${response.data}");
        }
        showCustomSnackBar(context, 'BOD Added', AppColors.green);
        Navigator.pop(context);
      } else if (response.statusCode == 401) {
        if (kDebugMode) {
          print("401 response: ${response.data}");
          print("Unauthorized: Check token validity.");
        }
        // state = AsyncValue.error(
        //     "Unauthorized: Token might be invalid or expired.",
        //     StackTrace.current);
      } else {
        print("Unexpected Error: ${response.statusCode}");
        // state = AsyncValue.error(
        //     "Error ${response.statusCode}: ${response.data}",
        //     StackTrace.current);
      }
    } catch (error) {
      DioExceptions.fromDioError(error as DioException, context);
      // state = AsyncValue.error(error, stackTrace);
      print("Exception occurred: ${error.toString()}");
    } finally {
      //print('object');
      state = state.copyWith(isLoading: false);
    }
  }

  Future<void> getCurrentLocation() async {
    state = state.copyWith(isLoading: true);

    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      state = state.copyWith(
          isLoading: false, distanceMessage: 'Location services are disabled.');
      return;
    }

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        log('location denied');
        state = state.copyWith(
            isLoading: false,
            distanceMessage: 'Location permissions are denied.');
        return;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      log('LocationPermission.deniedForever');
      state = state.copyWith(
          isLoading: false,
          distanceMessage: 'Location permissions are permanently denied.');
      return;
    }

    Position position = await Geolocator.getCurrentPosition(
      locationSettings: const LocationSettings(
        accuracy: LocationAccuracy.high,
        distanceFilter: 100,
      ),
    );
    state = state.copyWith(currentPosition: position);
    await getToken();
    await checkPunch().then(
          (value) {
        state = state.copyWith(isLoading: false);
        if (kDebugMode) {
          print('puch>>>>>>>> ');
          log('puch>>>>>>>> ');
        }
      },
    );
  }

  Future<void> getToken() async {
    // SharedPreferences preferences = await SessionService.getSession();
    // final String? name = preferences.getString('email');
    final String? name = speciality.getUserEmail();


    if (kDebugMode) {
      print('set in pinchin screen name $name');
    }

    storedToken = speciality.getToken();
    // final name = preferences.getString('email');
    state = state.copyWith(isLoading: false);
    state = state.copyWith(employeeName: speciality.getUserEmail());
    log("storedToken: $storedToken");
  }

  Future<PunchAttendanceModel?> checkPunch() async {
    if (state.currentPosition != null && storedToken != null) {
      Map<String, String> token = {"token": storedToken!};
      Map<String, double> location = {
        "latitude": state.currentPosition!.latitude,
        "longitude": state.currentPosition!.longitude,
      };

      try {
        Response response =
        await _punchInRepository.checkPunch(location, token);
        print(response.data);
        CheckAttendanceResponseModel checkAttendanceResponse =
        CheckAttendanceResponseModel.fromJson(response.data);
        state =
            state.copyWith(checkAttendanceResponse: checkAttendanceResponse);
        state =
            state.copyWith(punchStatus: checkAttendanceResponse.items.punchIn,punchAllowed: checkAttendanceResponse.items.allowed);
        log('punchIn Status: ${checkAttendanceResponse.items.punchIn}');
        return PunchAttendanceModel(allowed: checkAttendanceResponse.items.allowed, punchIn: checkAttendanceResponse.items.punchIn);
      } on DioException catch (error) {
        if (kDebugMode) {
          print(error);
        }
        throw Exception(error);
        // state = state.copyWith(isLoading: false);
        // DioExceptions.fromDioError(error,context);
      }
    }
    return null;
  }

//   Future<void> initialiseRoamSdk(String? trackingMode, String? roamId) async {
//     print("Attempting to initialize Roam SDK...");
//     try {
//
//       await requestLocationPermissions();
//
//       // Roam.createUser(description: 'First user', callBack: ({user}) {
//       //   if (user != null) {
//       //     // print("User created successfully: ${user['userId']}")
//       //
//       //     print('User created successfully: $user');
//       //
//       //     // Roam.offlineTracking(true);
//       //     // Roam.allowMockLocation(allow: true);
//       //
//       //   } else {
//       //     print("Failed to create user.");
//       //   }
//       // });
//       Roam.getUser(userId:roamId!,callBack: ({user}) {
// // do something on get user
//         Roam.startTracking(trackingMode: trackingMode);
//         print(user);
//       });
//       Roam.enableAccuracyEngine();
//       print('after AccuracyEngine');
//       Roam.onLocation((location) async {
//         if (kDebugMode) {
//           print(jsonEncode(location));
//         }
//       });
//       print('after onLocation');
//       // try {
//       //
//       // } on PlatformException {
//       //   print('Enable Accuracy Engine Error');
//       // }
//
//       // listenToLocationUpdates();
//
//
//
//
//       // if (Platform.isAndroid) {
//       //   initializeService();
//       // } else {
//       //   Roam.onLocation((location) async {
//       //     print(jsonEncode(location));
//       //     await platform.invokeMethod('send_notification', {'body': jsonEncode(location)});
//       //     setState(() {
//       //       locationResponse = location.toString();
//       //     });
//       //   });
//       // }
//
//       // Roam.setForeground(true, "Flutter Example", "Tap to open", "mipmap/ic_launcher", "ai.roam.example.MainActivity");
//       print('tracking begain');
//
//
//       print('tracking end');
//
//
//       Roam.onLocation((location) {
//         if (location != null) {
//           print("Location update: ${jsonEncode(location)}");
//         } else {
//           print("No location update received.");
//         }
//         print("Received location from Roam SDK: ${jsonEncode(location)}");
//         /*showCustomSnackBar(
//           context, "Received location from Roam SDK: ${jsonEncode(location)}", Colors.green);*/
//       });
//       // await listenToLocationUpdates();
//
//
//       trackingTimer = Timer(Duration(hours: 15), () {
//         Roam.stopTracking();
//         print("Tracking stopped after 15 minutes.");
//       });
//
//     } catch (e) {
//       print("Failed to initialize Roam SDK: $e");
//     }
//   }
//
//   Future<void> requestLocationPermissions() async {
//     final locationWhenInUse = await Permission.locationWhenInUse.request();
//     if (locationWhenInUse.isGranted) {
//       final locationAlways = await Permission.locationAlways.request();
//       if (!locationAlways.isGranted) {
//         print("Location always permission not granted.");
//       } else {
//         print("Location permissions granted.");
//         await getCurrentLocation1();
//       }
//     } else {
//       print("Location permission denied.");
//     }
//   }
//
//   Future<void> getCurrentLocation1() async {
//     Position position = await Geolocator.getCurrentPosition(
//       desiredAccuracy: LocationAccuracy.high,
//     );
//     print("Initial location: ${position.latitude}, ${position.longitude}");
//   }
//
//   Future<void> listenToLocationUpdates() async {
//     print("Setting location listener...");
//
//     print("Location listener set.");
//   }


  Future<void> clickPunch(BuildContext context) async {
    // SharedPreferences preferences = await SharedPreferences.getInstance();
    
  //   List<String>? role = preferences.getStringList('roleName');
  //   final String? employeeID = preferences.getString('employeId');
  //   final String? token = preferences.getString('token');
  //  final String? roamId =  preferences.getString('roamId');
  //   final String? trackingMode =  preferences.getString('trackingMode');
    List<String>? role = speciality.getRole();
    final String? employeeID = speciality.getEmployeId();
    final String? token = speciality.getToken();
   final String? roamId = speciality.getRoamId();
    final String? trackingMode =  speciality.getTrackingMode();

    if (kDebugMode) {
      print(role?.first);
    }
    state = state.copyWith(employeeId: employeeID, token: token);
    state = state.copyWith(isLoading: true);
    // if (state.punchStatus) {
    await onPunchIn(context).then(
          (value) async {

        if (kDebugMode) {
          print(value);
        }
        if (value!) {
          await checkPunch().then(
                (value) {
              state = state.copyWith(punchStatus: value?.punchIn);
            },
          );
        }

        // if(trackingMode!=null && roamId!=null){
        //   // initialiseRoamSdk(trackingMode, roamId);
        // }
        if (value) {
          switch (role?.first.toString()) {
            case 'admin':
              log("Navigating to admin dashboard");
              Navigator.pushNamedAndRemoveUntil(
                context,
                AppRoutes.dashBoard, // Admin dashboard route
                    (route) => false, // Remove all previous routes
              );

              break;
            case 'sales':
              log("Navigating to sales dashboard");
              Navigator.pushNamedAndRemoveUntil(
                context,
                AppRoutes.dashBoard, // Sales dashboard route
                    (route) => false, // Remove all previous routes
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
                case 'creditPd':
              log("Navigating to collection dashboard");
              Navigator.pushNamedAndRemoveUntil(
                context,
                AppRoutes.pdscreen, // Collection dashboard route
                    (route) => false, // Remove all previous routes
              );
              break;
            default:
              Navigator.pushNamedAndRemoveUntil(
                context,
                AppRoutes.hrms, // Collection dashboard route
                    (route) => false, // Remove all previous routes
              );
            // Handle unknown roles or navigate to a default screen
              log('No matching role found');
              break;
          }
        }
      },
    );
    // } else {
    //   // await onPunchOut().then((value) async {
    //   //   if(value!){
    //   //     await checkPunch().then((value) {
    //   //       state = state.copyWith(punchStatus: value);
    //   //     },);
    //   //   }
    //   // },);
    // }
    state = state.copyWith(isLoading: false);
  }

  Future<bool?> onPunchIn(BuildContext context) async {
    Map<String, String> token = {"token": "$storedToken"};

    try {
      log('onPunchIn');
      state = state.copyWith(isLoading: true);
      var response = await _punchInRepository.punchIn(token);
      log('onPunchIn after');
      PunchInModel punchInModel = PunchInModel.fromJson(response.data);
      log(">>>punchin: ${response.data}");
      Fluttertoast.showToast(
        msg: punchInModel.message.toString(),
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.TOP,
        backgroundColor: Colors.white,
        textColor: Colors.blue,
        fontSize: 16.0,
      );

      await checkPunch();
      state = state.copyWith(
        isLoading: false,
        // punchStatus: false
      );
      return true;
      // Navigator.pushNamed(context, AppRoutes.eod);
    } catch (error) {
    ExceptionHandler().handleError(error);
      
    }finally{
state = state.copyWith(isLoading: false);
    }
    return false;
  }

  Future<bool?> onPunchOut(BuildContext context) async {
    print(storedToken);
    Map<String, String> token = {"token": storedToken!};
    // Map<String, String> tokens = {"token": token!};
    print(token.values);
    try {
      log('onPunchOut');
      var response = await _punchInRepository.punchOut(token);
      print('punch out response  ${response.data}');
      // log("onPunchOut response: " + response.);
      log('puch');
      var responseData = response.data; // Assuming response.data is a Map
      var message = responseData['message'];
      // Punch punchInModel = PunchInModel.fromJson(response.data);
      if (response.statusCode == 200) {
        showCustomSnackBar(context, message, AppColors.green);
      
        // PunchInModel punchInModel = PunchInModel.fromJson(response.data);
      } else {
        showCustomSnackBar(context, message, AppColors.green);
      }

      await checkPunch();
      return true;
    } on DioException catch (error) {
      DioExceptions.fromDioError(error, context);
    }
    return null;
  }
}

// final socketServiceProvider = Provider<SocketService>((ref) {
//   final socketService = SocketService();
//   socketService.connectSocket();  // Connect when the provider is created
//   return socketService;
// });

final punchInRepositoryProvider =
Provider.autoDispose<PunchInRepositoryImp>((ref) {
  return PunchInRepositoryImp(); // Provides instance of PunchInRepository
});

// Create the AttendanceNotifierProvider
final attendanceProvider =
StateNotifierProvider<AttendanceNotifier, AttendanceState>((ref) {
  final dio = ref.watch(dioProvider);
  // final socket = ref.watch(socketServiceProvider);
  return AttendanceNotifier(ref.watch(punchInRepositoryProvider), dio);
});

//
// class UserSession extends AsyncNotifier<String?> {
//   @override
//   Future<String?> build() async {
//     final prefs = await SharedPreferences.getInstance();
//     return prefs.getString('email'); // Loads username if available
//   }
//
//   // Future<void> setUser(String username) async {
//   //   final prefs = await SharedPreferences.getInstance();
//   //   await prefs.setString('username', username);
//   //   state = AsyncData(username);
//   // }
//   //
//   // Future<void> clearUser() async {
//   //   final prefs = await SharedPreferences.getInstance();
//   //   await prefs.clear();
//   //   state = const AsyncData(null);
//   // }
// }
//
// final userSessionProvider = AsyncNotifierProvider<UserSession, String?>(UserSession.new);

// final checkCurrentLocation = FutureProvider<String>(
//   (ref) async {
//     SharedPreferences preferences = await SessionService.getSession();
//     final String? name = await preferences.getString('email');
//     print('set in punch in screen name $name');
//     return name!;
//   },
// );
//
// Future<Position> getCurrentLocation() async {
//   await Geolocator.requestPermission();
//   LocationSettings locationSettings = const LocationSettings(
//     accuracy: LocationAccuracy.high,
//     distanceFilter: 100,
//   );
//   return Geolocator.getCurrentPosition(locationSettings: locationSettings);
// }
class PunchAttendanceModel{
  final bool allowed;
  final bool punchIn;

  PunchAttendanceModel({required this.allowed, required this.punchIn});
}




