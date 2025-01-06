import 'package:finexe/feature/base/routes/routes.dart';
import 'package:finexe/feature/base/utils/namespase/display_size.dart';
import 'package:finexe/feature/base/utils/widget/app_button.dart';
import 'package:finexe/feature/base/utils/widget/app_text_filed_login.dart';
import 'package:finexe/feature/ui/HRMS/EmployeeJoiningForm/view_model/employee_basic_details_view_model.dart';
import 'package:finexe/feature/ui/HRMS/EmployeeJoiningForm/widget/custom_listview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class EmploymentHistory extends ConsumerWidget {
  const EmploymentHistory({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final employeeDataViewModel = ref.read(employeeViewModelProvider.notifier);
    final employeeDataState = ref.watch(employeeViewModelProvider);
    return Scaffold(
        appBar: AppBar(
          title: const Text('Employment History'),
        ),
        body: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  AppListview(
                      scrollphysics: const NeverScrollableScrollPhysics(),
                      items:employeeDataState.employmentHistory.length,
                      builder: (context, index) {
                        print(index);
                        return Card(
                            child: Padding(
                                padding: const EdgeInsets.all(10),
                                child: Column(children: [
                                  SizedBox(
                                    height: displayHeight(context) * 0.02,
                                  ),
                                 AppFloatTextField(
  onChange: (value) {
    employeeDataViewModel.updateCurrentDesignation(value);
  },
  inerHint: 'Current Designation',
  errorText: "Current Designation is a required field",
  textInputType: TextInputType.text,
  textInputAction: TextInputAction.done,
),
SizedBox(
  height: displayHeight(context) * 0.02,
),
AppFloatTextField(
  onChange: (value) {
    employeeDataViewModel.updateLastOrganization(value);
  },
  inerHint: 'Last Organization',
  errorText: "Last Organization is a required field",
  textInputType: TextInputType.text,
  textInputAction: TextInputAction.done,
),
SizedBox(
  height: displayHeight(context) * 0.02,
),
AppFloatTextField(
  isReadOnly: true,
  suffixIcon: Icons.calendar_month,
  isSuffix: true,
  suffixOnTap: () {
    // employeeDataViewModel.openDatePicker(context);
  },
  onChange: (value) {
    employeeDataViewModel.updateStartDate(value);
  },
  inerHint: 'Start Date',
  errorText: "Start Date is a required field",
  textInputType: TextInputType.datetime,
  textInputAction: TextInputAction.done,
),
SizedBox(
  height: displayHeight(context) * 0.02,
),
AppFloatTextField(
  isReadOnly: true,
  suffixIcon: Icons.calendar_month,
  isSuffix: true,
  suffixOnTap: () {
    // employeeDataViewModel.openDatePicker(context);
  },
  onChange: (value) {
    employeeDataViewModel.updateEndDate(value);
  },
  inerHint: 'End Date',
  errorText: "End Date is a required field",
  textInputType: TextInputType.datetime,
  textInputAction: TextInputAction.done,
),
SizedBox(
  height: displayHeight(context) * 0.02,
),
AppFloatTextField(
  onChange: (value) {
    employeeDataViewModel.updateTotalExperience(value);
  },
  inerHint: 'Total Experience',
  errorText: "Total Experience is a required field",
  textInputType: TextInputType.number,
  textInputAction: TextInputAction.done,
),
SizedBox(
  height: displayHeight(context) * 0.02,
),
AppFloatTextField(
  onChange: (value) {
    employeeDataViewModel.updateCurrentCTC(value);
  },
  inerHint: 'Current CTC',
  errorText: "Current CTC is a required field",
  textInputType: TextInputType.number,
  textInputAction: TextInputAction.done,
),

                                  Visibility(
                                      visible: index >= 1,
                                      child: IconButton(
                                          onPressed: () {
                                            employeeDataViewModel
                                                .removeEmpHistory(index);
                                          },
                                          icon: const Icon(Icons.minimize)))
                                ])));
                      }),
                  AppButton(
                    width: displayWidth(context) * 0.50,
                    label: 'Add More',
                    onTap: () {
                      employeeDataViewModel.addEmpHistory();
                    },
                  ),
                  AppButton(
                    width: displayWidth(context) * 0.50,
                    //validation is remaining
                    label: 'Next',
                    onTap: () {
                      Navigator.pushNamed(context, AppRoutes.uploadDocuments);
                      // employeeDataViewModel.addFamilyMember();
                    },
                  )
                ],
              )),
        ));
  }
}
