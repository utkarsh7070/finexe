// viewmodels/lead_generation_viewmodel.dart
import 'dart:developer';

import 'package:finexe/feature/ui/Sales/LeadGeneration/model/get_all_branch_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:dio/dio.dart';

import '../../../../base/api/api.dart';
import '../../../../base/api/dio.dart';
import '../../../../base/service/session_service.dart';
import '../../../../base/utils/widget/custom_snackbar.dart';
import '../../NewLone/model/get_All_Product_model.dart';
import '../model/lead_generation_model.dart';



final leadGenerationViewModelProvider = Provider((ref) => LeadGenerationViewModel());

class LeadGenerationViewModel {
  final Dio _dio = Dio();

  // Static dropdown data for loan amount and monthly income
  final List<String> loanAmountOptions = [
    '0-1 lakh',
    '1-2 lakh',
    '2-3 lakh',
    'Above 3 lakh'
  ];

  final List<String> monthlyIncomeOptions = [
    '10k-30k',
    '30k-60k',
    '60k-90k',
    'Above 1 lakh'
  ];

  final fetchDataProvider = FutureProvider<List<Item>>((ref) async {
    String? token = await SessionService.getToken();
    final dio = ref.read(dioProvider);
    final response = await dio.get(Api.getAllProduct,options: Options(headers: {"token": token}),);
    print(response.statusMessage);
    print(response.statusCode);
    if (response.statusCode == 200) {
      GetAllProductModel apiResponseList =
      GetAllProductModel.fromJson(response.data);
      // ref.read(personalDetailViewModelProvider.notifier).list =
      //     apiResponseList.items;
      return apiResponseList.items;
    } else {
      throw Exception('Failed to load data');
    }
  });




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

final fetchAllBranchProvider = FutureProvider<List<Branch>>((ref) async {
  String? token = await SessionService.getToken();
  final dio = ref.read(dioProvider);
  final response = await dio.get(Api.getAllBranch,options: Options(headers: {"token": token}),);
  print(response.statusMessage);
  print(response.statusCode);
  if (response.statusCode == 200) {

    GetAllBranchModel apiResponseList =
    GetAllBranchModel.fromJson(response.data);
    // ref.read(personalDetailViewModelProvider.notifier).list =
    //     apiResponseList.items;
    return apiResponseList.items;
  } else {
    throw Exception('Failed to load data');
  }
});
