

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../base/api/api.dart';
import '../../../base/api/dio.dart';
import '../Model/pd_complete_response_model.dart';


class PdReject {
  final String id;

  final String imageUrl;
  final String name;
  final String address;
  final String? date;

  PdReject(
      {required this.id,
        required this.imageUrl,
        required this.name,
        required this.address,
        this.date});
}

final currentCompletedPageProvider = StateProvider<int>((ref) => 1);
//change return type
final paginatedCompletedDataProvider = FutureProvider.autoDispose.family<List<CompleteItem>, int>((ref,page) async {
  final apiService = ref.read(apiPdCompletedProvider);
  // final page = ref.watch(currentPageProvider);
  const int limit = 10;
  const String status = 'complete';
  final response = await apiService.fetchData(
    status: status,
    page: page,
    limit: limit,
    searchQuery: '',
  );
  return response?? [];
});


final apiPdCompletedProvider = Provider<ApiService>((ref) {
  final dio= ref.watch(dioProvider);
  return ApiService();
});


class ApiService {
  final Dio _dio = Dio();

  ApiService();

  Future<List<CompleteItem>> fetchData({
    required String status,
    required int page,
    required int limit,
    String searchQuery = '',
  }) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String? token = sharedPreferences.getString('token');
    if (kDebugMode) {
      print(token);
      print('$status  $page   $limit  $searchQuery');
    }

    try {
      final response = await _dio.get(
        Api.pdAssign,options: Options(headers: {'token':token}),
        queryParameters: {
          'status': status,
          'page': page,
          'limit': limit,
          'searchQuery': searchQuery,
        },
      );
      PdCompleteResponseModel responseModel = PdCompleteResponseModel.fromJson(response.data);
      print(response.data);

      if (response.statusCode == 200) {
        return responseModel.items;
      } else {
        throw Exception('Failed to load data with status code: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error fetching data: $e');
    }
  }
}