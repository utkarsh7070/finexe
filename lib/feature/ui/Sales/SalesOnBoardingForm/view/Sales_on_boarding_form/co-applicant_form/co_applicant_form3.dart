import 'package:finexe/feature/base/internetConnection/networklistener.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../../../base/utils/namespase/app_colors.dart';
import '../../../../../../base/utils/namespase/display_size.dart';
import '../../../../../../base/utils/widget/app_button.dart';
import '../../../../../../base/utils/widget/app_text_filed_login.dart';
import '../../../view_model/co_applicant_form_view_model.dart';

class CoApplicantForm3 extends ConsumerWidget {
  const CoApplicantForm3({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    //----------------controller-------------------------------------------------------
    final formListController = ref.watch(coApplicantController);
    final formNotifierController = ref.read(coApplicantController.notifier);
//---------------------------------------------------------------------------------
//
//     final removeScreen = ref.watch(count);
//     final remove = ref.read(count.notifier);
    final coApplicationFormState = ref.watch(coApplicantViewModelProvider);
    final coApplicationFormViewModel =
        ref.read(coApplicantViewModelProvider.notifier);
    final coApplicationFocusStates = ref.watch(coApplicantFocusProvider);
    final coApplicationFocusViewModel =
        ref.read(coApplicantFocusProvider.notifier);
    final index = ref.watch(listIndex);

    return NetworkListener(
      context: context,
      child: Scaffold(
          body: Container(
        width: displayWidth(context),
        height: displayHeight(context),
        color: AppColors.primary,
        padding: const EdgeInsets.only(top: 100),
        child: Container(
          height: displayHeight(context),
          padding: const EdgeInsets.all(20),
          decoration: const BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30), topRight: Radius.circular(30))),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  BackButton(onPressed: () {
                    ref.read(pageViewModelProvider.notifier).setTabIndex(0);
                  },),
                  const Text(
                    textAlign: TextAlign.center,
                    'Co-Applicant Details',
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
              SizedBox(
                height: displayHeight(context) * 0.01,
              ),
              Expanded(
                child: SingleChildScrollView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  child: Wrap(
                    crossAxisAlignment: WrapCrossAlignment.center,
                    verticalDirection: VerticalDirection.down,
                    runSpacing: displayHeight(context) * 0.04,
                    clipBehavior: Clip.none,
                    children: [
                      Column(
                        // mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          AppFloatTextField(
                            focusNode: coApplicationFocusViewModel.emailFocusNode,
                            currentState:
                                coApplicationFocusStates['emailFocusNode'],
                            controller: formListController[index].emailController,
                            onChange: (value) {
                              coApplicationFormViewModel.updateEmail(
                                  value, index);
                            },
                            height: !coApplicationFormState[index].isEmailValid
                                ? displayHeight(context) * 0.09
                                : null,
                            inerHint: 'Email ID',
                            errorText: "Email ID is a required field",
                            isError: !coApplicationFormState[index].isEmailValid,
                            textInputAction: TextInputAction.next,
                          ),
                          SizedBox(
                            height: displayHeight(context) * 0.02,
                          ),
                          AppFloatTextField(
                            focusNode:
                                coApplicationFocusViewModel.contactFocusNode,
                            currentState:
                                coApplicationFocusStates['contactFocusNode'],
                            controller:
                                formListController[index].contactController,
                            onChange: (value) {
                              coApplicationFormViewModel.updateContact(
                                  value, index);
                            },
                            height: !coApplicationFormState[index].isContactValid
                                ? displayHeight(context) * 0.09
                                : null,
                            inerHint: 'Contact Number',
                            errorText: "Contact Number is a required field",
                            isError:
                                !coApplicationFormState[index].isContactValid,
                            textInputAction: TextInputAction.next,
                          ),
                          SizedBox(
                            height: displayHeight(context) * 0.02,
                          ),
                          AppFloatTextField(
                            focusNode:
                                coApplicationFocusViewModel.fullNameFocusNode,
                            currentState:
                                coApplicationFocusStates['fullNameFocusNode'],
                            controller:
                                formListController[index].fullNameController,
                            onChange: (value) {
                              coApplicationFormViewModel.updateFullName(
                                  value, index);
                            },
                            height: !coApplicationFormState[index].isFullNameValid
                                ? displayHeight(context) * 0.09
                                : null,
                            inerHint: 'Full Name',
                            errorText: "Full Name is a required field",
                            isError:
                                !coApplicationFormState[index].isFullNameValid,
                            textInputAction: TextInputAction.next,
                          ),
                          SizedBox(
                            height: displayHeight(context) * 0.02,
                          ),
                          AppFloatTextField(
                            focusNode:
                                coApplicationFocusViewModel.fatherNameFocusNode,
                            currentState:
                                coApplicationFocusStates['fatherNameFocusNode'],
                            controller:
                                formListController[index].fatherNameController,
                            onChange: (value) {
                              coApplicationFormViewModel.updateEmail(
                                  value, index);
                            },
                            height:
                                !coApplicationFormState[index].isFatherNameValid
                                    ? displayHeight(context) * 0.09
                                    : null,
                            inerHint: 'Father Name',
                            errorText: "Father Name is a required field",
                            isError:
                                !coApplicationFormState[index].isFatherNameValid,
                            textInputAction: TextInputAction.next,
                          ),
                          SizedBox(
                            height: displayHeight(context) * 0.02,
                          ),
                          AppFloatTextField(
                            focusNode: coApplicationFocusViewModel.dobFocusNode,
                            currentState:
                                coApplicationFocusStates['dobFocusNode'],
                            controller: formListController[index].dobController,
                            onChange: (value) {
                              coApplicationFormViewModel.updateDob(value, index);
                            },
                            height: !coApplicationFormState[index].isDobValid
                                ? displayHeight(context) * 0.09
                                : null,
                            inerHint: 'DOB',
                            errorText: "DOB is a required field",
                            isError: !coApplicationFormState[index].isDobValid,
                            textInputAction: TextInputAction.next,
                          ),
                          SizedBox(
                            height: displayHeight(context) * 0.02,
                          ),
                          AppFloatTextField(
                            focusNode: coApplicationFocusViewModel.ageFocusNode,
                            currentState:
                                coApplicationFocusStates['ageFocusNode'],
                            controller: formListController[index].ageController,
                            onChange: (value) {
                              coApplicationFormViewModel.updateAge(value, index);
                            },
                            height: !coApplicationFormState[index].isAgeValid
                                ? displayHeight(context) * 0.09
                                : null,
                            inerHint: 'Age',
                            errorText: "Age is a required field",
                            isError: !coApplicationFormState[index].isAgeValid,
                            textInputAction: TextInputAction.next,
                          ),
                          SizedBox(
                            height: displayHeight(context) * 0.02,
                          ),
                          AppFloatTextField(
                            focusNode:
                                coApplicationFocusViewModel.genderFocusNode,
                            currentState:
                                coApplicationFocusStates['genderFocusNode'],
                            controller:
                                formListController[index].genderController,
                            onChange: (value) {
                              coApplicationFormViewModel.updateGender(
                                  value, index);
                            },
                            height: !coApplicationFormState[index].isGenderValid
                                ? displayHeight(context) * 0.09
                                : null,
                            inerHint: "Gender",
                            errorText: "Gender is a required field",
                            isError: !coApplicationFormState[index].isGenderValid,
                            textInputAction: TextInputAction.next,
                          ),
                          SizedBox(
                            height: displayHeight(context) * 0.02,
                          ),
                          AppButton(
                            textStyle: const TextStyle(color: AppColors.white),
                            width: displayWidth(context),
                            label: 'Next',
                            onTap: () {
                              // remove.state = removeScreen + 1;
                              ref.read(pageViewModelProvider.notifier).setTabIndex(2);
                              // Navigator.of(context).push(MaterialPageRoute(
                              //     builder: (context) =>
                              //         const CoApplicantForm2()));
                              //
                              // Navigator.pushNamed(
                              //     context, AppRoutes.saleCoApplicationForm2);
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
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      )),
    );
  }
}
