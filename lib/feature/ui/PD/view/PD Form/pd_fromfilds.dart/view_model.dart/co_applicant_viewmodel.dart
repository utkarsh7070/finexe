import 'package:dio/dio.dart';
import 'package:finexe/feature/base/api/api.dart';
import 'package:finexe/feature/base/api/dio.dart';
import 'package:finexe/feature/ui/PD/view/PD%20Form/pd_fromfilds.dart/model/Submit%20Data%20Models/coapplicant_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final pdCoapplicantViewModelProvider =
    StateNotifierProvider<PDCOApplicantViewModel, ApplicantState>((ref) {
  final dio = ref.read(dioProvider);
  // final checkStatus = ref.watch(checkBoxTermsConditionApplicant);

  return PDCOApplicantViewModel(dio);
});

class PDCOApplicantViewModel extends StateNotifier<ApplicantState> {
  final Dio dio;

  PDCOApplicantViewModel(this.dio) : super(ApplicantState());

  Future<bool> submitpdCoApplicantForm({
    required String customerId,
    required String pdType,
    String? coapplicantType,
    String? businessType,
    String? occupation,
    String? dob,
    String? email,
    String? houseLandMark,
    String? alternateMobileNo,
    String? noOfyearsAtCurrentAddress,
    String? gender,
    String? religion,
    String? nationality,
    String? category,
    String? caste,
    String? maritalStatus,
    String? noOfDependentWithCustomer,
    String? educationalDetails,
    String? residenceType,
  }) async {
    state = state.copyWith(isLoading: true);

    final coapplicantdata = CoApplicant(
      coApplicantType: coapplicantType,
      businessType: businessType,
      occupation: occupation,
      dOB: dob,
      emailId: email,
      houseLandMark: houseLandMark,
      alternateMobileNo: alternateMobileNo,
      noOfyearsAtCurrentAddress: noOfyearsAtCurrentAddress,
      gender: gender,
      religion: religion,
      nationality: nationality,
      category: category,
      caste: caste,
      maritalStatus: maritalStatus,
      educationalDetails: educationalDetails,
      residenceType: residenceType,
    );

    // Add customerId and pdType to the payload
    final payload = {
      'co_Applicant': coapplicantdata.toJson(),
      'customerId': customerId,
      'pdType': pdType,
    };

    //  String? token = await SessionService.getToken();
    String? token =
        "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJJZCI6IjY3MGY1NjFhZTc2NjMwMjQ0ZGVhNDU1YyIsInJvbGVOYW1lIjoiaW50ZXJuYWxWZW5kb3JBbmRjcmVkaXRQZCIsImlhdCI6MTczMDk1NzUzOH0.p_57wid1GuLPusS29IwyAfQnKR5qfpdDc4CoU2la-qY";
    try {
      final response = await dio.post(Api.updatePdReport,
          data: payload, options: Options(headers: {"token": token}));
      print(response.data);
      print('Payload: ${payload}');
      if (response.statusCode == 200) {
        CoApplicant coApplicant = CoApplicant.fromJson(response.data);
        print('CO--Applicant form submitted: $response');
        print('coApplicant-- ${coApplicant}');
        state = state.copyWith(isLoading: false);
        return true;
      } else {
        state = state.copyWith(isLoading: false);
        print('Error while submitting applicant form');
        return false;
      }
    } catch (e) {
      state = state.copyWith(isLoading: false);
      print('Exception: $e');
      throw Exception(e);
    }
  }
}

final coApplicantDetailsProvider =
    FutureProvider.autoDispose.family<CoItems, int>((ref, index) async {
  final viewModel = CoApplicationFormDetailsProvider();
  return await viewModel.fetchCoApplicationDetails(index);
});

class CoApplicationFormDetailsProvider {
  final Dio _dio = Dio();

  Future<CoItems> fetchCoApplicationDetails(int index) async {
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
        final details = PDCoApplicantSubmitFormModel.fromJson(responseData);

        if (details.items?.coApplicant != null &&
            details.items!.coApplicant!.isNotEmpty) {
          // Accessing the CoApplicant and coApplicantImage by index
          if (index < details.items!.coApplicant!.length &&
              index < details.items!.coApplicantImage!.length) {
            CoApplicant coApplicant = details.items!.coApplicant![index];
            String coApplicantImage = details.items!.coApplicantImage![index];

            // Print or return the data as needed
            print(
                "CoApplicant: ${coApplicant.coApplicantType}, Image: $coApplicantImage");

            // Return CoApplicant object for further use
            return details.items!;
          } else {
            throw Exception(
                "Index out of bounds for CoApplicant or coApplicantImage");
          }
        } else {
          throw Exception("Applicant details not found in the response");
        }
      } else {
        throw Exception(
            "Failed to load application data: ${response.statusCode}");
      }
    } catch (e) {
      print("Error fetching applicant details: $e");
      throw Exception("Error fetching application data: $e");
    }
  }
}

final coApplicantProvider =
    FutureProvider.autoDispose<List<CoApplicant>>((ref) async {
  final viewModel = CoApplicantProvider();
  return await viewModel.fetchCoApplicants();
});

class CoApplicantProvider {
  final Dio _dio = Dio();

  Future<List<CoApplicant>> fetchCoApplicants() async {
    String? token =
        "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJJZCI6IjY3MGY1NjFhZTc2NjMwMjQ0ZGVhNDU1YyIsInJvbGVOYW1lIjoiaW50ZXJuYWxWZW5kb3JBbmRjcmVkaXRQZCIsImlhdCI6MTczMDk1NzUzOH0.p_57wid1GuLPusS29IwyAfQnKR5qfpdDc4CoU2la-qY"; // Fetch dynamically from secure storage or other sources
    try {
      final response = await _dio.get(
        '${Api.getpdformdata}66f53ffbd7011eb65160f292',
        options: Options(headers: {"token": token}),
      );
      print('Full Response: ${response.data}');

      if (response.statusCode == 200 && response.data != null) {
        // final data = response.data['items'];

        // if (data is Map<String, dynamic>) {
        // Extract the 'co_Applicant' list
        final coApplicantList = response.data['items']['co_Applicant'] as List;

        // Convert the fetched data into CoItems objects
        List<CoApplicant> coApplicants =
            coApplicantList.map((item) => CoApplicant.fromJson(item)).toList();

        // Add empty entries if less than 2 for the UI to function properly
        while (coApplicants.length < 2) {
          coApplicants.add(CoApplicant());
        }

        return coApplicants;
        //  }
        //  else {
        //   throw Exception("Unexpected data format for 'items'");
        // }
      } else {
        throw Exception("Failed to load co-applicant data");
      }
    } catch (e) {
      print("Error fetching co-applicant data: $e");
      throw Exception("Error fetching co-applicant data: $e");
    }
  }
}

class ApplicantState {
  final bool? isLoading;

  final String? selectedDate;

  ApplicantState({
    this.isLoading,
    this.selectedDate,
  });

  ApplicantState.initial()
      : isLoading = false,
        selectedDate = null;

  ApplicantState copyWith({
    bool? isLoading,
    String? selectedDate,
  }) {
    return ApplicantState(
      isLoading: isLoading ?? this.isLoading,
      selectedDate: selectedDate ?? this.selectedDate,
    );
  }
}

class FocusViewModel extends StateNotifier<Map<String, bool>> {
  final FocusNode coApplicantFocus;
  final FocusNode passFocusNode;

  FocusViewModel()
      : coApplicantFocus = FocusNode(),
        passFocusNode = FocusNode(),
        super({
          'coApplicantFocus': false,
          'passFocusNode': false,
        }) {
    coApplicantFocus.addListener(
        () => _focusListener('coApplicantFocus', coApplicantFocus));
    passFocusNode
        .addListener(() => _focusListener('passFocusNode', passFocusNode));
  }

  void _focusListener(String field, FocusNode focusNode) {
    state = {
      ...state,
      field: focusNode.hasFocus,
    };
  }

  @override
  void dispose() {
    coApplicantFocus.removeListener(
        () => _focusListener('userFocusNode', coApplicantFocus));
    passFocusNode
        .removeListener(() => _focusListener('passFocusNode', passFocusNode));
    coApplicantFocus.dispose();
    passFocusNode.dispose();
    super.dispose();
  }
}

final coappvalidation = StateNotifierProvider<CoAppValidation, bool>(
  (ref) {
    return CoAppValidation();
  },
);

class CoAppValidation extends StateNotifier<bool> {
  CoAppValidation() : super(false); // Default value for the radio buttons

  void checkUsername(value) {
    if (value == '' || value.isEmpty) {
      state = true;
      // return true;
    } else {
      state = false;
    }
  }
}
