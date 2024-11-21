import 'package:dio/dio.dart';
import 'package:finexe/feature/base/api/api.dart';
import 'package:finexe/feature/base/api/dio_exception.dart';
import 'package:finexe/feature/base/extentions/dio_extension.dart';
import 'package:finexe/feature/base/utils/namespase/app_colors.dart';
import 'package:finexe/feature/base/utils/widget/custom_snackbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../model/add_task_request_model.dart';
import '../model/add_task_response_model.dart';


// final addBodTaskProvider =
//     StateNotifierProvider<AddBodTask, AsyncValue<AddTaskResponseModel?>>((ref) {
//   final dio = DioClientExtension
//       .client; // Assuming DioClientExtension provides a Dio client instance
//   return AddBodTask(dio);
// });
//
// class AddBodTask extends StateNotifier<AsyncValue<AddTaskResponseModel?>> {
//   final Dio dio;
//   bool? isLoading = false;
//
//   AddBodTask(this.dio) : super(const AsyncValue.data(null));
//
//
// }
