

import 'package:dio/dio.dart';
import 'package:finexe/feature/base/api/dio.dart';
import 'package:flutter/Material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../base/api/api.dart';
import '../../base/service/session_service.dart';
import '../../base/utils/widget/custom_snackbar.dart';

final punchInOutSideViewModelProvider = Provider.autoDispose((ref) {
  final dio = ref.watch(dioProvider);
  return PunchInOutSideViewModel(dio);
} );

class PunchInOutSideViewModel{
  final Dio _dio;
  PunchInOutSideViewModel(this._dio);


  Future<bool> punchInOutSideRequest(String reasonForPunch, BuildContext context) async {
    try {
      String? token = await SessionService.getToken();

      // Create a JSON payload with the "remark" key
      final requestData = {
        "remark": reasonForPunch,
      };

      final response = await _dio.post(
        Api.punchOutSide, // Replace with your API endpoint
        data: requestData,
        options: Options(headers: {"token": token}),
      );

      if (response.statusCode == 200) {
        showCustomSnackBar(context, 'Punch In Successfully', Colors.green);
        return true; // Indicate success
      } else {
        showCustomSnackBar(context, 'Failed to punch in. Try again.', Colors.red);
        return false; // Indicate failure
      }
    } catch (e) {
      showCustomSnackBar(context, 'An error occurred. Please try again.', Colors.red);
      print("Error submitting form: $e");
      return false; // Indicate failure
    }
  }

}