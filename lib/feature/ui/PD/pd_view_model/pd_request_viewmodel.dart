import 'package:dio/dio.dart';
import 'package:finexe/feature/base/api/api.dart';
import 'package:finexe/feature/base/api/dio.dart';
import 'package:finexe/feature/ui/PD/Model/pd_request_list_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:finexe/feature/base/utils/general/pref_utils.dart';

import '../../../base/api/dio_exception.dart';

// class PdRequestItem {
//   final String id;
//   final String customerId;
//   final String statusByCreditPd;
//   final String customerFinId;
//   final String customerName;
//   final int customerMobileNo;
//   final String customerFatherName;
//   final String customerAddress;
//   PdRequestItem({
//     required this.id,
//     required this.customerId,
//     required this.statusByCreditPd,
//     required this.customerFinId,
//     required this.customerName,
//     required this.customerMobileNo,
//     required this.customerFatherName,
//     required this.customerAddress,
//   });
//   factory PdRequestItem.fromJson(Map<String, dynamic> json) {
//     return PdRequestItem(
//       id: json["_id"],
//       customerId: json["customerId"],
//       statusByCreditPd: json["statusByCreditPd"],
//       customerFinId: json["customerFinId"],
//       customerName: json["customerName"],
//       customerMobileNo: json["customerMobileNo"],
//       customerFatherName: json["customerFatherName"],
//       customerAddress: json["customerAddress"],
//     );
//   }
// }

// final pdreqitemProvider =
//     StateNotifierProvider<PdRequestNotifier, List<PDReqItems>>(
//         (ref) => PdRequestNotifier());
// class PdRequestNotifier extends StateNotifier<List<PDReqItems>> {
//   PdRequestNotifier() : super([]);
//   Future<void> fetchPdRequests() async {
//     try {
//     final response = await dio.post(Api.updatePdReport,
//            options: Options(headers: {"token": }));
//       final List<dynamic> items = response.data["items"];
//       state = items.map((item) => PDReqItems.fromJson(item)).toList();
//     } catch (error) {
//       print("Error fetching PD requests: $error");
//     }
//   }
// }

final fetchpdRefuseandAcceptListProvider =
    FutureProvider.autoDispose<List<PDReqItems>>((ref) async {
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  String? token = sharedPreferences.getString('token');
  // final String token =
  //     "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJJZCI6IjY2ODUwZjdkMzc0NDI1ZTkzNzExNDE4MCIsInJvbGVOYW1lIjoiYWRtaW4iLCJpYXQiOjE3MjY3Mzc2Njd9.exsdAWj9fWc5LiOcAkFmlgade-POlU8orE8xvgfYXZU";
  final Map<String, String> queryParam = {"status": "WIP", "searchQuery": ""};
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
    return apiResponseList;
  } else {
    throw Exception('Failed to load data');
  }
});





final acceptpdrequestProvider =
    FutureProvider.autoDispose<List<PDReqItems>>((ref) async {
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  String? token = sharedPreferences.getString('token');
  // final String token =
  //     "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJJZCI6IjY2ODUwZjdkMzc0NDI1ZTkzNzExNDE4MCIsInJvbGVOYW1lIjoiYWRtaW4iLCJpYXQiOjE3MjY3Mzc2Njd9.exsdAWj9fWc5LiOcAkFmlgade-POlU8orE8xvgfYXZU";
  final Map<String, String> queryParam = {
    "status": "accept",
    "searchQuery": ""
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
    List<dynamic> responseList = response.data['items'] ?? [];

    // Map the list of dynamic objects to List<PDReqItems>
    List<PDReqItems> apiResponseList =
        responseList.map((item) => PDReqItems.fromJson(item)).toList();
    print('PDReqItems ${apiResponseList.length}');
    return apiResponseList;
  } else {
    throw Exception('Failed to load data');
  }
});





//*******************************Refuse and Reject
final pdRequestProvider = Provider<RequestApiService>((ref) {
  final dio = ref.watch(dioProvider);
  return RequestApiService(dio);
});

class RequestApiService {
  final Dio dio;

  RequestApiService(this.dio);
  Future<bool?> pdRequestAccept(String id,BuildContext context) async {
    try {
      if (kDebugMode) {
        print(id);
      }

      String? token = speciality.getToken();

      if (token==null) {
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


  //Revert Api
  Future<bool?> pdRequestRevert(String id,String rivertReason,BuildContext context) async {
    try {
      if (kDebugMode) {
        print('Request ID: $id');
      }

      SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
      String? token = sharedPreferences.getString('token');

      final queryParam = {
        '_id': id,
        'status': 'rivert',
        'remark': rivertReason, //reason of rejectectoin
      };
      print('queryParam ${queryParam.values}');
      final response = await dio.post(
        Api.revertByVendor,
        queryParameters: queryParam,
        options: Options(
            headers: {"token": token}),
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
        final errorMessage = response.data['message'] ?? 'An unknown error occurred';
        print('Error Message from API: $errorMessage');

        // Optionally, you can show this message in the UI using a dialog/snackbar
        return false;
      }
    }   catch (e) {
      // Handle any other exceptions
      print('revert api :: ${Api.revertByVendor}');

      print('Exception: $e');
      DioExceptions.fromDioError(e as DioException, context);

    }

    return false;
  }


}
