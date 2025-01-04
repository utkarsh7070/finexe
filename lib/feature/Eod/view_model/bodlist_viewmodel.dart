import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:finexe/feature/Eod/model/get_all_task_response_model.dart';
import 'package:finexe/feature/Eod/model/update_status_request_model.dart';
import 'package:finexe/feature/Eod/model/update_status_response_model.dart';
import 'package:finexe/feature/Eod/repo.dart';
import 'package:finexe/feature/base/api/dio_exception.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/foundation.dart';

class EODState {
  final bool isLoading;
  final List<Task> bodList;
  final List<Task> bodFilterList;

  final List<String> dropDownList;
  final List<String> dropDownFilterList;
  final List<String> dropDownDateFilterList;
  final List<String> dropDownValue;

  final String? selectedDate;

  EODState({
    required this.isLoading,
    required this.bodList,
    required this.bodFilterList,
    required this.dropDownList,
    required this.dropDownFilterList,
    required this.dropDownDateFilterList,
    required this.dropDownValue,
    this.selectedDate,
  });

  EODState.initial()
      : isLoading = false,
        bodList = [],
        bodFilterList = [],
        dropDownList = ['Completed', 'Pending', 'Processing'],
        dropDownFilterList = ['All', 'Completed', 'Pending', 'Processing'],
        dropDownDateFilterList = [],
        dropDownValue = [],
        selectedDate = null;

  EODState copyWith({
    bool? isLoading,
    List<Task>? bodList,
    List<Task>? bodfilterList,
    List<String>? dropDownList,
    List<String>? dropDownFilterList,
    List<String>? dropDownDateFilterList,
    List<String>? dropdownv,
    String? selectedDate,
  }) {
    return EODState(
      isLoading: isLoading ?? this.isLoading,
      bodList: bodList ?? this.bodList,
      bodFilterList: bodfilterList ?? bodFilterList,
      dropDownList: dropDownList ?? this.dropDownList,
      dropDownFilterList: dropDownFilterList ?? this.dropDownFilterList,
      dropDownDateFilterList:
          dropDownDateFilterList ?? this.dropDownDateFilterList,
      dropDownValue: dropdownv ?? dropDownValue,
      selectedDate: selectedDate ?? this.selectedDate,
    );
  }
}

class EODController extends StateNotifier<EODState> {
  final WorkTaskRepository _workTaskRepository;

  EODController(this._workTaskRepository) : super(EODState.initial()) {
    initializeTasks();
  }

  String? emp = '';
  String? token = '';
  Future<void> initializeTasks() async {
    // You can replace these with actual values or fetch them from shared preferences
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    token = sharedPreferences.getString('token');
    emp = sharedPreferences.getString('employeId'); // Replace with actual token
    log('token: $token');
    log('employeId: $emp');

    if (emp != null && token != null) {
      print('>>>>>>>???? calling');
      await getAllTask(emp!, token!);
      addStatusValue();
    }
  }

  String? dropDownFilterValue;

  void addStatusValue() {
    for (int i = 0; i < state.bodList.length; i++) {
      if (state.bodList[i].status == 'pending') {
        state.dropDownValue.add(state.dropDownList[1].toString());
      } else if (state.bodList[i].status == 'completed') {
        state.dropDownValue.add(state.dropDownList[0].toString());
      } else if (state.bodList[i].status == 'processing') {
        state.dropDownValue.add(state.dropDownList[2].toString());
      }
    }
    dropDownFilterValue = state.dropDownFilterList.first;
  }

  Future<void> getAllTask(String empioyeeid, String token) async {
    state = state.copyWith(isLoading: true);
    Map<String, String> sttoken = {"token": token};
    Map<String, String> emp = {"employeeId": empioyeeid};

    try {
      final response = await _workTaskRepository.getBodTask(emp, sttoken);
      print(response);
      if (response != null) {
        print('getAllBOD list: $response');
        final getAllTaskResponseModel =
            GetAllTaskResponseModel.fromJson(response.data);
        state = state.copyWith(
          isLoading: false,
          bodList: getAllTaskResponseModel.items.tasks.toList(),
          bodfilterList: getAllTaskResponseModel.items.tasks.toList(),
        );
        print(
            'getAllTaskResponseModel ${getAllTaskResponseModel.items.tasks.toList()}');
      } else {}
    } catch (e) {
      state = state.copyWith(isLoading: false);

      // Handle error
      if (kDebugMode) print("getAllTask Error: $e");
    } finally {
      state = state.copyWith(isLoading: false);
    }
  }

  Future<void> changeDropdown(
      String value, int index, String taskId, BuildContext context) async {
    // Create a new list to avoid modifying the original list directly
    List<String> updatedDropDownValue = List.from(state.dropDownValue);
    updatedDropDownValue[index] = value;

    // Update state with a new instance
    state = state.copyWith(dropdownv: updatedDropDownValue);

    if ((emp != null && emp!.isNotEmpty) &&
        (token != null && token!.isNotEmpty)) {
      if (kDebugMode) {
        print('token before update:: $token');
      }
      await updateStatusTask(taskId, token!, value.toLowerCase(), context);
    } else {
      print('No token or empID found');
    }
  }

  Future<void> updateStatusTask(String taskId, String storedToken,
      String status, BuildContext context) async {
    Map<String, String> token = {"token": storedToken};
    print('?////////employeeId $emp , status $status');
    UpdateStatusRequestModel updateStatusRequestModel =
        UpdateStatusRequestModel(taskId: taskId, status: status);
    await _workTaskRepository
        .updateStatusTask(updateStatusRequestModel, token)
        .onError((error, stackTrace) {
      if (kDebugMode) {
        print('error $error');
      }
      //state.isLoading = false;
      DioExceptions.fromDioError(error as DioException, context);
    }).then((value) {
      if (value != null) {
        UpdateStatusResponseModel updateStatusResponseModel =
            UpdateStatusResponseModel.fromJson(value.data);
        //state = state.copyWith(dropdownv[ind]: updateStatusResponseModel!.items.status);

        // update();
        // bodList = getAllTaskResponseModel!.items.tasks.toList();
        // isLoading = false;
        // update();
      }
    });
  }

  List<DropdownMenuItem<String>> dropDownItem() {
    return state.dropDownList
        .map((value) => DropdownMenuItem(
              value: value,
              child: Text(value.toString()),
            ))
        .toList();
  }
}

final eodControllerProvider =
    StateNotifierProvider.autoDispose<EODController, EODState>((ref) {
  final workTaskRepository = ref.watch(
      workTaskRepositoryProvider); // Assuming you have a repository provider
  return EODController(workTaskRepository);
});

final workTaskRepositoryProvider = Provider<WorkTaskRepository>((ref) {
  return WorkTaskRepository(); // Initialize your repository here
});
