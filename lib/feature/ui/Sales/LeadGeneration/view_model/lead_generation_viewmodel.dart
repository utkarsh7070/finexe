// viewmodels/lead_generation_viewmodel.dart
import 'dart:developer';
import 'dart:io';

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
  String? uploadedSelfieUrl;

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

  final fetchDataProvider = FutureProvider.autoDispose<List<Item>>((ref) async {
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

  Future<String?> uploadImage(File image) async {
    try {
      String? token = await SessionService.getToken();

      final formData = FormData.fromMap({
        'image': await MultipartFile.fromFile(image.path),
      });

      // Log request details
      print("Uploading image with FormData: ${formData.fields}");
      print("Headers: $token");

      final response = await _dio.post(
        Api.uploadImageCollection, // API endpoint
        data: formData,
        options: Options(headers: {"token": token}),
      );

      print('Lead Generated Response ${response.data}');

      // Access the correct key
      if (response.statusCode == 200 && response.data['items'] != null) {
        return response.data['items']['image']; // Access 'image' from 'items'
      } else {
        throw Exception('Image upload failed');
      }
    } catch (e) {
      log('Error uploading image: $e');
      return null;
    }
  }

  Future<void> leadFormSubmit(LeadGenerationModel leadData, BuildContext context) async {
      String? token = await SessionService.getToken();
      print('lead input ${leadData.toJson()}');

      final response = await _dio.post(
        Api.leadFormSubmit,
        data: leadData.toJson(),
        options: Options(headers: {"token": token}
          , validateStatus: (status) => true,),
      );

      var responseData = response.data;
      print('Lead Generation response: ${responseData}');
      var message = responseData['message'];
      // print('message: ${message}');

      try {
            if (response.statusCode == 200 && responseData['status'] == true) {

            log('Lead Generated Successfully');
            print('Lead Generated Response ${response.data}');
            showCustomSnackBar(context, message, Colors.green);
            Navigator.pop(context, true);
          } else {
              showCustomSnackBar(context, message, Colors.red);
            throw Exception('Failed to load data');
          }
      }on DioException catch (error) {
        print('Error message: $message');
        throw Exception(error);
      }
      catch (e) {
        // Handle unexpected errors
        print('Unexpected error: $e');
        throw Exception(e);
      }
  }

}

final fetchAllBranchProvider = FutureProvider.autoDispose<List<Branch>>((ref) async {
  String? token = await SessionService.getToken();
  final dio = ref.read(dioProvider);
  final response = await dio.get(Api.getAllBranch,
    options: Options(headers: {"token": token}
        , validateStatus: (status) => true,),);

  /*print(response.statusMessage);
  print(response.statusCode);*/

  var responseData = response.data;
  print('fetch pan father response: ${responseData}');
  var message = responseData['message'];
  // print('message: ${message}');

  try {
    if (response.statusCode == 200 && responseData['status'] == true) {
      GetAllBranchModel apiResponseList =
      GetAllBranchModel.fromJson(response.data);
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
