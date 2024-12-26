import 'package:dio/dio.dart';
import 'package:finexe/feature/base/api/api.dart';
import 'package:finexe/feature/base/api/dio.dart';
import 'package:finexe/feature/base/service/session_service.dart';
import 'package:finexe/feature/base/utils/namespase/app_colors.dart';
import 'package:finexe/feature/base/utils/widget/custom_snackbar.dart';
import 'package:finexe/feature/ui/Collection/Collection%20cases/model/visit_update_upload_image_responce_model.dart';
import 'package:finexe/feature/ui/PD/PD%20Forms/pd_fromfilds.dart/model/Submit%20Data%20Models/coapplicant_model.dart';
// import 'package:finexe/feature/ui/PD/view/PD%20Form/pd_fromfilds.dart/model/Submit%20Data%20Models/coapplicant_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

final pdCoapplicantViewModelProvider =
    StateNotifierProvider<PDCOApplicantViewModel, ApplicantState>((ref) {
  final dio = ref.read(dioProvider);
  // final checkStatus = ref.watch(checkBoxTermsConditionApplicant);
  return PDCOApplicantViewModel(dio);
});

class PDCOApplicantViewModel extends StateNotifier<ApplicantState> {
  final Dio dio;

  PDCOApplicantViewModel(this.dio) : super(ApplicantState());

  Future<bool> submitpdCoApplicantForm(
      {required String customerId,
      required String pdType,
      required List<String?> coapplicantImages,
      CoApplicant? coApplicatFirstData
      // String? coapplicantType,
      // String? businessType,
      // String? occupation,
      // String? dob,
      // String? email,
      // String? houseLandMark,
      // String? alternateMobileNo,
      // String? noOfyearsAtCurrentAddress,
      // String? gender,
      // String? religion,
      // String? nationality,
      // String? category,
      // String? caste,
      // String? maritalStatus,
      // String? noOfDependentWithCustomer,
      // String? educationalDetails,
      // String? residenceType,
      }) async {
    state = state.copyWith(isLoading: true);

    // Add customerId and pdType to the payload
    final payload = {
      'co_Applicant': coApplicatFirstData?.toJson(),
      'customerId': customerId,
      'pdType': pdType,
      'coApplicantImage': coapplicantImages.toList()
    };

    String? token = await SessionService.getToken();
    // String? token =
    //     "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJJZCI6IjY3MGY1NjFhZTc2NjMwMjQ0ZGVhNDU1YyIsInJvbGVOYW1lIjoiaW50ZXJuYWxWZW5kb3JBbmRjcmVkaXRQZCIsImlhdCI6MTczMDk1NzUzOH0.p_57wid1GuLPusS29IwyAfQnKR5qfpdDc4CoU2la-qY";
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
      print('payload of coapplicantImages :: $payload');
      state = state.copyWith(isLoading: false);
      print('Exception in co_applicant form: $e');
      return false;
    }
  }
}

//********************************************
class CoApplicantDetailsParams {
  final int index;
  final String customerId;

  CoApplicantDetailsParams({
    required this.index,
    required this.customerId,
  });
}

final coApplicantDetailsProvider =
    FutureProvider.autoDispose.family<CoItems, String>((ref, customerId) async {
  final viewModel = CoApplicationFormDetailsProvider();
  return await viewModel.fetchCoApplicationDetails(0,customerId);
});

class CoApplicationFormDetailsProvider {
  final Dio _dio = Dio();
 // int index=0;
  Future<CoItems> fetchCoApplicationDetails(int index, String customerId) async {
    String? token = await SessionService.getToken();
    print('index: $index');
    print('url: ${Api.getpdformdata}$customerId');

    try {
      final response = await _dio.get(
        '${Api.getpdformdata}$customerId',
        options: Options(headers: {"token": token}),
      );

      if (response.statusCode == 200 && response.data != null) {
        final Map<String, dynamic> responseData = response.data;

        // Parse the response into the PDCoApplicantSubmitFormModel
        final details = PDCoApplicantSubmitFormModel.fromJson(responseData);

        if (details.items?.coApplicant != null &&
            details.items!.coApplicant!.isNotEmpty) {
          print('CoApplicant List Length: ${details.items!.coApplicant!.length}');
          print('CoApplicantImage List Length: ${details.items!.coApplicantImage!.length}');

          // Ensure index is valid for coApplicant list
          if (index < details.items!.coApplicant!.length) {
            CoApplicant coApplicant = details.items!.coApplicant![index];

            String? coApplicantImage = (details.items!.coApplicantImage != null &&
                index < details.items!.coApplicantImage!.length)
                ? details.items!.coApplicantImage![index]
                : null;

            print("CoApplicant: ${coApplicant.coApplicantType}");
            print("CoApplicant Image: ${coApplicantImage ?? 'No Image Available'}");

            // Return the CoItems object with or without the image
            return details.items!;
          } else {
            throw Exception("Index $index is out of bounds for coApplicant");
          }
        } else {
          throw Exception("CoApplicant details not found in the response");
        }
      } else {
        throw Exception("Failed to load coApplicant data: ${response.statusCode}");
      }
    } catch (e) {
      print("Error fetching coApplicant details: $e");
      throw Exception("Error fetching coApplication data: $e");
    }
  }


}


//***************************************list***************************************
final coApplicantProvider =
    FutureProvider.autoDispose.family<List<CoApplicant>,String>((ref,custOmerId) async {
  final viewModel = CoApplicantProvider();
  return await viewModel.fetchCoApplicants(custOmerId);
});

class CoApplicantProvider {
  final Dio _dio = Dio();

  Future<List<CoApplicant>> fetchCoApplicants(String custId) async {
    String? token = await SessionService.getToken();

    // String? token =
    //     "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJJZCI6IjY3MGY1NjFhZTc2NjMwMjQ0ZGVhNDU1YyIsInJvbGVOYW1lIjoiaW50ZXJuYWxWZW5kb3JBbmRjcmVkaXRQZCIsImlhdCI6MTczMDk1NzUzOH0.p_57wid1GuLPusS29IwyAfQnKR5qfpdDc4CoU2la-qY"; // Fetch dynamically from secure storage or other sources
    try {
      final response = await _dio.get(
        '${Api.getpdformdata}$custId',
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

// class FocusViewModel extends StateNotifier<Map<String, bool>> {
//   final FocusNode coApplicantFocus;
//   final FocusNode passFocusNode;
//
//   FocusViewModel()
//       : coApplicantFocus = FocusNode(),
//         passFocusNode = FocusNode(),
//         super({
//           'coApplicantFocus': false,
//           'passFocusNode': false,
//         }) {
//     coApplicantFocus.addListener(
//         () => _focusListener('coApplicantFocus', coApplicantFocus));
//     passFocusNode
//         .addListener(() => _focusListener('passFocusNode', passFocusNode));
//   }
//
//   void _focusListener(String field, FocusNode focusNode) {
//     state = {
//       ...state,
//       field: focusNode.hasFocus,
//     };
//   }
//
//   @override
//   void dispose() {
//     coApplicantFocus.removeListener(
//         () => _focusListener('userFocusNode', coApplicantFocus));
//     passFocusNode
//         .removeListener(() => _focusListener('passFocusNode', passFocusNode));
//     coApplicantFocus.dispose();
//     passFocusNode.dispose();
//     super.dispose();
//   }
// }
//
// final coappvalidation = StateNotifierProvider<CoAppValidation, bool>(
//   (ref) {
//     return CoAppValidation();
//   },
// );
//
// class CoAppValidation extends StateNotifier<bool> {
//   CoAppValidation() : super(false); // Default value for the radio buttons
//
//   void checkUsername(value) {
//     if (value == '' || value.isEmpty) {
//       state = true;
//       // return true;
//     } else {
//       state = false;
//     }
//   }
// }

// final coapplicantImageFirst =
//     StateNotifierProvider<CoApplicantImageNot, XFile?>((ref) {
//   final dio = ref.read(dioProvider);
//   return CoApplicantImageNot(dio);
// });

// class CoApplicantImageNot extends StateNotifier<XFile?> {
//   final Dio _dio;
//
//   CoApplicantImageNot(this._dio) : super(null);
//
//   Future<XFile?> pickSecondImage() async {
//     final ImagePicker picker = ImagePicker();
//     final XFile? image = await picker.pickImage(source: ImageSource.camera);
//
//     if (image != null) {
//       state = image;
//       return image;
//     }
//     return null;
//   }
//
//   void removeSecondImage() {
//     state = null;
//   }
//
//   Future<String> uploadImage(String image, BuildContext context) async {
//     String? token = await SessionService.getToken();
//
//     // String? token =
//     //     "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJJZCI6IjY3MGY1NjFhZTc2NjMwMjQ0ZGVhNDU1YyIsInJvbGVOYW1lIjoiaW50ZXJuYWxWZW5kb3JBbmRjcmVkaXRQZCIsImlhdCI6MTczMDk1NzUzOH0.p_57wid1GuLPusS29IwyAfQnKR5qfpdDc4CoU2la-qY";
//
//     if (token == null) {
//       throw Exception('Token is missing. Please log in again.');
//     }
//
//     // state = state.copyWith(isLoading: true);
//
//     var formData = FormData.fromMap({
//       'image':
//           await MultipartFile.fromFile(image, filename: image.split('/').last),
//     });
//
//     try {
//       final response = await _dio.post(
//         Api.uploadImageCollection,
//         data: formData,
//         options: Options(headers: {"token": token}),
//       );
//
//       if (response.statusCode == 200) {
//         VisitUpdateUploadImageResponseModel imageResponseModel =
//             VisitUpdateUploadImageResponseModel.fromJson(response.data);
//
//         // state = state.copyWith(isLoading: false);
//         return imageResponseModel.items.image;
//       } else {
//         showCustomSnackBar(context, 'Failed to upload image.', AppColors.red);
//         throw Exception(
//             'Failed to upload image. Status code: ${response.statusCode}');
//       }
//     } catch (e) {
//       // state = state.copyWith(isLoading: false);
//       showCustomSnackBar(
//           context,
//           'An error occurred while uploading the image. Please try again.',
//           AppColors.red);
//       throw Exception(
//           'An error occurred while uploading the image. Please try again.');
//     }
//   }
// }
