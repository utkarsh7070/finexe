import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:finexe/feature/base/api/api.dart';
import 'package:finexe/feature/base/api/dio_exception.dart';
import 'package:finexe/feature/base/extentions/dio_extension.dart';

// import 'package:finexe_attendance/feature/attendance/model/response_model.dart';
import 'package:flutter/foundation.dart';
import 'package:geolocator/geolocator.dart';

// import '../../constant/api/api.dart';
// import '../../constant/extension/dio_extension.dart';
import '../../base/location/location.dart';
import 'punch_in_repository.dart';

class PunchInRepositoryImp extends PunchInRepository {
  final dio = DioClientExtension.client;

  // Map<String, String> _headers = <String, String>{
  //   'Content-Type': 'application/json',
  //   'Accept': 'application/json',
  // };

  @override
  Future<dynamic> punchIn(Map<String, String> token) async {

    Position? position = await getCurrentLocation();
    if (position == null) {
      return Future.error('Unable to fetch location');
    }

    // Construct the query parameters
    Map<String, dynamic> queryParam = { // Action value
      'longitude': position.longitude, // Longitude from the current position
      'latitude': position.latitude, // Latitude from the current position
    };
    print('token $token');
    print('Query Parameters IN: $queryParam');
    try {
      Response response =
      await dio.get(Api.punchIn,queryParameters: queryParam, options: Options(headers: token));
      log('punchIn api: ${Api.punchIn.toString()}');

      // if (kDebugMode) {
      //   print(response.data);
      // }
      // if (response.statusCode == 500) {
      //   if (kDebugMode) {
      //     print('500 error');
      //   }
      // } else if (response.statusCode == 404) {
      //   if (kDebugMode) {}
      // } else if (response.statusCode == 200){
        return response;
      // }
    } catch (exception) {
      ExceptionHandler().handleError(exception);
      return Future.error(exception);
    }
  }

  @override
  Future<dynamic> punchOut(Map<String, String> token) async {
    Position? position = await getCurrentLocation();
    if (position == null) {
      return Future.error('Unable to fetch location');
    }

    // Construct the query parameters
    Map<String, dynamic> queryParam = {
      'longitude': position.longitude, // Longitude from the current position
      'latitude': position.latitude, // Latitude from the current position
    };
    print('token $token');
    print('Query Parameters OUT: $queryParam');
    try {
      Response response =
      await dio.get(Api.punchOut,queryParameters: queryParam, options: Options(headers: token));
      log('punchOut api: ${Api.punchOut.toString()}');
      print('punch out response $response');
      if (response.statusCode == 200) {
        return response;
      }
      if (kDebugMode) {
        // log(">>>L " + response.data);
      }
      if (response.statusCode == 500) {
        if (kDebugMode) {
          print('500 error');
        }
      } else if (response.statusCode == 404) {
        log('404 error');
      } else {
        return response;
      }
    } catch (exception) {
      return Future.error(exception);
    }
  }

  @override
  Future<dynamic> checkPunch(
      Map<String, double> queryParam, Map<String, String> token) async {
    try {
      Response response = await dio.get(Api.checkPunchIn,
          queryParameters: queryParam, options: Options(headers: token));
      log('queryParam: $queryParam');
      log('checkPunchIn api: ${Api.checkPunchIn.toString()}');

      if (kDebugMode) {
        print('check punch status ${response.data}');
      }
      if (response.statusCode == 500){
        if (kDebugMode) {
          print('500 error');
        }
      } else if (response.statusCode == 404) {
        if (kDebugMode) {}
      } else {
        return response;
      }
    } catch (exception) {
      return Future.error(exception);
    }
  }
}


/*Future<Position?> getCurrentLocation() async {
  bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
  if (!serviceEnabled) {
    log('Location services are disabled.');
    return null;
  }

  LocationPermission permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      log('Location permissions are denied.');
      return null;
    }
  }

  if (permission == LocationPermission.deniedForever) {
    log('Location permissions are permanently denied.');
    return null;
  }

  try {
    Position position = await Geolocator.getCurrentPosition(
      locationSettings: const LocationSettings(
        accuracy: LocationAccuracy.high,
        distanceFilter: 100,
      ),
    );
    return position;
  } catch (e) {
    log('Error getting location: $e');
    return null;
  }
}*/

