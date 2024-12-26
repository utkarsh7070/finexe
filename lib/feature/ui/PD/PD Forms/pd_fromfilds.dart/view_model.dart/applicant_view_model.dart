import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:finexe/feature/base/api/api.dart';
import 'package:finexe/feature/base/api/dio.dart';
import 'package:finexe/feature/base/service/session_service.dart';
import 'package:finexe/feature/base/utils/general/pref_utils.dart';
import 'package:finexe/feature/base/utils/namespase/app_colors.dart';
import 'package:finexe/feature/base/utils/widget/custom_snackbar.dart';
import 'package:finexe/feature/ui/Collection/Collection%20cases/model/visit_update_upload_image_responce_model.dart';
// import 'package:finexe/feature/ui/PD/view/PD%20Form/pd_fromfilds.dart/model/Submit%20Data%20Models/applicant_model.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../model/Submit Data Models/applicant_model.dart';

final isAppExpandedProvider = StateProvider<bool>((ref) => false);


class PDApplicantViewModel extends StateNotifier<ApplicantState> {
  final Dio dio;

  PDApplicantViewModel(this.dio) : super(ApplicantState());

  Future<bool> submitpdApplicantForm({
    String? applicantdImage,
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
      'applicantImage': applicantdImage
    };

    String? token = speciality.getToken();
    // String? token =
    //     "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJJZCI6IjY3MGY1NjFhZTc2NjMwMjQ0ZGVhNDU1YyIsInJvbGVOYW1lIjoiaW50ZXJuYWxWZW5kb3JBbmRjcmVkaXRQZCIsImlhdCI6MTczMDk1NzUzOH0.p_57wid1GuLPusS29IwyAfQnKR5qfpdDc4CoU2la-qY";
    print('stored token:: $token');
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
      // throw Exception(e);
      return false;
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
// final loanDetailsProvider = FutureProvider.autoDispose
//     .family<LoanDetails, String>((ref, customerId) async {
//   final token = speciality.getToken();
//   final viewModel = LoanDetailsProvider();
//   return await viewModel.fetchLoanDetails(token, customerId);
// });
final applicationDetailsProvider =
    FutureProvider.autoDispose.family<ApplicantItems,String>((ref,customerId) async {
  final viewModel = ApplicationFormDetailsProvider();
  return await viewModel.fetchApplicationDetails(customerId);
});

class ApplicationFormDetailsProvider {
  final Dio _dio = Dio();

  Future<ApplicantItems> fetchApplicationDetails(String customerId) async {
    String? token = speciality.getToken();

    // String? token =
    //     "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJJZCI6IjY3MGY1NjFhZTc2NjMwMjQ0ZGVhNDU1YyIsInJvbGVOYW1lIjoiaW50ZXJuYWxWZW5kb3JBbmRjcmVkaXRQZCIsImlhdCI6MTczMDk1NzUzOH0.p_57wid1GuLPusS29IwyAfQnKR5qfpdDc4CoU2la-qY"; // Replace with a secure way of managing tokens
    print('url: ${Api.getpdformdata}$customerId');

    try {
      final response = await _dio.get(
        '${Api.getpdformdata}$customerId',
        options: Options(headers: {"token": token}),
      );

      if (response.statusCode == 200 && response.data != null) {
        final Map<String, dynamic> responseData = response.data;

        // Parse the response into the GetApplicantDetailsModel
        final details = ApplicantModel.fromJson(responseData);

        if (details.items != null) {
          return details.items!;
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

final applicantImageProvider =
    StateNotifierProvider<ApplicantImageNotifier, XFile?>((ref) {
  final dio = ref.read(dioProvider);
  return ApplicantImageNotifier(dio);
});

class ApplicantImageNotifier extends StateNotifier<XFile?> {
  final Dio _dio;

  ApplicantImageNotifier(this._dio) : super(null);

  Future<XFile?> pickSecondImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.camera);

    if (image != null) {
      state = image;
      return image;
    }
    return null;
  }

  void removeSecondImage() {
    state = null;
  }

  Future<String> uploadImage(String image, BuildContext context) async {
    String? token = speciality.getToken();

    // String? token =
    //     "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJJZCI6IjY3MGY1NjFhZTc2NjMwMjQ0ZGVhNDU1YyIsInJvbGVOYW1lIjoiaW50ZXJuYWxWZW5kb3JBbmRjcmVkaXRQZCIsImlhdCI6MTczMDk1NzUzOH0.p_57wid1GuLPusS29IwyAfQnKR5qfpdDc4CoU2la-qY";

    if (token == null) {
      throw Exception('Token is missing. Please log in again.');
    }

    // state = state.copyWith(isLoading: true);

    var formData = FormData.fromMap({
      'image':
          await MultipartFile.fromFile(image, filename: image.split('/').last),
    });

    try {
      final response = await _dio.post(
        Api.uploadImageCollection,
        data: formData,
        options: Options(headers: {"token": token}),
      );

      if (response.statusCode == 200) {
        VisitUpdateUploadImageResponseModel imageResponseModel =
            VisitUpdateUploadImageResponseModel.fromJson(response.data);

        // state = state.copyWith(isLoading: false);
        return imageResponseModel.items.image;
      } else {
        showCustomSnackBar(context, 'Failed to upload image.', AppColors.red);
        throw Exception(
            'Failed to upload image. Status code: ${response.statusCode}');
      }
    } catch (e) {
      // state = state.copyWith(isLoading: false);
      showCustomSnackBar(
          context,
          'An error occurred while uploading the image. Please try again.',
          AppColors.red);
      throw Exception(
          'An error occurred while uploading the image. Please try again.');
    }
  }
}
