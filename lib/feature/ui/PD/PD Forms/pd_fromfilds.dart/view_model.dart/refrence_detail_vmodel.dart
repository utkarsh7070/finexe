import 'dart:async';

import 'package:dio/dio.dart';
import 'package:finexe/feature/base/api/api.dart';
import 'package:finexe/feature/base/api/dio.dart';
import 'package:finexe/feature/base/utils/general/pref_utils.dart';
// import 'package:finexe/feature/ui/PD/view/PD%20Form/pd_fromfilds.dart/model/Submit%20Data%20Models/refrence_form_model.dart';
import 'package:flutter/Material.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../base/api/dio_exception.dart';
import '../../../../../base/utils/widget/custom_snackbar.dart';
import '../model/Submit Data Models/pd_response_model.dart';

class PDRefrenceDetails extends StateNotifier<ReferenceApplicationState> {
  final Dio dio;

  PDRefrenceDetails(this.dio) : super(ReferenceApplicationState());

  void UpdateInitially(PdResponseModel data) {
    final List<ReferenceDetailModel> modifiableList = [];
    if (data.items?.referenceDetails?.length != null) {
      for (int i = 0; i < data.items!.referenceDetails!.length; i++) {
        modifiableList.add(ReferenceDetailModel(
          referenceAddress: data.items?.referenceDetails?[i].address ?? '',
          referenceMobile: data.items?.referenceDetails?[i].mobileNumber ?? '',
          referenceRelation: data.items?.referenceDetails?[i].relation ?? '',
          referenceName: data.items?.referenceDetails?[i].name ?? '',
          id: data.items?.referenceDetails?[i].id ?? '',
        ));
      }
      state = state.copyWith(referenceList: modifiableList);
    }
  }

  void updateReferenceName(String value, int index) {
    state = state.copyWith(referenceList: [
      for (int i = 0; i < state.referenceList.length; i++)
        if (i == index)
          state.referenceList[i].copyWith(referenceName: value)
        else
          state.referenceList[i],
    ]);
  }

  void updateReferenceAddress(String value, int index) {
    state = state.copyWith(referenceList: [
      for (int i = 0; i < state.referenceList.length; i++)
        if (i == index)
          state.referenceList[i].copyWith(referenceAddress: value)
        else
          state.referenceList[i],
    ]);
  }
  void updateReferenceMobile(String value, int index) {
    state = state.copyWith(referenceList: [
      for (int i = 0; i < state.referenceList.length; i++)
        if (i == index)
          state.referenceList[i].copyWith(referenceMobile: value)
        else
          state.referenceList[i],
    ]);
  }
  void updateReferenceRelation(String value, int index) {
    state = state.copyWith(referenceList: [
      for (int i = 0; i < state.referenceList.length; i++)
        if (i == index)
          state.referenceList[i].copyWith(referenceRelation: value)
        else
          state.referenceList[i],
    ]);
  }


  Future<bool> submitPdReferenceDetailsForm(
      {required String customerId,
      required BuildContext context}) async {
    state = state.copyWith(isLoading: true);

    // Add customerId and pdType to the payload
    final payload = {
      'referenceDetails': state.referenceList.toList(),
      'customerId': customerId,
      'pdType': 'creditPd',
    };
    String? token = speciality.getToken();
    try {
      final response = await dio.post(Api.updatePdReport,
          data: payload, options: Options(headers: {"token": token}));
      if (kDebugMode) {
        print(token);
        print(payload);
        print(response.data);
        print('Payload: $payload');
      }
      if (response.statusCode == 200) {
        print('refrence form submitted: ${response.data}');
        showCustomSnackBar(context, 'Form Saved successfully!', Colors.green);
        state = state.copyWith(isLoading: false);
        return true;
      } else {
        state = state.copyWith(isLoading: false);
        print('Error while submitting refernceFormData form');
        return false;
      }
    } catch (error) {
      print(error);
      state = state.copyWith(isLoading: false);
      DioExceptions.fromDioError(error as DioException, context);
      print('response.data.message $error');
      return false;
    }
  }
}

final pdRefrenceSubmitProvider =
    StateNotifierProvider<PDRefrenceDetails, ReferenceApplicationState>((ref) {
  final dio = ref.read(dioProvider);
  // final checkStatus = ref.watch(checkBoxTermsConditionApplicant);

  return PDRefrenceDetails(dio);
});

class ReferenceApplicationState {
  final bool? isLoading;
  final List<ReferenceDetailModel> referenceList;

  ReferenceApplicationState({
    this.isLoading = false,
    this.referenceList = const [],
  });

  ReferenceApplicationState copyWith({
    bool? isLoading,
    List<ReferenceDetailModel>? referenceList,
  }) {
    return ReferenceApplicationState(
        isLoading: isLoading ?? this.isLoading,
        referenceList: referenceList ?? this.referenceList);
  }
}

final getRefrenceDataProvider = AsyncNotifierProvider.family<RefFormDetailProvider, PdResponseModel, String>(
  () {
    return RefFormDetailProvider();
  },
);

class RefFormDetailProvider
    extends FamilyAsyncNotifier<PdResponseModel, String> {
  @override
  FutureOr<PdResponseModel> build(String arg) {
    final dio = ref.watch(dioProvider);
    final referenceUpdateViewModel =
        ref.read(pdRefrenceSubmitProvider.notifier);
    return fetchRefDetails(arg, dio, referenceUpdateViewModel);
  }

  Future<PdResponseModel> fetchRefDetails(String custId, Dio dio,
      PDRefrenceDetails referenceUpdateViewModel) async {
    String? token = speciality.getToken();
    PdResponseModel refernceFormData = PdResponseModel();
    print('url: ${Api.getpdformdata}$custId');

    try {
      final response = await dio.get(
        '${Api.getpdformdata}$custId',
        options: Options(headers: {"token": token}),
      );

      if (response.statusCode == 200 && response.data != null) {
        final Map<String, dynamic> responseData = response.data;

        // Parse the response into the GetApplicantDetailsModel
        refernceFormData = PdResponseModel.fromJson(responseData);
        referenceUpdateViewModel.UpdateInitially(refernceFormData);
        print('refernceFormData:: $refernceFormData');
        return refernceFormData;
      } else {
        throw Exception(
            "Failed to load refernceFormData data: ${response.statusCode}");
      }
    } catch (e) {
      print("Error fetching refernceFormData details: $e");
      // throw Exception("Error fetching refernceFormData data: $e");
      return refernceFormData;
    }
  }
}

class ReferenceDetailModel {
  final String referenceName;
  final String referenceAddress;
  final String referenceRelation;
  final String referenceMobile;
  final String id;

  ReferenceDetailModel(
      {this.referenceName = '',
      this.referenceAddress = '',
      this.referenceRelation = '',
      this.referenceMobile = '',
      this.id = ''});

  ReferenceDetailModel copyWith({
    String? referenceName,
    String? referenceAddress,
    String? referenceRelation,
    String? referenceMobile,
    String? id,
  }) {
    return ReferenceDetailModel(
        id: id ?? this.id,
        referenceAddress: referenceAddress ?? this.referenceAddress,
        referenceMobile: referenceMobile ?? this.referenceMobile,
        referenceName: referenceName ?? this.referenceName,
        referenceRelation: referenceRelation ?? this.referenceRelation);
  }
}
