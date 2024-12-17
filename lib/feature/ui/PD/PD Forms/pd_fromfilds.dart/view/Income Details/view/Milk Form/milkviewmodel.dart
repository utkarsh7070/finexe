import 'dart:io';
import 'package:dio/dio.dart';
import 'package:finexe/feature/base/api/api.dart';
import 'package:finexe/feature/base/api/dio.dart';
import 'package:finexe/feature/base/service/session_service.dart';
import 'package:finexe/feature/base/utils/widget/custom_snackbar.dart';
import 'package:finexe/feature/ui/Collection/Collection%20cases/model/visit_update_upload_image_responce_model.dart';
import 'package:flutter/Material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

// import '../../../../../../../../../../base/api/api.dart';
// import '../../../../../../../../../../base/service/session_service.dart';
// import '../../../../../../../../../../base/utils/widget/custom_snackbar.dart';
import 'milk_model/milk_income_form_model.dart';

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
    String? token = await SessionService.getToken();

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

//  ------------- submit api--------
final milkBusinessFormViewModelProvider =
    Provider.autoDispose((ref) => MilkBusinessFormViewModel());

class MilkBusinessFormViewModel {
  final Dio _dio = Dio();

  Future<void> submitMilkBusinessForm(
    MilkBusinessModel formData,
    BuildContext context,
    String custId
  ) async {
    try {
      // Create the payload for the API request
      final payload = {
        'incomeSource': [formData.toJson()],
        'customerId': custId,
        'pdType': 'creditPd',
      };

      final token = await SessionService.getToken();

      final response = await _dio.post(
        Api.updatePdReport, // Replace with your API endpoint
        data: payload,
        options: Options(headers: {"token": token}),
      );

      print('response: ${response.data}');

      if (response.statusCode == 200) {
        final updatedData = response.data['items'];
        print(
            'Updated milk business data: ${updatedData['incomeSource'][0]['milkBusiness']}');

        showCustomSnackBar(
            context, 'Milk Business Form Submitted', Colors.green);
      } else {
        // Log the error response for debugging
        print('Error response: ${response.data}');
        throw Exception('Failed to submit milk business form');
      }
    } catch (e) {
      print("Error submitting milk business form: $e");
      showCustomSnackBar(context, 'Form Submission Failed', Colors.red);
    }
  }
}

//  -------------- get api
final milkBusinessProvider = FutureProvider.autoDispose.family<MilkBusinessData,String>((ref,customerId) async {
  final apiService = ApiService();
  return apiService.fetchMilkBusiness(customerId);
});

class ApiService {
  final Dio _dio = Dio();

  Future<MilkBusinessData> fetchMilkBusiness(String custId) async {
    final token = await SessionService.getToken();

    try {

      // Make the API request
      final response = await _dio.get(
        '${Api.getpdformdata}$custId',
        options: Options(headers: {"token": token}),
      );

      // Print the full response for debugging
      print('Full API Response: ${response.data}');

      // Check if the response is valid
      if (response.statusCode == 200) {
        final items = response.data['items'] as Map<String, dynamic>? ?? {};
        print('Items: $items');

        final incomeSource = items['incomeSource'];
        print('Income Source Type: ${incomeSource.runtimeType}');

        if (incomeSource == null) {
          throw Exception('Error: "incomeSource" field is missing in response');
        }

        if (incomeSource is List) {
          for (var source in incomeSource) {
            print('Income Source Entry: $source');

            // Ensure each entry is a Map before processing
            if (source is Map<String, dynamic>) {
              if (source.containsKey('milkBusiness')) {
                final milkBusiness = source['milkBusiness'];
                print('Milk Business: $milkBusiness');

                if (milkBusiness != null) {
                  return MilkBusinessData.fromJson(milkBusiness);
                } else {
                  throw Exception('Error: "milkBusiness" data is missing in the entry');
                }
              } else {
                print('Skipping entry without "milkBusiness": $source');
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
        throw Exception(
            'Failed to fetch data. Status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error occurred: $e');
      throw Exception('Error occurred: $e');
    }
  }
}
