

import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../base/api/api.dart';
import '../../../../base/service/session_service.dart';
import '../../../../base/utils/widget/custom_snackbar.dart';
import '../model/leave_request_model.dart';
import 'package:dio/dio.dart';


final leaveRequestViewModelProvider = Provider.autoDispose((ref) => LeaveRequestViewModel());

class LeaveRequestViewModel {
  final Dio _dio = Dio();

  Future<void> submitLeaveRequest(LeaveRequestItem leadData, BuildContext context) async {
    try {
      String? token = await SessionService.getToken();

      print('Leave input ${leadData.toJson()}');
      final response = await _dio.post(
        Api.submitLeaveRequest, // Replace with your API endpoint
        data: leadData.toJson(),
        options: Options(headers: {"token": token}),
      );

      print('Leave Request Response ${response.data}');

      final responseMessage = response.data['message'];
      print('Response message: $responseMessage');

      if (response.statusCode == 200) {
        log('Leave Request Successfully');
        showCustomSnackBar(context, 'Leave Request Submitted', Colors.green);
        Navigator.pop(context, true); // Return success to the previous screen
      } else {
        throw Exception('Failed to load data');
      }
    } catch (e) {
      if (e is DioException) {
        if (e.response?.statusCode == 400) {
          // Handle 400 response
          final errorMessage = e.response?.data['message'] ?? 'Bad Request';
          print("400 Error: $errorMessage");
          showCustomSnackBar(context, errorMessage, Colors.red);
        } else {
          // Handle other Dio errors
          print("DioError: ${e.message}");
          showCustomSnackBar(context, "Something went wrong. Please try again.", Colors.red);
        }
      } else {
        // Handle non-Dio errors
        print("Error submitting form: $e");
        showCustomSnackBar(context, "An unexpected error occurred.", Colors.red);
      }
    }
  }


/*Future<void> submitLeaveRequest(LeaveRequestItem leadData,BuildContext context) async {
    try {
      String? token = await SessionService.getToken();

      print('Leave input ${leadData.toJson()}');
      final response = await _dio.post(Api.submitLeaveRequest, // Replace with your API endpoint
          data: leadData.toJson(),
          options: Options(headers: {"token": token})
      );

      print('Leave Request Response ${response.data}');

      final responseMessage=response.data['message'];

      print('response message $responseMessage');


      if (response.statusCode == 200) {
        log('Leave Request Successfully');
      //  print('Leave Request Response ${response.data}');
        showCustomSnackBar(context, 'Leave Request Submitted', Colors.green);
        //Navigator.of(context).pop();
        Navigator.pop(context,true);
        // Handle success response
      } else {
        throw Exception('Failed to load data');
      }
    } catch (e) {
      // Handle error
      print("Error submitting form: $e");
    }
  }*/

}
