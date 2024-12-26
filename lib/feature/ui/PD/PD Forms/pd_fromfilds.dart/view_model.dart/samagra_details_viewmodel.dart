import 'package:dio/dio.dart';
import 'package:finexe/feature/base/api/api.dart';
import 'package:finexe/feature/base/api/dio.dart';
import 'package:finexe/feature/base/service/session_service.dart';
import 'package:finexe/feature/base/utils/namespase/app_colors.dart';
import 'package:finexe/feature/base/utils/namespase/app_style.dart';
import 'package:finexe/feature/base/utils/widget/custom_snackbar.dart';
import 'package:finexe/feature/ui/Collection/Collection%20cases/model/visit_update_upload_image_responce_model.dart';
// import 'package:finexe/feature/ui/PD/view/PD%20Form/pd_fromfilds.dart/model/Submit%20Data%20Models/samagra_details_model.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../model/Submit Data Models/samagra_details_model.dart';

// final imageProvider =
//     StateNotifierProvider<ImageNotifier, ApplicantState>((ref) {
//   final dio = ref.read(dioProvider);

//   return ImageNotifier(dio);
// });

// class ImageNotifier extends StateNotifier<ApplicantState> {
//   final Dio _dio;

//   ImageNotifier(this._dio) : super(ApplicantState.initial());

//   Future<XFile?> pickFirstImage() async {
//     final ImagePicker picker = ImagePicker();
//     final XFile? image = await picker.pickImage(source: ImageSource.camera);

//     if (image != null) {
//       state = state.copyWith(isLoading: false);
//     }

//     return image;
//   }

//   Future<XFile?> pickSecondImage() async {
//     final ImagePicker picker = ImagePicker();
//     final XFile? image = await picker.pickImage(source: ImageSource.camera);

//     if (image != null) {
//       state = state.copyWith(isLoading: false);
//     }

//     return image;
//   }

//   void removeImage(int index) {
//     state = state.copyWith(isLoading: false);
//   }

//   Future<String> uploadImage(String image) async {
//     String? token =
//         "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJJZCI6IjY3MGY1NjFhZTc2NjMwMjQ0ZGVhNDU1YyIsInJvbGVOYW1lIjoiaW50ZXJuYWxWZW5kb3JBbmRjcmVkaXRQZCIsImlhdCI6MTczMDk1NzUzOH0.p_57wid1GuLPusS29IwyAfQnKR5qfpdDc4CoU2la-qY";

//     if (token == null) {
//       throw Exception('Token is missing. Please log in again.');
//     }

//     state = state.copyWith(isLoading: true);

//     var formData = FormData.fromMap({
//       'image':
//           await MultipartFile.fromFile(image, filename: image.split('/').last),
//     });

//     try {
//       final response = await _dio.post(
//         Api.uploadImageCollection,
//         data: formData,
//         options: Options(headers: {"token": token}),
//       );

//       if (response.statusCode == 200) {
//         VisitUpdateUploadImageResponseModel imageResponseModel =
//             VisitUpdateUploadImageResponseModel.fromJson(response.data);

//         state = state.copyWith(isLoading: false);
//         return imageResponseModel.items.image;
//       } else {
//         throw Exception(
//             'Failed to upload image. Status code: ${response.statusCode}');
//       }
//     } catch (e) {
//       state = state.copyWith(isLoading: false);
//       throw Exception(
//           'An error occurred while uploading the image. Please try again.');
//     }
//   }
// }

class PDSubmitSamagraDetailsModel extends StateNotifier<ApplicantState> {
  final Dio _dio;

  PDSubmitSamagraDetailsModel(this._dio) : super(ApplicantState.initial());

  Future<void> submitSamagraDetails({
    required String customerId,
    required String pdType,
    required SamagraDetail samagraDetail,
    required List<FamilyMember> familyMembers,
    required String sssmPhoto,
    required String gasdiaryPhoto,
    //required List<String> imagePaths,

    required BuildContext context,
  }) async {
    print('familyMembers: ${familyMembers.length}');
    String? token = await SessionService.getToken();

    // String? token =
    //     "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJJZCI6IjY3MGY1NjFhZTc2NjMwMjQ0ZGVhNDU1YyIsInJvbGVOYW1lIjoiaW50ZXJuYWxWZW5kb3JBbmRjcmVkaXRQZCIsImlhdCI6MTczMDk1NzUzOH0.p_57wid1GuLPusS29IwyAfQnKR5qfpdDc4CoU2la-qY";
    final payload = {
      'samagraDetail': samagraDetail.toJson(),
      'gasDiaryPhoto': gasdiaryPhoto,
      'SSSMPhoto': sssmPhoto,
      'customerId': customerId,
      'pdType': pdType,
      'familyMember': familyMembers
          .map((member) => {
                'name': member.name,
                'age': member.age,
                'relation': member.relation,
              })
          .toList(),
    };
    try {
      // Set loading to true
      state = state.copyWith(isLoading: true);

      final response = await _dio.post(
        Api.updatePdReport,
        data: payload,
        options: Options(headers: {"token": token}),
      );
      print('response of samagra details before success: ${response.data}');
      if (response.statusCode == 200) {
        // Handle success
        if (response.data['subCode'] == 200) {
          print(
              'samagra details form submitted succesfully:: ${response.data}');
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              backgroundColor: AppColors.green,
              content: Text(
                'Form submitted successfully!',
                style: AppStyles.whiteText16,
              ),
            ),
          );
        }
      } else {
        // Handle failure
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: AppColors.red,
            content: Text(
              'Failed to submit Samagra Details',
              style: AppStyles.whiteText16,
            ),
          ),
        );
      }
    } catch (e) {
      // Handle error
      if (kDebugMode) {
        print('POST Samagra Details Error: $e');
      }
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: AppColors.red,
          content: Text(
            'Failed to submit Samagra Details',
            style: AppStyles.whiteText16,
          ),
        ),
      );
    } finally {
      // Set loading to false
      state = state.copyWith(isLoading: false);
    }
  }
}

final samagraSubmitProvider =
    StateNotifierProvider<PDSubmitSamagraDetailsModel, ApplicantState>(
  (ref) {
    final dio = ref.read(dioProvider);
    return PDSubmitSamagraDetailsModel(dio);
  },
);

class ApplicantState {
  final bool? isLoading;
  final bool? imageLoading;
  final XFile? image;
  final String? selectedDate;

  ApplicantState(
      {this.isLoading, this.selectedDate, this.imageLoading, this.image});

  ApplicantState.initial()
      : isLoading = false,
        imageLoading = false,
        image = null,
        selectedDate = null;

  ApplicantState copyWith({
    bool? isLoading,
    bool? imageloading,
    String? selectedDate,
    XFile? image,
  }) {
    return ApplicantState(
      imageLoading: imageloading ?? this.imageLoading,
      isLoading: isLoading ?? this.isLoading,
      selectedDate: selectedDate ?? this.selectedDate,
      image: image ?? this.image,
    );
  }
}

final samagraDetailDetailsProvider =
    FutureProvider.autoDispose.family<SamagraDetailsItems,String>((ref,custId) async {
  final viewModel = SamagraFormDetailsProvider();
  return await viewModel.fetchSamagraFormDetails(custId);
});

class SamagraFormDetailsProvider {
  final Dio _dio = Dio();

  Future<SamagraDetailsItems> fetchSamagraFormDetails(String custId) async {
    String? token = await SessionService.getToken();

    // String? token =
    //     "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJJZCI6IjY3MGY1NjFhZTc2NjMwMjQ0ZGVhNDU1YyIsInJvbGVOYW1lIjoiaW50ZXJuYWxWZW5kb3JBbmRjcmVkaXRQZCIsImlhdCI6MTczMDk1NzUzOH0.p_57wid1GuLPusS29IwyAfQnKR5qfpdDc4CoU2la-qY"; // Replace with a secure way of managing tokens
    print('url: ${Api.getpdformdata}$custId');

    try {
      final response = await _dio.get(
        '${Api.getpdformdata}$custId',
        options: Options(headers: {"token": token}),
      );

      if (response.statusCode == 200 && response.data != null) {
        final Map<String, dynamic> responseData = response.data;

        // Parse the response into the GetApplicantDetailsModel
        final details = SamagraDetailsModel.fromJson(responseData);
        print('Samagra details:: ${details}');
        if (details.items != null) {
          return details.items!;
        } else {
          throw Exception(
              "SamagraDetailsModel details not found in the response");
        }
      } else {
        throw Exception(
            "Failed to load SamagraDetailsModel data: ${response.statusCode}");
      }
    } catch (e) {
      print("Error fetching SamagraDetailsModel details: $e");
      throw Exception("Error fetching SamagraDetailsModel data: $e");
    }
  }
}

class FirstImageNotifier extends StateNotifier<ApplicantState> {
  final Dio _dio;

  FirstImageNotifier(this._dio)
      : super(ApplicantState(image: null, isLoading: false));

  Future<XFile?> pickFirstImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.camera);

    if (image != null) {
      state = state.copyWith(image: image);
      return image;
    }
    return null;
  }

  void removeFirstImage() {
    state = state.copyWith(image: null);
  }

  Future<String> uploadImage(String image) async {
    String? token = await SessionService.getToken();

    // String? token =
    //     "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJJZCI6IjY3MGY1NjFhZTc2NjMwMjQ0ZGVhNDU1YyIsInJvbGVOYW1lIjoiaW50ZXJuYWxWZW5kb3JBbmRjcmVkaXRQZCIsImlhdCI6MTczMDk1NzUzOH0.p_57wid1GuLPusS29IwyAfQnKR5qfpdDc4CoU2la-qY";

    if (token == null) {
      throw Exception('Token is missing. Please log in again.');
    }

    state = state.copyWith(isLoading: true); // Set loading to true

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

        state = state.copyWith(isLoading: false); // Set loading to false
        return imageResponseModel.items.image;
      } else {
        state = state.copyWith(isLoading: false); // Set loading to false
        throw Exception(
            'Failed to upload image. Status code: ${response.statusCode}');
      }
    } catch (e) {
      state = state.copyWith(isLoading: false); // Set loading to false
      throw Exception(
          'An error occurred while uploading the image. Please try again.');
    }
  }
}

class SecondImageNotifier extends StateNotifier<XFile?> {
  final Dio _dio;

  SecondImageNotifier(this._dio) : super(null);

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

  Future<String> uploadImage(String image) async {
    String? token =
        "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJJZCI6IjY3MGY1NjFhZTc2NjMwMjQ0ZGVhNDU1YyIsInJvbGVOYW1lIjoiaW50ZXJuYWxWZW5kb3JBbmRjcmVkaXRQZCIsImlhdCI6MTczMDk1NzUzOH0.p_57wid1GuLPusS29IwyAfQnKR5qfpdDc4CoU2la-qY";

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
      throw Exception(
          'An error occurred while uploading the image. Please try again.');
    }
  }
}

final sssMidimageProvider =
    StateNotifierProvider<FirstImageNotifier, ApplicantState>((ref) {
  final dio = Dio(); // Replace with your Dio instance configuration
  return FirstImageNotifier(dio);
});

final gasDiaryPhotoProvider =
    StateNotifierProvider<SecondImageNotifier, XFile?>((ref) {
  final dio = ref.read(dioProvider);
  return SecondImageNotifier(dio);
});

// final uploadImageProvider =
//     StateNotifierProvider<ImageUploadNotifier, ApplicantState>((ref) {
//   final dio = ref.read(dioProvider);
//   return ImageUploadNotifier(dio);
// });

// class ImageUploadNotifier extends StateNotifier<ApplicantState> {
//   final Dio _dio;

//   ImageUploadNotifier(this._dio) : super(ApplicantState.initial());

//   Future<String> uploadImage(String image, BuildContext context) async {
//     String? token =
//         "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJJZCI6IjY3MGY1NjFhZTc2NjMwMjQ0ZGVhNDU1YyIsInJvbGVOYW1lIjoiaW50ZXJuYWxWZW5kb3JBbmRjcmVkaXRQZCIsImlhdCI6MTczMDk1NzUzOH0.p_57wid1GuLPusS29IwyAfQnKR5qfpdDc4CoU2la-qY";

//     if (token == null) {
//       throw Exception('Token is missing. Please log in again.');
//     }

//     state = state.copyWith(isLoading: true);

//     var formData = FormData.fromMap({
//       'image':
//           await MultipartFile.fromFile(image, filename: image.split('/').last),
//     });

//     try {
//       final response = await _dio.post(
//         Api.uploadImageCollection,
//         data: formData,
//         options: Options(headers: {"token": token}),
//       );

//       if (response.statusCode == 200) {
//         VisitUpdateUploadImageResponseModel imageResponseModel =
//             VisitUpdateUploadImageResponseModel.fromJson(response.data);

//         state = state.copyWith(isLoading: false);
//         showCustomSnackBar(
//             context, 'Image uploaded Succesfully', AppColors.green);
//         return imageResponseModel.items.image;
//       } else {
//         print('error');
//         showCustomSnackBar(context, 'Failed to upload image.', AppColors.red);
//         throw Exception(
//             'Failed to upload image. Status code: ${response.statusCode}');
//       }
//     } catch (e) {
//       state = state.copyWith(isLoading: false);
//       showCustomSnackBar(
//           context, 'Failed to upload image. Please try again.', AppColors.red);
//       throw Exception(
//           'An error occurred while uploading the image. Please try again.');
//     }
//   }
// }
