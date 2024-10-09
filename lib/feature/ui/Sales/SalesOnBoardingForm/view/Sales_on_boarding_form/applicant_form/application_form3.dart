import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../../../base/routes/routes.dart';
import '../../../../../../base/utils/namespase/app_colors.dart';
import '../../../../../../base/utils/namespase/display_size.dart';
import '../../../../../../base/utils/widget/app_button.dart';
import '../../../../../../base/utils/widget/app_text_filed_login.dart';
import '../../../view_model/application_form_view_model.dart';

class ApplicantForm3 extends ConsumerWidget {
  const ApplicantForm3({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    //-------------------controllers--------------------------------------
    final formListController = ref.watch(applicantController);
    final formNotifierController = ref.read(applicantController.notifier);
    //--------------------------------------------------------------------------
    final personalFormState = ref.watch(applicantViewModelProvider);
    final personalFormViewModel = ref.read(applicantViewModelProvider.notifier);
    final personalFocusStates = ref.watch(applicantFocusProvider);
    final personalFocusViewModel = ref.read(applicantFocusProvider.notifier);
    final isRemember = ref.watch(rememberProvider);
    return Scaffold(
      body: Container(
        color: AppColors.primary,
        padding: const EdgeInsets.only(top: 80),
        child: Container(
          height: displayHeight(context),
          padding: const EdgeInsets.all(20),
          decoration: const BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30), topRight: Radius.circular(30))),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const BackButton(),
                  const Text(
                    textAlign: TextAlign.center,
                    'Applicant Details',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(
                    width: displayWidth(context) * 0.10,
                  )
                ],
              ),
              // const Text('Communication Address'),
              Expanded(
                child: SingleChildScrollView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  child: Wrap(children: [
                    Column(
                      children: [
                        SizedBox(
                          height: displayHeight(context) * 0.02,
                        ),
                        AppFloatTextField(
                          focusNode: personalFocusViewModel.emailFocusNode,
                          currentState: personalFocusStates['emailFocusNode'],
                          controller: formListController.emailController,
                          onChange: (value) {
                            personalFormViewModel.updateEmail(value);
                          },
                          height: !personalFormState.isEmailValid
                              ? displayHeight(context) * 0.09
                              : null,
                          inerHint: 'Email ID',
                          errorText: "Email ID is a required field",
                          isError: !personalFormState.isEmailValid,
                          textInputAction: TextInputAction.next,
                        ),
                        SizedBox(
                          height: displayHeight(context) * 0.02,
                        ),
                        AppFloatTextField(
                          focusNode: personalFocusViewModel.contactFocusNode,
                          currentState:
                          personalFocusStates['contactFocusNode'],
                          controller: formListController.contactController,
                          onChange: (value) {
                            personalFormViewModel.updateContact(value);
                          },
                          height: !personalFormState.isContactValid
                              ? displayHeight(context) * 0.09
                              : null,
                          inerHint: 'Contact Number',
                          errorText: "Contact is a required field",
                          isError: !personalFormState.isContactValid,
                          textInputAction: TextInputAction.next,
                        ),
                        SizedBox(
                          height: displayHeight(context) * 0.02,
                        ),
                        AppFloatTextField(
                          // initialValue: personalFormState.fullName,
                          focusNode: personalFocusViewModel.fullNameFocusNode,
                          currentState:
                          personalFocusStates['fullNameFocusNode'],
                          controller: formListController.fullNameController,
                          onChange: (value) {
                            personalFormViewModel.updateFullName(value);
                          },
                          height: !personalFormState.isFullNameValid
                              ? displayHeight(context) * 0.09
                              : null,
                          inerHint: 'Full Name',
                          errorText: "Full Name is a required field",
                          isError: !personalFormState.isFullNameValid,
                          textInputAction: TextInputAction.next,
                        ),
                        SizedBox(
                          height: displayHeight(context) * 0.02,
                        ),
                        AppFloatTextField(
                          focusNode: personalFocusViewModel.fatherNameFocusNode,
                          currentState:
                          personalFocusStates['fatherNameFocusNode'],
                          controller: formListController.fatherNameController,
                          onChange: (value) {
                            personalFormViewModel.updateEmail(value);
                          },
                          height: !personalFormState.isFatherNameValid
                              ? displayHeight(context) * 0.09
                              : null,
                          inerHint: 'Father Name',
                          errorText: "Father Name is a required field",
                          isError: !personalFormState.isFatherNameValid,
                          textInputAction: TextInputAction.next,
                        ),
                        SizedBox(
                          height: displayHeight(context) * 0.02,
                        ),
                        AppFloatTextField(
                          focusNode: personalFocusViewModel.dobFocusNode,
                          currentState: personalFocusStates['dobFocusNode'],
                          controller: formListController.dobController,
                          onChange: (value) {
                            personalFormViewModel.updateDob(value);
                          },
                          height: !personalFormState.isDobValid
                              ? displayHeight(context) * 0.09
                              : null,
                          inerHint: 'DOB',
                          errorText: "DOB is a required field",
                          isError: !personalFormState.isDobValid,
                          textInputAction: TextInputAction.next,
                        ),
                        SizedBox(
                          height: displayHeight(context) * 0.02,
                        ),
                        AppFloatTextField(
                          focusNode: personalFocusViewModel.ageFocusNode,
                          currentState: personalFocusStates['ageFocusNode'],
                          controller: formListController.ageController,
                          onChange: (value) {
                            personalFormViewModel.updateAge(value);
                          },
                          height: !personalFormState.isAgeValid
                              ? displayHeight(context) * 0.09
                              : null,
                          inerHint: 'Age',
                          errorText: "Age is a required field",
                          isError: !personalFormState.isAgeValid,
                          textInputAction: TextInputAction.next,
                        ),
                        SizedBox(
                          height: displayHeight(context) * 0.02,
                        ),
                        AppFloatTextField(
                          focusNode: personalFocusViewModel.genderFocusNode,
                          currentState: personalFocusStates['genderFocusNode'],
                          controller: formListController.genderController,
                          onChange: (value) {
                            personalFormViewModel.updateGender(value);
                          },
                          height: !personalFormState.isGenderValid
                              ? displayHeight(context) * 0.09
                              : null,
                          inerHint: 'Gender',
                          errorText: "Gender is a required field",
                          isError: !personalFormState.isGenderValid,
                          textInputAction: TextInputAction.next,
                        ),
                        SizedBox(
                          height: displayHeight(context) * 0.02,
                        ),

                        SizedBox(
                          height: displayHeight(context) * 0.02,
                        ),

                        AppButton(
                          textStyle: const TextStyle(color: AppColors.white),
                          width: displayWidth(context),
                          label: 'Next',
                          onTap: () {
                            Navigator.pushNamed(
                                context, AppRoutes.saleApplicationForm2);
                          },
                        ),
                        SizedBox(
                          height: displayHeight(context) * 0.01,
                        ),
                        // AppButton(
                        //   textStyle: const TextStyle(color: AppColors.white),
                        //   width: displayWidth(context),
                        //   label: 'Back',
                        //   onTap: () {},
                        // ),


                      ],
                    ),
                  ],),
                ),
              )

            ],
          ),
        ),
      ),
    );
  }
}
