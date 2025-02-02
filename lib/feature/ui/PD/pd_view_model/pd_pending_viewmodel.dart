import 'package:dio/dio.dart';
import 'package:finexe/feature/base/api/api.dart';
import 'package:finexe/feature/base/api/dio.dart';
import 'package:finexe/feature/base/utils/general/pref_utils.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../Model/pd_pending_response_model.dart';

class Applicant {
  final String name;
  final String id;
  final String address;
  final String imageUrl;
  final String? date;

  Applicant({
    this.date,
    required this.name,
    required this.id,
    required this.address,
    required this.imageUrl,
  });
}

final applicantProvider = Provider<List<Applicant>>((ref) {
  return [
    Applicant(
      date: '07/10/2024',
      name: 'Ajay Pal',
      id: 'LOCAI1007',
      address: 'Gram Panali Panali Rajgarh Madhya Pradesh 465683',
      imageUrl:
          'https://easy-peasy.ai/cdn-cgi/image/quality=80,format=auto,width=700/https://fdczvxmwwjwpwbeeqcth.supabase.co/storage/v1/object/public/images/50dab922-5d48-4c6b-8725-7fd0755d9334/3a3f2d35-8167-4708-9ef0-bdaa980989f9.png',
    ),
    Applicant(
      date: null,
      // No date for this applicant
      name: 'Mohit Verma',
      id: 'LOCAI1008',
      address: 'Gram Panali Panali Rajgarh Madhya Pradesh 465683',
      imageUrl:
          'https://easy-peasy.ai/cdn-cgi/image/quality=80,format=auto,width=700/https://fdczvxmwwjwpwbeeqcth.supabase.co/storage/v1/object/public/images/50dab922-5d48-4c6b-8725-7fd0755d9334/3a3f2d35-8167-4708-9ef0-bdaa980989f9.png',
    ),
    Applicant(
      date: '08/10/2024',
      name: 'Utkarsh',
      id: 'LOCAI1009',
      address: 'Gram Panali Panali Rajgarh Madhya Pradesh 465683',
      imageUrl:
          'https://easy-peasy.ai/cdn-cgi/image/quality=80,format=auto,width=700/https://fdczvxmwwjwpwbeeqcth.supabase.co/storage/v1/object/public/images/50dab922-5d48-4c6b-8725-7fd0755d9334/3a3f2d35-8167-4708-9ef0-bdaa980989f9.png',
    ),
    Applicant(
      date: null,
      // Another entry with no date
      name: 'Manish Patidar',
      id: 'LOCAI1010',
      address: 'Gram Panali Panali Rajgarh Madhya Pradesh 465683',
      imageUrl:
          'https://easy-peasy.ai/cdn-cgi/image/quality=80,format=auto,width=700/https://fdczvxmwwjwpwbeeqcth.supabase.co/storage/v1/object/public/images/50dab922-5d48-4c6b-8725-7fd0755d9334/3a3f2d35-8167-4708-9ef0-bdaa980989f9.png',
    ),
    Applicant(
      date: '09/10/2024',
      name: 'Akshay Kumar',
      id: 'LOCAI1011',
      address: 'Gram Panali Panali Rajgarh Madhya Pradesh 465683',
      imageUrl:
          'https://easy-peasy.ai/cdn-cgi/image/quality=80,format=auto,width=700/https://fdczvxmwwjwpwbeeqcth.supabase.co/storage/v1/object/public/images/50dab922-5d48-4c6b-8725-7fd0755d9334/3a3f2d35-8167-4708-9ef0-bdaa980989f9.png',
    ),
    // Add more applicants as needed
  ];
});

// final pdPendingList = FutureProvider((ref) {
//   SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
//   String? token = sharedPreferences.getString('token');
//   final queryParam = {'_id': id, 'status': 'reject'};
//   final response = await dio.post(Api.revertByVendor,
//       queryParameters: queryParam,
//       options: Options(headers: {"token": token}));
//   if (kDebugMode) {
//     print(response.data);
//   }
//   if (response.statusCode == 200) {
//     return true;
//   }
//   return false;
// }
// },);
// `complete`, `RePd` , `WIP` ,`allCases`

// final currentPageProvider = StateProvider<int>((ref) => 1);
// updated>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
final searchingitems = StateProvider<List<Item>>( (ref) {
  return [];
},);

// update search items 
void searchupdate(ref, String searchterm, List<Item> listOfLists) {
  final filteredResults = listOfLists.where((item) {
    return item.customerName != null &&
        (item.customerName!.toLowerCase().contains(searchterm.toLowerCase())
            // item.ld!.toLowerCase().contains(searchterm.toLowerCase())
            );
  }).toList();

  ref
      .read(searchingitems.notifier)
      .state = filteredResults;
}


final paginatedDataProvider =
    FutureProvider.autoDispose.family<List<Item>, int>((ref, page) async {
  final apiService = ref.read(apiPdPendingProvider);
  // final page = ref.watch(currentPageProvider);
  const int limit = 10;
  const String status = 'WIP';
  final response = await apiService.fetchData(
    status: status,
    page: page,
    limit: limit,
    searchQuery: '',
  );

  ref.read(searchingitems.notifier).state.addAll(response) ;

  return response ?? [];
});


final apiPdPendingProvider = Provider<ApiService>((ref) {
  final dio = ref.watch(dioProvider);
  return ApiService();
});

class ApiService {
  final Dio _dio = Dio();

  ApiService();

  Future<List<Item>> fetchData({
    required String status,
    required int page,
    required int limit,
    String searchQuery = '',
  }) async {
    String? token = speciality.getToken();
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
      PdPendingResponseModel responseModel =
          PdPendingResponseModel.fromJson(response.data);
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


