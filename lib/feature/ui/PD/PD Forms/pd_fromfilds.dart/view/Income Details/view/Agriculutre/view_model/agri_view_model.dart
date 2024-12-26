import 'dart:io';
import 'package:dio/dio.dart';
import 'package:finexe/feature/base/api/api.dart';
import 'package:finexe/feature/base/api/dio.dart';
import 'package:finexe/feature/base/service/session_service.dart';
import 'package:finexe/feature/base/utils/general/pref_utils.dart';
import 'package:finexe/feature/base/utils/widget/custom_snackbar.dart';
import 'package:finexe/feature/ui/Collection/Collection%20cases/model/visit_update_upload_image_responce_model.dart';
// import 'package:finexe/feature/ui/PD/view/PD%20Form/pd_fromfilds.dart/view/Income%20Details/view/Agriculutre/agri_mode/agriculture_income_form_model.dart';
// import 'package:finexe/feature/ui/PD/view/PD%20Form/pd_fromfilds.dart/pd_update_data/view/Income%20Details/view/Agriculutre/agri_mode/agriculture_income_form_model.dart';
import 'package:flutter/Material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

import '../agri_mode/agriculture_income_form_model.dart';

// import '../../../../../../../../../../../base/service/session_service.dart';
// import '../../../../../../../../../../../base/utils/widget/custom_snackbar.dart';

// class ImageUploadNotifier extends StateNotifier<List<File>> {
//   ImageUploadNotifier() : super([]);

//   // Add an image to the state
//   void addImage(File image) {
//     state = [...state, image];
//   }

//   void removeImage(int index) {
//     state = List.from(state)
//       ..removeAt(index); // Creates a new list without the selected image
//   }

//   // Pick an image from the gallery and add it to the state
//   Future<void> pickImage() async {
//     final ImagePicker picker = ImagePicker();
//     final XFile? pickedImage =
//         await picker.pickImage(source: ImageSource.gallery);

//     if (pickedImage != null) {
//       addImage(File(pickedImage.path)); // Add the image to the state
//     }
//   }
// }

class ImageUploadNotifier extends StateNotifier<List<File>> {
  final Dio _dio;

  ImageUploadNotifier(this._dio) : super([]);

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
    StateNotifierProvider<ImageUploadNotifier, List<File>>(
  // (ref) => ImageUploadNotifier(),
  (ref) {
    final dio = ref.read(dioProvider);

    return ImageUploadNotifier(dio);
  },
);

//  ------------- submit api--------
final agriBusinessFormViewModelProvider =
    Provider.autoDispose((ref) => AgricultureBusinessForm());

class AgricultureBusinessForm {
  final Dio _dio = Dio();

  Future<void> submitAgricultureForm(
    AgricultureDataModel formData,
    BuildContext context,
    String customerId
  ) async {
    try {
      // Create the payload for the API request
      final payload = {
        'incomeSource': [formData.toJson()],
        'customerId': customerId,
        'pdType': 'creditPd',
      };

      final token = speciality.getToken();
      // Update this with a dynamic token retrieval process

      final response = await _dio.post(
        Api.updatePdReport, // Replace with your API endpoint
        data: payload,
        options: Options(headers: {"token": token}),
      );

      if (response.statusCode == 200) {
        final updatedData = response.data['items'];
        print(
            'Updated agricultur business data: ${updatedData['incomeSource'][0]['agricultureBusiness']}');

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
final agriBusinessProvider = FutureProvider.autoDispose.family<AgricultureData,String>((ref,custId) async {
  final apiService = ApiService();
  return apiService.fetchAgricultureBusiness(custId);
});

class ApiService {
  final Dio _dio = Dio();

  Future<AgricultureData> fetchAgricultureBusiness(String customerId) async {
    String? token =
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJJZCI6IjY3MGY1NjFhZTc2NjMwMjQ0ZGVhNDU1YyIsInJvbGVOYW1lIjoiaW50ZXJuYWxWZW5kb3JBbmRjcmVkaXRQZCIsImlhdCI6MTczMDk1NzUzOH0.p_57wid1GuLPusS29IwyAfQnKR5qfpdDc4CoU2la-qY';

    try {
      // Make the API request
      final response = await _dio.get(
        '${Api.getpdformdata}$customerId',
        options: Options(headers: {"token": token}),
      );

      // Print the full response for debugging
      print('Agriculture get Response: ${response.data}');

      // Validate response status
      if (response.statusCode == 200) {
        final items = response.data['items'] as Map<String, dynamic>? ?? {};
        final incomeSource = items['incomeSource'];

        // Validate incomeSource existence
        if (incomeSource == null) {
          throw Exception('Error: "incomeSource" field is missing in response');
        }

        // Handle incomeSource if it's a List
        if (incomeSource is List) {
          final agriBusinessSource = incomeSource.firstWhere(
            (source) => source['incomeSourceType'] == 'agricultureBusiness',
            orElse: () => null,
          );

          if (agriBusinessSource != null) {
            final agriBusiness = agriBusinessSource['agricultureBusiness'];
            if (agriBusiness != null) {
              return AgricultureData.fromJson(agriBusiness);
            } else {
              throw Exception(
                  'Error: "agricultureBusiness" data is missing in list');
            }
          }
        }
        // Handle incomeSource if it's a Map
        else if (incomeSource is Map) {
          final agriData = incomeSource['agricultureBusiness'];
          if (agriData != null) {
            return AgricultureData.fromJson(agriData);
          }
        }

        // If no valid agriculture business data is found
        throw Exception(
            'Error: "agricultureBusiness" data not found in response');
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

// ---------- other drop down api name list --------
final otherProvider = FutureProvider.autoDispose.family<OtherDropData,String>((ref,customerID) async {
  final apiService = ApiOtherService();
  return apiService.fetchOtherData(customerID);
});

class ApiOtherService {
  final Dio _dio = Dio();

  Future<OtherDropData> fetchOtherData(String customerId) async {
    final token = speciality.getToken();

    try {
      final response = await _dio.get(
        '${Api.getotherdropdatalist}$customerId',
        options: Options(headers: {"token": token}),
      );

      if (response.statusCode == 200) {
        // Extract 'items' from the response
        final items = response.data['items'] as List<dynamic>? ?? [];
        if (items.isNotEmpty) {
          final data = items.first['data'] as List<dynamic>? ?? [];

          // Extract 'fullName' from each entry in 'data'
          final names = data
              .where((item) =>
                  item is Map<String, dynamic> && item.containsKey('fullName'))
              .map((item) => item['fullName'] as String)
              .toList();

          // Return the parsed model
          return OtherDropData(otherdrop: names);
        } else {
          throw Exception('No items found in the response.');
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
