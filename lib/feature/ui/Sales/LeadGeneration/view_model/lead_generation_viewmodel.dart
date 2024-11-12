// viewmodels/lead_generation_viewmodel.dart
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:dio/dio.dart';

import '../../../../base/api/api.dart';
import '../../../../base/service/session_service.dart';
import '../../../../base/utils/widget/custom_snackbar.dart';
import '../model/lead_generation_model.dart';



final leadGenerationViewModelProvider = Provider((ref) => LeadGenerationViewModel());

class LeadGenerationViewModel {
  final Dio _dio = Dio();

  Future<void> leadFormSubmit(LeadGenerationModel leadData,BuildContext context) async {
    try {
      String? token = await SessionService.getToken();
      print('lead input ${leadData.toJson()}');
      final response = await _dio.post(Api.leadFormSubmit, // Replace with your API endpoint
        data: leadData.toJson(),
          options: Options(headers: {"token": token})
      );

      if (response.statusCode == 200) {
        log('Lead Generated Successfully');
        print('Lead Generated Response ${response.data}');
        showCustomSnackBar(context, 'Lead Generated Successfully', Colors.green);
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
