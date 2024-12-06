import 'package:dio/dio.dart';
import 'package:finexe/feature/base/api/api.dart';
import 'package:finexe/feature/base/api/dio.dart';
import 'package:finexe/feature/ui/Collection/Collection%20cases/model/visit_update_upload_image_responce_model.dart';
import 'package:finexe/feature/ui/PD/view/PD%20Form/pd_fromfilds.dart/model/Submit%20Data%20Models/property_form_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

class PDSubmitPropertyForm extends StateNotifier<ApplicationState> {
  final Dio dio;

  PDSubmitPropertyForm(this.dio) : super(ApplicationState());

  Future<bool> submitpdpropertyForm({
    required String customerId,
    required String pdType,
    // required List<ReferenceDetails> refrenceFormList,
    required Property propertty,
  }) async {
    state = state.copyWith(isLoading: true);

    // Add customerId and pdType to the payload
    final payload = {
      'property': propertty.toJson(),
      'customerId': customerId,
      'pdType': pdType,
    };

    //  String? token = await SessionService.getToken();
    String? token =
        "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJJZCI6IjY3MGY1NjFhZTc2NjMwMjQ0ZGVhNDU1YyIsInJvbGVOYW1lIjoiaW50ZXJuYWxWZW5kb3JBbmRjcmVkaXRQZCIsImlhdCI6MTczMDk1NzUzOH0.p_57wid1GuLPusS29IwyAfQnKR5qfpdDc4CoU2la-qY";
    try {
      final response = await dio.post(Api.updatePdReport,
          data: payload, options: Options(headers: {"token": token}));
      print(token);
      print(payload);
      print(response.data);
      print('Payload: ${payload}');

      if (response.statusCode == 200) {
        print('property form submitted: ${response.data}');

        state = state.copyWith(isLoading: false);
        return true;
      } else {
        state = state.copyWith(isLoading: false);
        print('Error while submitting property form');
        return false;
      }
    } catch (e) {
      state = state.copyWith(isLoading: false);
      print('Exception: $e');
      throw Exception(e);
    }
  }
}

final pdsubmitpropertyFormProvider =
    StateNotifierProvider<PDSubmitPropertyForm, ApplicationState>((ref) {
  final dio = ref.read(dioProvider);
  // final checkStatus = ref.watch(checkBoxTermsConditionApplicant);

  return PDSubmitPropertyForm(dio);
});

class ApplicationState {
  final bool? isLoading;
  final String? title;
  XFile? file;
  String? url;

  ApplicationState({this.isLoading, this.title, this.file, this.url});

  ApplicationState.initial()
      : isLoading = false,
        title = null,
        file = null,
        url = null;

  ApplicationState copyWith(
      {bool? isLoading, String? title, String? url, XFile? file}) {
    return ApplicationState(
        isLoading: isLoading ?? this.isLoading,
        title: title ?? this.title,
        file: file ?? this.file,
        url: url ?? this.url);
  }
}

final imageCollectionProvider =
    StateNotifierProvider<ImageCollectionNotifier, List<ApplicationState>>(
        (ref) {
  final dio = Dio(); // Replace with your Dio instance configuration
  return ImageCollectionNotifier(dio);
});

class ImageCollectionNotifier extends StateNotifier<List<ApplicationState>> {
  final Dio _dio;

  ImageCollectionNotifier(this._dio)
      : super([
          ApplicationState(title: 'Selfie With Customer'),
          ApplicationState(title: 'Photo with latlong'),
          ApplicationState(title: 'Front Image'),
          ApplicationState(title: 'Main Road Image'),
        ]);

  Future<void> pickImage(String title) async {
    final picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.camera);

    if (image != null) {
      state = [
        for (final item in state)
          if (item.title == title)
            ApplicationState(title: item.title, file: image, url: item.url)
          else
            item,
      ];
    }
  }

  Future<void> removeImage(String title) async {
    state = [
      for (final item in state)
        if (item.title == title)
          ApplicationState(title: item.title, file: null, url: null)
        else
          item,
    ];
  }

  Future<void> uploadImage(String title) async {
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

        state = [
          for (final item in state)
            if (item.title == title)
              ApplicationState(
                title: item.title,
                file: item.file,
                url: imageResponseModel.items.image,
              )
            else
              item,
        ];
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

final photoWithLatLongProvider =
    StateNotifierProvider<PhotoWithLatLong, XFile?>((ref) {
  final dio = Dio(); // Replace with your Dio instance configuration
  return PhotoWithLatLong(dio);
});

class PhotoWithLatLong extends StateNotifier<XFile?> {
  final Dio _dio;

  PhotoWithLatLong(this._dio) : super(null);

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

final frontImageProvider = StateNotifierProvider<FrontImage, XFile?>((ref) {
  final dio = Dio(); // Replace with your Dio instance configuration
  return FrontImage(dio);
});

class FrontImage extends StateNotifier<XFile?> {
  final Dio _dio;

  FrontImage(this._dio) : super(null);

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
