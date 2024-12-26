import 'package:dio/dio.dart';
import 'package:finexe/feature/ui/PD/Model/pd_pending_response_model.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../base/api/api.dart';
import '../../../base/api/dio.dart';
import '../Model/pd_reject_response_model.dart';

// class PdReject {
//   final String id;
//   final String imageUrl;
//   final String name;
//   final String address;
//   final String? date;
//
//   PdReject(
//       {required this.id,
//       required this.imageUrl,
//       required this.name,
//       required this.address,
//       this.date});
// }
//
// final pdrejectViewModel = Provider<List<PdReject>>((ref) {
//   return [
//     PdReject(
//       date: '12/10/2024',
//       id: 'LOCAI1007',
//       imageUrl:
//           'https://easy-peasy.ai/cdn-cgi/image/quality=80,format=auto,width=700/https://fdczvxmwwjwpwbeeqcth.supabase.co/storage/v1/object/public/images/50dab922-5d48-4c6b-8725-7fd0755d9334/3a3f2d35-8167-4708-9ef0-bdaa980989f9.png',
//       name: 'Ajay Pal S/O Ramprasad ',
//       address: 'Gram Panali Panali Rajgarh Madhya Pradesh 465683',
//     ),
//     PdReject(
//       date: null,
//       id: 'LOCAI1007',
//       imageUrl:
//           'https://easy-peasy.ai/cdn-cgi/image/quality=80,format=auto,width=700/https://fdczvxmwwjwpwbeeqcth.supabase.co/storage/v1/object/public/images/50dab922-5d48-4c6b-8725-7fd0755d9334/3a3f2d35-8167-4708-9ef0-bdaa980989f9.png',
//       name: 'Ajay Pal S/O Ramprasad ',
//       address: 'Gram Panali Panali Rajgarh Madhya Pradesh 465683',
//     ),
//     PdReject(
//       date: '10/10/2024',
//       id: 'LOCAI1007',
//       imageUrl:
//           'https://easy-peasy.ai/cdn-cgi/image/quality=80,format=auto,width=700/https://fdczvxmwwjwpwbeeqcth.supabase.co/storage/v1/object/public/images/50dab922-5d48-4c6b-8725-7fd0755d9334/3a3f2d35-8167-4708-9ef0-bdaa980989f9.png',
//       name: 'Ajay Pal S/O Ramprasad ',
//       address: 'Gram Panali Panali Rajgarh Madhya Pradesh 465683',
//     ),
//     PdReject(
//       date: null,
//       id: 'LOCAI1007',
//       imageUrl:
//           'https://easy-peasy.ai/cdn-cgi/image/quality=80,format=auto,width=700/https://fdczvxmwwjwpwbeeqcth.supabase.co/storage/v1/object/public/images/50dab922-5d48-4c6b-8725-7fd0755d9334/3a3f2d35-8167-4708-9ef0-bdaa980989f9.png',
//       name: 'Ajay Pal S/O Ramprasad ',
//       address: 'Gram Panali Panali Rajgarh Madhya Pradesh 465683',
//     ),
//     PdReject(
//       date: '08/10/2024',
//       id: 'LOCAI1007',
//       imageUrl:
//           'https://easy-peasy.ai/cdn-cgi/image/quality=80,format=auto,width=700/https://fdczvxmwwjwpwbeeqcth.supabase.co/storage/v1/object/public/images/50dab922-5d48-4c6b-8725-7fd0755d9334/3a3f2d35-8167-4708-9ef0-bdaa980989f9.png',
//       name: 'Ajay Pal S/O Ramprasad ',
//       address: 'Gram Panali Panali Rajgarh Madhya Pradesh 465683',
//     ),
//     // Add more items as needed
//   ];
// });

final currentRejectPageProvider = StateProvider<int>((ref) => 1);
//change return type
final paginatedRejectDataProvider =
    FutureProvider.autoDispose.family<List<RejectItem>, int>((ref, page) async {
  final apiService = ref.read(apiPdRejectProvider);
  // final page = ref.watch(currentPageProvider);
  const int limit = 10;
  const String status = 'approveByReject';
  final response = await apiService.fetchData(
    status: status,
    page: page,
    limit: limit,
    searchQuery: '',
  );
  return response ?? [];
});

final apiPdRejectProvider = Provider<ApiService>((ref) {
  final dio = ref.watch(dioProvider);
  return ApiService();
});

class ApiService {
  final Dio _dio = Dio();

  ApiService();

  Future<List<RejectItem>> fetchData({
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
      PdRejectResponseModel responseModel =
          PdRejectResponseModel.fromJson(response.data);
      print(response.data);

      if (response.statusCode == 200) {
        return responseModel.items;
      } else {
        throw Exception(
            'Failed to load data with status code: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error fetching data: $e');
    }
  }
}


final pdRejectStateProvider = StateNotifierProvider<PdRejectViewModel,PdDashBoardData>((ref) {
  return PdRejectViewModel();
},);

class PdRejectViewModel extends StateNotifier<PdDashBoardData> {
  PdRejectViewModel() : super(PdDashBoardData());

}

class PdDashBoardData {
  final List<RejectItem> rejectList;

  PdDashBoardData({this.rejectList = const []});

  PdDashBoardData copyWith({
    List<RejectItem>? rejectList,
  }) {
   return PdDashBoardData(rejectList: rejectList??this.rejectList);
  }
}
