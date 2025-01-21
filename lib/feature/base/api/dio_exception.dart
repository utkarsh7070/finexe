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
        break;
      case DioExceptionType.sendTimeout:
        showCustomSnackBar(
            context, DioExceptionType.sendTimeout.name, Colors.red);
        break;
      case DioExceptionType.receiveTimeout:
        showCustomSnackBar(
            context, DioExceptionType.receiveTimeout.name, Colors.red);
        break;
      case DioExceptionType.badCertificate:
        ErrorModel errorModel = ErrorModel.fromJson(error.response?.data);
        showCustomSnackBar(context, errorModel.message, Colors.red);
        break;
      case DioExceptionType.badResponse:
        errorModel = ErrorModel.fromJson(error.response!.data);
        showCustomSnackBar(context, errorModel!.message, Colors.red);
        break;
      case DioExceptionType.cancel:
        showCustomSnackBar(context, DioExceptionType.cancel.name, Colors.red);
        break;
      case DioExceptionType.connectionError:
        showCustomSnackBar(
            context, DioExceptionType.connectionError.name, Colors.red);
        break;
      case DioExceptionType.unknown:
        showCustomSnackBar(context, DioExceptionType.unknown.name, Colors.red);
        break;
    }
  }
}

class ExceptionHandler {
  static final ExceptionHandler _instance = ExceptionHandler._internal();

  factory ExceptionHandler() {
    return _instance;
  }

  ExceptionHandler._internal();

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
              errorMessage = error.response?.data['message'] ??
                  'Unauthorized. Please check your credentials.';
              break;
            case 403:
              errorMessage = error.response?.data['message'] ??
                  'Forbidden. You do not have permission.';
              break;
            case 404:
              errorMessage = error.response?.data['message'] ??
                  'Not Found. The requested resource could not be found.';
              break;
            case 500:
              errorMessage = error.response?.data['message'] ??
                  'Server error. Please try again later.';
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
    Fluttertoast.showToast(
        msg: errorMessage, backgroundColor: Colors.red, fontSize: 18);
  }

  // Function to handle other exceptions (non-Dio errors)
  void handleGeneralError(Exception error) {
    print("Error: $error");
    Fluttertoast.showToast(
        msg: 'An unexpected error occurred. Please try again.',
        backgroundColor: Colors.red,
        fontSize: 18);
  }

  // Function to handle all errors uniformly (Dio or general exceptions)
  void handleError(dynamic error) {
    if (error is DioException) {
      handleDioError(error);
    } else if (error is Exception) {
      handleGeneralError(error);
    } else {
      Fluttertoast.showToast(
          msg: 'An unknown error occurred.',
          backgroundColor: Colors.red,
          fontSize: 18);
    }
  }
}
