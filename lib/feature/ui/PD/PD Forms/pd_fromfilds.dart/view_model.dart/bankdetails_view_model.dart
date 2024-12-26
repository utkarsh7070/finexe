import 'package:dio/dio.dart';
import 'package:finexe/feature/base/api/api.dart';
import 'package:finexe/feature/base/api/dio.dart';
import 'package:finexe/feature/base/service/session_service.dart';
import 'package:finexe/feature/base/utils/general/pref_utils.dart';
import 'package:finexe/feature/ui/PD/PD%20Forms/pd_fromfilds.dart/model/Submit%20Data%20Models/bank_detail_form_model.dart';
// import 'package:finexe/feature/ui/PD/view/PD%20Form/pd_fromfilds.dart/model/Submit%20Data%20Models/bank_detail_form_model.dart';
// import 'package:finexe/feature/ui/PD/view/PD%20Form/pd_fromfilds.dart/model/Submit%20Data%20Models/gauranter_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PDBankDetailsViewModel extends StateNotifier<AppState> {
  final Dio dio;

  PDBankDetailsViewModel(this.dio) : super(AppState());

  Future<bool> submitpdBankDetailsForm({
    required String customerId,
    required String pdType,
    String? accountholerdName,
    String? accountno,
    String? accounttype,
    String? branch,
    String? ifscCode,
    String? nameofBank,
  }) async {
    state = state.copyWith(isLoading: true);

    final bankdetail = BankDetail(
        accountHolderName: accountholerdName,
        accountNo: accountno,
        accountType: accounttype,
        branchName: branch,
        iFSCCode: ifscCode,
        nameOfBank: nameofBank);

    // Add customerId and pdType to the payload
    final payload = {
      'bankDetail': bankdetail.toJson(),
      'customerId': customerId,
      'pdType': pdType,
    };

    String? token = speciality.getToken();
    // String? token =
    //     "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJJZCI6IjY3MGY1NjFhZTc2NjMwMjQ0ZGVhNDU1YyIsInJvbGVOYW1lIjoiaW50ZXJuYWxWZW5kb3JBbmRjcmVkaXRQZCIsImlhdCI6MTczMDk1NzUzOH0.p_57wid1GuLPusS29IwyAfQnKR5qfpdDc4CoU2la-qY";
    try {
      final response = await dio.post(Api.updatePdReport,
          data: payload, options: Options(headers: {"token": token}));
      print(response.data);
      print('Payload: ${payload}');
      if (response.statusCode == 200) {
        BankDetail bankDetailsRespone = BankDetail.fromJson(response.data);
        print('bankdetails form submitted: $response');
        print('bankDeatils-- ${bankDetailsRespone}');
        state = state.copyWith(isLoading: false);
        return true;
      } else {
        state = state.copyWith(isLoading: false);
        print('Error while submitting applicant form');
        return false;
      }
    } catch (e) {
      state = state.copyWith(isLoading: false);
      print('Exception in bankdetails form: $e');
      // throw Exception(e);
      return false;
    }
  }
}

final pdsubmitbankdetailsProvider =
    StateNotifierProvider<PDBankDetailsViewModel, AppState>((ref) {
  final dio = ref.read(dioProvider);

  return PDBankDetailsViewModel(dio);
});

class AppState {
  final bool? isLoading;

  final String? selectedDate;

  AppState({
    this.isLoading,
    this.selectedDate,
  });

  AppState.initial()
      : isLoading = false,
        selectedDate = null;

  AppState copyWith({
    bool? isLoading,
    String? selectedDate,
  }) {
    return AppState(
      isLoading: isLoading ?? this.isLoading,
      selectedDate: selectedDate ?? this.selectedDate,
    );
  }
}

final bankdetailsDetailsProvider =
    FutureProvider.autoDispose.family<BankDetail,String>((ref,custId) async {
  final viewModel = GauranterrFormDetailsProvider();
  return await viewModel.fetchBankDetails(custId);
});

class GauranterrFormDetailsProvider {
  final Dio _dio = Dio();

  Future<BankDetail> fetchBankDetails(String custId) async {
    String? token = speciality.getToken();

    // String? token =
    //     "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJJZCI6IjY3MGY1NjFhZTc2NjMwMjQ0ZGVhNDU1YyIsInJvbGVOYW1lIjoiaW50ZXJuYWxWZW5kb3JBbmRjcmVkaXRQZCIsImlhdCI6MTczMDk1NzUzOH0.p_57wid1GuLPusS29IwyAfQnKR5qfpdDc4CoU2la-qY"; // Replace with a secure way of managing tokens
    print('url: ${Api.getpdformdata}$custId');

    try {
      final response = await _dio.get(
        '${Api.getpdformdata}$custId',
        options: Options(headers: {"token": token}),
      );

      if (response.statusCode == 200 && response.data != null) {
        final Map<String, dynamic> responseData = response.data;

        // Parse the response into the GetApplicantDetailsModel
        final details = BankDetailsFormModel.fromJson(responseData);

        if (details.items!.bankDetail != null) {
          return details.items!.bankDetail!;
        } else {
          throw Exception("bankdetails not found in the response");
        }
      } else {
        throw Exception(
            "Failed to load bankdetails data: ${response.statusCode}");
      }
    } catch (e) {
      print("Error fetching bank details: $e");
      throw Exception("Error fetching bankdetails: $e");
    }
  }
}
