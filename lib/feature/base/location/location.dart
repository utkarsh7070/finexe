

import 'dart:developer';

import 'package:finexe/feature/base/api/dio_exception.dart';
import 'package:geolocator/geolocator.dart';

Future<Position?> getCurrentLocation() async {
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
    ExceptionHandler().handleError(e);
   
    return null;
  }
}