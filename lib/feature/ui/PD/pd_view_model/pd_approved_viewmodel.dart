import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../base/api/api.dart';
import '../../../base/api/dio.dart';
import '../Model/pd_approved_response_model.dart';

class PdApproved {
  final String id;

  final String imageUrl;
  final String name;
  final String address;
  final String? date;

  PdApproved(
      {required this.id,
      required this.imageUrl,
      required this.name,
      required this.address,
      this.date});
}

final pdrejectViewModel = Provider<List<PdApproved>>((ref) {
  return [
    PdApproved(
      date: '12/10/2024',
      id: 'LOCAI1007',
      imageUrl:
          'https://easy-peasy.ai/cdn-cgi/image/quality=80,format=auto,width=700/https://fdczvxmwwjwpwbeeqcth.supabase.co/storage/v1/object/public/images/50dab922-5d48-4c6b-8725-7fd0755d9334/3a3f2d35-8167-4708-9ef0-bdaa980989f9.png',
      name: 'Ajay Pal S/O Ramprasad ',
      address: 'Gram Panali Panali Rajgarh Madhya Pradesh 465683',
    ),
    PdApproved(
      date: null,
      id: 'LOCAI1007',
      imageUrl:
          'https://easy-peasy.ai/cdn-cgi/image/quality=80,format=auto,width=700/https://fdczvxmwwjwpwbeeqcth.supabase.co/storage/v1/object/public/images/50dab922-5d48-4c6b-8725-7fd0755d9334/3a3f2d35-8167-4708-9ef0-bdaa980989f9.png',
      name: 'Ajay Pal S/O Ramprasad ',
      address: 'Gram Panali Panali Rajgarh Madhya Pradesh 465683',
    ),
    PdApproved(
      date: '10/10/2024',
      id: 'LOCAI1007',
      imageUrl:
          'https://easy-peasy.ai/cdn-cgi/image/quality=80,format=auto,width=700/https://fdczvxmwwjwpwbeeqcth.supabase.co/storage/v1/object/public/images/50dab922-5d48-4c6b-8725-7fd0755d9334/3a3f2d35-8167-4708-9ef0-bdaa980989f9.png',
      name: 'Ajay Pal S/O Ramprasad ',
      address: 'Gram Panali Panali Rajgarh Madhya Pradesh 465683',
    ),
    PdApproved(
      date: null,
      id: 'LOCAI1007',
      imageUrl:
          'https://easy-peasy.ai/cdn-cgi/image/quality=80,format=auto,width=700/https://fdczvxmwwjwpwbeeqcth.supabase.co/storage/v1/object/public/images/50dab922-5d48-4c6b-8725-7fd0755d9334/3a3f2d35-8167-4708-9ef0-bdaa980989f9.png',
      name: 'Ajay Pal S/O Ramprasad ',
      address: 'Gram Panali Panali Rajgarh Madhya Pradesh 465683',
    ),
    PdApproved(
      date: '08/10/2024',
      id: 'LOCAI1007',
      imageUrl:
          'https://easy-peasy.ai/cdn-cgi/image/quality=80,format=auto,width=700/https://fdczvxmwwjwpwbeeqcth.supabase.co/storage/v1/object/public/images/50dab922-5d48-4c6b-8725-7fd0755d9334/3a3f2d35-8167-4708-9ef0-bdaa980989f9.png',
      name: 'Ajay Pal S/O Ramprasad ',
      address: 'Gram Panali Panali Rajgarh Madhya Pradesh 465683',
    ),
    // Add more items as needed
  ];
});

final currentPageApprovedProvider = StateProvider<int>((ref) => 1);

final paginatedApprovedDataProvider = FutureProvider.autoDispose
    .family<List<Item>, int>((ref, page) async {
  final apiService = ref.read(apiPdPApprovedProvider);
  // final page = ref.watch(currentPageApprovedProvider);
  const int limit = 10;
  const String status = 'RePd';
  final response = await apiService.fetchData(
    status: status,
    page: page,
    limit: limit,
    searchQuery: '',
  );
  return response ?? [];
});

final apiPdPApprovedProvider = Provider<ApiApprovedService>((ref) {
  final dio = ref.watch(dioProvider);
  return ApiApprovedService(dio);
});

class ApiApprovedService {
  final Dio _dio;

  ApiApprovedService(this._dio);

  Future<List<Item>?> fetchData({
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
        Api.pdAssign,
        options: Options(headers: {'token': token}),
        queryParameters: {
          'status': status,
          'page': page,
          'limit': limit,
          'searchQuery': searchQuery,
        },
      );
      PdApprovedResponseModel responseModel =
          PdApprovedResponseModel.fromJson(response.data);
      print(response.data);

      if (response.statusCode == 200) {
        return responseModel.items?.items??[];
      } else {
        throw Exception(
            'Failed to load data with status code: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error fetching data: $e');
    }
  }
}
