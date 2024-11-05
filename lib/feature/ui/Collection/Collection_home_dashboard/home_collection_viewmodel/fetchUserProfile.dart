import 'dart:async';
import 'dart:developer';
import 'package:finexe/feature/base/api/dio.dart';
import 'package:finexe/feature/ui/Collection/Collection%20cases/model/update_password_request_model.dart';
import 'package:finexe/feature/ui/Collection/Collection%20cases/model/update_password_responsemodel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:dio/dio.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../base/api/api.dart';
import '../../../../base/api/dio_exception.dart';
import '../../../../base/service/session_service.dart';
import '../../../../base/utils/widget/custom_snackbar.dart';
import '../home_collection_model/user_profile_model.dart';
import '../home_collection_model/user_profile_response_model.dart';

class ApiResponseNotifier extends StateNotifier<AsyncValue<UserProfile>> {
  final Dio dio;

  ApiResponseNotifier(this.dio) : super(const AsyncValue.loading());
  bool _isInitialized = false;
  bool isPunchOutStatus = false;

  String greeting() {
    var hour = DateTime.now().hour;
    if (hour < 12) {
      return 'Good Morning';
    }
    if (hour < 17) {
      return 'Good Afternoon';
    }
    return 'Good Evening';
  }

  Future<void> clickPunchOut(BuildContext context) async {
    await employeePunchOut(context);
  }

  Future<void> fetchDashboardData() async {
    if (_isInitialized) return;
    String? token = await SessionService.getToken();
    try {
      final response = await dio.get(Api.getAllocationDashboard,
          options: Options(headers: {"token": token}));
      print('Response status: ${response.statusCode}');
      print('Response body: ${response.data}');
      if (response.statusCode == 200) {
        final UserprofileResponseModel responseModel =
            UserprofileResponseModel.fromJson(response.data);
        state = AsyncValue.data(UserProfile(
            name: responseModel.items.employeeDetail.employeName!,
            visitRejected: responseModel.items.visitRejected,
            visitPendingForApproval:
                responseModel.items.visitPendingForApproval,
            visitAccepted: responseModel.items.visitAccepted,
            collectionRejectAmount: responseModel.items.collectionRejectAmount,
            collectionEmiAmountPendingForApproval:
                responseModel.items.collectionEmiAmountPendingForApproval,
            collectionAcceptAmount: responseModel.items.collectionAcceptAmount,
            employeeUniqueId:
                responseModel.items.employeeDetail.employeUniqueId!,
            joiningDate: responseModel.items.employeeDetail.joiningDate!,
            employeeId: responseModel.items.employeeDetail.id!,
            email: responseModel.items.employeeDetail.email!,
            imageUrl: responseModel.items.employeeDetail.employeePhoto ?? '',
            mobileNo: responseModel.items.employeeDetail.mobileNo.toString(),
            address: responseModel.items.employeeDetail.currentAddress!));
      }
    } catch (error) {
      state = AsyncValue.error(error, StackTrace.current);
    }
  }

  void clearData() {
    state = const AsyncValue.loading(); // Reset the state
    _isInitialized = false; // Reset the flag for future data fetch
  }

  Future<void> employeePunchOut(BuildContext context) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String? token = sharedPreferences.getString('token');
    print('token of employee punchout $token');
    try {
      final response = await dio.get(Api.punchOut,
          options: Options(headers: {'token': token}));
      log('punchOut api: ${Api.punchOut.toString()}');
      print('punch out response $response');
      if (response.statusCode == 200) {
        showCustomSnackBar(context, "Punch Out is Successful", Colors.green);
        Navigator.pop(context);
        // isPunchOutStatus = true;
        // return response;
      } else {
        showCustomSnackBar(
            context, response.statusMessage.toString(), Colors.red);
        Navigator.pop(context);
      }
    } catch (error) {
      DioExceptions.fromDioError(error as DioException, context);
      Navigator.pop(context);
    }
  }
}

Future<void> logoutSession() async {
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  sharedPreferences.clear();
  print('email is exit or not ${sharedPreferences.containsKey('email')}');
  sharedPreferences.containsKey('email');
}

final apiResponseProvider =
    StateNotifierProvider<ApiResponseNotifier, AsyncValue<UserProfile>>((ref) {
  final dio = ref.read(dioProvider);
  return ApiResponseNotifier(dio);
});

final dialogVisibilityProvider = StateProvider<bool>((ref) => false);

final profileProvider =
    StateNotifierProvider<UserProfileProvider, ProfileModel>((ref) {
  final dio = ref.watch(dioProvider);
  return UserProfileProvider(dio);
});

class UserProfileProvider extends StateNotifier<ProfileModel> {
  final Dio dio;

  UserProfileProvider(this.dio) : super(ProfileModel());
  final ImagePicker imagePicker = ImagePicker();

  Future<XFile?> updatePhoto(String employeeId) async {
    print('employee id $employeeId');
    state = state.copyWith(isLoading: true);
    final pickedFile = await imagePicker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      await uploadImage(pickedFile.path, employeeId);
      state = state.copyWith(profilePhoto: pickedFile.path);
      return pickedFile;
    }
    state = state.copyWith(isLoading: false);
    return null;
  }

  Future<void> uploadImage(String image, String employeeId) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String? token = sharedPreferences.getString('token');
    var formData = FormData.fromMap({
      'id': employeeId,
      'employeePhoto': await MultipartFile.fromFile(image),
    });
    print(image);
    // final String token =
    //     "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJJZCI6IjY2ODUwZjdkMzc0NDI1ZTkzNzExNDE4MCIsInJvbGVOYW1lIjoiYWRtaW4iLCJpYXQiOjE3MjY3Mzc2Njd9.exsdAWj9fWc5LiOcAkFmlgade-POlU8orE8xvgfYXZU";
    final response = await dio.post(Api.updateProfile,
        data: formData, options: Options(headers: {"token": token}));
    print(response.statusCode);
    print(response.data);
    if (response.statusCode == 200) {
      // VisitUpdateUploadImageResponseModel imageResponseModel =
      // VisitUpdateUploadImageResponseModel.fromJson(response.data);
      state = state.copyWith(isLoading: false);
      // if (kDebugMode) {
      //   print('image ${imageResponseModel.items.image}');
      //   state = state.copyWith(transactionImage: imageResponseModel.items.image);
      //   imageApi = imageResponseModel.items.image;
      //   print(imageApi);
      // }
    } else {
      state = state.copyWith(isLoading: false);
      throw Exception('Failed to load data');
    }
  }

  Future<void> changePassword(BuildContext context, WidgetRef ref) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String? token = sharedPreferences.getString('token');
    UpdatePasswordRequestModel requestModel = UpdatePasswordRequestModel(
        oldPassword: state.password, newPassword: state.confirmPassword);
    final response = await dio.post(Api.updatePassword,
        data: requestModel.toJson(),
        options: Options(headers: {"token": token}));
    print(response.statusCode);
    print(response.data);
    UpdatePasswordResponseModel responseModel =UpdatePasswordResponseModel.fromJson(response.data);
    if (response.statusCode == 200) {
      showCustomSnackBar(
          context, responseModel.message, Colors.green);
      ref.read(dialogVisibilityProvider.notifier).state = false;
    }
  }

  void updateConfirmPassword(String value) {
    final isValid = _validateConfirmPassword(value);
    state = state.copyWith(confirmPassword: value, isConfirmPassword: isValid);
  }

  void updatePassword(String value) {
    final isValid = _validatePassword(value);
    state = state.copyWith(password: value, isPassword: isValid);
  }
}

bool _validateConfirmPassword(String value) {
  return value.isNotEmpty;
}

bool _validatePassword(String value) {
  return value.isNotEmpty;
}

class ProfileModel {
  final String profilePhoto;
  final bool isLoading;
  final String confirmPassword;
  final bool isConfirmPassword;
  final String password;
  final bool isPassword;

  ProfileModel(
      {this.profilePhoto = '',
      this.isLoading = false,
      this.password = '',
      this.confirmPassword = '',
      this.isConfirmPassword = true,
      this.isPassword = false});

  ProfileModel copyWith({
    String? profilePhoto,
    bool? isLoading,
    String? password,
    String? confirmPassword,
    bool? isConfirmPassword,
    bool? isPassword,
  }) {
    return ProfileModel(
        isConfirmPassword: isConfirmPassword ?? this.isConfirmPassword,
        isPassword: isPassword ?? this.isPassword,
        profilePhoto: profilePhoto ?? this.profilePhoto,
        isLoading: isLoading ?? this.isLoading,
        password: password ?? this.password,
        confirmPassword: confirmPassword ?? this.confirmPassword);
  }
}
