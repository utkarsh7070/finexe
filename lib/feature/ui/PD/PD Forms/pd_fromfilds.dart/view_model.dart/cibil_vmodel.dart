import 'dart:async';

import 'package:dio/dio.dart';
import 'package:finexe/feature/base/api/api.dart';
import 'package:finexe/feature/base/api/dio.dart';
import 'package:finexe/feature/ui/PD/PD%20Forms/pd_fromfilds.dart/model/Submit%20Data%20Models/cibil_form_model.dart';

// import 'package:finexe/feature/ui/PD/view/PD%20Form/pd_fromfilds.dart/model/Submit%20Data%20Models/refrence_form_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:finexe/feature/base/utils/general/pref_utils.dart';


import '../../../../../base/api/dio_exception.dart';
import '../model/Submit Data Models/pd_response_model.dart';

final isExpandedProvider = StateProvider<bool>((ref) => false);


class PDCibilDetails extends StateNotifier<CibilApplicationState> {
  final Dio dio;

  PDCibilDetails(this.dio) : super(CibilApplicationState());

  void updateTotalLoans(String value) {
    final valid = _validString(value);
    state = state.copyWith(totalLoans: value, isTotalLoans: valid);
  }

  void updateDetailsOfCurrentLoans(String value) {
    final valid = _validString(value);
    state = state.copyWith(
        detailsOfCurrentLoans: value, isDetailsOfCurrentLoans: valid);
  }

  void updateReasonforDpd(String value) {
    final valid = _validString(value);
    state = state.copyWith(reasonforDpd: value, isReasonforDpd: valid);
  }

  void updateInitialValue(PdResponseModel data) {
    state = state.copyWith(totalLoans: data.items?.cibilAnalysis?.totalLoans,
        detailsOfCurrentLoans: data.items?.cibilAnalysis
            ?.detailsOfCurrentLoans,reasonforDpd: data.items?.cibilAnalysis?.reasonforDpd);
  }

  Future<bool> submitpdCibilDetailsForm({
    required String customerId,
    required String pdType,
    required BuildContext context,
    // required List<ReferenceDetails> refrenceFormList,
    // required List<Map<String, dynamic>> refrenceFormList,
    //  required CibilAnalysis cibilData
  }) async {
    state = state.copyWith(isLoading: true);
    final cibilAnalysis = {
      'TotalLoans': state.totalLoans,
      'detailsOfCurrentLoans': state.detailsOfCurrentLoans,
      'reasonforDPD': state.reasonforDpd
    };
    final payload = {
      'cibilAnalysis': cibilAnalysis,
      'customerId': customerId,
      'pdType': pdType,
    };

    String? token = speciality.getToken();
    // String? token =
    //     "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJJZCI6IjY3MGY1NjFhZTc2NjMwMjQ0ZGVhNDU1YyIsInJvbGVOYW1lIjoiaW50ZXJuYWxWZW5kb3JBbmRjcmVkaXRQZCIsImlhdCI6MTczMDk1NzUzOH0.p_57wid1GuLPusS29IwyAfQnKR5qfpdDc4CoU2la-qY";
    try {
      final response = await dio.post(Api.updatePdReport,
          data: payload, options: Options(headers: {"token": token}));
      print(token);
      print(payload);
      print(response.data);
      print('Payload: $payload');

      if (response.statusCode == 200) {
        print('cibil form submitted: ${response.data}');

        state = state.copyWith(isLoading: false);
        return true;
      } else {
        state = state.copyWith(isLoading: false);
        print('Error while submitting refernceFormData form');
        return false;
      }
    }
    catch (e) {
      state = state.copyWith(isLoading: false);
      print('Exception in refrenceDeatils form: $e');
      DioExceptions.fromDioError(e as DioException, context);

      // throw Exception(e);
      return false;
    }
  }
}

bool _validString(String val) {
  return val.isNotEmpty;
}

final pdCibilSubmitProvider =
StateNotifierProvider<PDCibilDetails, CibilApplicationState>((ref) {
  final dio = ref.read(dioProvider);
  // final checkStatus = ref.watch(checkBoxTermsConditionApplicant);

  return PDCibilDetails(dio);
});

class CibilApplicationState {
  final bool isLoading;
  final String totalLoans;
  final String detailsOfCurrentLoans;
  final String reasonforDpd;
  final String selectedDate;
  final bool isReasonforDpd;
  final bool isDetailsOfCurrentLoans;
  final bool isTotalLoans;


  CibilApplicationState({
    this.isReasonforDpd = true,
    this.isDetailsOfCurrentLoans = true,
    this.isTotalLoans = true,
    this.totalLoans = '',
    this.detailsOfCurrentLoans = '',
    this.reasonforDpd = '',
    this.isLoading = false,
    this.selectedDate = '',
  });

  CibilApplicationState copyWith({
    String? totalLoans,
    bool? isTotalLoans,
    String? detailsOfCurrentLoans,
    bool? isDetailsOfCurrentLoans,
    String? reasonforDpd,
    bool? isReasonforDpd,
    bool? isLoading,
    String? selectedDate,
  }) {
    return CibilApplicationState(
      isDetailsOfCurrentLoans: isDetailsOfCurrentLoans ??
          this.isDetailsOfCurrentLoans,
      isReasonforDpd: isReasonforDpd ?? this.isReasonforDpd,
      isTotalLoans: isTotalLoans ?? this.isTotalLoans,
      detailsOfCurrentLoans: detailsOfCurrentLoans ??
          this.detailsOfCurrentLoans,
      reasonforDpd: reasonforDpd ?? this.reasonforDpd,
      totalLoans: totalLoans ?? this.totalLoans,
      isLoading: isLoading ?? this.isLoading,
      selectedDate: selectedDate ?? this.selectedDate,
    );
  }
}


// final cibilDetailsProvider =
// FutureProvider.autoDispose.family<CibilAnalysis?,String>((ref,customerId) async {
//   final viewModel = ApplicationFormDetailsProvider();
//   return await viewModel.fetchApplicationDetails(customerId);
// });

final cibilDetailsProvider =
AsyncNotifierProvider.family<CibilInitialApiCall, PdResponseModel, String>(
      () {
    return CibilInitialApiCall();
  },
);

class CibilInitialApiCall extends FamilyAsyncNotifier<PdResponseModel, String> {
  @override
  FutureOr<PdResponseModel> build(String arg) {
    final dio = ref.watch(dioProvider);
    final cibilInitalDataUpdate = ref.read(pdCibilSubmitProvider.notifier);
    return fetchApplicationDetails(arg, dio,cibilInitalDataUpdate);
  }

  Future<PdResponseModel> fetchApplicationDetails(String customerId,
      Dio _dio,PDCibilDetails pdCibil) async {
    String? token = speciality.getToken();
    PdResponseModel cibildetails = PdResponseModel();
    print('urlC: ${Api.getpdformdata}$customerId');

    try {
      final response = await _dio.get(
        '${Api.getpdformdata}$customerId',
        options: Options(headers: {"token": token}),
      );

      if (response.statusCode == 200 && response.data != null) {
        cibildetails = PdResponseModel.fromJson(response.data);
        pdCibil.updateInitialValue(cibildetails);
        return cibildetails;
        // final Map<String, dynamic> responseData = response.data;
        //
        // // Extract the `items` object first
        // final itemsData = responseData['items'];
        //
        // if (itemsData != null && itemsData is Map<String, dynamic>) {
        //   // Extract the nested `cibilAnalysis` object
        //   final cibilData = itemsData['cibilAnalysis'];
        //
        //   if (cibilData != null && cibilData is Map<String, dynamic>) {
        //     cibildetails = PdResponseModel.fromJson( response.data);
        //     print('cibildetails:: ${cibildetails.items?.applicant}');
        //     return cibildetails;
        //   } else {
        //     // throw Exception("Cibil Analysis data not found in the response");
        //     print('Cibil Analysis data not found in the response');
        //     return cibildetails;
        //   }
        // } else {
        //   // throw Exception("Items data not found in the response");
        //   print('Items data not found in the response');
        //   return cibildetails;
        //
        // }
      } else {
        // throw Exception("Failed to load application data: ${response.statusCode}");
        print('Failed to load application data: ${response.statusCode}');
        return cibildetails;
      }
    } catch (e) {
      print("Error fetching applicant details: $e");
      // throw Exception("Error fetching application data: $e");
      return cibildetails;
    }
  }

}

class ApplicationFormDetailsProvider {
  final Dio _dio = Dio();

}