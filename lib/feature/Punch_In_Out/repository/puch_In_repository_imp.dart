import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:finexe/feature/base/api/api.dart';
import 'package:finexe/feature/base/extentions/dio_extension.dart';

// import 'package:finexe_attendance/feature/attendance/model/response_model.dart';
import 'package:flutter/foundation.dart';
import 'package:fluttertoast/fluttertoast.dart';

// import '../../constant/api/api.dart';
// import '../../constant/extension/dio_extension.dart';
import 'punch_in_repository.dart';

class PunchInRepositoryImp extends PunchInRepository {
  final dio = DioClientExtension.client;

  // Map<String, String> _headers = <String, String>{
  //   'Content-Type': 'application/json',
  //   'Accept': 'application/json',
  // };

  @override
  Future<dynamic> punchIn(Map<String, String> token) async {
    print('token $token');
    try {
      Response response =
          await dio.get(Api.punchIn, options: Options(headers: token));
      log('punchIn api: ${Api.punchIn.toString()}');

      if (kDebugMode) {
        print(response.data);
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

  @override
  Future<dynamic> punchOut(Map<String, String> token) async {
    try {
      Response response =
          await dio.get(Api.punchOut, options: Options(headers: token));
      log('punchOut api: ${Api.punchOut.toString()}');
      print('punch out response $response');
      if (response.statusCode == 200) {
        return response;
      }
      if (kDebugMode) {
        // log(">>>L " + response.data);
      }
      if (response.statusCode == 500) {
        if (kDebugMode) {
          print('500 error');
        }
      } else if (response.statusCode == 404) {
        log('404 error');
      } else {
        return response;
      }
    } catch (exception) {
      return Future.error(exception);
    }
  }

  @override
  Future<dynamic> checkPunch(
      Map<String, double> queryParam, Map<String, String> token) async {
    try {
      Response response = await dio.get(Api.checkPunchIn,
          queryParameters: queryParam, options: Options(headers: token));
      log('queryParam: ' + queryParam.toString());
      log('checkPunchIn api: ${Api.checkPunchIn.toString()}');

      if (kDebugMode) {
        print('check punch status ${response.data}');
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
