import 'package:dropdown_textfield/dropdown_textfield.dart';
import 'package:finexe/feature/base/routes/routes.dart';
import 'package:finexe/feature/base/utils/widget/app_button.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../base/utils/namespase/app_colors.dart';
import '../../../../base/utils/namespase/display_size.dart';
import '../../../../base/utils/widget/app_list_view.dart';
import '../../../../base/utils/widget/app_text_filed_login.dart';
import '../view_model/employee_basic_details_view_model.dart';

class FamilyDetails extends ConsumerWidget {
  const FamilyDetails({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final employeeDataViewModel = ref.read(employeeViewModelProvider.notifier);
    final employeeDataState = ref.watch(employeeViewModelProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Family Details'),
      ),
      body: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              SizedBox(
                height: displayHeight(context) * 0.02,
              ),
              AppFloatTextField(
                // focusNode:
                // personalFocusViewModel.aadhaarFocusNode,
                // currentState:
                // personalFocusStates['aadhaarFocusNode'],
                onChange: (value) {
                  employeeDataViewModel.updateFathers(value);
                },
                // height: !personalFormState.isAadhaarValid
                //     ? displayHeight(context) * 0.09
                //     : null,
                inerHint: 'Fathers Name',
                errorText: "Fathers Name is a required field",
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
                  employeeDataViewModel.updateFathersOccupations(value);
                },
                // height: !personalFormState.isAadhaarValid
                //     ? displayHeight(context) * 0.09
                //     : null,
                inerHint: 'Fathers Occupations',
                errorText: "Fathers Occupations is a required field",
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
                  employeeDataViewModel.updateFathersContact(value);
                },
                // height: !personalFormState.isAadhaarValid
                //     ? displayHeight(context) * 0.09
                //     : null,
                inerHint: 'Fathers Contact',
                errorText: "Fathers Contact is a required field",
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
                  employeeDataViewModel.updateMothersName(value);
                },
                // height: !personalFormState.isAadhaarValid
                //     ? displayHeight(context) * 0.09
                //     : null,
                inerHint: 'Mothers Name',
                errorText: "Mothers Name is a required field",
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
                  employeeDataViewModel.updateMothersContact(value);
                },
                // height: !personalFormState.isAadhaarValid
                //     ? displayHeight(context) * 0.09
                //     : null,
                inerHint: 'Mothers Contact',
                errorText: "Mothers Contact is a required field",
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
                  employeeDataViewModel.updateFamilyIncome(value);
                },
                // height: !personalFormState.isAadhaarValid
                //     ? displayHeight(context) * 0.09
                //     : null,
                inerHint: 'Family Income',
                errorText: "Family Income is a required field",
                // isError: !personalFormState.isAadhaarValid,
                textInputType: TextInputType.number,
                textInputAction: TextInputAction.done,
              ),
              SizedBox(
                height: displayHeight(context) * 0.02,
              ),
              const Text('Additional Family Members'),
              SizedBox(
                height: displayHeight(context) * 0.02,
              ),

              AppListview(
                scrollPhysics: const NeverScrollableScrollPhysics(),
                items: employeeDataState.additionalFamilyMember.length,
                builder: (context, index) {
                  return Card(
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: Column(
                        children: [
                          AppFloatTextField(
                            // focusNode:
                            // personalFocusViewModel.aadhaarFocusNode,
                            // currentState:
                            // personalFocusStates['aadhaarFocusNode'],
                            onChange: (value) {
                              employeeDataViewModel
                                  .updateAdditionalFamilyName(value);
                            },
                            // height: !personalFormState.isAadhaarValid
                            //     ? displayHeight(context) * 0.09
                            //     : null,
                            inerHint: 'Name',
                            errorText: "Name is a required field",
                            // isError: !personalFormState.isAadhaarValid,
                            textInputType: TextInputType.text,
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
                                  .updateAdditionalFamilyRelation(value);
                            },
                            // height: !personalFormState.isAadhaarValid
                            //     ? displayHeight(context) * 0.09
                            //     : null,
                            inerHint: 'Relation',
                            errorText: "Relation is a required field",
                            // isError: !personalFormState.isAadhaarValid,
                            textInputType: TextInputType.number,
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
                            // focusNode:
                            // personalFocusViewModel.aadhaarFocusNode,
                            // currentState:
                            // personalFocusStates['aadhaarFocusNode'],
                            onChange: (value) {
                              employeeDataViewModel
                                  .updateAdditionalFamilyDob(value);
                            },
                            // height: !personalFormState.isAadhaarValid
                            //     ? displayHeight(context) * 0.09
                            //     : null,
                            inerHint: 'Date Of Birth',
                            errorText: "Email is a required field",
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
                                .dependentDropdownControllerProvider,
                            listSpace: 20,
                            listPadding: ListPadding(top: 20),
                            enableSearch: false,
                            dropDownList:
                                employeeDataViewModel.dependentDropdown,
                            listTextStyle:
                                const TextStyle(color: AppColors.primary),
                            // dropDownItemCount: 2,
                            onChanged: (val) {
                              employeeDataViewModel
                                  .updateAdditionalFamilyDependent(val);
                            },
                            // textFieldFocusNode:
                            // paymentFocusViewModel.paymentStatusFocusNode,
                            textFieldDecoration: const InputDecoration(
                              hintStyle: TextStyle(color: AppColors.textGray),
                              // floatingLabelStyle:
                              // paymentFocusStates['paymentStatusFocusNode']!
                              //     ? AppStyles.subHeading
                              //     .copyWith(color: AppColors.primary)
                              //     : AppStyles.subHeading,
                              label: Text(
                                'Dependent',
                                // style: const TextStyle(color: AppColors.textGray),
                              ),

                              // errorText: isError! ? errorText : null,
                              enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: AppColors.buttonBorderGray,
                                      width: 1),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10))),
                              // filled: true,
                              // fillColor: AppColors.gray,
                              border: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: AppColors.buttonBorderGray,
                                    width: 1),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10)),
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
                          SizedBox(
                            height: displayHeight(context) * 0.02,
                          ),
                          DropDownTextField(
                            clearOption: false,
                            controller: employeeDataViewModel
                                .whetherEmployeeDropdownControllerProvider,
                            listSpace: 20,
                            listPadding: ListPadding(top: 20),
                            enableSearch: false,
                            dropDownList:
                                employeeDataViewModel.whetherEmployeeDropdown,
                            listTextStyle:
                                const TextStyle(color: AppColors.primary),
                            // dropDownItemCount: 3,
                            onChanged: (val) {
                              employeeDataViewModel
                                  .updateAdditionalFamilyWhetherEmployee(val);
                            },
                            // textFieldFocusNode:
                            // paymentFocusViewModel.paymentStatusFocusNode,
                            textFieldDecoration: const InputDecoration(
                              hintStyle: TextStyle(color: AppColors.textGray),
                              // floatingLabelStyle:
                              // paymentFocusStates['paymentStatusFocusNode']!
                              //     ? AppStyles.subHeading
                              //     .copyWith(color: AppColors.primary)
                              //     : AppStyles.subHeading,
                              label: Text(
                                'Whether Employee',
                                // style: const TextStyle(color: AppColors.textGray),
                              ),

                              // errorText: isError! ? errorText : null,
                              enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: AppColors.buttonBorderGray,
                                      width: 1),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10))),
                              // filled: true,
                              // fillColor: AppColors.gray,
                              border: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: AppColors.buttonBorderGray,
                                    width: 1),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10)),
                              ),

                              // focusedBorder: OutlineInputBorder(
                              //     borderSide: BorderSide(
                              //         color: !paymentState.isPaymentStatusValid
                              //             ? Colors.red
                              //             : Colors.blue,
                              //         width: 2),
                              //     borderRadius:
                              //     const BorderRadius.all(Radius.circular(10))),
                            ),
                          ),
                          SizedBox(
                            height: displayHeight(context) * 0.02,
                          ),
                          const AppFloatTextField(
                            // focusNode:
                            // personalFocusViewModel.aadhaarFocusNode,
                            // currentState:
                            // personalFocusStates['aadhaarFocusNode'],
                            // onChange: (value) {
                            //   personalFormViewModel.updateAadhaar(value);
                            // },
                            // height: !personalFormState.isAadhaarValid
                            //     ? displayHeight(context) * 0.09
                            //     : null,
                            inerHint: 'Mobile No',
                            errorText: "Mobile No is a required field",
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
                                  .updateAdditionalFamilyOccupation(value);
                            },
                            // height: !personalFormState.isAadhaarValid
                            //     ? displayHeight(context) * 0.09
                            //     : null,
                            inerHint: 'Occupation',
                            errorText: "Occupation is a required field",
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
                                  .updateAdditionalFamilyDepartment(value);
                            },
                            // height: !personalFormState.isAadhaarValid
                            //     ? displayHeight(context) * 0.09
                            //     : null,
                            inerHint: 'Name of Department',
                            errorText: "Name of Department is a required field",
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
                                  .updateAdditionalFamilyCompany(value);
                            },
                            // height: !personalFormState.isAadhaarValid
                            //     ? displayHeight(context) * 0.09
                            //     : null,
                            inerHint: 'Company Name',
                            errorText: "Company Name is a required field",
                            // isError: !personalFormState.isAadhaarValid,
                            textInputType: TextInputType.number,
                            textInputAction: TextInputAction.done,
                          ),
                          SizedBox(
                            height: displayHeight(context) * 0.02,
                          ),
                          Visibility(
                              visible: index >= 1,
                              child: IconButton(
                                  onPressed: () {

                                    employeeDataViewModel.removeFamilyItem(index);
                                  }, icon: const Icon(Icons.minimize)))

                        ],
                      ),
                    ),
                  );
                },
              ),
              AppButton(
                width: displayWidth(context) * 0.50,
                label: 'Add Family Member',
                onTap: () {
                  employeeDataViewModel.addFamilyMember();
                },
              ),
              AppButton(
                width: displayWidth(context) * 0.50,
                //validation is remaining
                label: 'Next',
                onTap: () {
                  Navigator.pushNamed(context, AppRoutes.educationalDetails);
                  // employeeDataViewModel.addFamilyMember();
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
