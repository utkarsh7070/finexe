import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../../base/routes/routes.dart';
import '../../../../../../base/utils/namespase/app_colors.dart';
import '../../../../../../base/utils/namespase/display_size.dart';
import '../../../../../../base/utils/widget/app_button.dart';
import '../../../../../../base/utils/widget/app_text_filed_login.dart';
import '../../../view_model/guarantor_form_view_model.dart';

class GuarantorForm3 extends ConsumerWidget {
  const GuarantorForm3({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final personalFormState = ref.watch(guarantorViewModelProvider);
    final personalFormViewModel = ref.read(guarantorViewModelProvider.notifier);
    final personalFocusStates = ref.watch(guarantorFocusProvider);
    final personalFocusViewModel = ref.read(guarantorFocusProvider.notifier);
    final isRemember = ref.watch(guarantorRememberProvider);
    return Scaffold(
      body: Container(
        color: AppColors.primary,
        padding: const EdgeInsets.only(top: 100),
        child: Container(
          height: displayHeight(context),
          padding: const EdgeInsets.all(20),
          decoration: const BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30), topRight: Radius.circular(30))),
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const BackButton(),
                    const Text(
                      textAlign: TextAlign.center,
                      'Guarantor Details',
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
                Column(
                  children: [
                    SizedBox(
                      height: displayHeight(context) * 0.02,
                    ),
                    AppFloatTextField(
                      focusNode:
                      personalFocusViewModel.emailFocusNode,
                      currentState:
                      personalFocusStates['emailFocusNode'],
                      // controller: emailController,
                      onChange: (value) {
                        personalFormViewModel.updateEmail(value);
                      },
                      height: !personalFormState.isEmailValid
                          ? displayHeight(context) * 0.09
                          : null,
                      inerHint: 'Email ID',
                      errorText: "Email ID is a required field",
                      isError: !personalFormState.isEmailValid,
                      textInputAction: TextInputAction.done,
                    ),
                    SizedBox(
                      height: displayHeight(context) * 0.02,
                    ),
                    AppFloatTextField(
                      focusNode:
                      personalFocusViewModel.contactFocusNode,
                      currentState:
                      personalFocusStates['contactFocusNode'],
                      // controller: contactController,
                      onChange: (value) {
                        personalFormViewModel.updateContact(value);
                      },
                      height: !personalFormState.isContactValid
                          ? displayHeight(context) * 0.09
                          : null,
                      inerHint: 'Contact Number',
                      errorText: "Contact Number is a required field",
                      isError: !personalFormState.isContactValid,
                      textInputAction: TextInputAction.next,
                    ),
                    SizedBox(
                      height: displayHeight(context) * 0.02,
                    ),
                    AppFloatTextField(
                      focusNode:
                      personalFocusViewModel.fullNameFocusNode,
                      currentState:
                      personalFocusStates['fullNameFocusNode'],
                      // controller: contactController,
                      onChange: (value) {
                        personalFormViewModel.updateFullName(value);
                      },
                      height: !personalFormState.isFullNameValid
                          ? displayHeight(context) * 0.09
                          : null,
                      inerHint: 'Full Name',
                      errorText: "Full Name is a required field",
                      isError: !personalFormState.isFullNameValid,
                      textInputAction: TextInputAction.done,
                    ),
                    SizedBox(
                      height: displayHeight(context) * 0.02,
                    ),
                    AppFloatTextField(
                      focusNode:
                      personalFocusViewModel.fatherNameFocusNode,
                      currentState:
                      personalFocusStates['fatherNameFocusNode'],
                      // controller: emailController,
                      onChange: (value) {
                        personalFormViewModel.updateEmail(value);
                      },
                      height: !personalFormState.isFatherNameValid
                          ? displayHeight(context) * 0.09
                          : null,
                      inerHint: 'Father Name',
                      errorText: "Father Name is a required field",
                      isError: !personalFormState.isFatherNameValid,
                      textInputAction: TextInputAction.done,
                    ),
                    SizedBox(
                      height: displayHeight(context) * 0.02,
                    ),
                    AppFloatTextField(
                      focusNode: personalFocusViewModel.dobFocusNode,
                      currentState:
                      personalFocusStates['dobFocusNode'],
                      // controller: maritalController,
                      onChange: (value) {
                        personalFormViewModel.updateDob(value);
                      },
                      height: !personalFormState.isDobValid
                          ? displayHeight(context) * 0.09
                          : null,
                      inerHint: 'DOB',
                      errorText: "DOB is a required field",
                      isError: !personalFormState.isDobValid,
                      textInputAction: TextInputAction.done,
                    ),
                    SizedBox(
                      height: displayHeight(context) * 0.02,
                    ),
                    AppFloatTextField(
                      focusNode: personalFocusViewModel.ageFocusNode,
                      currentState:
                      personalFocusStates['ageFocusNode'],
                      // controller: religionController,
                      onChange: (value) {
                        personalFormViewModel.updateAge(value);
                      },
                      height: !personalFormState.isAgeValid
                          ? displayHeight(context) * 0.09
                          : null,
                      inerHint: 'Age',
                      errorText: "Age is a required field",
                      isError: !personalFormState.isAgeValid,
                      textInputAction: TextInputAction.done,
                    ),
                    SizedBox(
                      height: displayHeight(context) * 0.02,
                    ),
                    AppFloatTextField(
                      focusNode:
                      personalFocusViewModel.genderFocusNode,
                      currentState:
                      personalFocusStates['genderFocusNode'],
                      // controller: motherController,
                      onChange: (value) {
                        personalFormViewModel.updateGender(value);
                      },
                      height: !personalFormState.isGenderValid
                          ? displayHeight(context) * 0.09
                          : null,
                      inerHint: 'Gender',
                      errorText: "Gender is a required field",
                      isError: !personalFormState.isGenderValid,
                      textInputAction: TextInputAction.done,
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
                            context, AppRoutes.saleGuarantorForm2);
                      },),
                    SizedBox(
                      height: displayHeight(context) * 0.02,
                    ),
                    // AppButton(
                    //   textStyle: const TextStyle(color: AppColors.white),
                    //   width: displayWidth(context),
                    //   label: 'Back',
                    //   onTap: () {},
                    // ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
