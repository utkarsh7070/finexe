import 'dart:io';

import 'package:dio/dio.dart';
import 'package:finexe/feature/base/api/api.dart';
import 'package:finexe/feature/base/api/dio.dart';
import 'package:finexe/feature/base/service/session_service.dart';
import 'package:finexe/feature/ui/Collection/Collection%20cases/model/visit_update_upload_image_responce_model.dart';
// import 'package:finexe/feature/ui/PD/view/PD%20Form/pd_fromfilds.dart/model/Submit%20Data%20Models/agri_work_images_model.dart';
// import 'package:finexe/feature/ui/PD/view/PD%20Form/pd_fromfilds.dart/model/Submit%20Data%20Models/bank_detail_form_model.dart';
// import 'package:finexe/feature/ui/PD/view/PD%20Form/pd_fromfilds.dart/model/Submit%20Data%20Models/gauranter_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

import '../model/Submit Data Models/agri_work_images_model.dart';

class PDAgriAndWorkImagePRovdier extends StateNotifier<AppState> {
  final Dio dio;

  PDAgriAndWorkImagePRovdier(this.dio) : super(AppState());

  Future<bool> submitpdBankDetailsForm({
    required String customerId,
    required String pdType,
    String? eastBoundaryImage,
    String? westBoundaryImage,
    String? northBoundaryImage,
    String? southBoundaryImage,
    String? landmarkImageUrl,
    String? latlongImageUrl,
    String? videourl,
    List<String>? workPhoto,
    List<String>? houseInsidephotos,
  }) async {
    state = state.copyWith(isLoading: true);

    // Add customerId and pdType to the payload
    final payload = {
      'customerId': customerId,
      'pdType': pdType,
      "fourBoundaryPhotos": [
        eastBoundaryImage,
        westBoundaryImage,
        northBoundaryImage,
        southBoundaryImage
      ],
      "landmarkPhoto": landmarkImageUrl,
      "latLongPhoto": latlongImageUrl,
      "videoUpload": videourl,
      "workPhotos": workPhoto?.toList(), //houseInsidePhoto
    };

    String? token = await SessionService.getToken();
    // String? token =
    //     "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJJZCI6IjY2OWY5MDVjNmEzMGY4OTExMzQwN2EzZSIsInJvbGVOYW1lIjpbImNyZWRpdFBkIl0sImlhdCI6MTczMzU3ODg1MH0.eEhMeH02cPzPw3gyNttXMrkC1l2yVZALYKdYGvXj0oA";
    //vendor // "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJJZCI6IjY3MGY1NjFhZTc2NjMwMjQ0ZGVhNDU1YyIsInJvbGVOYW1lIjoiaW50ZXJuYWxWZW5kb3JBbmRjcmVkaXRQZCIsImlhdCI6MTczMDk1NzUzOH0.p_57wid1GuLPusS29IwyAfQnKR5qfpdDc4CoU2la-qY";
    try {
      final response = await dio.post(Api.updatePdReport,
          data: payload, options: Options(headers: {"token": token}));
      print(response.data);
      print('Payload: ${payload}');
      if (response.statusCode == 200) {
        // BankDetail bankDetailsRespone = BankDetail.fromJson(response.data);
        print('work agri images form submitted: $response');
        print('images-- ${response.data}');
        state = state.copyWith(isLoading: false);
        return true;
      } else {
        state = state.copyWith(isLoading: false);
        print('Error while submitting applicant form');
        return false;
      }
    } catch (e) {
      state = state.copyWith(isLoading: false);
      print('Exception in work agriculature images form: $e');
      // throw Exception(e);
      return false;
    }
  }
}

final pdsubmitWorkAndAgriImages =
    StateNotifierProvider<PDAgriAndWorkImagePRovdier, AppState>((ref) {
  final dio = ref.read(dioProvider);

  return PDAgriAndWorkImagePRovdier(dio);
});

class AppState {
  final bool? isLoading;

  final String? selectedDate;

  AppState({
    this.isLoading,
    this.selectedDate,
  });

  AppState.initial()
      : isLoading = false,
        selectedDate = null;

  AppState copyWith({
    bool? isLoading,
    String? selectedDate,
  }) {
    return AppState(
      isLoading: isLoading ?? this.isLoading,
      selectedDate: selectedDate ?? this.selectedDate,
    );
  }
}

final getWorkAndImagesProvider =
    FutureProvider.autoDispose.family<AgriWorkItems,String>((ref,custoemrId) async {
  final viewModel = AgriANdWorkFormDetailProvider();
  return await viewModel.fetchDetails(custoemrId);
});

class AgriANdWorkFormDetailProvider {
  final Dio _dio = Dio();

  Future<AgriWorkItems> fetchDetails(String customerId) async {
    String? token = await SessionService.getToken();

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
        final details = AgriWorkItems.fromJson(responseData['items']);
        // print('object')
        if (details != null) {
          print('AgriWorkItems:: ${details.latLongPhoto}');
          return details;
        } else {
          throw Exception("AgriWorkItems details not found in the response");
        }
      } else {
        throw Exception(
            "Failed to load AgriWorkItems data: ${response.statusCode}");
      }
    } catch (e) {
      print("Error fetching AgriWorkItems details: $e");
      throw Exception("Error fetching AgriWorkItems data: $e");
    }
  }
}

class AgriImageUploadNotifier extends StateNotifier<List<File>> {
  final Dio _dio;

  AgriImageUploadNotifier(this._dio) : super([]);

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

final workagriimageUploadProvider =
    StateNotifierProvider<AgriImageUploadNotifier, List<File>>(
        // (ref) => AgriImageUploadNotifier(),
        (ref) {
  final dio = ref.read(dioProvider);

  return AgriImageUploadNotifier(dio);
});
