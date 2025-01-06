import 'package:dio/dio.dart';
import 'package:finexe/feature/base/api/api.dart';
import 'package:finexe/feature/base/api/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// import '../../../../../../../base/api/dio.dart';
// import '../../../../../../../base/service/session_service.dart';
import '../../../../../base/api/dio_exception.dart';
import '../model/Submit Data Models/loan_detail_modal.dart';
import 'package:finexe/feature/base/utils/general/pref_utils.dart';

// ----------- post api ---------
final pdLoanDetailsProvider =
    StateNotifierProvider<PDLoanDetailsModel, ApplicantState>((ref) {
  final dio = ref.read(dioProvider);
  return PDLoanDetailsModel(dio);
});

class PDLoanDetailsModel extends StateNotifier<ApplicantState> {
  final Dio dio;

  PDLoanDetailsModel(this.dio) : super(ApplicantState());

  Future<bool> submitLoanDetails({
    required String customerId,
    required String pdType,
    required UpdateLoanDetails loanDetails,
    required BuildContext context,
  }) async {
    state = state.copyWith(isLoading: true);

    final payload = {
      "approveLoanDetails": loanDetails.toJson(),
      'customerId': customerId,
      'pdType': pdType,
    };
    // if(state.isLoading==true){
    //   print('click second time');
    //   return false;
    // }
    final token = speciality.getToken();

    try {
      final response = await dio.post(
        Api.updatePdReport,
        data: payload,
        options: Options(headers: {"token": token}),
      );
      // print("approve LoanDetails  api ---${response.data}");

      if (response.statusCode == 200) {
        state = state.copyWith(isLoading: false);
        return true;
      } else {
        state = state.copyWith(isLoading: false);
        print('Error while submitting income details');
        return false;
      }
    }
    // catch (e) {
    //   state = state.copyWith(isLoading: false);
    //   print('Exception in LoanDetails form: $e');
    //   // throw Exception(e);
    //   return false;
    // }
    catch (error) {
      print(error);
      state = state.copyWith(isLoading: false);
      DioExceptions.fromDioError(error as DioException, context);
      // Handle exceptions and set state to error
      // state = AsyncValue.error(error, stackTrace);
      print('response.data.message $error');
      return false;
    }
  }
}

// ---------------- GET: Fetch Income

final loanDetailsGetProvider =
    FutureProvider.autoDispose.family<UpdateLoanDetails?,String>((ref,custId) async {
  // Directly create an instance of TotalIncomeApi
  final viewModel = loanDetailApi(Dio()); // Inject Dio directly here
  // Fetch the income details
  return await viewModel.fetchLoanDetails(custId);
});

class loanDetailApi {
  final Dio _dio;

  loanDetailApi(this._dio);

  Future<UpdateLoanDetails?> fetchLoanDetails(String customerId) async {
    final token = speciality.getToken();
    UpdateLoanDetails details = UpdateLoanDetails();
    try {
      final response = await _dio.get(
        '${Api.getpdformdata}$customerId',
        options: Options(headers: {"token": token}),
      );

      if (response.statusCode == 200 && response.data != null) {
        // Accessing the nested `approveLoanDetails` in the API response
        final data = response.data['items'];
        if (data != null && data['approveLoanDetails'] != null) {
           details =
              UpdateLoanDetails.fromJson(data['approveLoanDetails']);
          return details;
        } else {
          // throw Exception("approveLoanDetails not found in the response.");
          print('approveLoanDetails not found in the response.');
          return details;
        }
      }
      // else {
      //   throw Exception(
      //     "Failed to load loan data. Status code: ${response.statusCode}",
      //   );
      // }
    } catch (e) {
      print("Error fetching loan details: $e");
      // throw Exception("Error fetching loan details: $e");
      return details;
    }
    return null;
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
