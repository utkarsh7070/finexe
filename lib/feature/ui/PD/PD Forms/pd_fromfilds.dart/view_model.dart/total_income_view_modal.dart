import 'dart:async';

import 'package:dio/dio.dart';
import 'package:finexe/feature/base/api/api.dart';
import 'package:finexe/feature/base/api/dio.dart';
import 'package:finexe/feature/base/utils/general/pref_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../base/api/dio_exception.dart';
import '../model/Submit Data Models/pd_response_model.dart';

final pdIncomeDetailsProvider =
    StateNotifierProvider<PDIncomeDetailsModel, ApplicantState>((ref) {
  final dio = ref.read(dioProvider);
  return PDIncomeDetailsModel(dio);
});

bool _validString(String val) {
  return val.isNotEmpty;
}

class PDIncomeDetailsModel extends StateNotifier<ApplicantState> {
  final Dio dio;

  PDIncomeDetailsModel(this.dio) : super(ApplicantState());

  void updateInitially(PdResponseModel data) {
    state = state.copyWith(
        totalExpensesMonthly:
            data.items?.totalIncomeDetails?.totalExpensesMonthly,
        totalExpensesYearly:
            data.items?.totalIncomeDetails?.totalExpensesYearly,
        totalMonthlyIncome: data.items?.totalIncomeDetails?.totalMonthlyIncome,
        totalYearlyIncome: data.items?.totalIncomeDetails?.totalYearlyIncome);
  }

  void updateTotalExpensesMonthly(String value) {
    final valid = _validString(value);
    state = state.copyWith(totalExpensesMonthly: value,isTotalExpensesMonthly: valid);
  }
  void updateTotalExpensesYearly(String value) {
    final valid = _validString(value);
    state = state.copyWith(totalExpensesYearly: value,isTotalExpensesYearly: valid);
  }
  void updateTotalMonthlyIncome(String value) {
    final valid = _validString(value);
    state = state.copyWith(totalMonthlyIncome: value,isTotalMonthlyIncome: valid);
  }
  void updateTotalYearlyIncome(String value) {
    final valid = _validString(value);
    state = state.copyWith(totalYearlyIncome: value,isTotalYearlyIncome: valid);
  }

  Future<bool> submitIncomeDetails({
    required String customerId,
    required String pdType,
    // required TotalIncomeDetails incomeDetails,
    required BuildContext context,
  }) async {
    state = state.copyWith(isLoading: true);

    final payload = {
      // "totalIncomeDetails": incomeDetails.toJson(),
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
    } catch (error) {
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

// final totalIncomeDetailsProvider =
//     FutureProvider.autoDispose.family<TotalIncomeDetailsModel,String>((ref,customerId) async {
//   // Directly create an instance of TotalIncomeApi
//   final viewModel = TotalIncomeApi(Dio()); // Inject Dio directly here
//   // Fetch the income details
//   return await viewModel.fetchIncomeDetails(customerId);
// });

final totalIncomeDetailsProvider =
    AsyncNotifierProvider.family<TotalIncomeApi, PdResponseModel, String>(
  () {
    return TotalIncomeApi();
  },
);

class TotalIncomeApi extends FamilyAsyncNotifier<PdResponseModel, String> {
  @override
  FutureOr<PdResponseModel> build(String arg) {
    final dio = ref.watch(dioProvider);
    final pdIncomeDetails = ref.read(pdIncomeDetailsProvider.notifier);
    return fetchIncomeDetails(arg, dio, pdIncomeDetails);
  }

  Future<PdResponseModel> fetchIncomeDetails(
      String customerId, Dio dio, PDIncomeDetailsModel pdIncomeDetails) async {
    final token = speciality.getToken();
    PdResponseModel details = PdResponseModel();
    try {
      final response = await dio.get(
        '${Api.getpdformdata}$customerId',
        options: Options(headers: {"token": token}),
      );
      print('---> Income API Response: ${response.data}');

      if (response.statusCode == 200 && response.data != null) {
        final data = response.data['items'];
        details = PdResponseModel.fromJson(data);
        pdIncomeDetails.updateInitially(details);
        // Parse the data and return the correct model
        if (data != null && data['totalIncomeDetails'] != null) {

          if (details.items?.totalIncomeDetails != null) {
            return details; // Return the TotalIncomeDetails directly
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
  final bool isLoading;
  final String totalMonthlyIncome;
  final String totalYearlyIncome;
  final String totalExpensesYearly;
  final String totalExpensesMonthly;
  final bool isTotalMonthlyIncome;
  final bool isTotalYearlyIncome;
  final bool isTotalExpensesYearly;
  final bool isTotalExpensesMonthly;

  ApplicantState({
    this.isLoading = false,
    this.totalExpensesMonthly = '',
    this.totalExpensesYearly = '',
    this.totalMonthlyIncome = '',
    this.totalYearlyIncome = '',
    this.isTotalMonthlyIncome = true,
    this.isTotalYearlyIncome = true,
    this.isTotalExpensesYearly = true,
    this.isTotalExpensesMonthly = true,
  });

  ApplicantState copyWith(
      {bool? isLoading,
      String? totalMonthlyIncome,
      String? totalYearlyIncome,
      String? totalExpensesYearly,
      String? totalExpensesMonthly,
      bool? isTotalMonthlyIncome,
      bool? isTotalYearlyIncome,
      bool? isTotalExpensesYearly,
      bool? isTotalExpensesMonthly}) {
    return ApplicantState(
      isTotalExpensesMonthly:
          isTotalExpensesMonthly ?? this.isTotalExpensesMonthly,
      isTotalExpensesYearly:
          isTotalExpensesYearly ?? this.isTotalExpensesYearly,
      isTotalMonthlyIncome: isTotalMonthlyIncome ?? this.isTotalMonthlyIncome,
      isTotalYearlyIncome: isTotalYearlyIncome ?? this.isTotalYearlyIncome,
      totalExpensesMonthly: totalExpensesMonthly ?? this.totalExpensesMonthly,
      totalExpensesYearly: totalExpensesYearly ?? this.totalExpensesYearly,
      totalMonthlyIncome: totalMonthlyIncome ?? this.totalMonthlyIncome,
      totalYearlyIncome: totalYearlyIncome ?? this.totalYearlyIncome,
      isLoading: isLoading ?? this.isLoading,
      // selectedDate: selectedDate ?? this.selectedDate,
    );
  }
}
