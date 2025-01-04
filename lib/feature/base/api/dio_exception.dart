import 'package:dio/dio.dart';
import 'package:finexe/feature/ui/authenticate/model/error_model.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../utils/widget/custom_snackbar.dart';

class DioExceptions implements Exception {
  ErrorModel? errorModel;

  DioExceptions.fromDioError(DioException error, BuildContext context) {
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
        showCustomSnackBar(
            context, DioExceptionType.connectionTimeout.name, Colors.red);
        // Get.snackbar('Finexe', DioExceptionType.connectionTimeout.name);
        break;
      case DioExceptionType.sendTimeout:
        showCustomSnackBar(
            context, DioExceptionType.sendTimeout.name, Colors.red);
        // Get.snackbar('Finexe', DioExceptionType.sendTimeout.name);
        break;
      case DioExceptionType.receiveTimeout:
        showCustomSnackBar(
            context, DioExceptionType.receiveTimeout.name, Colors.red);
        // Get.snackbar('Finexe', DioExceptionType.receiveTimeout.name);
        break;
      case DioExceptionType.badCertificate:
        ErrorModel errorModel = ErrorModel.fromJson(error.response?.data);
        showCustomSnackBar(context, errorModel.message, Colors.red);
        // Get.snackbar('Finexe', DioExceptionType.badCertificate.name);
        break;
      case DioExceptionType.badResponse:
        errorModel = ErrorModel.fromJson(error.response!.data);
        showCustomSnackBar(context, errorModel!.message, Colors.red);

        // Get.snackbar('Finexe', errorModel!.message,backgroundColor: Colors.red.shade500,colorText: Colors.white);
        break;
      case DioExceptionType.cancel:
        showCustomSnackBar(context, DioExceptionType.cancel.name, Colors.red);
        // Get.snackbar('Finexe', DioExceptionType.cancel.name);
        break;
      case DioExceptionType.connectionError:
        showCustomSnackBar(
            context, DioExceptionType.connectionError.name, Colors.red);
        // Get.snackbar('Finexe', 'Please check your internet connection');
        break;
      case DioExceptionType.unknown:
        showCustomSnackBar(context, DioExceptionType.unknown.name, Colors.red);
        // Get.snackbar('Finexe', DioExceptionType.unknown.name);
        break;
    }
  }
}



// dio exception  handler - 


class ExceptionHandler {
  // Singleton instance for reusability
  static final ExceptionHandler _instance = ExceptionHandler._internal();

  factory ExceptionHandler() {
    return _instance;
  }

  ExceptionHandler._internal();

  // function to handle Api errors after status code 200 
//    void handleApiError(BuildContext context, String message, int statusCode) {
//   String errorMessage = message;

//   // Customize error messages based on status codes
//   if (statusCode == 400) {
//     errorMessage = message.isNotEmpty ? message : 'Bad Request';
//   } else if (statusCode == 404) {
//     errorMessage = 'User not found';
//   } else if (statusCode == 401) {
//     errorMessage = 'Invalid credentials';
//   } else {
//     errorMessage = message.isNotEmpty ? message : 'Unknown error occurred';
//   }

//   // Show error message in a toast/snackbar
//   showCustomSnackBar(context, errorMessage, Colors.red);
// }


  // Function to handle Dio exceptions
  void handleDioError(DioException error) {
    String errorMessage = 'Something went wrong';
    print(error.response?.statusCode);
    // Handle different DioException types
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
        errorMessage = 'Connection timeout. Please try again.';
        break;
      case DioExceptionType.sendTimeout:
        errorMessage = 'Send timeout. Please try again.';
        break;
      case DioExceptionType.receiveTimeout:
        errorMessage = 'Receive timeout. Please try again.';
        break;
      case DioExceptionType.badResponse:
        if (error.response != null) {
          switch (error.response?.statusCode) {
            case 400:
              errorMessage = error.response?.data['message'] ?? 'Bad Request';
              break;
            case 401:
              errorMessage =error.response?.data['message'] ?? 'Unauthorized. Please check your credentials.';
              break;
            case 403:
              errorMessage =error.response?.data['message'] ?? 'Forbidden. You do not have permission.';
              break;
            case 404:
              errorMessage =error.response?.data['message'] ?? 'Not Found. The requested resource could not be found.';
              break;
            case 500:
              errorMessage = error.response?.data['message'] ??'Server error. Please try again later.';
              break;
            default:
              errorMessage = 'Server error. Please try again later.';
          }
        }
        break;
      case DioExceptionType.cancel:
        errorMessage = 'Request was canceled by the user.';
        break;
      case DioExceptionType.connectionError:
        errorMessage = 'Network error. Please check your internet connection.';
        break;
      case DioExceptionType.badCertificate:
        errorMessage = 'Invalid SSL certificate.';
        break;
      case DioExceptionType.unknown:
        errorMessage = 'An unknown error occurred. Please try again.';
        break;
    }

    // Show the error message via FlutterToast
    Fluttertoast.showToast(msg: errorMessage,backgroundColor: Colors.red,fontSize: 18);
  }

  // Function to handle other exceptions (non-Dio errors)
  void handleGeneralError(Exception error) {
    print("Error: $error");
    Fluttertoast.showToast(msg: 'An unexpected error occurred. Please try again.',backgroundColor: Colors.red,fontSize: 18);
  }

  // Function to handle all errors uniformly (Dio or general exceptions)
  void handleError(dynamic error) {
    if (error is DioException) {
      handleDioError(error);
    } else if (error is Exception) {
      handleGeneralError(error);
    } else {
      Fluttertoast.showToast(msg: 'An unknown error occurred.',backgroundColor: Colors.red,fontSize: 18);
    }
  }
}


// class DioExceptions implements Exception {
//   final String errorMessage; // Declared as final
//
//   DioExceptions.fromDioError(DioException error, BuildContext context)
//       : errorMessage = _mapErrorToMessage(error, context);
//
//   static String _mapErrorToMessage(DioException error, BuildContext context) {
//     String message = 'An error occurred'; // Default message
//
//     switch (error.type) {
//       case DioExceptionType.connectionTimeout:
//         message = 'Connection timed out. Please try again later.';
//         break;
//       case DioExceptionType.sendTimeout:
//         message = 'Request timed out while sending data.';
//         break;
//       case DioExceptionType.receiveTimeout:
//         message = 'Response timed out from the server.';
//         break;
//       case DioExceptionType.badCertificate:
//         message = 'Invalid SSL certificate detected.';
//         break;
//       case DioExceptionType.badResponse:
//         final responseData = error.response?.data;
//         if (responseData is Map<String, dynamic>) {
//           try {
//             final errorModel = ErrorModel.fromJson(responseData);
//             message = errorModel.message.isNotEmpty
//                 ? errorModel.message
//                 : 'Unexpected server error occurred.';
//           } catch (e) {
//             message = responseData['message'] ?? 'Server error occurred.';
//           }
//         } else if (responseData is String) {
//           message = responseData;
//         } else {
//           message = 'Unexpected server error occurred.';
//         }
//         break;
//       case DioExceptionType.cancel:
//         message = 'Request was cancelled.';
//         break;
//       case DioExceptionType.connectionError:
//         message = 'Connection error. Please check your internet connection.';
//         break;
//       case DioExceptionType.unknown:
//       default:
//         message = 'An unknown error occurred.';
//         break;
//     }
//
//     showCustomSnackBar(context, message, Colors.red);
//     return message;
//   }
// }
