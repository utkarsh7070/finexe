import 'package:dio/dio.dart';
import 'package:finexe/feature/base/api/api.dart';
import 'package:finexe/feature/base/api/dio_exception.dart';
import 'package:finexe/feature/base/extentions/dio_extension.dart';
import 'package:finexe/feature/base/utils/namespase/app_colors.dart';
import 'package:finexe/feature/base/utils/widget/custom_snackbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:finexe/feature/Eod/model/add_task_request_model.dart';
// import 'package:finexe/feature/constant/api/api.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../model/add_task_request_model.dart';
import '../model/add_task_response_model.dart';
// import 'package:finexe/feature/constant/extension/dio_extension.dart';

final addBodTaskProvider =
    StateNotifierProvider<AddBodTask, AsyncValue<AddTaskResponseModel?>>((ref) {
  final dio = DioClientExtension
      .client; // Assuming DioClientExtension provides a Dio client instance
  return AddBodTask(dio);
});

class AddBodTask extends StateNotifier<AsyncValue<AddTaskResponseModel?>> {
  final Dio dio;
  bool? isLoading = false;

  AddBodTask(this.dio) : super(const AsyncValue.data(null));

  Future<void> onAddTask(
      AddTaskRequestModel addTaskRequestModel, BuildContext context) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String? token = sharedPreferences.getString('token');
    isLoading = true;
    state = const AsyncValue.loading();
    final headers = {"token": token};
    if (kDebugMode) {
      print("Authorization Token: $token");
      print("API Endpoint: ${Api.addTask}");
      print("Request Data: ${addTaskRequestModel.toJson()}");
    }

    try {
      final response = await dio.post(
        Api.addTask,
        data: addTaskRequestModel.toJson(),
        options: Options(
          headers: headers,
          validateStatus: (status) => status != null && status < 500,
        ),
      );

      if (response.statusCode == 200) {
        final addTaskResponseModel =
            AddTaskResponseModel.fromJson(response.data);
        state = AsyncValue.data(addTaskResponseModel);
        print("Add Task Response: ${response.data}");
        showCustomSnackBar(context, 'BOD Added', AppColors.green);
        Navigator.of(context).pop();
      } else if (response.statusCode == 401) {
        if (kDebugMode) {
          print("401 response: ${response.data}");
          print("Unauthorized: Check token validity.");
        }
        state = AsyncValue.error(
            "Unauthorized: Token might be invalid or expired.",
            StackTrace.current);
      } else {
        print("Unexpected Error: ${response.statusCode}");
        state = AsyncValue.error(
            "Error ${response.statusCode}: ${response.data}",
            StackTrace.current);
      }
    } catch (error, stackTrace) {
      DioExceptions.fromDioError(error as DioException, context);
      state = AsyncValue.error(error, stackTrace);
      print("Exception occurred: ${error.toString()}");
    } finally {
      //print('object');
      isLoading = false;
    }
  }
}
