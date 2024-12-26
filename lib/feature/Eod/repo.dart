import 'package:dio/dio.dart';
import 'package:finexe/feature/Eod/model/update_status_request_model.dart';
import 'package:finexe/feature/base/api/api.dart';
import 'package:finexe/feature/base/extentions/dio_extension.dart';
import 'package:flutter/foundation.dart';

class WorkTaskRepository {
  final dio = DioClientExtension.client;

  @override
  Future<dynamic> getBodTask(
      Map<String, String> queryParam, Map<String, String> token) async {
    print('param $queryParam');
    print('param $token');
    try {
      Response response = await dio.get(Api.getAllTask,
          queryParameters: queryParam, options: Options(headers: token));
      print('GET ALL DATA ${response.data}');

      if (response.statusCode == 500) {
        print('500 error');
      } else if (response.statusCode == 404) {
        print('404 eror');
      } else {
        return response;
      }
    } catch (exception) {
      return Future.error(exception);
    }
  }

  @override
  Future<dynamic> updateStatusTask(
      UpdateStatusRequestModel status, Map<String, String> token) async {
    print('param ${status.toJson()}');
    print('param $token');
    try {
      Response response = await dio.post(Api.updateStatusTask,
          data: status.toJson(), options: Options(headers: token));
      if (kDebugMode) {
        print('UPDATE DATA ${response.data}');
      }
      if (response.statusCode == 500) {
        if (kDebugMode) {
          print('500 error');
        }
      } else if (response.statusCode == 404) {
        if (kDebugMode) {}
      } else {
        return response;
      }
    } catch (exception) {
      return Future.error(exception);
    }
  }
}
