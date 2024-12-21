import 'package:dio/dio.dart';
import 'package:finexe/feature/base/api/api.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../../../../base/api/dio.dart';
import '../../../../../../../base/service/session_service.dart';
import '../model/Submit Data Models/pendency_reject_modal.dart';


final dioProvider = Provider((ref) => Dio());

final pendencyApiServiceProvider = Provider((ref) => PendencyApiService(ref.watch(dioProvider)));

final postPendencyDetailsProvider = FutureProvider.autoDispose.family<Response, PendencyDetailsFormModel>((ref, model) async {
  final apiService = ref.watch(pendencyApiServiceProvider);
  return await apiService.postPendencyDetails(model);
});

class PendencyApiService {
  final Dio _dio;

  PendencyApiService(this._dio);

  Future<Response> postPendencyDetails(PendencyDetailsFormModel model) async {
    final token = await SessionService.getToken();

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
    } catch (e) {
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
final pendencyApiServiceGetProvider = Provider((ref) => PendencyApiServiceGet(ref.watch(dioProvider)));

// FutureProvider for the GET request to fetch PendencyDetails
final getPendencyDetailsProvider = FutureProvider.autoDispose.family<PendencyDetailsFormModel, String>((ref, customerId) async {
  final apiService = ref.watch(pendencyApiServiceGetProvider);
  return await apiService.getPendencyDetails(customerId);
});


class PendencyApiServiceGet {
  final Dio _dio;

  PendencyApiServiceGet(this._dio);

  Future<PendencyDetailsFormModel> getPendencyDetails(String customerId) async {
    final token = await SessionService.getToken();

    try {
      final response = await _dio.get(
        '${Api.getpdformdata}66f53ffbd7011eb65160f292',
        options: Options(headers: {"token": token}),
      );


      if (response.statusCode == 200 && response.data != null) {
        print('Response---: ${response.data['items']}');
        final pendencyDetails = PendencyDetailsFormModel.fromJson(response.data['items']);
        return pendencyDetails;
      }else {
        throw Exception(
          "Failed to load loan data. Status code: ${response.statusCode}",
        );
      }
    } catch (e) {
      print("Error fetching loan details: $e");
      throw Exception("Error fetching loan details: $e");
    }
    }
  }




