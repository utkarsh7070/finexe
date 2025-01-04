import 'package:finexe/feature/base/routes/routes.dart';
import 'package:finexe/feature/base/utils/namespase/app_style.dart';
import 'package:finexe/feature/base/utils/namespase/display_size.dart';
import 'package:finexe/feature/base/utils/widget/app_button.dart';
import 'package:finexe/feature/ui/HRMS/EmployeeJoiningForm/view_model/employee_basic_details_view_model.dart';
import 'package:finexe/feature/ui/HRMS/EmployeeJoiningForm/widget/otp_dialog.dart';
import 'package:flutter/Material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../base/utils/widget/app_text_filed_login.dart';

class EmployeeBasicDetails extends ConsumerWidget {
  const EmployeeBasicDetails({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final employeeDataViewModel = ref.read(employeeViewModelProvider.notifier);
    final employeeDataController = ref.watch(employeeDetailsController);
    // final employeeDataState = ref.watch(employeeViewModelProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Employee Joining Form'),
      ),
      body: Container(
        padding: const EdgeInsets.all(16),
        height: displayHeight(context),
        width: displayWidth(context),
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Employee Basic Details'),
              SizedBox(
                height: displayHeight(context) * 0.01,
              ),
              AppFloatTextField(
                // focusNode:
                // personalFocusViewModel.aadhaarFocusNode,
                // currentState:
                // personalFocusStates['aadhaarFocusNode'],
                onChange: (value) {
                  employeeDataViewModel.updatePan(value);
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
              SizedBox(
                height: displayHeight(context) * 0.01,
              ),
              AppFloatTextField(
                // focusNode:
                // personalFocusViewModel.aadhaarFocusNode,
                // currentState:
                // personalFocusStates['aadhaarFocusNode'],
                onChange: (value) {
                  employeeDataViewModel.updateAadhaar(value);
                },
                // height: !personalFormState.isAadhaarValid
                //     ? displayHeight(context) * 0.09
                //     : null,
                inerHint: 'Enter Aadhaar Number',
                errorText: "Aadhaar Number is a required field",
                // isError: !personalFormState.isAadhaarValid,
                textInputType: TextInputType.number,
                textInputAction: TextInputAction.done,
              ),
              SizedBox(
                height: displayHeight(context) * 0.01,
              ),
              SizedBox(
                child: Center(
                  child: AppButton(
                    textStyle: AppStyles.buttonLightTextStyle,
                    width: displayWidth(context) * 0.50,
                    label: 'Send Otp',
                    onTap: () {
                      employeeDataViewModel.fetchAadhaarNumber(context).then((value) {
                        if(value){
                            OtpDialog().otpDialog(context: context);
                          }
                        },);

                    },
                  ),
                ),
              ),
              SizedBox(
                height: displayHeight(context) * 0.01,
              ),
               AppFloatTextField(
                 controller: employeeDataViewModel.fullNameController,
                // focusNode:
                // personalFocusViewModel.aadhaarFocusNode,
                // currentState:
                // personalFocusStates['aadhaarFocusNode'],
                onChange: (value) {
                  employeeDataViewModel.updateName(value);
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
                height: displayHeight(context) * 0.01,
              ),
               AppFloatTextField(
                // focusNode:
                // personalFocusViewModel.aadhaarFocusNode,
                // currentState:
                // personalFocusStates['aadhaarFocusNode'],
                onChange: (value) {
                  employeeDataViewModel.updateGender(value);
                },
                // height: !personalFormState.isAadhaarValid
                //     ? displayHeight(context) * 0.09
                //     : null,
                inerHint: 'Gender',
                errorText: "Gender is a required field",
                // isError: !personalFormState.isAadhaarValid,
                textInputType: TextInputType.text,
                textInputAction: TextInputAction.done,
              ),
              SizedBox(
                height: displayHeight(context) * 0.01,
              ),
               AppFloatTextField(
                // focusNode:
                // personalFocusViewModel.aadhaarFocusNode,
                // currentState:
                // personalFocusStates['aadhaarFocusNode'],
                onChange: (value) {
                  employeeDataViewModel.updateMaritalStatus(value);
                },
                // height: !personalFormState.isAadhaarValid
                //     ? displayHeight(context) * 0.09
                //     : null,
                inerHint: 'Marital Status',
                errorText: "Marital Status is a required field",
                // isError: !personalFormState.isAadhaarValid,
                textInputType: TextInputType.text,
                textInputAction: TextInputAction.done,
              ),
              SizedBox(
                height: displayHeight(context) * 0.01,
              ),
               AppFloatTextField(
                // focusNode:
                // personalFocusViewModel.aadhaarFocusNode,
                // currentState:
                // personalFocusStates['aadhaarFocusNode'],
                onChange: (value) {
                  employeeDataViewModel.updateContact(value);
                },
                // height: !personalFormState.isAadhaarValid
                //     ? displayHeight(context) * 0.09
                //     : null,
                inerHint: 'Contact',
                errorText: "Contact is a required field",
                // isError: !personalFormState.isAadhaarValid,
                textInputType: TextInputType.number,
                textInputAction: TextInputAction.done,
              ),
              SizedBox(
                height: displayHeight(context) * 0.01,
              ),
               AppFloatTextField(
                // focusNode:
                // personalFocusViewModel.aadhaarFocusNode,
                // currentState:
                // personalFocusStates['aadhaarFocusNode'],
                onChange: (value) {
                  employeeDataViewModel.updateEmail(value);
                },
                // height: !personalFormState.isAadhaarValid
                //     ? displayHeight(context) * 0.09
                //     : null,
                inerHint: 'Email',
                errorText: "Email is a required field",
                // isError: !personalFormState.isAadhaarValid,
                textInputType: TextInputType.text,
                textInputAction: TextInputAction.done,
              ),
              SizedBox(
                height: displayHeight(context) * 0.01,
              ),
              AppFloatTextField(
                controller: employeeDataViewModel.dobController,
                isReadOnly: true,
                suffixIcon: Icons.calendar_month,
                isSuffix: true,
                suffixOnTap: () {
                  employeeDataViewModel.openDatePicker(context);
                },
                // focusNode:
                // personalFocusViewModel.aadhaarFocusNode,
                // currentState:
                // personalFocusStates['aadhaarFocusNode'],
                onChange: (value) {
                  employeeDataViewModel.updateDob(value);
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
                height: displayHeight(context) * 0.01,
              ),
               AppFloatTextField(
                // focusNode:
                // personalFocusViewModel.aadhaarFocusNode,
                // currentState:
                // personalFocusStates['aadhaarFocusNode'],
                onChange: (value) {
                  employeeDataViewModel.updateIdentityMark(value);
                },
                // height: !personalFormState.isAadhaarValid
                //     ? displayHeight(context) * 0.09
                //     : null,
                inerHint: 'Identity Mark',
                errorText: "Identity Mark is a required field",
                // isError: !personalFormState.isAadhaarValid,
                textInputType: TextInputType.number,
                textInputAction: TextInputAction.done,
              ),
              SizedBox(
                height: displayHeight(context) * 0.01,
              ),
              const Text('Permanent Address'),
              SizedBox(
                height: displayHeight(context) * 0.01,
              ),
               AppFloatTextField(
                 height: displayHeight(context)*0.10,
                 controller: employeeDataViewModel.permanentAddress1Controller,
                // focusNode:
                // personalFocusViewModel.aadhaarFocusNode,
                // currentState:
                // personalFocusStates['aadhaarFocusNode'],
                onChange: (value) {
                  employeeDataViewModel.updatePermanentAddress(value);
                },
                // height: !personalFormState.isAadhaarValid
                //     ? displayHeight(context) * 0.09
                //     : null,
                inerHint: 'Permanent Address',
                errorText: "Permanent Address is a required field",
                // isError: !personalFormState.isAadhaarValid,
                textInputType: TextInputType.number,
                textInputAction: TextInputAction.done,
              ),
              SizedBox(
                height: displayHeight(context) * 0.01,
              ),
               AppFloatTextField(
                 controller: employeeDataViewModel.permanentStateController,
                // focusNode:
                // personalFocusViewModel.aadhaarFocusNode,
                // currentState:
                // personalFocusStates['aadhaarFocusNode'],
                onChange: (value) {
                  employeeDataViewModel.updatePermanentAddressState(value);
                },
                // height: !personalFormState.isAadhaarValid
                //     ? displayHeight(context) * 0.09
                //     : null,
                inerHint: 'Permanent Address State',
                errorText: "State is a required field",
                // isError: !personalFormState.isAadhaarValid,
                textInputType: TextInputType.number,
                textInputAction: TextInputAction.done,
              ),
              SizedBox(
                height: displayHeight(context) * 0.01,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  AppFloatTextField(
                    width: displayWidth(context) * 0.45,
                    controller: employeeDataViewModel.permanentCityController,
                    // focusNode:
                    // personalFocusViewModel.aadhaarFocusNode,
                    // currentState:
                    // personalFocusStates['aadhaarFocusNode'],
                    onChange: (value) {
                      employeeDataViewModel.updatePermanentCity(value);
                    },
                    // height: !personalFormState.isAadhaarValid
                    //     ? displayHeight(context) * 0.09
                    //     : null,
                    inerHint: 'City',
                    errorText: "City is a required field",
                    // isError: !personalFormState.isAadhaarValid,
                    textInputType: TextInputType.number,
                    textInputAction: TextInputAction.done,
                  ),
                  SizedBox(
                    height: displayHeight(context) * 0.01,
                  ),
                  AppFloatTextField(
                    width: displayWidth(context) * 0.45,
                    controller: employeeDataViewModel.permanentPinCodeController,
                    // focusNode:
                    // personalFocusViewModel.aadhaarFocusNode,
                    // currentState:
                    // personalFocusStates['aadhaarFocusNode'],
                    onChange: (value) {
                      employeeDataViewModel.updatePermanentPinCode(value);
                    },
                    // height: !personalFormState.isAadhaarValid
                    //     ? displayHeight(context) * 0.09
                    //     : null,
                    inerHint: 'PinCode',
                    errorText: "PinCode is a required field",
                    // isError: !personalFormState.isAadhaarValid,
                    textInputType: TextInputType.number,
                    textInputAction: TextInputAction.done,
                  ),
                ],
              ),
              SizedBox(
                height: displayHeight(context) * 0.01,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  AppFloatTextField(
                    width: displayWidth(context) * 0.45,
                    // focusNode:
                    // personalFocusViewModel.aadhaarFocusNode,
                    // currentState:
                    // personalFocusStates['aadhaarFocusNode'],
                    onChange: (value) {
                      employeeDataViewModel.updateLatitude(value);
                    },
                    // height: !personalFormState.isAadhaarValid
                    //     ? displayHeight(context) * 0.09
                    //     : null,
                    inerHint: 'Latitude',
                    errorText: "Latitude is a required field",
                    // isError: !personalFormState.isAadhaarValid,
                    textInputType: TextInputType.number,
                    textInputAction: TextInputAction.done,
                  ),
                  AppFloatTextField(
                    width: displayWidth(context) * 0.45,
                    // focusNode:
                    // personalFocusViewModel.aadhaarFocusNode,
                    // currentState:
                    // personalFocusStates['aadhaarFocusNode'],
                    onChange: (value) {
                      employeeDataViewModel.updateLongitude(value);
                    },
                    // height: !personalFormState.isAadhaarValid
                    //     ? displayHeight(context) * 0.09
                    //     : null,
                    inerHint: 'Longitude',
                    errorText: "Latitude is a required field",
                    // isError: !personalFormState.isAadhaarValid,
                    textInputType: TextInputType.number,
                    textInputAction: TextInputAction.done,
                  ),
                ],
              ),
              SizedBox(
                height: displayHeight(context) * 0.02,
              ),
              const Text('Current Address'),
              SizedBox(
                height: displayHeight(context) * 0.01,
              ),
               AppFloatTextField(
                // focusNode:
                // personalFocusViewModel.aadhaarFocusNode,
                // currentState:
                // personalFocusStates['aadhaarFocusNode'],
                onChange: (value) {
                  employeeDataViewModel.updateCurrentAddress(value);
                },
                // height: !personalFormState.isAadhaarValid
                //     ? displayHeight(context) * 0.09
                //     : null,
                inerHint: 'Current Address',
                errorText: "Address is a required field",
                // isError: !personalFormState.isAadhaarValid,
                textInputType: TextInputType.number,
                textInputAction: TextInputAction.done,
              ),
              SizedBox(
                height: displayHeight(context) * 0.01,
              ),
               AppFloatTextField(
                // focusNode:
                // personalFocusViewModel.aadhaarFocusNode,
                // currentState:
                // personalFocusStates['aadhaarFocusNode'],
                onChange: (value) {
                  employeeDataViewModel.updateCurrentState(value);
                },
                // height: !personalFormState.isAadhaarValid
                //     ? displayHeight(context) * 0.09
                //     : null,
                inerHint: 'State',
                errorText: "State is a required field",
                // isError: !personalFormState.isAadhaarValid,
                textInputType: TextInputType.number,
                textInputAction: TextInputAction.done,
              ),
              SizedBox(
                height: displayHeight(context) * 0.01,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  AppFloatTextField(
                    width: displayWidth(context) * 0.45,
                    // focusNode:
                    // personalFocusViewModel.aadhaarFocusNode,
                    // currentState:
                    // personalFocusStates['aadhaarFocusNode'],
                    onChange: (value) {
                      employeeDataViewModel.updateCurrentCity(value);
                    },
                    // height: !personalFormState.isAadhaarValid
                    //     ? displayHeight(context) * 0.09
                    //     : null,
                    inerHint: 'City',
                    errorText: "City is a required field",
                    // isError: !personalFormState.isAadhaarValid,
                    textInputType: TextInputType.text,
                    textInputAction: TextInputAction.done,
                  ),
                  AppFloatTextField(
                    width: displayWidth(context) * 0.45,
                    // focusNode:
                    // personalFocusViewModel.aadhaarFocusNode,
                    // currentState:
                    // personalFocusStates['aadhaarFocusNode'],
                    onChange: (value) {
                      employeeDataViewModel.updateCurrentPinCode(value);
                    },
                    // height: !personalFormState.isAadhaarValid
                    //     ? displayHeight(context) * 0.09
                    //     : null,
                    inerHint: 'PinCode',
                    errorText: "PinCode is a required field",
                    // isError: !personalFormState.isAadhaarValid,
                    textInputType: TextInputType.number,
                    textInputAction: TextInputAction.done,
                  ),
                ],
              ),
              SizedBox(
                height: displayHeight(context) * 0.01,
              ),
              AppButton(
                width: displayWidth(context) * 0.50,
                label: 'Next',
                onTap: () {
                 Navigator.pushNamed(context, AppRoutes.familyDetails);
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
