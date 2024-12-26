import 'dart:io';
import 'package:dio/dio.dart';
import 'package:finexe/feature/base/api/api.dart';
import 'package:finexe/feature/base/api/dio.dart';
import 'package:finexe/feature/base/service/session_service.dart';
import 'package:finexe/feature/base/utils/general/pref_utils.dart';
import 'package:finexe/feature/base/utils/widget/custom_snackbar.dart';
import 'package:finexe/feature/ui/Collection/Collection%20cases/model/visit_update_upload_image_responce_model.dart';
// import 'package:finexe/feature/ui/PD/view/PD%20Form/pd_fromfilds.dart/view/Income%20Details/view/Others/other_model/other_income_model.dart';
// import 'package:finexe/feature/ui/PD/view/PD%20Form/pd_fromfilds.dart/pd_update_data/view/Income%20Details/view/Others/other_model/other_income_model.dart';
// import 'package:finexe/feature/ui/PD/view/PD%20Form/pd_fromfilds.dart/pd_update_data/view/Income%20Details/view/Salary%20Income/salary_model/salary_income_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

import 'other_model/other_income_model.dart';

// import '../../../../../../../../../../base/api/api.dart';
// import '../../../../../../../../../../base/service/session_service.dart';
// import '../../../../../../../../../../base/utils/widget/custom_snackbar.dart';

// ---------- Image Upload Notifier (Optional) ---------
// class OtherImageUploadNotifier extends StateNotifier<List<File>> {
//   OtherImageUploadNotifier() : super([]);

//   void addImage(File image) {
//     state = [...state, image];
//   }

//   void removeImage(int index) {
//     state = List.from(state)..removeAt(index);
//   }

//   Future<void> pickImage() async {
//     final picker = ImagePicker();
//     final XFile? pickedImage =
//         await picker.pickImage(source: ImageSource.gallery);

//     if (pickedImage != null) {
//       addImage(File(pickedImage.path));
//     }
//   }
// }

// final otherImageUploadProvider =
//     StateNotifierProvider<OtherImageUploadNotifier, List<File>>(
//   (ref) => OtherImageUploadNotifier(),
// );

// ---------- Submit API ViewModel -----------
final otherDetailsFormViewModelProvider =
    Provider.autoDispose((ref) => OtherDetailsFormView());

class OtherDetailsFormView {
  final Dio _dio = Dio();

  Future<void> submitOtherDetailsForm(
    OtherIncomeModel formData,
    BuildContext context,
      String custId
  ) async {
    try {
      // Create the payload for API request
      final payload = {
        'incomeSource': [formData.toJson()],
        'customerId': custId,
        'pdType': 'creditPd',
      };

      final token = speciality.getToken();

      final response = await _dio.post(
        Api.updatePdReport, // Replace with your API endpoint
        data: payload,
        options: Options(headers: {"token": token}),
      );
      print('Response  post other--: ${response.data}');

      if (response.statusCode == 200) {
        showCustomSnackBar(context, 'other Details Submitted', Colors.green);
      } else {
        print('Error response: ${response.data}');
        throw Exception('Failed to submit salary details');
      }
    } catch (e) {
      print('Error submitting salary details: $e');
      showCustomSnackBar(context, 'Form Submission Failed', Colors.red);
    }
  }
}

// ---------- Fetch API Provider ----------
final salaryDetailsProvider = FutureProvider.autoDispose.family<OtherIncomeData,String>((ref,custId) async {
  final apiService = OtherApiService();
  return apiService.fetchOtherDetails(custId);
});

class OtherApiService {
  final Dio _dio = Dio();

  Future<OtherIncomeData> fetchOtherDetails(String custId) async {
    final token = speciality.getToken();

    try {
      // Make the API request
      final response = await _dio.get(
        '${Api.getpdformdata}$custId',
        options: Options(headers: {"token": token}),
      );

      print('Full other API Response: ${response.data}');

      if (response.statusCode == 200) {
        final items = response.data['items'] as Map<String, dynamic>? ?? {};
        final incomeSource = items['incomeSource'];

        if (incomeSource == null) {
          throw Exception('Error: "incomeSource" field is missing in response');
        }

        // Safely parse `incomeSource` to ensure it's not null or of invalid type
        if (incomeSource is List) {
          for (var source in incomeSource) {
            print('Income Source Entry: $source');

            // Ensure each entry is a Map before processing
            if (source is Map<String, dynamic>) {
              if (source.containsKey('other')) {
                final ohterBusiness = source['other'];
                print('ohterBusiness: $ohterBusiness');

                if (ohterBusiness != null) {
                  return OtherIncomeData.fromJson(ohterBusiness);
                } else {
                  throw Exception('Error: "ohterBusiness" data is missing in the entry');
                }
              } else {
                print('Skipping entry without "ohterBusiness": $source');
              }
            } else {
              print('Unexpected entry type in incomeSource: ${source.runtimeType}');
            }
          }
          // If no entry contains "milkBusiness"
          throw Exception('Error: "milkBusiness" data not found in any income source entry');
        } else {
          throw Exception('Error: "incomeSource" is not a valid List');
        }
      } else {
        throw Exception('Failed to fetch data. Status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error occurred: $e');
      throw Exception('Error occurred while fetching other income details: $e');
    }
  }

}

class AnimalImageUploadNotifier extends StateNotifier<List<File>> {
  final Dio _dio;

  AnimalImageUploadNotifier(this._dio) : super([]);

  // Pick an image from the gallery and add it to the state
  Future<String> pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? pickedImage =
        await picker.pickImage(source: ImageSource.camera);

    if (pickedImage != null) {
      // Add the image to the state
      // uploadImage(pickedImage.path);
      print('pickedImage.path:: ${pickedImage.path}');
      return pickedImage.path;
    }
    return '';
  }

  Future<String> uploadImage(String image) async {
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
        throw Exception(
            'Failed to upload image. Status code: ${response.statusCode}');
      }
    } catch (e) {
      // state = state.copyWith(isLoading: false);
      throw Exception('An error occurred while uploading the image. $e.');
    }
  }
}

final imageUploadProvider =
    StateNotifierProvider<AnimalImageUploadNotifier, List<File>>(
  // (ref) => ImageUploadNotifier(),
  (ref) {
    final dio = ref.read(dioProvider);

    return AnimalImageUploadNotifier(dio);
  },
);
