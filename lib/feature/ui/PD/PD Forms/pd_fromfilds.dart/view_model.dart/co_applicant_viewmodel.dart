import 'package:finexe/feature/base/utils/general/pref_utils.dart';

import 'package:dio/dio.dart';
import 'package:finexe/feature/base/api/api.dart';
import 'package:finexe/feature/base/api/dio.dart';
import 'package:finexe/feature/ui/PD/PD%20Forms/pd_fromfilds.dart/model/Submit%20Data%20Models/coapplicant_model.dart';
// import 'package:finexe/feature/ui/PD/view/PD%20Form/pd_fromfilds.dart/model/Submit%20Data%20Models/coapplicant_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../base/api/dio_exception.dart';


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
        required BuildContext context,
      // CoApplicant? coApplicatFirstData,
        List<CoApplicant>? coApplicantUsers,

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
    // if(state.isLoading==true){
    //   print('click second time');
    //   return false;
    // }
    // Add customerId and pdType to the payload
    final payload = {
      // 'co_Applicant': coApplicatFirstData?.toJson(),
      'co_Applicant': coApplicantUsers?.toList(),
      'customerId': customerId,
      'pdType': pdType,
      'coApplicantImage': coapplicantImages.toList()
    };

    String? token = speciality.getToken();
    // String? token =
    //     "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJJZCI6IjY3MGY1NjFhZTc2NjMwMjQ0ZGVhNDU1YyIsInJvbGVOYW1lIjoiaW50ZXJuYWxWZW5kb3JBbmRjcmVkaXRQZCIsImlhdCI6MTczMDk1NzUzOH0.p_57wid1GuLPusS29IwyAfQnKR5qfpdDc4CoU2la-qY";
    try {
      final response = await dio.post(Api.updatePdReport,
          data: payload, options: Options(headers: {"token": token}));
      print(response.data);
      print('Payload: $payload');
      if (response.statusCode == 200) {
        CoApplicant coApplicant = CoApplicant.fromJson(response.data);
        print('CO--Applicant form submitted: $response');
        print('coApplicant-- $coApplicant');
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
      DioExceptions.fromDioError(e as DioException, context);

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
    FutureProvider.autoDispose.family<PDCoApplicantSubmitFormModel?, String>((ref, customerId) async {
  final viewModel = CoApplicationFormDetailsProvider();
  return await viewModel.fetchCoApplicationDetails(0,customerId);
});

class CoApplicationFormDetailsProvider {
  final Dio _dio = Dio();
 // int index=0;
  Future<PDCoApplicantSubmitFormModel?> fetchCoApplicationDetails(int index, String customerId) async {
    String? token = speciality.getToken();
    PDCoApplicantSubmitFormModel details = PDCoApplicantSubmitFormModel();
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
         details = PDCoApplicantSubmitFormModel.fromJson(responseData);

        if (details.items?.coApplicant != null
            // && details.items?.coApplicant?.isNotEmpty
        ) {
          print('CoApplicant List Length: ${details.items?.coApplicant?.length}');
          print('CoApplicantImage List Length: ${details.items?.coApplicantImage?.length}');

          // Ensure index is valid for coApplicant list
          if (index < details.items!.coApplicant!.length) {
            CoApplicant coApplicant = details.items?.coApplicant![index] ?? CoApplicant.fromJson({});

            String? coApplicantImage = (details.items?.coApplicantImage != null &&
                index < details.items!.coApplicantImage!.length)
                ? details.items?.coApplicantImage![index]
                : null;

            print("CoApplicant: ${coApplicant.coApplicantType}");
            print("CoApplicant Image: ${coApplicantImage ?? 'No Image Available'}");

            // Return the CoItems object with or without the image
            return details;
          } else {
            print('Index $index is out of bounds for coApplicant');
            return null;
            // throw Exception("Index $index is out of bounds for coApplicant");
          }
        } else {
          print('CoApplicant details not found in the response');
          return null;

          // throw Exception("CoApplicant details not found in the response");
        }
      } else {
        return null;

        print('Failed to load coApplicant data: ${response.statusCode}');
        // throw Exception("Failed to load coApplicant data: ${response.statusCode}");
      }
    } catch (e) {
      print("Error fetching coApplicant details: $e");
      // throw Exception("Error fetching coApplication data: $e");
      return details;
    }
  }
}


//***************************************list***************************************
// final coApplicantProvider =
//     FutureProvider.autoDispose.family<List<CoApplicant>,String>((ref,custOmerId) async {
//   final viewModel = CoApplicantProvider();
//   return await viewModel.fetchCoApplicants(custOmerId);
// });
//
// class CoApplicantProvider {
//   final Dio _dio = Dio();
//
//   Future<List<CoApplicant>> fetchCoApplicants(String custId) async {
//     String? token = speciality.getToken();
//
//     // String? token =
//     //     "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJJZCI6IjY3MGY1NjFhZTc2NjMwMjQ0ZGVhNDU1YyIsInJvbGVOYW1lIjoiaW50ZXJuYWxWZW5kb3JBbmRjcmVkaXRQZCIsImlhdCI6MTczMDk1NzUzOH0.p_57wid1GuLPusS29IwyAfQnKR5qfpdDc4CoU2la-qY"; // Fetch dynamically from secure storage or other sources
//     try {
//       final response = await _dio.get(
//         '${Api.getpdformdata}$custId',
//         options: Options(headers: {"token": token}),
//       );
//       print('Full Response: ${response.data}');
//
//       if (response.statusCode == 200 && response.data != null) {
//         // final data = response.data['items'];
//
//         // if (data is Map<String, dynamic>) {
//         // Extract the 'co_Applicant' list
//         final coApplicantList = response.data['items']['co_Applicant'] as List;
//
//         // Convert the fetched data into CoItems objects
//         List<CoApplicant> coApplicants =
//             coApplicantList.map((item) => CoApplicant.fromJson(item)).toList();
//
//         // Add empty entries if less than 2 for the UI to function properly
//         while (coApplicants.length < 2) {
//           coApplicants.add(CoApplicant());
//         }
//
//         return coApplicants;
//         //  }
//         //  else {
//         //   throw Exception("Unexpected data format for 'items'");
//         // }
//       } else {
//         throw Exception("Failed to load co-applicant data");
//       }
//     } catch (e) {
//       print("Error fetching co-applicant data: $e");
//       throw Exception("Error fetching co-applicant data: $e");
//     }
//   }
// }

//*************************************************************coAppliocantimageUploadProvider
// final coAppliocantimageUploadProvider =
// StateNotifierProvider<COAppImageNotifier, List<File>>(
//   // (ref) => AgriImageUploadNotifier(),
//         (ref) {
//       final dio = ref.read(dioProvider);
//
//       return COAppImageNotifier(dio);
//     });
//
//
//
// class COAppImageNotifier extends StateNotifier<List<File>> {
//   final Dio _dio;
//
//   COAppImageNotifier(this._dio) : super([]);
//
//   // Pick an image from the gallery and add it to the state
//   Future<String> pickImage() async {
//     final ImagePicker picker = ImagePicker();
//     final XFile? pickedImage =
//     await picker.pickImage(source: ImageSource.camera);
//
//     if (pickedImage != null) {
//       // Add the image to the state
//       // uploadImage(pickedImage.path);
//       print('pickedImage.path:: ${pickedImage.path}');
//       return pickedImage.path;
//     }
//     return '';
//   }
//
//   Future<String> uploadImage(String image) async {
//     String? token = speciality.getToken();
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
//       await MultipartFile.fromFile(image, filename: image.split('/').last),
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
//         VisitUpdateUploadImageResponseModel.fromJson(response.data);
//
//         // state = state.copyWith(isLoading: false);
//
//         return imageResponseModel.items.image;
//       } else {
//         throw Exception(
//             'Failed to upload image. Status code: ${response.statusCode}');
//       }
//     } catch (e) {
//       // state = state.copyWith(isLoading: false);
//       throw Exception('An error occurred while uploading the image. $e.');
//     }
//   }
// }