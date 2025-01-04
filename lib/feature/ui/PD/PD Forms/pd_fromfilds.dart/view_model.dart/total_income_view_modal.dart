import 'package:dio/dio.dart';
import 'package:finexe/feature/base/api/api.dart';
import 'package:finexe/feature/base/api/dio.dart';
import 'package:finexe/feature/base/service/session_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../base/api/dio_exception.dart';
import '../model/Submit Data Models/total_income_modal.dart';import 'package:finexe/feature/base/utils/general/pref_utils.dart';


// import '../../../../../../../base/api/dio.dart';
// import '../../../../../../../base/service/session_service.dart';
// import '../model/Submit Data Models/total_income_modal.dart';

// ----------- post api ---------
final pdIncomeDetailsProvider =
    StateNotifierProvider<PDIncomeDetailsModel, ApplicantState>((ref) {
  final dio = ref.read(dioProvider);
  return PDIncomeDetailsModel(dio);
});

class PDIncomeDetailsModel extends StateNotifier<ApplicantState> {
  final Dio dio;

  PDIncomeDetailsModel(this.dio) : super(ApplicantState());

  Future<bool> submitIncomeDetails({
    required String customerId,
    required String pdType,
    required TotalIncomeDetails incomeDetails,
    required BuildContext context,
  }) async {
    state = state.copyWith(isLoading: true);

    final payload = {
      "totalIncomeDetails": incomeDetails.toJson(),
      'customerId': customerId,
      'pdType': pdType,
    };
    final token = speciality.getToken();
    // if(state.isLoading==true){
    //   print('click second time');
    //   return false;
    // }
    try {
      final response = await dio.post(
        Api.updatePdReport,
        data: payload,
        options: Options(headers: {"token": token}),
      );
      // print("total income api ---${response.data}");

      if (response.statusCode == 200) {
        state = state.copyWith(isLoading: false);
        return true;
      } else {
        state = state.copyWith(isLoading: false);
        print('Error while submitting income details');
        return false;
      }
    }
    catch (error) {
      print(error);
      state = state.copyWith(isLoading: false);
      DioExceptions.fromDioError(error as DioException, context);
      // Handle exceptions and set state to error
      // state = AsyncValue.error(error, stackTrace);
      print('response.data.message ${error}');
      return false;
    }
  }
}

// ---------------- GET: Fetch Income

final totalIncomeDetailsProvider =
    FutureProvider.autoDispose.family<TotalIncomeDetailsModel,String>((ref,customerId) async {
  // Directly create an instance of TotalIncomeApi
  final viewModel = TotalIncomeApi(Dio()); // Inject Dio directly here
  // Fetch the income details
  return await viewModel.fetchIncomeDetails(customerId);
});

class TotalIncomeApi {
  final Dio _dio;

  TotalIncomeApi(this._dio);

  Future<TotalIncomeDetailsModel> fetchIncomeDetails(String customerId) async {
    final token = speciality.getToken();
    TotalIncomeDetailsModel details = TotalIncomeDetailsModel();
    try {
      final response = await _dio.get(
        '${Api.getpdformdata}$customerId',
        options: Options(headers: {"token": token}),
      );

      // Debugging the response to see if data is correctly returned
      print('---> Income API Response: ${response.data}');

      if (response.statusCode == 200 && response.data != null) {
        final data = response.data['items'];

        // Parse the data and return the correct model
        if (data != null && data['totalIncomeDetails'] != null) {
           details = TotalIncomeDetailsModel.fromJson(data);
          if (details.totalIncomeDetails != null) {
            return details
                ; // Return the TotalIncomeDetails directly
          } else {
            throw Exception("Income details are missing in the response.");
          }
        } else {
          throw Exception("Total income details not found in the response.");
        }
      } else {
        throw Exception(
          "Failed to load income data. Status code: ${response.statusCode}",
        );
      }
    } catch (e) {
      print("Error fetching income details: $e");
      // throw Exception("Error fetching income details: $e");
      return details;
    }
  }
}

// --------------- Common Loader
class ApplicantState {
  final bool? isLoading;

  ApplicantState({
    this.isLoading,
  });

  ApplicantState.initial() : isLoading = false;

  ApplicantState copyWith({
    bool? isLoading,
  }) {
    return ApplicantState(
      isLoading: isLoading ?? this.isLoading,
      // selectedDate: selectedDate ?? this.selectedDate,
    );
  }
}
