import 'package:dropdown_textfield/dropdown_textfield.dart';
import 'package:finexe/feature/base/utils/widget/app_button.dart';
import 'package:finexe/feature/base/utils/widget/app_list_view.dart';
import 'package:flutter/Material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../base/utils/namespase/app_colors.dart';
import '../../../../base/utils/namespase/display_size.dart';
import '../../../../base/utils/widget/app_text_filed_login.dart';
import '../view_model/employee_basic_details_view_model.dart';

class NomineeInformation extends ConsumerWidget{
  const NomineeInformation({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final employeeDataViewModel = ref.read(employeeViewModelProvider.notifier);
    final employeeDataState = ref.watch(employeeViewModelProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Nominee Information'),
      ),
      body:
      SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        child: Column(
          children: [
            AppListview(
                builder: (p0, p1) {
             return Column(
                children: [
                  Text('Nominee $p1'),
                  AppFloatTextField(
                    // focusNode:
                    // personalFocusViewModel.aadhaarFocusNode,
                    // currentState:
                    // personalFocusStates['aadhaarFocusNode'],
                    onChange: (value) {
                      employeeDataViewModel.updateNomineeName(value);
                    },
                    // height: !personalFormState.isAadhaarValid
                    //     ? displayHeight(context) * 0.09
                    //     : null,
                    inerHint: 'Nominee Name',
                    errorText: "Nominee Name is a required field",
                    // isError: !personalFormState.isAadhaarValid,
                    textInputType: TextInputType.text,
                    textInputAction: TextInputAction.done,
                  ),
                  AppFloatTextField(
                    // focusNode:
                    // personalFocusViewModel.aadhaarFocusNode,
                    // currentState:
                    // personalFocusStates['aadhaarFocusNode'],
                    onChange: (value) {
                      employeeDataViewModel.updateRelationWithEmployee(value);
                    },
                    // height: !personalFormState.isAadhaarValid
                    //     ? displayHeight(context) * 0.09
                    //     : null,
                    inerHint: 'Relation With Employee',
                    errorText: "Caste is a required field",
                    // isError: !personalFormState.isAadhaarValid,
                    textInputType: TextInputType.text,
                    textInputAction: TextInputAction.done,
                  ),
                  SizedBox(height: displayHeight(context)*0.01,),
                  DropDownTextField(
                    clearOption: false,
                    controller: employeeDataViewModel
                        .nominationTypeControllerProvider,
                    listSpace: 20,
                    listPadding: ListPadding(top: 20),
                    enableSearch: false,
                    dropDownList: employeeDataViewModel.nominationTypeDropdown,
                    listTextStyle:
                    const TextStyle(color: AppColors.primary),
                    // dropDownItemCount: 3,
                    onChanged: (val) {
                      employeeDataViewModel
                          .updateNominationType(val);
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
                        'Nomination Type',
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
                  SizedBox(height: displayHeight(context)*0.01,),
                  AppFloatTextField(
                    // focusNode:
                    // personalFocusViewModel.aadhaarFocusNode,
                    // currentState:
                    // personalFocusStates['aadhaarFocusNode'],
                    onChange: (value) {
                      employeeDataViewModel.updateNomineeAge(value);
                    },
                    // height: !personalFormState.isAadhaarValid
                    //     ? displayHeight(context) * 0.09
                    //     : null,
                    inerHint: 'Nominee Age',
                    errorText: "Nominee Age is a required field",
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
                      employeeDataViewModel.updateNomineeAddress(value);
                    },
                    // height: !personalFormState.isAadhaarValid
                    //     ? displayHeight(context) * 0.09
                    //     : null,
                    inerHint: 'Nominee Address',
                    errorText: "Nominee Address is a required field",
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
                      employeeDataViewModel.updateNomineeState(value);
                    },
                    // height: !personalFormState.isAadhaarValid
                    //     ? displayHeight(context) * 0.09
                    //     : null,
                    inerHint: 'Nominee State',
                    errorText: "Nominee State is a required field",
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
                      employeeDataViewModel.updateNomineeDistrict(value);
                    },
                    // height: !personalFormState.isAadhaarValid
                    //     ? displayHeight(context) * 0.09
                    //     : null,
                    inerHint: 'Nominee District',
                    errorText: "District is a required field",
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
                      employeeDataViewModel.updateNomineeBlock(value);
                    },
                    // height: !personalFormState.isAadhaarValid
                    //     ? displayHeight(context) * 0.09
                    //     : null,
                    inerHint: 'Block',
                    errorText: "Block is a required field",
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
                      employeeDataViewModel.updateNomineePanchayat(value);
                    },
                    // height: !personalFormState.isAadhaarValid
                    //     ? displayHeight(context) * 0.09
                    //     : null,
                    inerHint: 'Panchayat',
                    errorText: "Panchayat is a required field",
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
                      employeeDataViewModel.updateNomineePincode(value);
                    },
                    // height: !personalFormState.isAadhaarValid
                    //     ? displayHeight(context) * 0.09
                    //     : null,
                    inerHint: 'Nominee Pincode',
                    errorText: "Nominee Pincode is a required field",
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
                      employeeDataViewModel.updateNomineePhoneNumber(value);
                    },
                    // height: !personalFormState.isAadhaarValid
                    //     ? displayHeight(context) * 0.09
                    //     : null,
                    inerHint: 'Nominee Phone Number',
                    errorText: "Nominee Phone Number is a required field",
                    // isError: !personalFormState.isAadhaarValid,
                    textInputType: TextInputType.text,
                    textInputAction: TextInputAction.done,
                  ),
                  Visibility(
                      visible: p1 >= 1,
                      child: IconButton(
                          onPressed: () {
                            employeeDataViewModel.removeNominee(p1);
                          },
                          icon: const Icon(Icons.minimize)))
                ],
              );
            }, items: employeeDataState.nomineeInformation.length, scrollPhysics: const NeverScrollableScrollPhysics()),
            AppButton(label: 'Add Another Nominee',onTap: () {
              employeeDataViewModel.addNominee();
            },)
          ],
        ),
      )

    );
  }
  
}