import 'package:dio/dio.dart';
import 'package:dropdown_textfield/dropdown_textfield.dart';
import 'package:finexe/feature/base/api/api.dart';
import 'package:finexe/feature/base/api/dio.dart';
import 'package:finexe/feature/base/utils/general/pref_utils.dart';
import 'package:finexe/feature/ui/PD/Model/pd_request_list_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../base/api/dio_exception.dart';

class ArgumentModel {
  final int page;
  final String branchId;
  final int currentPage;
  final int pageSize;
  final String filter;

  ArgumentModel({
    required this.page,
    required this.branchId,
    required this.currentPage,
    required this.pageSize,
    required this.filter,
  });
}

final fetchpdRefuseandAcceptListProvider =
    FutureProvider.autoDispose.family<List<PDReqItems>, ArgumentModel>((
  ref,
  list,
) async {
  String? token = speciality.getToken();
  final Map<String, dynamic> queryParam = {
    "status": "allCases",
    'page': list.page,
    'limit': 10,
    "searchQuery": "",
    'branchId': list.branchId
  };
  final dio = ref.read(dioProvider);
  print('Api.getReqRefP:: ${Api.getReqRefP}');
  print('token:: $token');

  final response = await dio.get(Api.getReqRefP,
      queryParameters: queryParam, options: Options(headers: {"token": token}));
  print(response.statusMessage);
  print(response.statusCode);
  if (response.statusCode == 200) {
    print(response.data);
    List<dynamic> responseList = response.data['items']['items'] ?? [];

    // Map the list of dynamic objects to List<PDReqItems>
    List<PDReqItems> apiResponseList =
        responseList.map((item) => PDReqItems.fromJson(item)).toList();
    print('PDReqItems ${apiResponseList.length}');
    // ref.read(dataList.notifier).state = apiResponseList;
    return apiResponseList;
  } else {
    throw Exception('Failed to load data');
  }
});

// final acceptpdrequestProvider =
//     FutureProvider.autoDispose<List<PDReqItems>>((ref) async {
//   SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
//   String? token = sharedPreferences.getString('token');
//   // final String token =
//   //     "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJJZCI6IjY2ODUwZjdkMzc0NDI1ZTkzNzExNDE4MCIsInJvbGVOYW1lIjoiYWRtaW4iLCJpYXQiOjE3MjY3Mzc2Njd9.exsdAWj9fWc5LiOcAkFmlgade-POlU8orE8xvgfYXZU";
//   final Map<String, String> queryParam = {
//     "status": "allCases",
//     "searchQuery": ""
//   };
//   final dio = ref.read(dioProvider);
//   print('Api.getReqRefP:: ${Api.getReqRefP}');
//   print('token:: $token');
//
//   final response = await dio.get(Api.getReqRefP,
//       queryParameters: queryParam, options: Options(headers: {"token": token}));
//   print(response.statusMessage);
//   print(response.statusCode);
//   if (response.statusCode == 200) {
//     print(response.data);
//     List<dynamic> responseList = response.data['items'] ?? [];
//
//     // Map the list of dynamic objects to List<PDReqItems>
//     List<PDReqItems> apiResponseList =
//         responseList.map((item) => PDReqItems.fromJson(item)).toList();
//     print('PDReqItems ${apiResponseList.length}');
//     return apiResponseList;
//   } else {
//     throw Exception('Failed to load data');
//   }
// });

//*******************************Refuse and Reject

final mapProvider = StateProvider<Map<String, String>>((ref) => {});
const dropdownOptions = [
  DropDownValueModel(
      name: 'Indore Head Office', value: '6711061af2b907b03fe37dd0'),
  DropDownValueModel(name: 'PACHORE', value: '67110738f2b907b03fe37e19'),
  DropDownValueModel(name: 'BHOPAL', value: '67110790f2b907b03fe37e25'),
  DropDownValueModel(name: 'DHAMNOD', value: '671109d9f2b907b03fe37e78'),
  DropDownValueModel(name: 'JAORA', value: '67110a2bf2b907b03fe37e8c'),
  DropDownValueModel(name: 'GUJARAT', value: '67110a6df2b907b03fe37ea3'),
  DropDownValueModel(name: 'BIAORA', value: '67110d3d85cc2517ea2c196d'),
  DropDownValueModel(name: 'MULTAI', value: '67110eaf85cc2517ea2c19ce'),
  DropDownValueModel(name: 'SHAMGRH', value: '67110f2485cc2517ea2c19f7'),
  DropDownValueModel(name: 'MANASA', value: '67110f8c85cc2517ea2c1a13'),
  DropDownValueModel(name: 'MANDSAUR', value: '6711101585cc2517ea2c1a1f'),
  DropDownValueModel(name: 'NARMDAPURAM', value: '6711105085cc2517ea2c1a2b'),
  DropDownValueModel(name: 'DEWAS', value: '6711115885cc2517ea2c1a5a'),
  DropDownValueModel(name: 'DEPALPUR', value: '671111ff85cc2517ea2c1a5f'),
  DropDownValueModel(name: 'BETUL', value: '6711123485cc2517ea2c1a66'),
  DropDownValueModel(name: 'NAGDA', value: '6711127685cc2517ea2c1a6b'),
  DropDownValueModel(name: 'KHILCHIPUR', value: '672b4a0a5c59f87ed5151fda'),
  DropDownValueModel(name: 'JHALAWAD', value: '672cb0520f700f8851ff2d68'),
  DropDownValueModel(name: 'ZEERAPUR', value: '6731da1bc5018ff31237f750'),
  DropDownValueModel(name: 'AHEMDABAD', value: '673ef4ef1c600b445add496a'),
  DropDownValueModel(name: 'Mehsana', value: '6748521025c99f03a0123379'),
];

final pdRequestProvider = Provider<RequestApiService>((ref) {
  final dio = ref.watch(dioProvider);
  return RequestApiService(dio);
});

class RequestApiService {
  final Dio dio;

  RequestApiService(this.dio);

  Future<bool?> pdRequestAccept(String id, BuildContext context) async {
    try {
      if (kDebugMode) {
        print(id);
      }

      String? token = speciality.getToken();

      if (token == null) {
        if (kDebugMode) {
          print("Token is null. Unable to proceed with the request.");
        }
        return false;
      }

      final queryParam = {'_id': id, 'status': 'accept'};
      print(queryParam.toString());
      final response = await dio.post(
        Api.revertByVendor,
        queryParameters: queryParam,
        options: Options(headers: {"token": token}),
      );

      if (kDebugMode) {
        print('pdRequestAccept: ${response.data}');
      }

      if (response.statusCode == 200) {
        return true;
      }
    } catch (e) {
      if (e is DioException) {
        DioExceptions.fromDioError(e, context);
      } else {
        if (kDebugMode) {
          print("An unexpected error occurred: $e");
        }
      }
      return false;
    }
    return null;
  }

  Future<List<PDReqItems>> pdRequestItem(ArgumentModel list) async {
    String? token = speciality.getToken();
    final Map<String, dynamic> queryParam = {
      "status": "allCases",
      'page': list.page,
      'limit': 10,
      "searchQuery": "",
      'branchId': list.branchId
    };
    print('Api.getReqRefP:: ${Api.getReqRefP}');
    print('token:: $token');

    final response = await dio.get(Api.getReqRefP,
        queryParameters: queryParam,
        options: Options(headers: {"token": token}));
    print(response.statusMessage);
    print(response.statusCode);
    if (response.statusCode == 200) {
      print(response.data);
      List<dynamic> responseList = response.data['items']['items'] ?? [];

      // Map the list of dynamic objects to List<PDReqItems>
      List<PDReqItems> apiResponseList =
          responseList.map((item) => PDReqItems.fromJson(item)).toList();
      print('PDReqItems ${apiResponseList.length}');
      // ref.read(dataList.notifier).state = apiResponseList;
      return apiResponseList;
    }
    return [];
  }

  //Revert Api
  Future<bool?> pdRequestRevert(
      String id, String rivertReason, BuildContext context) async {
    try {
      if (kDebugMode) {
        print('Request ID: $id');
      }
      String? token = speciality.getToken();

      final queryParam = {
        '_id': id,
        'status': 'rivert',
        'remark': rivertReason, //reason of rejectectoin
      };
      print('queryParam ${queryParam.values}');
      final response = await dio.post(
        Api.revertByVendor,
        queryParameters: queryParam,
        options: Options(headers: {"token": token}),
      );
      print('revert api :: ${Api.revertByVendor}');
      if (kDebugMode) {
        print('Response Data: ${response.data}');
      }

      if (response.statusCode == 200) {
        // print('object')
        return true;
      } else {
        // Handle and log error messages from the API response
        final errorMessage =
            response.data['message'] ?? 'An unknown error occurred';
        print('Error Message from API: $errorMessage');

        // Optionally, you can show this message in the UI using a dialog/snackbar
        return false;
      }
    } catch (e) {
      // Handle any other exceptions
      print('revert api :: ${Api.revertByVendor}');

      print('Exception: $e');
      DioExceptions.fromDioError(e as DioException, context);
    }

    return false;
  }
}

final itemViewModelProvider =
    StateNotifierProvider<ItemViewModel, AsyncValue<List<PDReqItems>>>((ref) {
  final dio = ref.watch(dioProvider);
  return ItemViewModel(dio);
});

class ItemViewModel extends StateNotifier<AsyncValue<List<PDReqItems>>> {
  ItemViewModel(this.dio) : super(const AsyncValue.loading());
  final Dio dio;
  final SingleValueDropDownController creditPersonController =
  SingleValueDropDownController();
  int _currentPage = 1;
  String? _currentFilter;
  bool _hasMore = true;

  List<PDReqItems> _items = [];

  List<PDReqItems> get items => _items;

  bool get hasMore => _hasMore;

  Future<void> fetchItems({String? filter, bool reset = false}) async {
    final RequestApiService _repository = RequestApiService(dio);
    if (reset) {
      state = const AsyncValue.loading();
      _currentPage = 1;
      _hasMore = true;
      _items = [];
    }

    if (!_hasMore) return;

    _currentFilter = filter;
    try {
      final newItems = await _repository.pdRequestItem(ArgumentModel(
          page: _currentPage,
          branchId: 'all',
          currentPage: _currentPage,
          pageSize: 10,
          filter: _currentFilter!));

      if (newItems.isEmpty) {
        _hasMore = false;
      } else {
        _items.addAll(newItems);
        _currentPage++;
      }

      state = AsyncValue.data(_items);
    } catch (error) {
      state = AsyncValue.error(error, StackTrace.current);
    }
  }
}
