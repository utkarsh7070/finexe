import 'dart:io';

import 'package:dio/dio.dart';
import 'package:finexe/feature/base/api/api.dart';
import 'package:finexe/feature/base/api/dio.dart';
import 'package:finexe/feature/base/service/session_service.dart';
import 'package:finexe/feature/base/utils/general/pref_utils.dart';
import 'package:finexe/feature/ui/Collection/Collection%20cases/model/visit_update_upload_image_responce_model.dart';
// import 'package:finexe/feature/ui/PD/view/PD%20Form/pd_fromfilds.dart/model/Submit%20Data%20Models/property_form_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

import '../model/Submit Data Models/property_form_model.dart';

//make all url here
class ApplicationState {
  final bool? isLoading;
  final String? title;
  XFile? file;
  String? url;
  String? selfieImageUrl;
  String? phototImageUrl;
  String? frontIamgeUrl;
  String? mainRoadUrl;
  String? leftSideUrl;
  String? rightSideImageUrl;
  String? approachRoadImage;
  String? interiorImage;
  List<String>? otherPhotos; // Add this for storing other photo URLs

  ApplicationState({
    this.isLoading,
    this.title,
    this.file,
    this.url,
    this.selfieImageUrl,
    this.phototImageUrl,
    this.frontIamgeUrl,
    this.mainRoadUrl,
    this.leftSideUrl,
    this.rightSideImageUrl,
    this.approachRoadImage,
    this.interiorImage,
    this.otherPhotos,
  });

  ApplicationState.initial()
      : isLoading = false,
        title = null,
        file = null,
        url = null,
        selfieImageUrl = null,
        phototImageUrl = null,
        frontIamgeUrl = null,
        mainRoadUrl = null,
        leftSideUrl = null,
        rightSideImageUrl = null,
        approachRoadImage = null,
        interiorImage = null,
        otherPhotos = [];

  ApplicationState copyWith({
    bool? isLoading,
    String? title,
    XFile? file,
    String? url,
    String? selfieImageUrl,
    String? phototImageUrl,
    String? frontIamgeUrl,
    String? mainRoadUrl,
    String? leftSideUrl,
    String? rightSideImageUrl,
    String? approachRoadImage,
    String? interiorImage,
    List<String>? otherPhotos,
  }) {
    return ApplicationState(
      isLoading: isLoading ?? this.isLoading,
      title: title ?? this.title,
      file: file ?? this.file,
      url: url ?? this.url,
      selfieImageUrl: selfieImageUrl ?? this.selfieImageUrl,
      phototImageUrl: phototImageUrl ?? this.phototImageUrl,
      frontIamgeUrl: frontIamgeUrl ?? this.frontIamgeUrl,
      mainRoadUrl: mainRoadUrl ?? this.mainRoadUrl,
      leftSideUrl: leftSideUrl ?? this.leftSideUrl,
      rightSideImageUrl: rightSideImageUrl ?? this.rightSideImageUrl,
      approachRoadImage: approachRoadImage ?? this.approachRoadImage,
      interiorImage: interiorImage ?? this.interiorImage,
      otherPhotos: otherPhotos ?? this.otherPhotos,
    );
  }
}

class PDSubmitPropertyForm extends StateNotifier<ApplicationState> {
  final Dio dio;

  PDSubmitPropertyForm(this.dio) : super(ApplicationState());

  Future<bool> submitpdpropertyForm({
    required String customerId,
    required String pdType,
    // required List<ReferenceDetails> refrenceFormList,
    required Property properttyItems,
    required String approachRoadImage,
    required String selfiWCust,
    required String front,
    required String photoWLat,
    required String mainRoadImage,
    required String interiorRoadImage,
    required String leftImage,
    required String rightImage,
    required List<String>? otherPhotos,
    List<String>? houseInsidephotos,
  }) async {
    state = state.copyWith(isLoading: true);

    // Add customerId and pdType to the payload
    final payload = {
      'customerId': customerId,
      'pdType': pdType,
      'property': properttyItems.toJson(),
      'approachRoad': approachRoadImage,
      'front': front,
      'mainRoad': mainRoadImage,
      'photoWithLatLong': photoWLat,
      'selfiWithCustomer': selfiWCust,
      'interiorRoad': interiorRoadImage,
      'leftSide': leftImage,
      'rightSide': rightImage,
      'propertyOtherPhotos': otherPhotos?.toList(),
      "houseInsidePhoto": houseInsidephotos?.toList() //houseInsidePhoto
    };

    String? token = speciality.getToken();
    // String? token =
    //     "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJJZCI6IjY3MGY1NjFhZTc2NjMwMjQ0ZGVhNDU1YyIsInJvbGVOYW1lIjoiaW50ZXJuYWxWZW5kb3JBbmRjcmVkaXRQZCIsImlhdCI6MTczMDk1NzUzOH0.p_57wid1GuLPusS29IwyAfQnKR5qfpdDc4CoU2la-qY";
    try {
      final response = await dio.post(Api.updatePdReport,
          data: payload, options: Options(headers: {"token": token}));
      print(token);
      print(payload);
      print(response.data);
      print('Payload: ${payload}');

      if (response.statusCode == 200) {
        print('property_colateralform submitted: ${response.data}');

        state = state.copyWith(isLoading: false);
        return true;
      } else {
        state = state.copyWith(isLoading: false);
        print('Error while submitting property form');
        return false;
      }
    } catch (e) {
      state = state.copyWith(isLoading: false);
      print('Exception in propert-collateral form: $e');
      // throw Exception(e);
      return false;
    }
  }
}

final pdsubmitpropertyFormProvider =
    StateNotifierProvider<PDSubmitPropertyForm, ApplicationState>((ref) {
  final dio = ref.read(dioProvider);
  // final checkStatus = ref.watch(checkBoxTermsConditionApplicant);

  return PDSubmitPropertyForm(dio);
});
//***********************fetching-data-methode*************************************** */

final propertyFormDitailsProvider =
    FutureProvider.autoDispose.family<PropertyItems,String>((ref,cusId) async {
  final viewModel = PropertyFormDetails();
  return await viewModel.fetchPropertyformDetails(cusId);
});

class PropertyFormDetails extends StateNotifier<List<ApplicationState>> {
  PropertyFormDetails()
      : super([
          ApplicationState(title: 'Selfie With Customer'),
          ApplicationState(title: 'Photo with latlong'),
          ApplicationState(title: 'Front Image'),
          ApplicationState(title: 'Main Road Image'),
          ApplicationState(title: 'Left Side'),
          ApplicationState(title: 'Right Side'),
          ApplicationState(title: 'Approach Road'),
          ApplicationState(title: 'Interior Road'),
        ]);

  final Dio _dio = Dio();

  Future<PropertyItems> fetchPropertyformDetails(String custId) async {
    String? token = speciality.getToken();

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
        final propertyDetails = PropertyItems.fromJson(responseData['items']);
        print('Response Data???: $responseData');

        if (propertyDetails != null) {
          print('selfiWithCustomer:: ${propertyDetails.selfiWithCustomer}');

          state = [
            ApplicationState(
                title: 'Selfie With Customer',
                url: propertyDetails.selfiWithCustomer),
            ApplicationState(
                title: 'Photo with latlong',
                url: propertyDetails.photoWithLatLong),
            ApplicationState(title: 'Front Image', url: propertyDetails.front),
            ApplicationState(
                title: 'Main Road Image', url: propertyDetails.mainRoad),
            ApplicationState(title: 'Left Side', url: propertyDetails.leftSide),
            ApplicationState(
                title: 'Right Side', url: propertyDetails.rightSide),
            ApplicationState(
                title: 'Approach Road', url: propertyDetails.approachRoad),
            ApplicationState(
                title: 'Interior Road', url: propertyDetails.interiorRoad),
          ];

          return propertyDetails;
        } else {
          throw Exception("propertyDetails not found in the response");
        }
      } else {
        throw Exception(
            "Failed to load propertyDetails: ${response.statusCode}");
      }
    } catch (e) {
      print("Error fetching propertyDetails: $e");
      throw Exception("Error fetching propertyDetails data: $e");
    }
  }
}

//*********************************dynamiclisting-images************************ */

class PropertDynaicListingImgagesNotifier extends StateNotifier<List<File>> {
  final Dio _dio;

  PropertDynaicListingImgagesNotifier(this._dio) : super([]);

  // Pick an image from the gallery and add it to the state
  Future<String> pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? pickedImage = await picker.pickImage(
      source: ImageSource.camera,
      preferredCameraDevice: CameraDevice.rear,
    );

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

final otherPhototsimageUploadProvider =
    StateNotifierProvider<PropertDynaicListingImgagesNotifier, List<File>>(
        // (ref) => AgriImageUploadNotifier(),
        (ref) {
  final dio = ref.read(dioProvider);

  return PropertDynaicListingImgagesNotifier(dio);
});

//**************************Image-Collection-Provider*************************** */
// final imageCollectionProvider =
//     StateNotifierProvider<ImageCollectionNotifier, List<ApplicationState>>(
//         (ref) {
//   final dio = Dio(); // Replace with your Dio instance configuration
//   return ImageCollectionNotifier(dio);
// });

class ImageCollectionNotifier extends StateNotifier<List<ApplicationState>> {
  final Dio _dio;

  ImageCollectionNotifier(this._dio)
      : super([
          ApplicationState(title: 'Selfie With Customer'),
          ApplicationState(title: 'Photo with latlong'),
          ApplicationState(title: 'Front Image'),
          ApplicationState(title: 'Main Road Image'),
          ApplicationState(title: 'Left Side'),
          ApplicationState(title: 'Right Side'),
          ApplicationState(title: 'Approach Road'),
          ApplicationState(title: 'Interior Road'),
        ]);
  void updateStateFromFetchedDetails(List<ApplicationState> fetchedDetails) {
    state = fetchedDetails;
  }

  Future<XFile?> pickImage(String title) async {
    final picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.camera);

    if (image != null) {
      state = [
        for (final item in state)
          if (item.title == title)
            ApplicationState(title: item.title, file: image)
          else
            item,
      ];
    }
    return image; // Return the picked image
  }

  Future<void> removeImage(String title) async {
    state = [
      for (final item in state)
        if (item.title == title)
          ApplicationState(
            title: item.title,
            file: null,
          )
        else
          item,
    ];
  }

  Future<String?> uploadImage(String title) async {
    final imageItem = state.firstWhere((item) => item.title == title);

    if (imageItem.file == null) {
      throw Exception('No image selected for $title');
    }

    String? token =
        "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJJZCI6IjY3MGY1NjFhZTc2NjMwMjQ0ZGVhNDU1YyIsInJvbGVOYW1lIjoiaW50ZXJuYWxWZW5kb3JBbmRjcmVkaXRQZCIsImlhdCI6MTczMDk1NzUzOH0.p_57wid1GuLPusS29IwyAfQnKR5qfpdDc4CoU2la-qY";

    var formData = FormData.fromMap({
      'image': await MultipartFile.fromFile(
        imageItem.file!.path,
        filename: imageItem.file!.path.split('/').last,
      ),
    });

    try {
      final response = await _dio.post(
        Api.uploadImageCollection,
        data: formData,
        options: Options(headers: {"token": token}),
      );

      if (response.statusCode == 200) {
        final imageResponseModel =
            VisitUpdateUploadImageResponseModel.fromJson(response.data);

        final imageUrl = imageResponseModel.items.image;

        state = [
          for (final item in state)
            if (item.title == title)
              ApplicationState(
                title: item.title,
                file: item.file,
                url: imageUrl,
              )
            else
              item,
        ];

        return imageUrl; // Return the uploaded URL
      } else {
        throw Exception(
            'Failed to upload image. Status code: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception(
          'An error occurred while uploading the image. Please try again.');
    }
  }
}

//***************************photoWithLatLongProvider************************************************** */

final photoWithLatLongProvider =
    StateNotifierProvider<PhotoWithLatLong, ApplicationState>((ref) {
  final dio = Dio(); // Replace with your Dio instance configuration
  return PhotoWithLatLong(dio);
});

class PhotoWithLatLong extends StateNotifier<ApplicationState> {
  final Dio _dio;

  PhotoWithLatLong(this._dio) : super(ApplicationState.initial());

  Future<void> uploadAndStoreImage(String imagePath) async {
    try {
      // Upload the image and get the URL
      String imageUrl = await uploadImage(imagePath);

      // Update the state with the new image URL in the otherPhotos list
      state = state.copyWith(
        otherPhotos: List.from(state.otherPhotos ?? [])..add(imageUrl),
      );
    } catch (e) {
      throw Exception('Failed to upload and store image: $e');
    }
  }

  Future<String> uploadImage(String imagePath) async {
    String? token =
        "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJJZCI6IjY3MGY1NjFhZTc2NjMwMjQ0ZGVhNDU1YyIsInJvbGVOYW1lIjoiaW50ZXJuYWxWZW5kb3JBbmRjcmVkaXRQZCIsImlhdCI6MTczMDk1NzUzOH0.p_57wid1GuLPusS29IwyAfQnKR5qfpdDc4CoU2la-qY";

    if (token == null) {
      throw Exception('Token is missing. Please log in again.');
    }

    var formData = FormData.fromMap({
      'image': await MultipartFile.fromFile(imagePath,
          filename: imagePath.split('/').last),
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

        return imageResponseModel.items.image;
      } else {
        throw Exception(
            'Failed to upload image. Status code: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('An error occurred while uploading the image: $e');
    }
  }
}

//****************************frontImageProvider*************************************************** */
final frontImageProvider =
    StateNotifierProvider<FrontImageNotifier, List<XFile?>>((ref) {
  final dio = Dio(); // Replace with your Dio instance configuration
  return FrontImageNotifier(dio);
});

class FrontImageNotifier extends StateNotifier<List<XFile?>> {
  final Dio _dio;

  FrontImageNotifier(this._dio) : super([]);

  Future<void> pickSelfie() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.camera);

    if (image != null) {
      state = [...state, image]; // Append the new image to the list
    }
  }

  void removeImage(int index) {
    final updatedState = [...state];
    updatedState.removeAt(index);
    state = updatedState; // Update the state after removing the image
  }

  Future<String> uploadImage(String image) async {
    String token =
        "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJJZCI6IjY3MGY1NjFhZTc2NjMwMjQ0ZGVhNDU1YyIsInJvbGVOYW1lIjoiaW50ZXJuYWxWZW5kb3JBbmRjcmVkaXRQZCIsImlhdCI6MTczMDk1NzUzOH0.p_57wid1GuLPusS29IwyAfQnKR5qfpdDc4CoU2la-qY";

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

        return imageResponseModel.items.image;
      } else {
        throw Exception(
            'Failed to upload image. Status code: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('An error occurred while uploading the image.');
    }
  }
}

//********************leftSideIamgePro******************************** */

final leftSideIamgePro = StateNotifierProvider<LeftSideImage, XFile?>((ref) {
  final dio = Dio(); // Replace with your Dio instance configuration
  return LeftSideImage(dio);
});

class LeftSideImage extends StateNotifier<XFile?> {
  final Dio _dio;

  LeftSideImage(this._dio) : super(null);

  Future<XFile?> pickSelfie() async {
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

final rightSideProvider = StateNotifierProvider<RightSideImage, XFile?>((ref) {
  final dio = Dio(); // Replace with your Dio instance configuration
  return RightSideImage(dio);
});

class RightSideImage extends StateNotifier<XFile?> {
  final Dio _dio;

  RightSideImage(this._dio) : super(null);

  Future<XFile?> pickSelfie() async {
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

final aproachRoadPro = StateNotifierProvider<ApproachRoadImage, XFile?>((ref) {
  final dio = Dio(); // Replace with your Dio instance configuration
  return ApproachRoadImage(dio);
});

class ApproachRoadImage extends StateNotifier<XFile?> {
  final Dio _dio;

  ApproachRoadImage(this._dio) : super(null);

  Future<XFile?> pickSelfie() async {
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
