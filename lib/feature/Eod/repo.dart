import 'package:dio/dio.dart';
import 'package:finexe/feature/Eod/model/update_status_request_model.dart';
import 'package:finexe/feature/base/api/api.dart';
import 'package:finexe/feature/base/api/dio_exception.dart';
import 'package:finexe/feature/base/extentions/dio_extension.dart';
import 'package:flutter/foundation.dart';

class WorkTaskRepository {
  final dio = DioClientExtension.client;

 
  Future<dynamic> getBodTask(
      Map<String, String> queryParam, Map<String, String> token) async {
    print('param $queryParam');
    print('param $token');
    try {
      Response response = await dio.get(Api.getAllTask,
          queryParameters: queryParam, options: Options(headers: token));
      print('GET ALL DATA ${response.data}');
      return response;

    
    } catch (exception) {
      ExceptionHandler().handleError(exception);

      // return Future.error(exception);
    }
  }

 
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
    
        
        return response;
      
    } catch (exception) {
     ExceptionHandler().handleError(exception);
    }
  }
}
