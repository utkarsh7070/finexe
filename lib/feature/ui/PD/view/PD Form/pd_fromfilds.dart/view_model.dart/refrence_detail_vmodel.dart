import 'package:dio/dio.dart';
import 'package:finexe/feature/base/api/api.dart';
import 'package:finexe/feature/base/api/dio.dart';
import 'package:finexe/feature/ui/PD/view/PD%20Form/pd_fromfilds.dart/model/Submit%20Data%20Models/refrence_form_model.dart';
import 'package:finexe/feature/ui/Sales/SalesOnBoardingForm/view/Sales_on_boarding_form/referance/referance_details.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PDRefrenceDetails extends StateNotifier<ApplicationState> {
  final Dio dio;

  PDRefrenceDetails(this.dio) : super(ApplicationState());

  Future<bool> submitpdRefrenceDetailsForm({
    required String customerId,
    required String pdType,
    // required List<ReferenceDetails> refrenceFormList,
    required List<Map<String, dynamic>> refrenceFormList,
  }) async {
    state = state.copyWith(isLoading: true);

    // Add customerId and pdType to the payload
    final payload = {
      'referenceDetails': refrenceFormList.toList(),
      'customerId': customerId,
      'pdType': pdType,
    };

    //  String? token = await SessionService.getToken();
    String? token =
        "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJJZCI6IjY3MGY1NjFhZTc2NjMwMjQ0ZGVhNDU1YyIsInJvbGVOYW1lIjoiaW50ZXJuYWxWZW5kb3JBbmRjcmVkaXRQZCIsImlhdCI6MTczMDk1NzUzOH0.p_57wid1GuLPusS29IwyAfQnKR5qfpdDc4CoU2la-qY";
    try {
      final response = await dio.post(Api.updatePdReport,
          data: payload, options: Options(headers: {"token": token}));
      print(token);
      print(payload);
      print(response.data);
      print('Payload: ${payload}');

      if (response.statusCode == 200) {
        print('refrence form submitted: ${response.data}');

        state = state.copyWith(isLoading: false);
        return true;
      } else {
        state = state.copyWith(isLoading: false);
        print('Error while submitting refernceFormData form');
        return false;
      }
    } catch (e) {
      state = state.copyWith(isLoading: false);
      print('Exception: $e');
      throw Exception(e);
    }
  }
}

final pdRefrenceSubmitProvider =
    StateNotifierProvider<PDRefrenceDetails, ApplicationState>((ref) {
  final dio = ref.read(dioProvider);
  // final checkStatus = ref.watch(checkBoxTermsConditionApplicant);

  return PDRefrenceDetails(dio);
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

final getRefrenceDataProvider =
    FutureProvider.autoDispose<RefrenceDetailModel>((ref) async {
  final viewModel = RefFormDetailProvider();
  return await viewModel.fetchRefDetails();
});

class RefFormDetailProvider {
  final Dio _dio = Dio();

  Future<RefrenceDetailModel> fetchRefDetails() async {
    String? token =
        "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJJZCI6IjY3MGY1NjFhZTc2NjMwMjQ0ZGVhNDU1YyIsInJvbGVOYW1lIjoiaW50ZXJuYWxWZW5kb3JBbmRjcmVkaXRQZCIsImlhdCI6MTczMDk1NzUzOH0.p_57wid1GuLPusS29IwyAfQnKR5qfpdDc4CoU2la-qY"; // Replace with a secure way of managing tokens
    print('url: ${Api.getpdformdata}66f53ffbd7011eb65160f292');

    try {
      final response = await _dio.get(
        '${Api.getpdformdata}66f53ffbd7011eb65160f292',
        options: Options(headers: {"token": token}),
      );

      if (response.statusCode == 200 && response.data != null) {
        final Map<String, dynamic> responseData = response.data;

        // Parse the response into the GetApplicantDetailsModel
        final refernceFormData = RefrenceDetailModel.fromJson(responseData);

        if (refernceFormData != null) {
          print('refernceFormData:: ${refernceFormData}');
          return refernceFormData;
        } else {
          throw Exception("refernceFormData details not found in the response");
        }
      } else {
        throw Exception(
            "Failed to load refernceFormData data: ${response.statusCode}");
      }
    } catch (e) {
      print("Error fetching refernceFormData details: $e");
      throw Exception("Error fetching refernceFormData data: $e");
    }
  }
}
