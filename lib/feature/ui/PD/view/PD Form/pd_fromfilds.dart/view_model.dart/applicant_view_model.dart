import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:finexe/feature/base/api/api.dart';
import 'package:finexe/feature/base/api/dio.dart';
import 'package:finexe/feature/base/service/session_service.dart';
import 'package:finexe/feature/ui/PD/view/PD%20Form/pd_fromfilds.dart/model/Submit%20Data%20Models/applicant_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PDApplicantViewModel extends StateNotifier<ApplicantState> {
  final Dio dio;

  PDApplicantViewModel(this.dio) : super(ApplicantState());

  Future<bool> submitpdApplicantForm({
    required String customerId,
    required String pdType,
    String? applicantType,
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

    final applicantdata = Applicant(
      applicantType: applicantType,
      businessType: businessType,
      occupation: occupation,
      dOB: dob,
      email: email,
      houseLandMark: houseLandMark,
      alternateMobileNo: alternateMobileNo,
      noOfyearsAtCurrentAddress: noOfyearsAtCurrentAddress,
      gender: gender,
      religion: religion,
      nationality: nationality,
      category: category,
      caste: caste,
      maritalStatus: maritalStatus,
      noOfDependentWithCustomer: noOfDependentWithCustomer,
      educationalDetails: educationalDetails,
      residenceType: residenceType,
    );

    // Add customerId and pdType to the payload
    final payload = {
      'applicant': applicantdata.toJson(),
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
        Applicant applicantdata = Applicant.fromJson(response.data);
        print('Applicant form submitted: $response');

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

final pdapplicantViewModelProvider =
    StateNotifierProvider<PDApplicantViewModel, ApplicantState>((ref) {
  final dio = ref.read(dioProvider);
  // final checkStatus = ref.watch(checkBoxTermsConditionApplicant);

  return PDApplicantViewModel(dio);
});

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

final applicationDetailsProvider =
    FutureProvider.autoDispose<Applicant>((ref) async {
  final viewModel = ApplicationFormDetailsProvider();
  return await viewModel.fetchApplicationDetails();
});

class ApplicationFormDetailsProvider {
  final Dio _dio = Dio();

  Future<Applicant> fetchApplicationDetails() async {
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
        final details = ApplicantModel.fromJson(responseData);

        if (details.items?.applicant != null) {
          return details.items!.applicant!;
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
