import 'package:dropdown_textfield/dropdown_textfield.dart';
import 'package:finexe/feature/base/routes/routes.dart';
import 'package:finexe/feature/base/utils/namespase/app_colors.dart';
import 'package:finexe/feature/base/utils/namespase/display_size.dart';
import 'package:finexe/feature/base/utils/widget/app_button.dart';
import 'package:finexe/feature/base/utils/widget/app_text_filed_login.dart';
import 'package:finexe/feature/ui/HRMS/EmployeeJoiningForm/view_model/employee_basic_details_view_model.dart';
import 'package:finexe/feature/ui/HRMS/EmployeeJoiningForm/widget/custom_listview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class EducationDetails extends ConsumerWidget {
  const EducationDetails({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final employeeDataViewModel = ref.read(employeeViewModelProvider.notifier);
    final employeeDataState = ref.watch(employeeViewModelProvider);
    return Scaffold(
        appBar: AppBar(
          title: const Text('Educational Details'),
        ),
        body: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  AppListview(
                      scrollphysics: const NeverScrollableScrollPhysics(),
                      items: employeeDataState.educationalDetail.length,
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
                                    // focusNode:
                                    // personalFocusViewModel.aadhaarFocusNode,
                                    // currentState:
                                    // personalFocusStates['aadhaarFocusNode'],
                                    onChange: (value) {
                                      employeeDataViewModel
                                          .updateEducation(value);
                                    },
                                    // height: !personalFormState.isAadhaarValid
                                    //     ? displayHeight(context) * 0.09
                                    //     : null,
                                    inerHint: 'Education',
                                    errorText: "Education is a required field",
                                    // isError: !personalFormState.isAadhaarValid,
                                    textInputType: TextInputType.number,
                                    textInputAction: TextInputAction.done,
                                  ),
                                  SizedBox(
                                    height: displayHeight(context) * 0.02,
                                  ),
                                  AppFloatTextField(
                                    // focusNode:
                                    // personalFocusViewModel.aadhaarFocusNode,
                                    // currentState:
                                    // personalFocusStates['aadhaarFocusNode'],
                                    onChange: (value) {
                                      employeeDataViewModel
                                          .updateNameofboard(value);
                                    },
                                    // height: !personalFormState.isAadhaarValid
                                    //     ? displayHeight(context) * 0.09
                                    //     : null,
                                    inerHint: 'Name of board',
                                    errorText:
                                        "Name of board is a required field",
                                    // isError: !personalFormState.isAadhaarValid,
                                    textInputType: TextInputType.number,
                                    textInputAction: TextInputAction.done,
                                  ),
                                  SizedBox(
                                    height: displayHeight(context) * 0.02,
                                  ),
                                  AppFloatTextField(
                                    // focusNode:
                                    // personalFocusViewModel.aadhaarFocusNode,
                                    // currentState:
                                    // personalFocusStates['aadhaarFocusNode'],
                                    onChange: (value) {
                                      employeeDataViewModel
                                          .updateMarkobtained(value);
                                    },
                                    // height: !personalFormState.isAadhaarValid
                                    //     ? displayHeight(context) * 0.09
                                    //     : null,
                                    inerHint: 'Mark obtained',
                                    errorText:
                                        "Mark obtained is a required field",
                                    // isError: !personalFormState.isAadhaarValid,
                                    textInputType: TextInputType.number,
                                    textInputAction: TextInputAction.done,
                                  ),
                                  SizedBox(
                                    height: displayHeight(context) * 0.02,
                                  ),
                                  AppFloatTextField(
                                    // focusNode:
                                    // personalFocusViewModel.aadhaarFocusNode,
                                    // currentState:
                                    // personalFocusStates['aadhaarFocusNode'],
                                    onChange: (value) {
                                      employeeDataViewModel
                                          .updatePassingyear(value);
                                    },
                                    // height: !personalFormState.isAadhaarValid
                                    //     ? displayHeight(context) * 0.09
                                    //     : null,
                                    inerHint: 'Passing year',
                                    errorText:
                                        "Passing year is a required field",
                                    // isError: !personalFormState.isAadhaarValid,
                                    textInputType: TextInputType.number,
                                    textInputAction: TextInputAction.done,
                                  ),
                                  SizedBox(
                                    height: displayHeight(context) * 0.02,
                                  ),
                                  AppFloatTextField(
                                    // focusNode:
                                    // personalFocusViewModel.aadhaarFocusNode,
                                    // currentState:
                                    // personalFocusStates['aadhaarFocusNode'],
                                    onChange: (value) {
                                      employeeDataViewModel.updateStream(value);
                                    },
                                    // height: !personalFormState.isAadhaarValid
                                    //     ? displayHeight(context) * 0.09
                                    //     : null,
                                    inerHint: 'Stream',
                                    errorText: "Stream is a required field",
                                    // isError: !personalFormState.isAadhaarValid,
                                    textInputType: TextInputType.number,
                                    textInputAction: TextInputAction.done,
                                  ),
                                  SizedBox(
                                    height: displayHeight(context) * 0.02,
                                  ),
                                  DropDownTextField(
                                    clearOption: false,
                                    controller: employeeDataViewModel
                                        .gradeDropdownControllerProvider,
                                    listSpace: 20,
                                    listPadding: ListPadding(top: 20),
                                    enableSearch: false,
                                    dropDownList:
                                        employeeDataViewModel.gradedropdown,
                                    listTextStyle: const TextStyle(
                                        color: AppColors.primary),
                                    // dropDownItemCount: 2,
                                    onChanged: (val) {
                                      employeeDataViewModel.updategrade(val);
                                    },
                                    // textFieldFocusNode:
                                    // paymentFocusViewModel.paymentStatusFocusNode,
                                    textFieldDecoration: const InputDecoration(
                                      hintStyle:
                                          TextStyle(color: AppColors.textGray),
                                      // floatingLabelStyle:
                                      // paymentFocusStates['paymentStatusFocusNode']!
                                      //     ? AppStyles.subHeading
                                      //     .copyWith(color: AppColors.primary)
                                      //     : AppStyles.subHeading,
                                      label: Text(
                                        'Grade',
                                        // style: const TextStyle(color: AppColors.textGray),
                                      ),

                                      // errorText: isError! ? errorText : null,
                                      enabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: AppColors.buttonBorderGray,
                                              width: 1),
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(10))),
                                      // filled: true,
                                      // fillColor: AppColors.gray,
                                      border: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: AppColors.buttonBorderGray,
                                            width: 1),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10)),
                                      ),

                                      // focusedBorder: OutlineInputBorder(
                                      //     borderSide: BorderSide(
                                      //         color: !paymentState.isPaymentStatusValid
                                      //             ? Colors.red
                                      //             : Colors.blue,
                                      //         width: 2),
                                      //     borderRadius:
                                      // const BorderRadius.all(Radius.circular(10))),
                                    ),
                                  ),
                                  Visibility(
                                      visible: index >= 1,
                                      child: IconButton(
                                          onPressed: () {
                                            employeeDataViewModel
                                                .removeEducationalItem(index);
                                          },
                                          icon: const Icon(Icons.minimize)))
                                ])));
                      }),
                  AppButton(
                    width: displayWidth(context) * 0.50,
                    label: 'Add More',
                    onTap: () {
                      employeeDataViewModel.addEducationalDetail();
                    },
                  ),
                  AppButton(
                    width: displayWidth(context) * 0.50,
                    //validation is remaining
                    label: 'Next',
                    onTap: () {
                      Navigator.pushNamed(context, AppRoutes.employmentHistory);
                      // employeeDataViewModel.addFamilyMember();
                    },
                  )
                ],
              )),
        ));
  }
}
