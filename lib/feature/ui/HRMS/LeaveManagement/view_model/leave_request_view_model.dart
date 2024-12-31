

import 'dart:developer';

import 'package:finexe/feature/base/utils/general/pref_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import '../../../../base/api/api.dart';
import '../../../../base/api/dio.dart';
import '../../../../base/utils/widget/custom_snackbar.dart';
import '../model/leave_type_response_model.dart';
import '../model/leave_request_model.dart';
import 'package:dio/dio.dart';


final leaveRequestViewModelProvider = ChangeNotifierProvider.autoDispose((ref) => LeaveRequestViewModel());

class LeaveRequestViewModel extends ChangeNotifier {
  final TextEditingController leaveReasonController = TextEditingController();
  final TextEditingController leaveTittleController = TextEditingController();
  final TextEditingController leaveTypeController = TextEditingController();
  DateTime? startDate;
  DateTime? endDate;
  String? selectedLeaveTypeId;

  final Dio _dio = Dio();

  // Date picker logic
  Future<void> pickDate(BuildContext context, bool isStartDate) async {
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
    );

    if (pickedDate != null) {
      if (isStartDate) {
        startDate = pickedDate;
      } else {
        endDate = pickedDate;
      }
      notifyListeners(); // Notify listeners to rebuild the UI
    }
  }

  // Form submission logic
  Future<void> submitLeaveRequest(BuildContext context) async {
    if (leaveTittleController.text.isEmpty ||
        leaveReasonController.text.isEmpty ||
        selectedLeaveTypeId == null ||
        startDate == null ||
        endDate == null) {
      showCustomSnackBar(context, "Please fill all fields", Colors.red);
      return;
    }

    final formattedStartDate = DateFormat('yyyy-MM-dd').format(startDate!);
    final formattedEndDate = DateFormat('yyyy-MM-dd').format(endDate!);

    final leaveData = LeaveRequestItem(
      title: leaveTittleController.text.trim(),
      leaveType: selectedLeaveTypeId!,
      startDate: formattedStartDate,
      endDate: formattedEndDate,
      reasonForLeave: leaveReasonController.text.trim(),
    );

    try {
      String? token = speciality.getToken();

      final response = await _dio.post(
        Api.submitLeaveRequest,
        data: leaveData.toJson(),
        options: Options(headers: {"token": token}),
      );

      if (response.statusCode == 200) {
        showCustomSnackBar(context, 'Leave Request Submitted', Colors.green);
        Navigator.pop(context, true);
      } else {
        throw Exception('Failed to submit leave request');
      }
    } /*catch (e) {
      showCustomSnackBar(context, "An unexpected error occurred.", Colors.red);
    }*/
    catch (e) {
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

}

final fetchLeaveTypeProvider = FutureProvider.autoDispose<List<Item>>((ref) async {
  String? token = speciality.getToken();
  final dio = ref.read(dioProvider);
  final response = await dio.get(Api.getAllLeaveType,
    options: Options(headers: {"token": token}
      , validateStatus: (status) => true,),);

  var responseData = response.data;
  print('fetch Leave Type response: $responseData');
  var message = responseData['message'];
  // print('message: ${message}');

  try {
    if (response.statusCode == 200 && responseData['status'] == true) {
      LeaveTypeResponseModel apiResponseList =
      LeaveTypeResponseModel.fromJson(response.data);
      // ref.read(personalDetailViewModelProvider.notifier).list =
      //     apiResponseList.items;
      return apiResponseList.items;
    } else {
      print('Error message: $message');
      throw Exception('Failed to load data');
    }
  }on DioException catch (error) {
    throw Exception(error);
    // throw Exception(error);
  }catch (e) {
    // Handle unexpected errors
    print('Unexpected error: $e');
    throw Exception(e);
  }

});



