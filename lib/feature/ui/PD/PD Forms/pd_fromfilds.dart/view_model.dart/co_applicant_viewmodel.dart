import 'dart:async';

import 'package:dio/dio.dart';
import 'package:dropdown_textfield/dropdown_textfield.dart';
import 'package:finexe/feature/base/api/api.dart';
import 'package:finexe/feature/base/api/dio.dart';
import 'package:finexe/feature/base/utils/general/pref_utils.dart';
import 'package:finexe/feature/ui/PD/PD%20Forms/pd_fromfilds.dart/model/Submit%20Data%20Models/coapplicant_model.dart';
import 'package:finexe/feature/ui/PD/PD%20Forms/pd_fromfilds.dart/model/Submit%20Data%20Models/pd_response_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../base/api/dio_exception.dart';
import '../../../../../base/utils/Repo/image_upload.dart';

final pdCoApplicantViewModelProvider =
    StateNotifierProvider<PDCOApplicantViewModel, CoApplicantState>(
        (ref) {
  final dio = ref.read(dioProvider);
  return PDCOApplicantViewModel(dio);
});

class PDCOApplicantViewModel extends StateNotifier<CoApplicantState> {
  final Dio dio;

  PDCOApplicantViewModel(this.dio) : super(CoApplicantState());

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
    state = state.copyWith(coApplicantImage: image ?? '');
  }

  void updateApplicantType(String val,int index) {
    final valid = _validString(val);
    // state = [
    //   for (final todo in state)
    //     if (todo.id == index)
    //       todo.copyWith(applicantType: val, isApplicantType: valid)
    //     else
    //       todo
    // ];
    state = state.copyWith(applicantType: val, isApplicantType: valid);
  }

  void updateOccupation(String val) {
    final valid = _validString(val);
    state = state.copyWith(occupation: val, isOccupation: valid);
  }

  void updateYearCurrentAddress(String val) {
    final valid = _validString(val);
    state =
        state.copyWith(yearCurrentAddress: val, isYearCurrentAddress: valid);
  }

  void updateAlternativeMobile(String val) {
    final valid = _validString(val);
    state = state.copyWith(alternativeMobile: val, isAlternativeMobile: valid);
  }

  // void updateEmail(String val) {
  //   final valid = _validString(val);
  //   state = state.copyWith(email: val, isEmail: valid);
  // }

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

  // void updateDependentsWithCustomer(String val) {
  //   final valid = _validString(val);
  //   state = state.copyWith(
  //       dependentsWithCustomer: val, isDependentsWithCustomer: valid);
  // }

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

  // void updateInitialValue(PDCoApplicantSubmitFormModel data) {
  //   state = state.copyWith(
  //       coApplicantImage: data.items!.coApplicantImage,
  //       occupation: data.items?.applicant?.occupation,
  //       applicantType: data.items?.applicant?.applicantType,
  //       businessType: data.items?.applicant?.businessType
  //   );
  // }

  bool validateClickButton() {
    final applicantType = _validString(state.applicantType);
    final businessType = _validString(state.businessType);
    final occupation = _validString(state.occupation);
    final yearCurrentAddress = _validString(state.yearCurrentAddress);
    final houseLandmark = _validString(state.houseLandmark);
    final alternativeMobile = _validString(state.alternativeMobile);
    // final email = _validString(state.email);
    final religion = _validString(state.religion);
    final nationality = _validString(state.nationality);
    final category = _validString(state.category);
    final caste = _validString(state.caste);
    // final dependentsWithCustomer = _validString(state.dependentsWithCustomer);
    final residenceType = _validString(state.residenceType);

    state = state.copyWith(
        isApplicantType: applicantType,
        isBusinessType: businessType,
        isOccupation: occupation,
        isYearCurrentAddress: yearCurrentAddress,
        isHouseLandmark: houseLandmark,
        isAlternativeMobile: alternativeMobile,
        // isEmail: email,
        isReligion: religion,
        isNationality: nationality,
        isCategory: category,
        isCaste: caste,
        // isDependentsWithCustomer: dependentsWithCustomer,
        isResidenceType: residenceType);
    return applicantType &&
        businessType &&
        occupation &&
        yearCurrentAddress &&
        houseLandmark &&
        alternativeMobile &&
        // email &&
        religion &&
        nationality &&
        category &&
        caste &&
        // dependentsWithCustomer &&
        residenceType;
  }

  Future<bool> submitpdCoApplicantForm({
    required String customerId,
    required String pdType,
    required List<String?> coapplicantImages,
    required BuildContext context,
    // CoApplicant? coApplicatFirstData,
    List<CoApplicant>? coApplicantUsers,

    // String? coapplicantType,
    // String? businessType,
    // String? occupation,
    // String? dob,
    // String? email,
    // String? houseLandMark,
    // String? alternateMobileNo,
    // String? noOfyearsAtCurrentAddress,
    // String? gender,
    // String? religion,
    // String? nationality,
    // String? category,
    // String? caste,
    // String? maritalStatus,
    // String? noOfDependentWithCustomer,
    // String? educationalDetails,
    // String? residenceType,
  }) async {
    state = state.copyWith(isLoading: true);
    // if(state.isLoading==true){
    //   print('click second time');
    //   return false;
    // }
    // Add customerId and pdType to the payload
    final payload = {
      // 'co_Applicant': coApplicatFirstData?.toJson(),
      'co_Applicant': coApplicantUsers?.toList(),
      'customerId': customerId,
      'pdType': pdType,
      'coApplicantImage': coapplicantImages.toList()
    };
    String? token = speciality.getToken();
    try {
      final response = await dio.post(Api.updatePdReport,
          data: payload, options: Options(headers: {"token": token}));
      print(response.data);
      print('Payload: $payload');
      if (response.statusCode == 200) {
        CoApplicant coApplicant = CoApplicant.fromJson(response.data);
        print('CO--Applicant form submitted: $response');
        print('coApplicant-- $coApplicant');
        state = state.copyWith(isLoading: false);
        return true;
      } else {
        state = state.copyWith(isLoading: false);
        print('Error while submitting applicant form');
        return false;
      }
    } catch (e) {
      print('payload of coapplicantImages :: $payload');
      state = state.copyWith(isLoading: false);
      DioExceptions.fromDioError(e as DioException, context);

      print('Exception in co_applicant form: $e');
      return false;
    }
  }
}

bool _validString(String val) {
  return val.isNotEmpty;
}

//********************************************
class CoApplicantDetailsParams {
  final int index;
  final String customerId;

  CoApplicantDetailsParams({
    required this.index,
    required this.customerId,
  });
}

final coApplicantDetailsProvider = AsyncNotifierProvider.family<
    InitialApiCoApplicant, PdResponseModel, String>(
  () {
    return InitialApiCoApplicant();
  },
);

class InitialApiCoApplicant
    extends FamilyAsyncNotifier<PdResponseModel, String> {
  @override
  FutureOr<PdResponseModel> build(String arg) {
    final dataViewModel = ref.read(pdCoApplicantViewModelProvider.notifier);
    final dio = ref.watch(dioProvider);
    return fetchCoApplicationDetails(arg, dio, dataViewModel);
  }

  Future<PdResponseModel> fetchCoApplicationDetails(
      String customerId, _dio, PDCOApplicantViewModel data) async {
    String? token = speciality.getToken();
    // PDCoApplicantSubmitFormModel details = PDCoApplicantSubmitFormModel();
    PdResponseModel pdResponseModel = PdResponseModel();
    // print('index: $index');
    print('url: ${Api.getpdformdata}$customerId');

    try {
      final response = await _dio.get(
        '${Api.getpdformdata}$customerId',
        options: Options(headers: {"token": token}),
      );

      if (response.statusCode == 200 && response.data != null) {
        final Map<String, dynamic> responseData = response.data;

        // Parse the response into the PDCoApplicantSubmitFormModel
        //  details = PDCoApplicantSubmitFormModel.fromJson(responseData);
        pdResponseModel = PdResponseModel.fromJson(responseData);
        return pdResponseModel;
        //   if (pdResponseModel.items?.coApplicant != null
        //       // && details.items?.coApplicant?.isNotEmpty
        //   )
        //   {
        //     print('CoApplicant List Length: ${pdResponseModel.items?.coApplicant?.length}');
        //     print('CoApplicantImage List Length: ${pdResponseModel.items?.coApplicantImage?.length}');
        //
        //     // Ensure index is valid for coApplicant list
        //     if (index < pdResponseModel.items!.coApplicant!.length) {
        //       CoApplicant coApplicant = pdResponseModel.items?.coApplicant![index] ?? CoApplicant.fromJson({});
        //
        //       String? coApplicantImage = (details.items?.coApplicantImage != null &&
        //           index < details.items!.coApplicantImage!.length)
        //           ? details.items?.coApplicantImage![index]
        //           : null;
        //
        //       print("CoApplicant: ${coApplicant.coApplicantType}");
        //       print("CoApplicant Image: ${coApplicantImage ?? 'No Image Available'}");
        //
        //       // Return the CoItems object with or without the image
        //       return details;
        //     } else {
        //       print('Index $index is out of bounds for coApplicant');
        //       return null;
        //       // throw Exception("Index $index is out of bounds for coApplicant");
        //     }
        //   } else {
        //     print('CoApplicant details not found in the response');
        //     return null;
        //
        //     // throw Exception("CoApplicant details not found in the response");
        //   }
        // } else {
        //   return null;
        //
        //   print('Failed to load coApplicant data: ${response.statusCode}');
        //   // throw Exception("Failed to load coApplicant data: ${response.statusCode}");
        // }
      } else {
        return pdResponseModel;
      }
    } catch (e) {
      ExceptionHandler().handleError(e);
      print("Error fetching coApplicant details: $e");
      // throw Exception("Error fetching coApplication data: $e");
      rethrow;
    }
  }
}

class CoApplicantState {
  final bool isLoading;
  final String coApplicantImage;
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
  final int id;

  // final bool isEmail;
  // final String email;
  final bool isReligion;
  final String religion;
  final bool isNationality;
  final String nationality;
  final bool isCategory;
  final String category;
  final bool isCaste;
  final String caste;

  // final bool isDependentsWithCustomer;
  // final String dependentsWithCustomer;
  final bool isResidenceType;
  final String residenceType;

  CoApplicantState({
    this.id = 0,
    this.residenceType = '',
    this.isResidenceType = true,
    // this.dependentsWithCustomer = '',
    // this.isDependentsWithCustomer = true,
    this.caste = '',
    this.isCaste = true,
    this.category = '',
    this.isCategory = true,
    this.nationality = '',
    this.isNationality = true,
    this.isReligion = true,
    this.religion = '',
    // this.email = '',
    // this.isEmail = true,
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
    this.coApplicantImage = '',
    this.isLoading = false,
    this.selectedDate = '',
  });

  CoApplicantState copyWith({
    String? businessType,
    bool? isBusinessType,
    String? occupation,
    bool? isAlternativeMobile,
    String? alternativeMobile,
    int? id,
    // bool? isEmail,
    // String? email,
    bool? isReligion,
    String? religion,
    bool? isNationality,
    String? nationality,
    bool? isCategory,
    String? caste,
    bool? isCaste,
    // String? dependentsWithCustomer,
    // bool? isDependentsWithCustomer,
    String? residenceType,
    bool? isResidenceType,
    String? category,
    String? yearCurrentAddress,
    bool? isYearCurrentAddress,
    bool? isOccupation,
    String? applicantType,
    bool? isApplicantType,
    String? coApplicantImage,
    bool? isLoading,
    String? houseLandmark,
    bool? isHouseLandmark,
    String? selectedDate,
  }) {
    return CoApplicantState(
      id: id ?? this.id,
      isResidenceType: isResidenceType ?? this.isResidenceType,
      residenceType: residenceType ?? this.residenceType,
      // dependentsWithCustomer:
      // dependentsWithCustomer ?? this.dependentsWithCustomer,
      // isDependentsWithCustomer:
      // isDependentsWithCustomer ?? this.isDependentsWithCustomer,
      caste: caste ?? this.caste,
      isCaste: isCaste ?? this.isCaste,
      isCategory: isCategory ?? this.isCategory,
      category: category ?? this.category,
      isNationality: isNationality ?? this.isNationality,
      nationality: nationality ?? this.nationality,
      religion: religion ?? this.religion,
      isReligion: isReligion ?? this.isReligion,
      // email: email ?? this.email,
      // isEmail: isEmail ?? this.isEmail,
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
      coApplicantImage: coApplicantImage ?? this.coApplicantImage,
      isLoading: isLoading ?? this.isLoading,
      selectedDate: selectedDate ?? this.selectedDate,
    );
  }
}
