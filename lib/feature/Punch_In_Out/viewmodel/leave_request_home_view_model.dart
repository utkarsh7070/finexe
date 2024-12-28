



import 'package:dio/dio.dart';
import 'package:finexe/feature/base/utils/general/pref_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../base/api/api.dart';
import '../../base/utils/widget/custom_snackbar.dart';
import '../../ui/HRMS/LeaveManagement/model/leave_request_model.dart';

final leaveRequestHomeViewModelProvider = Provider.autoDispose((ref) => LeaveRequestHomeViewModel());

class LeaveRequestHomeViewModel {
  final Dio _dio = Dio();

  /*Future<void> submitLeaveHomeRequest(LeaveRequestItem leadData,BuildContext context) async {
    try {
<<<<<<< HEAD
      String? token = speciality.getToken();
=======
      String? token = speciality.getToken();
>>>>>>> origin/To_merge
      print('Leave Request token ${token}');

      print('Leave input leadData ${leadData.toJson()}');

    //  print('Leave input ${leadData.toJson()}');
      final response = await _dio.post(Api.submitLeaveRequest, // Replace with your API endpoint
          data: leadData.toJson(),
          options: Options(headers: {"token": token})
      );

      final responseData=response.data;
      print('Leave Request Response: $responseData');
      String message=responseData['message'];

      print('Leave Request Response ${response.data}');

      if (response.statusCode == 200 ) {
        log('Leave Request Successfully');
        //  print('Leave Request Response ${response.data}');
        showCustomSnackBar(context, 'Leave Request Submitted', Colors.green);
        //Navigator.of(context).pop();
      //  Navigator.pop(context,true);
        // Handle success response
      }
      else if(response.statusCode == 400){
        showCustomSnackBar(context, message, Colors.red);
      }

      else {
        throw Exception('Failed to load data');
      }
    } catch (e) {
      // Handle error
      print("Error submitting form: $e");
    }
  }*/

  Future<void> submitLeaveHomeRequest(LeaveRequestItem leadData, BuildContext context) async {
    try {
      // String? token = speciality.getToken();
      String? token = speciality.getToken();

      print('Leave Request token: $token');
      print('Leave input leadData: ${leadData.toJson()}');

      // Make the API request
      final response = await _dio.post(
        Api.submitLeaveRequest,
        data: leadData.toJson(),
        options: Options(
          headers: {"token": token},
          validateStatus: (status) => true, // Allow all status codes
        ),
      );

      // Parse the response data
      final responseData = response.data;
      print('Leave Request Response: $responseData');

      // Extract the message
      String message = responseData['message'] ?? 'An error occurred. Please try again.';

      if (response.statusCode == 200 && responseData['status'] == true) {
       // log('Leave Request Successfully');
        showCustomSnackBar(context, 'Leave Request Submitted', Colors.green);
      } else {
        // Handle error responses
        showCustomSnackBar(context, message, Colors.red);
      }
    } catch (e) {
      // Handle unexpected errors
      print("Error submitting form: $e");
      showCustomSnackBar(context, 'Unexpected error occurred. Please try again.', Colors.red);
    }
  }


}