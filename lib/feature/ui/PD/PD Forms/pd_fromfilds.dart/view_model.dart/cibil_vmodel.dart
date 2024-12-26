

import 'package:dio/dio.dart';
import 'package:finexe/feature/base/api/api.dart';
import 'package:finexe/feature/base/api/dio.dart';
import 'package:finexe/feature/base/service/session_service.dart';
import 'package:finexe/feature/base/utils/general/pref_utils.dart';
import 'package:finexe/feature/ui/PD/PD%20Forms/pd_fromfilds.dart/model/Submit%20Data%20Models/cibil_form_model.dart';
// import 'package:finexe/feature/ui/PD/view/PD%20Form/pd_fromfilds.dart/model/Submit%20Data%20Models/refrence_form_model.dart';
import 'package:finexe/feature/ui/Sales/SalesOnBoardingForm/view/Sales_on_boarding_form/referance/referance_details.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../model/Submit Data Models/refrence_form_model.dart';
final isExpandedProvider = StateProvider<bool>((ref) => false);


class PDCibilDetails extends StateNotifier<ApplicationState> {
  final Dio dio;

  PDCibilDetails(this.dio) : super(ApplicationState());

  Future<bool> submitpdCibilDetailsForm({
    required String customerId,
    required String pdType,

    // required List<ReferenceDetails> refrenceFormList,
   // required List<Map<String, dynamic>> refrenceFormList,
    required CibilAnalysis cibilData
  }) async {
    state = state.copyWith(isLoading: true);

    // Add customerId and pdType to the payload
    final payload = {
      'cibilAnalysis': cibilData.toJson(),
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
      print('Payload: ${payload}');

      if (response.statusCode == 200) {
        print('cibil form submitted: ${response.data}');

        state = state.copyWith(isLoading: false);
        return true;
      } else {
        state = state.copyWith(isLoading: false);
        print('Error while submitting refernceFormData form');
        return false;
      }
    } catch (e) {
      state = state.copyWith(isLoading: false);
      print('Exception in refrenceDeatils form: $e');
      // throw Exception(e);
      return false;
    }
  }
}

final pdCibilSubmitProvider =
StateNotifierProvider<PDCibilDetails, ApplicationState>((ref) {
  final dio = ref.read(dioProvider);
  // final checkStatus = ref.watch(checkBoxTermsConditionApplicant);

  return PDCibilDetails(dio);
});

class ApplicationState {
  final bool? isLoading;

  final String? selectedDate;

  ApplicationState({
    this.isLoading,
    this.selectedDate,
  });

  ApplicationState.initial()
      : isLoading = false,
        selectedDate = null;

  ApplicationState copyWith({
    bool? isLoading,
    String? selectedDate,
  }) {
    return ApplicationState(
      isLoading: isLoading ?? this.isLoading,
      selectedDate: selectedDate ?? this.selectedDate,
    );
  }
}



final cibilDetailsProvider =
FutureProvider.autoDispose.family<CibilAnalysis,String>((ref,customerId) async {
  final viewModel = ApplicationFormDetailsProvider();
  return await viewModel.fetchApplicationDetails(customerId);
});

class ApplicationFormDetailsProvider {
  final Dio _dio = Dio();

  Future<CibilAnalysis> fetchApplicationDetails(String customerId) async {
    String? token = speciality.getToken();

    print('urlC: ${Api.getpdformdata}$customerId');

    try {
      final response = await _dio.get(
        '${Api.getpdformdata}$customerId',
        options: Options(headers: {"token": token}),
      );

      if (response.statusCode == 200 && response.data != null) {
        final Map<String, dynamic> responseData = response.data;

        // Extract the `items` object first
        final itemsData = responseData['items'];

        if (itemsData != null && itemsData is Map<String, dynamic>) {
          // Extract the nested `cibilAnalysis` object
          final cibilData = itemsData['cibilAnalysis'];

          if (cibilData != null && cibilData is Map<String, dynamic>) {
            final cibildetails = CibilAnalysis.fromJson(cibilData);
            print('cibildetails:: ${cibildetails.totalLoans}');
            return cibildetails;
          } else {
            throw Exception("Cibil Analysis data not found in the response");
          }
        } else {
          throw Exception("Items data not found in the response");
        }
      } else {
        throw Exception("Failed to load application data: ${response.statusCode}");
      }
    } catch (e) {
      print("Error fetching applicant details: $e");
      throw Exception("Error fetching application data: $e");
    }
  }



}