

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

  Future<void> submitLeaveRequest(LeaveRequestItem leadData,BuildContext context) async {
    try {
      String? token = await SessionService.getToken();

      print('Leave input ${leadData.toJson()}');
      final response = await _dio.post(Api.submitLeaveRequest, // Replace with your API endpoint
          data: leadData.toJson(),
          options: Options(headers: {"token": token})
      );

      print('Leave Request Response ${response.data}');

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
  }

}
