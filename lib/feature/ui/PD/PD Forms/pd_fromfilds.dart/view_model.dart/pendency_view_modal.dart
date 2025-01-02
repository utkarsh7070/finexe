import 'package:dio/dio.dart';
import 'package:finexe/feature/base/api/api.dart';
import 'package:finexe/feature/base/service/session_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../../base/api/dio_exception.dart';
import '../model/Submit Data Models/pendency_reject_modal.dart';
import 'package:finexe/feature/base/utils/general/pref_utils.dart';


final dioProvider = Provider((ref) => Dio());

final pendencyApiServiceProvider =
    Provider((ref) => PendencyApiService(ref.watch(dioProvider)));

final postPendencyDetailsProvider = FutureProvider.autoDispose
    .family<Response, PendencyDetailsFormModel>((ref, model) async {
  final apiService = ref.watch(pendencyApiServiceProvider);
  return await apiService.postPendencyDetails(model);
});

class PendencyApiService {
  final Dio _dio;

  PendencyApiService(this._dio);

  Future<Response> postPendencyDetails(PendencyDetailsFormModel model) async {
    final token = speciality.getToken();

    try {
      // Perform the POST request
      final response = await _dio.post(
        Api.updatePdReport,
        data: model.toJson(),
        options: Options(headers: {"token": token}),
      );

      print('Response model: ${model}');

      if (response.statusCode == 200) {

        return response; // Return response if successful
      } else {
        // Return a custom error response if status code is not 200
        return Response(
          requestOptions: RequestOptions(path: Api.updatePdReport),
          statusCode: response.statusCode,
          statusMessage: 'Error while submitting income details',
        );
      }
    }
    catch (e) {
      // Handle the error and return a default Response object
      print('Error: $e');
      return Response(
        requestOptions: RequestOptions(path: Api.updatePdReport),
        statusCode: 500, // Internal server error
        statusMessage: e.toString(), // Send the error message
      );
    }
  }
}

// -------------- get api
// Define the provider for PendencyApiService

// FutureProvider for the GET request to fetch PendencyDetails
final pendencyApiServiceGetProvider =
    Provider((ref) => PendencyApiServiceGet(ref.watch(dioProvider)));

// FutureProvider for the GET request to fetch PendencyDetails
final getPendencyDetailsProvider = FutureProvider.autoDispose
    .family<PendencyDetailsFormModel?, String>((ref, customerId) async {
  final apiService = ref.watch(pendencyApiServiceGetProvider);
  return await apiService.getPendencyDetails(customerId);
});

class PendencyApiServiceGet {
  final Dio _dio;

  PendencyApiServiceGet(this._dio);

  Future<PendencyDetailsFormModel?> getPendencyDetails(String customerId) async {
    final token = speciality.getToken();
    PendencyDetailsFormModel pendencyDetails = PendencyDetailsFormModel();
    try {
      final response = await _dio.get(
        '${Api.getpdformdata}$customerId',
        options: Options(headers: {"token": token}),
      );

      if (response.statusCode == 200 && response.data != null) {
        print('Response---: ${response.data['items']}');
         pendencyDetails =
            PendencyDetailsFormModel.fromJson(response.data['items']);
        return pendencyDetails;
      }
      // else {
      //   throw Exception(
      //     "Failed to load loan data. Status code: ${response.statusCode}",
      //   );
      // }
    } catch (e) {
      print("Error fetching loan details: $e");
      // throw Exception("Error fetching loan details: $e");
      return pendencyDetails;
    }
  }
}


//***********************************************Calling-Reject-Form**********************

class RejectPDForm extends StateNotifier<ApplicationState> {
  final Dio dio;

  RejectPDForm(this.dio) : super(ApplicationState());

  // Future<bool> rejectPDFormRequest({
  //   required String customerId,
  //   required String pdType,
  //   required List<AssetDetails> assetDetailList,
  //   required double totalMarketV,
  //   required double totalPurchaseV,
  // }) async {
  //
  //   state = state.copyWith(isLoading: true);
  //   // if(state.isLoading==true){
  //   //   print('click second time');
  //   //   return false;
  //   // }
  //   // Add customerId and pdType to the payload
  //   final payload = {
  //     'assetDetails': assetDetailList.toList(),
  //     'customerId': customerId,
  //     'pdType': pdType,
  //     "total": {
  //       "totalPurchaseValue": totalMarketV,
  //       "totalMarketValue": totalPurchaseV
  //     },
  //   };
  //
  //   String? token = speciality.getToken();
  //   // String? token =
  //   //     "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJJZCI6IjY3MGY1NjFhZTc2NjMwMjQ0ZGVhNDU1YyIsInJvbGVOYW1lIjoiaW50ZXJuYWxWZW5kb3JBbmRjcmVkaXRQZCIsImlhdCI6MTczMDk1NzUzOH0.p_57wid1GuLPusS29IwyAfQnKR5qfpdDc4CoU2la-qY";
  //   try {
  //     final response = await dio.post(Api.revertByVendor,
  //         data: payload, options: Options(headers: {"token": token}));
  //     print(token);
  //     print(payload);
  //     print(response.data);
  //     print('Payload: ${payload}');
  //
  //     if (response.statusCode == 200) {
  //       // AssetDetails assetDetails =
  //       //     AssetDetails.fromJson(response.data['items']['assetDetails']);
  //       final List<dynamic> assets = response.data['items']['assetDetails'];
  //       final List<AssetDetails> assetDetails =
  //       assets.map((e) => AssetDetails.fromJson(e)).toList();
  //       print('assetDetails form submitted: ${assetDetails.length}');
  //
  //       state = state.copyWith(isLoading: false);
  //       return true;
  //     } else {
  //       state = state.copyWith(isLoading: false);
  //       print('Error while submitting applicant form');
  //       return false;
  //     }
  //   } catch (e) {
  //     state = state.copyWith(isLoading: false);
  //     print('Exception: $e');
  //     // throw Exception(e);
  //     return false;
  //   }
  // }

  Future<bool?> rejectPDFormRequest(String id, String rijectReason, String uploadRejectPhotoUrl,BuildContext context, String remarkbypd) async {
    try {
      print('Request ID: $id');

      SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
      String? token = sharedPreferences.getString('token');
      print('Token: $token');

      if (token == null || token.isEmpty) {
        print('Error: Missing token');
        return false;
      }

      final queryParam = {
        'customerId': id,
        'status': 'reject',
        'rejectPhoto': uploadRejectPhotoUrl, // Upload from camera
        'reasonForReject': rijectReason, // Reason for rejection
        'remarkByPd': remarkbypd,
      };
      print('Query Parameters: $queryParam');

      final response = await dio.post(
        Api.revertByVendor,
        queryParameters: queryParam,
        options: Options(headers: {"token": token}),
      );

      print('Revert API URL: ${Api.revertByVendor}');
      print('Response Status Code: ${response.statusCode}');
      print('Response Data: ${response.data}');

      if (response.statusCode == 200) {
        return true;
      } else {
        // Log and handle error message from the API
        final errorMessage = response.data['message'] ?? 'An unknown error occurred';
        print('Error Message from API: $errorMessage');
        return false;
      }
    } catch (e) {
      // Log the exception details
      print('Exception occurred during API call: $e');
      DioExceptions.fromDioError(e as DioException, context);
      return false;

    }


  }



}

final pdRejectVModelProvider =
StateNotifierProvider<RejectPDForm, ApplicationState>((ref) {
  final dio = ref.read(dioProvider);
  return RejectPDForm(dio);
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
