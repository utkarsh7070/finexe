import 'dart:io';
import 'package:dio/dio.dart';
import 'package:finexe/feature/base/api/api.dart';
import 'package:finexe/feature/base/api/dio.dart';
import 'package:finexe/feature/base/utils/general/pref_utils.dart';
import 'package:finexe/feature/ui/Collection/Collection%20cases/model/visit_update_upload_image_responce_model.dart';
import 'package:flutter/Material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../../../../../../base/api/dio_exception.dart';
import '../../../../../../../../../base/utils/widget/custom_snackbar.dart';
import '../agri_mode/agriculture_income_form_model.dart';

class MultiSelectNotifier extends StateNotifier<List<String>> {
  MultiSelectNotifier() : super([]);
  final List<String> options = [];
  void toggleSelection(String value) {
    if (state.contains(value)) {
      state = state.where((item) => item != value).toList();
    } else {
      state = [...state, value];
    }
  }
}

final multiSelectProvider =
StateNotifierProvider<MultiSelectNotifier, List<String>>(
      (ref) => MultiSelectNotifier(),
);

final isExpanded = StateProvider<bool>(
  (ref) {
  return false;
});
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
      AgricultreItems formData,
    BuildContext context,
    String customerId,

  ) async {
    try {
      // Create the payload for the API request
      final payload = {
        'incomeSource': [formData.toJson()],
        'customerId': customerId,
        'pdType': 'creditPd',
      };

      final token =  speciality.getToken();
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
            context, 'Milk Business Form Saved', Colors.green);
        // ScaffoldMessenger.of(context).showSnackBar(
        //   SnackBar(
        //     backgroundColor: AppColors.green,
        //     content: Text(
        //       'Form Details Saved successfully!',
        //       style: AppStyles.whiteText16,
        //     ),
        //   ),
        // );
      }
      else {
        // Log the error response for debugging
        print('Error response: ${response.data}');
        // ScaffoldMessenger.of(context).showSnackBar(
        //   SnackBar(
        //     backgroundColor: AppColors.red,
        //     content: Text(
        //       'Failed to save form details',
        //       style: AppStyles.whiteText16,
        //     ),
        //   ),
        // );
        showCustomSnackBar(
            context, 'Failed to save form details', Colors.green);
        // throw Exception('Failed to submit milk business form');
      }
    } catch (e) {
      print("Error submitting milk business form: $e");
      // showCustomSnackBar(context, 'Form Submission Failed', Colors.red);
      DioExceptions.fromDioError(e as DioException, context);

    }
  }
}

//  -------------- get api
final agriBusinessProvider = FutureProvider.autoDispose.family<AgricultureDataModel?,String>((ref,custId) async {
  final apiService = ApiService();
  return apiService.fetchAgricultureBusiness(custId);
});

class ApiService {
  final Dio _dio = Dio();

  Future<AgricultureDataModel?> fetchAgricultureBusiness(String customerId) async {
    // String? token =
    //     'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJJZCI6IjY3MGY1NjFhZTc2NjMwMjQ0ZGVhNDU1YyIsInJvbGVOYW1lIjoiaW50ZXJuYWxWZW5kb3JBbmRjcmVkaXRQZCIsImlhdCI6MTczMDk1NzUzOH0.p_57wid1GuLPusS29IwyAfQnKR5qfpdDc4CoU2la-qY';
    String? token =speciality.getToken();

    try {
      // Make the API request
      final response = await _dio.get(
        '${Api.getpdformdata}$customerId',
        options: Options(headers: {"token": token}),
      );
      print('Agriculture get Response: ${response.data}');

      // Validate response status
      if (response.statusCode == 200) {
        final items = response.data['items'] as Map<String, dynamic>? ?? {};
        print('items in agri:: $items');
        // Handle case when items is empty
        if (items.isEmpty) {
          print('Warning: "items" is empty in the response');
          return null; // Return null or handle as needed
        }
        final incomeSource = items['incomeSource'];
        if (incomeSource == null) {
          print('Error: "incomeSource" field is missing in response');
          //throw Exception('Error: "incomeSource" field is missing in response');
          return null;
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
              return AgricultureDataModel.fromJson(agriBusiness);
            } else {
              print('Error: "agricultureBusiness" data is missing in list');
              // throw Exception(
              //     'Error: "agricultureBusiness" data is missing in list');
              return null;
            }
          }
        }
        // Handle incomeSource if it's a Map
        else if (incomeSource is Map) {
          final agriData = incomeSource['agricultureBusiness'];
          if (agriData != null) {
            return AgricultureDataModel.fromJson(agriData);
          }
        }

        // If no valid agriculture business data is found
        // throw Exception(
        //     'Error: "agricultureBusiness" data not found in response');
        print('Error: "agricultureBusiness" data not found in response');
      } else {
        // throw Exception(
        //     'Failed to fetch data. Status code: ${response.statusCode}');
        print('Failed to fetch data. Status code: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      print('Error occurred: $e');
      throw Exception('Error occurred: $e');
    }
    return null;
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
