import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class DioExceptions implements Exception {
   // ErrorModel? errorModel;
  DioExceptions.fromDioError(DioException error) {
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
        // Get.snackbar('Finexe', DioExceptionType.connectionTimeout.name);
        break;
      case DioExceptionType.sendTimeout:
        // Get.snackbar('Finexe', DioExceptionType.sendTimeout.name);
        break;
      case DioExceptionType.receiveTimeout:
        // Get.snackbar('Finexe', DioExceptionType.receiveTimeout.name);
        break;
      case DioExceptionType.badCertificate:
        // Get.snackbar('Finexe', DioExceptionType.badCertificate.name);
        break;
      case DioExceptionType.badResponse:
        // errorModel=ErrorModel.fromJson(error.response!.data);
        // Get.snackbar('Finexe', errorModel!.message,backgroundColor: Colors.red.shade500,colorText: Colors.white);
        break;
      case DioExceptionType.cancel:
        // Get.snackbar('Finexe', DioExceptionType.cancel.name);
        break;
      case DioExceptionType.connectionError:
        // Get.snackbar('Finexe', 'Please check your internet connection');
        break;
      case DioExceptionType.unknown:
        // Get.snackbar('Finexe', DioExceptionType.unknown.name);
        break;
    }
  }
}
