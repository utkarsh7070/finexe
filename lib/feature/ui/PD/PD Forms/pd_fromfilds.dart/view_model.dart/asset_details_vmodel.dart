import 'package:dio/dio.dart';
import 'package:finexe/feature/base/api/api.dart';
import 'package:finexe/feature/base/api/dio.dart';
import 'package:finexe/feature/base/utils/general/pref_utils.dart';
import 'package:finexe/feature/ui/PD/PD%20Forms/pd_fromfilds.dart/model/Submit%20Data%20Models/asset_detail_model.dart';
// import 'package:finexe/feature/ui/PD/view/PD%20Form/pd_fromfilds.dart/model/Submit%20Data%20Models/asset_detail_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PDAssetDetails extends StateNotifier<ApplicationState> {
  final Dio dio;

  PDAssetDetails(this.dio) : super(ApplicationState());

  Future<bool> submitpdAssetDetailsForm({
    required String customerId,
    required String pdType,
    required List<AssetDetails> assetDetailList,
    required double totalMarketV,
    required double totalPurchaseV,
  }) async {
    state = state.copyWith(isLoading: true);

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
      print('Payload: $payload');

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
    } catch (e) {
      state = state.copyWith(isLoading: false);
      print('Exception: $e');
      // throw Exception(e);
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
    FutureProvider.autoDispose.family<AssetFormModel,String>((ref,customerId) async {
  final viewModel = AssetFormDetailProvider();
  return await viewModel.fetchAssetDetails(customerId);
});


class AssetFormDetailProvider {
  final Dio _dio = Dio();

  Future<AssetFormModel> fetchAssetDetails(String customerId) async {
    String? token = speciality.getToken();

    // String? token =
    //     "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJJZCI6IjY3MGY1NjFhZTc2NjMwMjQ0ZGVhNDU1YyIsInJvbGVOYW1lIjoiaW50ZXJuYWxWZW5kb3JBbmRjcmVkaXRQZCIsImlhdCI6MTczMDk1NzUzOH0.p_57wid1GuLPusS29IwyAfQnKR5qfpdDc4CoU2la-qY"; // Replace with a secure way of managing tokens
    print('url: ${Api.getpdformdata}66f53ffbd7011eb65160f292');

    try {
      final response = await _dio.get(
        '${Api.getpdformdata}$customerId',
        options: Options(headers: {"token": token}),
      );

      if (response.statusCode == 200 && response.data != null) {
        final Map<String, dynamic> responseData = response.data;

        // Parse the response into the GetApplicantDetailsModel
        final details = AssetFormModel.fromJson(responseData);

        if (details.items?.assetDetails != null) {
          // print('');
          return details;
        } else {
          throw Exception("PDAssetDetails not found in the response");
        }
      } else {
        throw Exception(
            "Failed to load PDAssetDetails data: ${response.statusCode}");
      }
    } catch (e) {
      print("Error fetching PDAssetDetails : $e");
      throw Exception("Error fetching PDAssetDetails data: $e");
    }
  }
}
