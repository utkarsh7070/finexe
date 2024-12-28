import 'package:dio/dio.dart';
import 'package:finexe/feature/base/api/api.dart';
import 'package:finexe/feature/base/api/dio.dart';
import 'package:finexe/feature/base/service/session_service.dart';
import 'package:finexe/feature/base/utils/general/pref_utils.dart';

import 'package:finexe/feature/ui/PD/PD%20Forms/pd_fromfilds.dart/model/Submit%20Data%20Models/asset_detail_model.dart';
import 'package:flutter/Material.dart';
// import 'package:finexe/feature/ui/PD/view/PD%20Form/pd_fromfilds.dart/model/Submit%20Data%20Models/asset_detail_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../base/api/dio_exception.dart';

class PDAssetDetails extends StateNotifier<ApplicationState> {
  final Dio dio;

  PDAssetDetails(this.dio) : super(ApplicationState());

  Future<bool> submitpdAssetDetailsForm({
    required String customerId,
    required String pdType,
    required List<AssetDetails> assetDetailList,
    required double totalMarketV,
    required double totalPurchaseV,
    required BuildContext context
  }) async {

    state = state.copyWith(isLoading: true);
    // if(state.isLoading==true){
    //   print('click second time');
    //   return false;
    // }
    // Add customerId and pdType to the payload
    final payload = {
      'assetDetails': assetDetailList.toList(),
      'customerId': customerId,
      'pdType': pdType,
      "total": {
        "totalPurchaseValue": totalMarketV,
        "totalMarketValue": totalPurchaseV
      },
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
        // AssetDetails assetDetails =
        //     AssetDetails.fromJson(response.data['items']['assetDetails']);
        final List<dynamic> assets = response.data['items']['assetDetails'];
        final List<AssetDetails> assetDetails =
            assets.map((e) => AssetDetails.fromJson(e)).toList();
        print('assetDetails form submitted: ${assetDetails.length}');

        state = state.copyWith(isLoading: false);
        return true;
      } else {
        state = state.copyWith(isLoading: false);
        print('Error while submitting applicant form');
        return false;
      }
    }
    catch (error) {
      print(error);
      state = state.copyWith(isLoading: false);
      DioExceptions.fromDioError(error as DioException, context);
      // Handle exceptions and set state to error
      // state = AsyncValue.error(error, stackTrace);
      print('response.data.message ${error}');
      return false;
    }
  }
}

final pdassetDetailsiewModelProvider =
    StateNotifierProvider<PDAssetDetails, ApplicationState>((ref) {
  final dio = ref.read(dioProvider);
  // final checkStatus = ref.watch(checkBoxTermsConditionApplicant);

  return PDAssetDetails(dio);
});

class ApplicationState {
  final bool? isLoading;

  final String? selectedDate;

  ApplicationState({
    this.isLoading,
    this.selectedDate,
  });

  ApplicationState.initial()
      : isLoading = false,
        selectedDate = null;

  ApplicationState copyWith({
    bool? isLoading,
    String? selectedDate,
  }) {
    return ApplicationState(
      isLoading: isLoading ?? this.isLoading,
      selectedDate: selectedDate ?? this.selectedDate,
    );
  }
}

final getAssetDetailFromProvider =
    FutureProvider.autoDispose.family<AssetFormModel?,String>((ref,customerId) async {
  final viewModel = AssetFormDetailProvider();
  return await viewModel.fetchAssetDetails(customerId);
});


class AssetFormDetailProvider {
  final Dio _dio = Dio();
  Future<AssetFormModel?> fetchAssetDetails(String customerId) async {
    String? token = speciality.getToken();
    // final details = AssetFormModel.fromJson(responseData);
    AssetFormModel details= AssetFormModel();

    try {
      final response = await _dio.get(
        '${Api.getpdformdata}$customerId',
        options: Options(headers: {"token": token}),
      );

      if (response.statusCode == 200 && response.data != null) {
        final Map<String, dynamic> responseData = response.data;

         details = AssetFormModel.fromJson(responseData);
        if (details.items?.assetDetails != null) {
          return details;
        } else {
          // throw Exception("Asset details not found in the response.");
          print('Asset details not found in the response.');
          // return details;
          return details;
        }
      }

    }
    catch (e) {
      if (e is DioException && e.response?.statusCode == 404) {
        // throw Exception("Resource not found. statusCode == 404", );
        print('Resource not found. statusCode == 404');
      }
      print("Error fetching Asset Details: $e");
      // throw Exception("An error occurred: ${e.toString()}");
      print('details:: ${details.items?.assetDetails}');
      return details;
    }
  }
}
