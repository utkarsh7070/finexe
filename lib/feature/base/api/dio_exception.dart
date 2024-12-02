import 'package:dio/dio.dart';
import 'package:finexe/feature/ui/authenticate/model/error_model.dart';
import 'package:flutter/material.dart';

import '../utils/widget/custom_snackbar.dart';

/*class DioExceptions implements Exception {
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
            DioExceptionType.badResponse.name, Colors.red);

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
}*/

class DioExceptions implements Exception {
  final String errorMessage; // Declared as final

  DioExceptions.fromDioError(DioException error, BuildContext context)
      : errorMessage = _mapErrorToMessage(error, context);

  static String _mapErrorToMessage(DioException error, BuildContext context) {
    String message = 'An error occurred'; // Default message

    switch (error.type) {
      case DioExceptionType.connectionTimeout:
        message = 'Connection timed out. Please try again later.';
        break;
      case DioExceptionType.sendTimeout:
        message = 'Request timed out while sending data.';
        break;
      case DioExceptionType.receiveTimeout:
        message = 'Response timed out from the server.';
        break;
      case DioExceptionType.badCertificate:
        message = 'Invalid SSL certificate detected.';
        break;
      case DioExceptionType.badResponse:
        final responseData = error.response?.data;
        if (responseData is Map<String, dynamic>) {
          try {
            final errorModel = ErrorModel.fromJson(responseData);
            message = errorModel.message.isNotEmpty
                ? errorModel.message
                : 'Unexpected server error occurred.';
          } catch (e) {
            message = responseData['message'] ?? 'Server error occurred.';
          }
        } else if (responseData is String) {
          message = responseData;
        } else {
          message = 'Unexpected server error occurred.';
        }
        break;
      case DioExceptionType.cancel:
        message = 'Request was cancelled.';
        break;
      case DioExceptionType.connectionError:
        message = 'Connection error. Please check your internet connection.';
        break;
      case DioExceptionType.unknown:
      default:
        message = 'An unknown error occurred.';
        break;
    }

    showCustomSnackBar(context, message, Colors.red);
    return message;
  }
}

