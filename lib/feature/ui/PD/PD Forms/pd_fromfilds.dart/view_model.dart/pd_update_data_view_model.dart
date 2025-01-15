import 'package:dio/dio.dart';
import 'package:finexe/feature/ui/PD/PD%20Forms/pd_fromfilds.dart/model/Submit%20Data%20Models/pd_response_model.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../../base/api/api.dart';
import '../../../../../base/api/dio.dart';
import '../../../../../base/api/dio_exception.dart';
import '../../../../../base/utils/general/pref_utils.dart';
//
final getUpdatedDataProvider =
    FutureProvider.autoDispose.family<Items, String>(
  (ref, customerId) async {
    final _dio = ref.watch(dioProvider);
    String? token = speciality.getToken();
    if (kDebugMode) {
      print('url: ${Api.getpdformdata}$customerId');
    }
    try {
      final response = await _dio.get(
        '${Api.getpdformdata}$customerId',
        options: Options(headers: {"token": token}),
      );

      if (response.statusCode == 200 && response.data != null) {
        final responseData = response.data;

        PdResponseModel pdResponseModel =
            PdResponseModel.fromJson(response.data);
        print('response data ---------------${pdResponseModel.items?.coApplicant}');
        return pdResponseModel.items!;
      } else {
        // throw Exception(
        //     "Failed to load application data: ${response.statusCode}");
        print('Failed to load application data: ${response.statusCode}');
        return Items();
      }
    } catch (e) {
      ExceptionHandler().handleError(e);
      rethrow;
    }
  },
);
