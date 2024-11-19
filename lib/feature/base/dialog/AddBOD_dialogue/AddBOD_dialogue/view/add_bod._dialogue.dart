import 'package:finexe/feature/Eod/view_model/bodlist_viewmodel.dart';

import 'package:finexe/feature/base/service/session_service.dart';
import 'package:finexe/feature/base/utils/namespase/app_colors.dart';
import 'package:finexe/feature/base/utils/widget/app_text_field.dart';
import 'package:finexe/feature/base/utils/widget/custom_snackbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:finexe/feature/Eod/model/add_task_request_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../model/add_task_request_model.dart';
import '../viewmdoel/add_bod_viewmodel.dart';

class AddBodDialog {
  final TextEditingController _taskTitleController = TextEditingController();
  final TextEditingController _taskDescriptionController =
      TextEditingController();

  void dispose() {
    _taskTitleController.dispose();
    _taskDescriptionController.dispose();
  }

  Future<void> addAlbumDialog(
    BuildContext context,
    WidgetRef ref, // Add WidgetRef to access Riverpod providers
  ) async {
    SharedPreferences preferences = await SessionService.getSession();
    final String? employeID = preferences.getString('employeId');
    final String? token = preferences.getString('token');

    print('employeID:  $employeID');
    print('token:  $token');

    return showDialog<void>(
      context: context,
      barrierDismissible: false, // User must tap a button to dismiss
      builder: (BuildContext context) {
        return WillPopScope(
          onWillPop: () async {
            SystemNavigator.pop(); // Exit the app
            return false; // Prevent the default back action
          },
          child: AlertDialog(
            title: const Text('Add Task'),
            content: SingleChildScrollView(
              child: SizedBox(
                height: MediaQuery.of(context).size.height * 0.30,
                width: MediaQuery.of(context).size.width * 0.70,
                child: Column(
                  children: [
                    AppTextField(
                      onChange: (value) {},
                      textInputType: TextInputType.text,
                      hint: 'Enter Task Title',
                      controller: _taskTitleController,
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.02,
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.20,
                      child: AppTextField(
                        maximumLines: 5,
                        onChange: (value) {},
                        textInputType: TextInputType.text,
                        hint: 'Enter Task Description',
                        controller: _taskDescriptionController,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            actions: <Widget>[
              TextButton(
                child: const Text('ADD today tasks'),
                onPressed: () async {
                  final taskTitle = _taskTitleController.text;
                  final taskDescription = _taskDescriptionController.text;

                  if (taskTitle.isNotEmpty && taskDescription.isNotEmpty) {
                    AddTaskRequestModel addTaskRequestModel =
                        AddTaskRequestModel(
                      employeeId: employeID.toString(),
                      task: taskTitle,
                      description: taskDescription,
                    );

                    await ref
                        .read(addBodTaskProvider.notifier)
                        .onAddTask(addTaskRequestModel, context)
                        .then(
                      (value) {
                        print('refreshing list ');
                        ref.refresh(eodControllerProvider);
                      },
                    );
                  } else {
                    showCustomSnackBar(
                        context, 'Please Add Task', AppColors.red);
                  }
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
