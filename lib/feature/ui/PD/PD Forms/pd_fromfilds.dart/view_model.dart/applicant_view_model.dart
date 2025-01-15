import 'dart:async';
import 'package:dio/dio.dart';
import 'package:dropdown_textfield/dropdown_textfield.dart';
import 'package:finexe/feature/base/api/api.dart';
import 'package:finexe/feature/base/api/dio.dart';
import 'package:finexe/feature/base/utils/general/pref_utils.dart';
import 'package:finexe/feature/ui/PD/PD%20Forms/pd_fromfilds.dart/model/Submit%20Data%20Models/pd_response_model.dart';
import 'package:flutter/Material.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../../../../../base/api/dio_exception.dart';
import '../../../../../base/utils/Repo/image_upload.dart';
import '../model/Submit Data Models/applicant_model.dart';

final isAppExpandedProvider = StateProvider<bool>((ref) => false);
bool _validString(String val) {
  return val.isNotEmpty;
}

class PDApplicantViewModel extends StateNotifier<ApplicantState> {
  final Dio dio;

  PDApplicantViewModel(this.dio) : super(ApplicantState());


  final ExpansionTileController expansionTileController = ExpansionTileController();
  final List<DropDownValueModel> applicantTypeDropdownMenuItem = const [
    DropDownValueModel(name: "Individual", value: "Individual"),
    DropDownValueModel(name: "Non Individual", value: "Non Individual"),
  ];
  final List<DropDownValueModel> residenceTypeDropdownMenuItem = const [
    DropDownValueModel(name: "Owned", value: "Owned"),
    DropDownValueModel(name: "Rented", value: "Rented"),
    DropDownValueModel(name: "Leased", value: "Leased"),
  ];

  final List<DropDownValueModel> businessTypeDropdownMenuItem = const [
    DropDownValueModel(
        name: "Self Employed Proffessional",
        value: "Self Employed Proffessional"),
    DropDownValueModel(
        name: "Self Emplyed Non Proffessional",
        value: "Self Emplyed Non Proffessional"),
    DropDownValueModel(
        name: "Agriculture Business", value: "Agriculture Business"),
    DropDownValueModel(name: "House Wife", value: "House Wife"),
    DropDownValueModel(name: "Retired", value: "Retired"),
    DropDownValueModel(name: "Salaried", value: "Salaried"),
    DropDownValueModel(name: "Other", value: "Other"),
  ];

  final SingleValueDropDownController applicantTypeDropDownControllerProvider =
      SingleValueDropDownController();
  final SingleValueDropDownController businessTypeDropDownControllerProvider =
      SingleValueDropDownController();
  @override
  void dispose() {
    applicantTypeDropDownControllerProvider.dispose();
    businessTypeDropDownControllerProvider.dispose();
    super.dispose();
  }

  Future<void> applicantImage() async {
    String? image = await DocsUploader.uploadImage(
        isCompressed: true, compressedValue: 50, byCamera: true, dio: dio);
    state = state.copyWith(applicantImage: image ?? '');
  }

  void updateApplicantType(String val) {
    final valid = _validString(val);
    state = state.copyWith(applicantType: val, isApplicantType: valid);
  }

  void updateOccupation(String val) {
    final valid = _validString(val);
    state = state.copyWith(occupation: val, isOccupation: valid);
  }

  void updateYearCurrentAddress(String val) {
    final valid = _validString(val);
    state = state.copyWith(yearCurrentAddress: val, isYearCurrentAddress: valid);
  }

  void updateAlternativeMobile(String val) {
    final valid = _validString(val);
    state = state.copyWith(alternativeMobile: val, isAlternativeMobile: valid);
  }

  void updateEmail(String val) {
    final valid = _validString(val);
    state = state.copyWith(email: val, isEmail: valid);
  }

  void updateReligion(String val) {
    final valid = _validString(val);
    state = state.copyWith(religion: val, isReligion: valid);
  }

  void updateNationality(String val) {
    final valid = _validString(val);
    state = state.copyWith(nationality: val, isNationality: valid);
  }

  void updateCategory(String val) {
    final valid = _validString(val);
    state = state.copyWith(category: val, isCategory: valid);
  }

  void updateCaste(String val) {
    final valid = _validString(val);
    state = state.copyWith(caste: val, isCaste: valid);
  }

  void updateDependentsWithCustomer(String val) {
    final valid = _validString(val);
    state = state.copyWith(
        dependentsWithCustomer: val, isDependentsWithCustomer: valid);
  }

  void updateResidenceType(String val) {
    final valid = _validString(val);
    state = state.copyWith(residenceType: val, isResidenceType: valid);
  }

  void updateHouseLandmark(String val) {
    final valid = _validString(val);
    state = state.copyWith(houseLandmark: val, isHouseLandmark: valid);
  }

  void updateBusinessType(String val) {
    final valid = _validString(val);
    state = state.copyWith(businessType: val, isBusinessType: valid);
  }

  void updateInitialValue(PdResponseModel data) {
    state = state.copyWith(
        applicantImage: data.items?.applicantImage,
        occupation: data.items?.applicant?.occupation,
        applicantType: data.items?.applicant?.applicantType,
        businessType: data.items?.applicant?.businessType,
        caste: data.items?.applicant?.caste,
      email: data.items?.applicant?.email,
      category: data.items?.applicant?.category,
      houseLandmark: data.items?.applicant?.houseLandMark,
      religion: data.items?.applicant?.religion,
      nationality: data.items?.applicant?.nationality,
      residenceType: data.items?.applicant?.residenceType,
      alternativeMobile: data.items?.applicant?.alternateMobileNo,
        dependentsWithCustomer: data.items?.applicant?.noOfDependentWithCustomer,
    );
  }

  bool validateClickButton() {
    final applicantType = _validString(state.applicantType);
    final businessType = _validString(state.businessType);
    final occupation = _validString(state.occupation);
    final yearCurrentAddress = _validString(state.yearCurrentAddress);
    final houseLandmark = _validString(state.houseLandmark);
    final alternativeMobile = _validString(state.alternativeMobile);
    final email = _validString(state.email);
    final religion = _validString(state.religion);
    final nationality = _validString(state.nationality);
    final category = _validString(state.category);
    final caste = _validString(state.caste);
    final dependentsWithCustomer = _validString(state.dependentsWithCustomer);
    final residenceType = _validString(state.residenceType);

    state = state.copyWith(
        isApplicantType: applicantType,
        isBusinessType: businessType,
        isOccupation: occupation,
        isYearCurrentAddress: yearCurrentAddress,
        isHouseLandmark: houseLandmark,
        isAlternativeMobile: alternativeMobile,
        isEmail: email,
        isReligion: religion,
        isNationality: nationality,
        isCategory: category,
        isCaste: caste,
        isDependentsWithCustomer: dependentsWithCustomer,
        isResidenceType: residenceType);
    return applicantType &&
        businessType &&
        occupation &&
        yearCurrentAddress &&
        houseLandmark &&
        alternativeMobile &&
        email &&
        religion &&
        nationality &&
        category &&
        caste &&
        dependentsWithCustomer &&
        residenceType;
  }

  Future<bool> submitPdApplicantForm(String customerId) async {
    // Set loading state to true
    state = state.copyWith(isLoading: true);
    final applicantData = Applicant(
      applicantType: state.applicantType,
      businessType: state.businessType,
      occupation: state.occupation,
      // dOB: state.dob,
      email: state.email,
      houseLandMark: state.houseLandmark,
      alternateMobileNo: state.alternativeMobile,
      noOfyearsAtCurrentAddress: state.yearCurrentAddress,
      // gender: gender,
      religion: state.religion,
      nationality: state.nationality,
      category: state.category,
      caste: state.caste,
      // maritalStatus: maritalStatus,
      noOfDependentWithCustomer: state.dependentsWithCustomer,
      // educationalDetails: state.e,
      residenceType: state.residenceType,
    );

    // Add customerId and pdType to the payload
    final payload = {
      'applicant': applicantData.toJson(),
      'customerId': customerId,
      'pdType': 'creditPd',
      'applicantImage': state.applicantImage
    };

    String? token = speciality.getToken();
    if (kDebugMode) {
      print('stored token:: $token');
    }
    try {
      final response = await dio.post(Api.updatePdReport,
          data: payload, options: Options(headers: {"token": token}));

      if (response.statusCode == 200) {
        // Applicant applicantdata = Applicant.fromJson(response.data);
        if (kDebugMode) {
          print('Applicant form submitted: $response');
        }
        Fluttertoast.showToast(msg: 'Applicant form submitted',backgroundColor: Colors.green,fontSize: 18);
        state = state.copyWith(isLoading: false);
        return true;
      } else if (state.isLoading == true) {
        if (kDebugMode) {
          print('click second time');
        }
        return false;
      } else {
        state = state.copyWith(isLoading: false);
        if (kDebugMode) {
          print('Error while submitting applicant form');
        }
        return false;
      }
    }
    catch (error) {
      ExceptionHandler().handleError(error);
      if (kDebugMode) {
        print('response.data.message $error');
      }
      return false;
    } finally {
      state = state.copyWith(isLoading: false);
    }
  }
}

final pdapplicantViewModelProvider =
    StateNotifierProvider<PDApplicantViewModel, ApplicantState>((ref) {
  final dio = ref.read(dioProvider);
  // final checkStatus = ref.watch(checkBoxTermsConditionApplicant);

  return PDApplicantViewModel(dio);
});

class ApplicantState {
  final bool isLoading;
  final String applicantImage;
  final String selectedDate;
  final String applicantType;
  final bool isApplicantType;
  final String businessType;
  final bool isBusinessType;
  final String occupation;
  final bool isOccupation;
  final String yearCurrentAddress;
  final bool isYearCurrentAddress;
  final String houseLandmark;
  final bool isHouseLandmark;
  final bool isAlternativeMobile;
  final String alternativeMobile;
  final bool isEmail;
  final String email;
  final bool isReligion;
  final String religion;
  final bool isNationality;
  final String nationality;
  final bool isCategory;
  final String category;
  final bool isCaste;
  final String caste;
  final bool isDependentsWithCustomer;
  final String dependentsWithCustomer;
  final bool isResidenceType;
  final String residenceType;

  ApplicantState({
    this.residenceType = '',
    this.isResidenceType = true,
    this.dependentsWithCustomer = '',
    this.isDependentsWithCustomer = true,
    this.caste = '',
    this.isCaste = true,
    this.category = '',
    this.isCategory = true,
    this.nationality = '',
    this.isNationality = true,
    this.isReligion = true,
    this.religion = '',
    this.email = '',
    this.isEmail = true,
    this.isAlternativeMobile = true,
    this.alternativeMobile = '',
    this.houseLandmark = '',
    this.isHouseLandmark = true,
    this.yearCurrentAddress = '',
    this.isYearCurrentAddress = true,
    this.businessType = '',
    this.isBusinessType = true,
    this.occupation = '',
    this.isOccupation = true,
    this.isApplicantType = true,
    this.applicantType = '',
    this.applicantImage = '',
    this.isLoading = false,
    this.selectedDate = '',
  });

  ApplicantState copyWith({
    String? businessType,
    bool? isBusinessType,
    String? occupation,
    bool? isAlternativeMobile,
    String? alternativeMobile,
    bool? isEmail,
    String? email,
    bool? isReligion,
    String? religion,
    bool? isNationality,
    String? nationality,
    bool? isCategory,
    String? caste,
    bool? isCaste,
    String? dependentsWithCustomer,
    bool? isDependentsWithCustomer,
    String? residenceType,
    bool? isResidenceType,
    String? category,
    String? yearCurrentAddress,
    bool? isYearCurrentAddress,
    bool? isOccupation,
    String? applicantType,
    bool? isApplicantType,
    String? applicantImage,
    bool? isLoading,
    String? houseLandmark,
    bool? isHouseLandmark,
    String? selectedDate,
  }) {
    return ApplicantState(
      isResidenceType: isResidenceType ?? this.isResidenceType,
      residenceType: residenceType ?? this.residenceType,
      dependentsWithCustomer:
          dependentsWithCustomer ?? this.dependentsWithCustomer,
      isDependentsWithCustomer:
          isDependentsWithCustomer ?? this.isDependentsWithCustomer,
      caste: caste ?? this.caste,
      isCaste: isCaste ?? this.isCaste,
      isCategory: isCategory ?? this.isCategory,
      category: category ?? this.category,
      isNationality: isNationality ?? this.isNationality,
      nationality: nationality ?? this.nationality,
      religion: religion ?? this.religion,
      isReligion: isReligion ?? this.isReligion,
      email: email ?? this.email,
      isEmail: isEmail ?? this.isEmail,
      alternativeMobile: alternativeMobile ?? this.alternativeMobile,
      isAlternativeMobile: isAlternativeMobile ?? this.isAlternativeMobile,
      houseLandmark: houseLandmark ?? this.houseLandmark,
      isHouseLandmark: isHouseLandmark ?? this.isHouseLandmark,
      isYearCurrentAddress: isYearCurrentAddress ?? this.isYearCurrentAddress,
      yearCurrentAddress: yearCurrentAddress ?? this.yearCurrentAddress,
      businessType: businessType ?? this.businessType,
      isBusinessType: isBusinessType ?? this.isBusinessType,
      isOccupation: isOccupation ?? this.isOccupation,
      occupation: occupation ?? this.occupation,
      applicantType: applicantType ?? this.applicantType,
      isApplicantType: isApplicantType ?? this.isApplicantType,
      applicantImage: applicantImage ?? this.applicantImage,
      isLoading: isLoading ?? this.isLoading,
      selectedDate: selectedDate ?? this.selectedDate,
    );
  }
}

// final loanDetailsProvider = FutureProvider.autoDispose
//     .family<LoanDetails, String>((ref, customerId) async {
//   final token = speciality.getToken();
//   final viewModel = LoanDetailsProvider();
//   return await viewModel.fetchLoanDetails(token, customerId);
// });
final applicationDetailsProvider = FutureProvider.autoDispose
    .family<ApplicantModel, String>((ref, customerId) async {
  final viewModel = ApplicationFormDetailsProvider();
  return await viewModel.fetchApplicationDetails(customerId);
});

class ApplicationFormDetailsProvider {
  final Dio _dio = Dio();

  Future<ApplicantModel> fetchApplicationDetails(String customerId) async {
    String? token = speciality.getToken();
    ApplicantModel details = ApplicantModel();
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
        details = ApplicantModel.fromJson(responseData);

        if (details.items != null) {
          return details;
        } else {
          // throw Exception("Applicant details not found in the response");
          print('Applicant details not found in the response');
          return details;
        }
      } else {
        // throw Exception(
        //     "Failed to load application data: ${response.statusCode}");
        print('Failed to load application data: ${response.statusCode}');
        return details;
      }
    }
    // catch (e) {
    //   print("Error fetching applicant details: $e");
    //   throw Exception("Error fetching application data: $e");
    // }
    catch (e) {
      if (e is DioException && e.response?.statusCode == 404) {
        // throw Exception("Resource not found. statusCode == 404", );
        print('Resource not found. statusCode == 404');
      }
      print("Error fetching Asset Details: $e");
      // throw Exception("An error occurred: ${e.toString()}");
      print('applicant details:: ${details.items}');
      return details;
    }
  }
}

// final applicantImageProvider =
//     StateNotifierProvider<ApplicantImageNotifier, XFile?>((ref) {
//   final dio = ref.read(dioProvider);
//   return ApplicantImageNotifier(dio);
// });
//
// class ApplicantImageNotifier extends StateNotifier<XFile?> {
//   final Dio _dio;
//
//   ApplicantImageNotifier(this._dio) : super(null);
//
//   Future<XFile?> pickSecondImage() async {
//     final ImagePicker picker = ImagePicker();
//     final XFile? image = await picker.pickImage(source: ImageSource.camera);
//
//     if (image != null) {
//       state = image;
//       return image;
//     }
//     return null;
//   }
//
//   void removeSecondImage() {
//     state = null;
//   }
//
//   Future<String> uploadImage(String image, BuildContext context) async {
//     String? token = speciality.getToken();
//
//     // String? token =
//     //     "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJJZCI6IjY3MGY1NjFhZTc2NjMwMjQ0ZGVhNDU1YyIsInJvbGVOYW1lIjoiaW50ZXJuYWxWZW5kb3JBbmRjcmVkaXRQZCIsImlhdCI6MTczMDk1NzUzOH0.p_57wid1GuLPusS29IwyAfQnKR5qfpdDc4CoU2la-qY";
//
//     if (token == null) {
//       throw Exception('Token is missing. Please log in again.');
//     }
//
//     // state = state.copyWith(isLoading: true);
//
//     var formData = FormData.fromMap({
//       'image':
//           await MultipartFile.fromFile(image, filename: image.split('/').last),
//     });
//
//     try {
//       final response = await _dio.post(
//         Api.uploadImageCollection,
//         data: formData,
//         options: Options(headers: {"token": token}),
//       );
//
//       if (response.statusCode == 200) {
//         VisitUpdateUploadImageResponseModel imageResponseModel =
//             VisitUpdateUploadImageResponseModel.fromJson(response.data);
//
//         // state = state.copyWith(isLoading: false);
//         return imageResponseModel.items.image;
//       } else {
//         showCustomSnackBar(context, 'Failed to upload image.', AppColors.red);
//         throw Exception(
//             'Failed to upload image. Status code: ${response.statusCode}');
//       }
//     } catch (e) {
//       // state = state.copyWith(isLoading: false);
//       showCustomSnackBar(
//           context,
//           'An error occurred while uploading the image. Please try again.',
//           AppColors.red);
//       throw Exception(
//           'An error occurred while uploading the image. Please try again.');
//     }
//   }
// }

final apiCallInitially =
    AsyncNotifierProvider.family<InitialApiCall, PdResponseModel, String>(
  () {
    return InitialApiCall();
  },
);

class InitialApiCall extends FamilyAsyncNotifier<PdResponseModel, String> {
  @override
  FutureOr<PdResponseModel> build(String arg) {
    final dio = ref.watch(dioProvider);
    final dataViewModel = ref.read(pdapplicantViewModelProvider.notifier);
    return fetchApplicationDetails(arg, dio, dataViewModel);
  }

  Future<PdResponseModel> fetchApplicationDetails(
      String customerId, dio, PDApplicantViewModel data) async {
    String? token = speciality.getToken();
    // ApplicantModel details = ApplicantModel();
    PdResponseModel pdResponseModel = PdResponseModel();
    // String? token =
    //     "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJJZCI6IjY3MGY1NjFhZTc2NjMwMjQ0ZGVhNDU1YyIsInJvbGVOYW1lIjoiaW50ZXJuYWxWZW5kb3JBbmRjcmVkaXRQZCIsImlhdCI6MTczMDk1NzUzOH0.p_57wid1GuLPusS29IwyAfQnKR5qfpdDc4CoU2la-qY"; // Replace with a secure way of managing tokens
    print('url: ${Api.getpdformdata}$customerId');

    try {
      final response = await dio.get(
        '${Api.getpdformdata}$customerId',
        options: Options(headers: {"token": token}),
      );

      if (response.statusCode == 200 && response.data != null) {
        final Map<String, dynamic> responseData = response.data;
        // Parse the response into the GetApplicantDetailsModel
         pdResponseModel = PdResponseModel.fromJson(responseData);
        // details =   PdApplicant.fromJson(responseData);
            // .fromJson(responseData);
        data.updateInitialValue(pdResponseModel);
        if (pdResponseModel.items != null) {
          return pdResponseModel;
        } else {
          // throw Exception("Applicant details not found in the response");
          print('Applicant details not found in the response');
          return pdResponseModel;
        }
      } else {
        print('Failed to load application data: ${response.statusCode}');
        return pdResponseModel;
      }
    }
    catch (e) {
      ExceptionHandler().handleError(e);
      rethrow;
      // if (e is DioException && e.response?.statusCode == 404) {
      //   // throw Exception("Resource not found. statusCode == 404", );
      //   print('Resource not found. statusCode == 404');
      // }
      // print("Error fetching Asset Details: $e");
      // // throw Exception("An error occurred: ${e.toString()}");
      // print('applicant details:: ${pdResponseModel.items}');
      // return pdResponseModel;
    }
  }
}
