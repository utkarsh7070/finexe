import 'package:dio/dio.dart';
import 'package:finexe/feature/ui/authenticate/model/error_model.dart';
import 'package:flutter/material.dart';

import '../utils/widget/custom_snackbar.dart';

class DioExceptions implements Exception {
   ErrorModel? errorModel;
  DioExceptions.fromDioError(DioException error,BuildContext context) {
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
        showCustomSnackBar(context,
            DioExceptionType.connectionTimeout.name, Colors.red);
        // Get.snackbar('Finexe', DioExceptionType.connectionTimeout.name);
        break;
      case DioExceptionType.sendTimeout:
        showCustomSnackBar(context,
            DioExceptionType.sendTimeout.name, Colors.red);
        // Get.snackbar('Finexe', DioExceptionType.sendTimeout.name);
        break;
      case DioExceptionType.receiveTimeout:
        showCustomSnackBar(context,
            DioExceptionType.receiveTimeout.name, Colors.red);
        // Get.snackbar('Finexe', DioExceptionType.receiveTimeout.name);
        break;
      case DioExceptionType.badCertificate:
        showCustomSnackBar(context,
            DioExceptionType.badCertificate.name, Colors.red);
        // Get.snackbar('Finexe', DioExceptionType.badCertificate.name);
        break;
      case DioExceptionType.badResponse:
        errorModel=ErrorModel.fromJson(error.response!.data);
        showCustomSnackBar(context,
            DioExceptionType.badCertificate.name, Colors.red);

        // Get.snackbar('Finexe', errorModel!.message,backgroundColor: Colors.red.shade500,colorText: Colors.white);
        break;
      case DioExceptionType.cancel:
        showCustomSnackBar(context,
            DioExceptionType.cancel.name, Colors.red);

        // Get.snackbar('Finexe', DioExceptionType.cancel.name);
        break;
      case DioExceptionType.connectionError:
        showCustomSnackBar(context,
            DioExceptionType.connectionError.name, Colors.red);
        // Get.snackbar('Finexe', 'Please check your internet connection');
        break;
      case DioExceptionType.unknown:
        showCustomSnackBar(context,
            DioExceptionType.unknown.name, Colors.red);
        // Get.snackbar('Finexe', DioExceptionType.unknown.name);
        break;
    }
  }
}
