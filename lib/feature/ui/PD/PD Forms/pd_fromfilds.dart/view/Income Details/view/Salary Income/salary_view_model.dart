import 'dart:io';
import 'package:dio/dio.dart';
import 'package:finexe/feature/base/api/api.dart';
import 'package:finexe/feature/base/api/dio.dart';
import 'package:finexe/feature/base/utils/general/pref_utils.dart';
import 'package:finexe/feature/base/utils/widget/custom_snackbar.dart';
import 'package:finexe/feature/ui/Collection/Collection%20cases/model/visit_update_upload_image_responce_model.dart';
import 'package:finexe/feature/ui/PD/PD%20Forms/pd_fromfilds.dart/view/Income%20Details/view/Salary%20Income/salary_model/salary_income_model.dart';
// import 'package:finexe/feature/ui/PD/view/PD%20Form/pd_fromfilds.dart/view/Income%20Details/view/Salary%20Income/salary_model/salary_income_model.dart';
// import 'package:finexe/feature/ui/PD/view/PD%20Form/pd_fromfilds.dart/pd_update_data/view/Income%20Details/view/Salary%20Income/salary_model/salary_income_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

// import '../../../../../../../../../../base/api/api.dart';
// import '../../../../../../../../../../base/service/session_service.dart';
// import '../../../../../../../../../../base/utils/widget/custom_snackbar.dart';

// ---------- Image Upload Notifier (Optional) ---------
class SalaryImageUploadNotifier extends StateNotifier<List<File>> {
  SalaryImageUploadNotifier() : super([]);

  void addImage(File image) {
    state = [...state, image];
  }

  void removeImage(int index) {
    state = List.from(state)..removeAt(index);
  }

  Future<void> pickImage() async {
    final picker = ImagePicker();
    final XFile? pickedImage =
        await picker.pickImage(source: ImageSource.gallery);

    if (pickedImage != null) {
      addImage(File(pickedImage.path));
    }
  }
}

final salaryImageUploadProvider =
    StateNotifierProvider<SalaryImageUploadNotifier, List<File>>(
  (ref) => SalaryImageUploadNotifier(),
);

// ---------- Submit API ViewModel -----------
final salaryDetailsFormViewModelProvider =
    Provider.autoDispose((ref) => SalaryDetailsFormViewModel());

class SalaryDetailsFormViewModel {
  final Dio _dio = Dio();

  Future<void> submitSalaryDetailsForm(
    SalaryDetailsModel formData,
    BuildContext context,
  ) async {
    try {
      // Create the payload for API request
      final payload = {
        'incomeSource': [formData.toJson()],
        'customerId': '66f53ffbd7011eb65160f292',
        'pdType': 'creditPd',
      };
      final token = speciality.getToken();

      final response = await _dio.post(
        Api.updatePdReport, // Replace with your API endpoint
        data: payload,
        options: Options(headers: {"token": token}),
      );

      if (response.statusCode == 200) {
        showCustomSnackBar(context, 'Salary Details Submitted', Colors.green);
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
final salaryDetailsProvider = FutureProvider.autoDispose.family<SalaryDetailsData,String>((ref,custId) async {
  final apiService = SalaryApiService();
  return apiService.fetchSalaryDetails(custId);
});

class SalaryApiService {
  final Dio _dio = Dio();

  Future<SalaryDetailsData> fetchSalaryDetails(String custId) async {
    final token = speciality.getToken();

    try {
      // Make the API request
      final response = await _dio.get(
        '${Api.getpdformdata}$custId',
        options: Options(headers: {"token": token}),
      );

      print('Full salary API Response: ${response.data}');

      if (response.statusCode == 200) {
        final items = response.data['items'] as Map<String, dynamic>? ?? {};
        final incomeSource = items['incomeSource'] as dynamic;

        if (incomeSource == null) {
          throw Exception('Error: "incomeSource" is null');
        }

        if (incomeSource is List) {
          final salarySource = incomeSource.firstWhere(
            (source) => source['incomeSourceType'] == 'salaryIncome',
            orElse: () => null,
          );

          if (salarySource != null) {
            final salaryData = salarySource['salaryIncome'];
            return SalaryDetailsData.fromJson(salaryData);
          }
        } else if (incomeSource is Map) {
          final salaryData = incomeSource['salaryIncome'];
          if (salaryData != null) {
            return SalaryDetailsData.fromJson(salaryData);
          }
        }

        throw Exception('Error: "salaryIncome" data not found in response');
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

final threemonthsimageUploadProvider =
    StateNotifierProvider<AnimalImageUploadNotifier, List<File>>(
  // (ref) => ImageUploadNotifier(),
  (ref) {
    final dio = ref.read(dioProvider);

    return AnimalImageUploadNotifier(dio);
  },
);
