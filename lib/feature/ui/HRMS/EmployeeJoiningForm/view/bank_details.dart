import 'package:dropdown_textfield/dropdown_textfield.dart';
import 'package:finexe/feature/base/routes/routes.dart';
import 'package:finexe/feature/base/utils/namespase/app_style.dart';
import 'package:finexe/feature/base/utils/namespase/display_size.dart';
import 'package:finexe/feature/base/utils/widget/app_button.dart';
import 'package:flutter/Material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../base/utils/namespase/app_colors.dart';
import '../../../../base/utils/widget/app_text_filed_login.dart';
import '../view_model/employee_basic_details_view_model.dart';

class BankDetails extends ConsumerWidget {
  const BankDetails({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final employeeDataViewModel = ref.read(employeeViewModelProvider.notifier);
    final employeeFocusState = ref.watch(joiningFormFocusProvider);
    final employeeFocusViewModel = ref.watch(joiningFormFocusProvider.notifier);
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Bank Details'),
        ),
        body: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                AppFloatTextField(
                  // focusNode:
                  // personalFocusViewModel.aadhaarFocusNode,
                  // currentState:
                  // personalFocusStates['aadhaarFocusNode'],
                  onChange: (value) {
                    employeeDataViewModel.updateBankAccountNumber(value);
                  },
                  // height: !personalFormState.isAadhaarValid
                  //     ? displayHeight(context) * 0.09
                  //     : null,
                  inerHint: 'Enter Pan Number',
                  errorText: "Pan Number is a required field",
                  // isError: !personalFormState.isAadhaarValid,
                  textInputType: TextInputType.text,
                  textInputAction: TextInputAction.done,
                ),
                SizedBox(height: displayHeight(context)*0.01,),
                AppFloatTextField(
                  // focusNode:
                  // personalFocusViewModel.aadhaarFocusNode,
                  // currentState:
                  // personalFocusStates['aadhaarFocusNode'],
                  onChange: (value) {
                    employeeDataViewModel.updateIfscCode(value);
                  },
                  // height: !personalFormState.isAadhaarValid
                  //     ? displayHeight(context) * 0.09
                  //     : null,
                  inerHint: 'Enter Pan Number',
                  errorText: "Pan Number is a required field",
                  // isError: !personalFormState.isAadhaarValid,
                  textInputType: TextInputType.text,
                  textInputAction: TextInputAction.done,
                ),
                SizedBox(height: displayHeight(context)*0.01,),
                AppButton(
                  width: displayWidth(context) * 0.50,
                  onTap: () {},
                  label: 'Fetch Bank Details',
                ),
                SizedBox(height: displayHeight(context)*0.01,),
                AppFloatTextField(
                  // focusNode:
                  // personalFocusViewModel.aadhaarFocusNode,
                  // currentState:
                  // personalFocusStates['aadhaarFocusNode'],
                  onChange: (value) {
                    employeeDataViewModel.updateBankName(value);
                  },
                  // height: !personalFormState.isAadhaarValid
                  //     ? displayHeight(context) * 0.09
                  //     : null,
                  inerHint: 'Bank Name',
                  errorText: "Bank Name is a required field",
                  // isError: !personalFormState.isAadhaarValid,
                  textInputType: TextInputType.text,
                  textInputAction: TextInputAction.done,
                ),
                SizedBox(height: displayHeight(context)*0.01,),
                AppFloatTextField(
                  // focusNode:
                  // personalFocusViewModel.aadhaarFocusNode,
                  // currentState:
                  // personalFocusStates['aadhaarFocusNode'],
                  onChange: (value) {
                    employeeDataViewModel.updateNameAsPerBank(value);
                  },
                  // height: !personalFormState.isAadhaarValid
                  //     ? displayHeight(context) * 0.09
                  //     : null,
                  inerHint: 'Name As Per Bank',
                  errorText: "Name As Per Bank is a required field",
                  // isError: !personalFormState.isAadhaarValid,
                  textInputType: TextInputType.text,
                  textInputAction: TextInputAction.done,
                ),
                SizedBox(height: displayHeight(context)*0.01,),
                AppFloatTextField(
                  // focusNode:
                  // personalFocusViewModel.aadhaarFocusNode,
                  // currentState:
                  // personalFocusStates['aadhaarFocusNode'],
                  onChange: (value) {
                    employeeDataViewModel.updateBranchAddress(value);
                  },
                  // height: !personalFormState.isAadhaarValid
                  //     ? displayHeight(context) * 0.09
                  //     : null,
                  inerHint: 'Branch Address',
                  errorText: "Branch Address is a required field",
                  // isError: !personalFormState.isAadhaarValid,
                  textInputType: TextInputType.text,
                  textInputAction: TextInputAction.done,
                ),
                SizedBox(height: displayHeight(context)*0.01,),
                AppFloatTextField(
                  // focusNode:
                  // personalFocusViewModel.aadhaarFocusNode,
                  // currentState:
                  // personalFocusStates['aadhaarFocusNode'],
                  onChange: (value) {
                    employeeDataViewModel.updateUANNo(value);
                  },
                  // height: !personalFormState.isAadhaarValid
                  //     ? displayHeight(context) * 0.09
                  //     : null,
                  inerHint: 'UAN No',
                  errorText: "UAN No is a required field",
                  // isError: !personalFormState.isAadhaarValid,
                  textInputType: TextInputType.text,
                  textInputAction: TextInputAction.done,
                ),
                SizedBox(height: displayHeight(context)*0.01,),
                AppFloatTextField(
                  // focusNode:
                  // personalFocusViewModel.aadhaarFocusNode,
                  // currentState:
                  // personalFocusStates['aadhaarFocusNode'],
                  onChange: (value) {
                    employeeDataViewModel.updateEsicNumber(value);
                  },
                  // height: !personalFormState.isAadhaarValid
                  //     ? displayHeight(context) * 0.09
                  //     : null,
                  inerHint: 'Esic Number',
                  errorText: "Esic Number is a required field",
                  // isError: !personalFormState.isAadhaarValid,
                  textInputType: TextInputType.text,
                  textInputAction: TextInputAction.done,
                ),
                SizedBox(height: displayHeight(context)*0.02,),
                const Text('Mark the attached documents'),
                SizedBox(height: displayHeight(context)*0.01,),
                AppFloatTextField(
                  // focusNode:
                  // personalFocusViewModel.aadhaarFocusNode,
                  // currentState:
                  // personalFocusStates['aadhaarFocusNode'],
                  onChange: (value) {
                    employeeDataViewModel.updateEsicNumber(value);
                  },

                  inerHint: 'Height(cm)',
                  errorText: "Height is a required field",
                  // isError: !personalFormState.isAadhaarValid,
                  textInputType: TextInputType.text,
                  textInputAction: TextInputAction.done,
                ),
                SizedBox(height: displayHeight(context)*0.01,),
                AppFloatTextField(
                  onChange: (value) {
                    employeeDataViewModel.updateCaste(value);
                  },
                  inerHint: 'Caste',
                  errorText: "Caste is a required field",
                  // isError: !personalFormState.isAadhaarValid,
                  textInputType: TextInputType.text,
                  textInputAction: TextInputAction.done,
                ),
                SizedBox(height: displayHeight(context)*0.01,),
                DropDownTextField(
                  clearOption: false,
                  controller: employeeDataViewModel.categoryControllerProvider,
                  listSpace: 20,
                  textFieldFocusNode: employeeFocusViewModel.categoryFocusNode,
                  listPadding: ListPadding(top: 20),
                  enableSearch: false,
                  dropDownList: employeeDataViewModel.categoryDropdown,
                  listTextStyle: const TextStyle(color: AppColors.primary),
                  dropDownItemCount: 4,
                  onChanged: (val) {
                    // FocusScope.of(context).unfocus();
                    employeeDataViewModel.updateCategory(val);
                  },
                  textFieldDecoration:  InputDecoration(
                    hintStyle: const TextStyle(color: AppColors.textGray),
                    floatingLabelStyle: employeeFocusState['categoryFocusNode']!
                        ? AppStyles.subHeading
                        .copyWith(color: AppColors.primary)
                        : AppStyles.subHeading,
                    label: const Text(
                      'Cotegory',
                      // style: const TextStyle(color: AppColors.textGray),
                    ),

                    // errorText: isError! ? errorText : null,
                    enabledBorder: const OutlineInputBorder(
                        borderSide: BorderSide(
                            color: AppColors.buttonBorderGray, width: 1),
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                    // filled: true,
                    // fillColor: AppColors.gray,
                    border: const OutlineInputBorder(
                      borderSide: BorderSide(
                          color: AppColors.buttonBorderGray, width: 1),
                      borderRadius: BorderRadius.all(Radius.circular(10)),
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
                SizedBox(height: displayHeight(context)*0.01,),
                DropDownTextField(
                  clearOption: false,
                  controller: employeeDataViewModel.religionControllerProvider,
                  listSpace: 20,
                  listPadding: ListPadding(top: 20),
                  enableSearch: false,
                  dropDownList: employeeDataViewModel.religionDropdown,
                  listTextStyle: const TextStyle(color: AppColors.primary),
                  // dropDownItemCount: 3,
                  onChanged: (val) {
                    employeeDataViewModel.updateReligion(val);
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
                      'Religion',
                      // style: const TextStyle(color: AppColors.textGray),
                    ),

                    // errorText: isError! ? errorText : null,
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: AppColors.buttonBorderGray, width: 1),
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                    // filled: true,
                    // fillColor: AppColors.gray,
                    border: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: AppColors.buttonBorderGray, width: 1),
                      borderRadius: BorderRadius.all(Radius.circular(10)),
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
                SizedBox(height: displayHeight(context)*0.01,),
                DropDownTextField(
                  clearOption: false,
                  controller:
                      employeeDataViewModel.bloodGroupControllerProvider,
                  listSpace: 20,
                  listPadding: ListPadding(top: 20),
                  enableSearch: false,
                  dropDownList: employeeDataViewModel.bloodGroupDropdown,
                  listTextStyle: const TextStyle(color: AppColors.primary),
                  // dropDownItemCount: 3,
                  onChanged: (val) {
                    employeeDataViewModel.updateBloodGroup(val);
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
                      'Blood Group',
                      // style: const TextStyle(color: AppColors.textGray),
                    ),

                    // errorText: isError! ? errorText : null,
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: AppColors.buttonBorderGray, width: 1),
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                    // filled: true,
                    // fillColor: AppColors.gray,
                    border: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: AppColors.buttonBorderGray, width: 1),
                      borderRadius: BorderRadius.all(Radius.circular(10)),
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
                SizedBox(height: displayHeight(context)*0.01,),
                AppFloatTextField(
                  // focusNode:
                  // personalFocusViewModel.aadhaarFocusNode,
                  // currentState:
                  // personalFocusStates['aadhaarFocusNode'],
                  onChange: (value) {
                    employeeDataViewModel.updateHomeDistrict(value);
                  },
                  // height: !personalFormState.isAadhaarValid
                  //     ? displayHeight(context) * 0.09
                  //     : null,
                  inerHint: 'Home District',
                  errorText: "Home District is a required field",
                  // isError: !personalFormState.isAadhaarValid,
                  textInputType: TextInputType.text,
                  textInputAction: TextInputAction.done,
                ),
                SizedBox(height: displayHeight(context)*0.01,),
                AppFloatTextField(
                  // focusNode:
                  // personalFocusViewModel.aadhaarFocusNode,
                  // currentState:
                  // personalFocusStates['aadhaarFocusNode'],
                  onChange: (value) {
                    employeeDataViewModel.updateHomeState(value);
                  },
                  // height: !personalFormState.isAadhaarValid
                  //     ? displayHeight(context) * 0.09
                  //     : null,
                  inerHint: 'Home State',
                  errorText: "Home State is a required field",
                  // isError: !personalFormState.isAadhaarValid,
                  textInputType: TextInputType.text,
                  textInputAction: TextInputAction.done,
                ),
                SizedBox(height: displayHeight(context)*0.01,),
                AppFloatTextField(
                  // focusNode:
                  // personalFocusViewModel.aadhaarFocusNode,
                  // currentState:
                  // personalFocusStates['aadhaarFocusNode'],
                  onChange: (value) {
                    employeeDataViewModel.updateNearestRailwayStation(value);
                  },
                  // height: !personalFormState.isAadhaarValid
                  //     ? displayHeight(context) * 0.09
                  //     : null,
                  inerHint: 'Nearest Railway Station',
                  errorText: "Nearest Railway Station is a required field",
                  // isError: !personalFormState.isAadhaarValid,
                  textInputType: TextInputType.text,
                  textInputAction: TextInputAction.done,
                ),
                SizedBox(height: displayHeight(context)*0.01,),
                AppFloatTextField(
                  // focusNode:
                  // personalFocusViewModel.aadhaarFocusNode,
                  // currentState:
                  // personalFocusStates['aadhaarFocusNode'],
                  onChange: (value) {
                    employeeDataViewModel.updateUniversity(value);
                  },
                  // height: !personalFormState.isAadhaarValid
                  //     ? displayHeight(context) * 0.09
                  //     : null,
                  inerHint: 'University',
                  errorText: "University is a required field",
                  // isError: !personalFormState.isAadhaarValid,
                  textInputType: TextInputType.text,
                  textInputAction: TextInputAction.done,
                ),
                SizedBox(height: displayHeight(context)*0.01,),
                AppButton(
                  width: displayWidth(context)*0.60,
                  textStyle: AppStyles.blacktext14.copyWith(color: AppColors.white),
                  label: 'Next',
                  onTap: () {
                    Navigator.pushNamed(context, AppRoutes.nomineeInformation);
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
