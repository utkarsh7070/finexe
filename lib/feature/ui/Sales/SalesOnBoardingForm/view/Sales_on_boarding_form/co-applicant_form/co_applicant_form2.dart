import 'package:finexe/feature/base/internetConnection/networklistener.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../../base/routes/routes.dart';
import '../../../../../../base/utils/namespase/app_colors.dart';
import '../../../../../../base/utils/namespase/display_size.dart';
import '../../../../../../base/utils/widget/app_button.dart';
import '../../../../../../base/utils/widget/app_text_filed_login.dart';
import '../../../view_model/co_applicant_form_view_model.dart';
import 'co_applicant_form1.dart';

class CoApplicantForm2 extends ConsumerWidget {
  const CoApplicantForm2({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    //----------------controller-------------------------------------------------------
    final formListController = ref.watch(coApplicantController);
    final formNotifierController = ref.read(coApplicantController.notifier);
//---------------------------------------------------------------------------------
//     final removeScreen = ref.watch(count);
//     final remove = ref.read(count.notifier);
    final coAddressRadio = ref.watch(coApplicantAddressRoleProvider);
    final coAddressRadioViewModel =
        ref.watch(coApplicantAddressRoleProvider.notifier);
    final coApplicationFormState = ref.watch(coApplicantViewModelProvider);
    final coApplicationFormViewModel =
        ref.read(coApplicantViewModelProvider.notifier);
    final coApplicationFocusStates = ref.watch(coApplicantFocusProvider);
    final coApplicationFocusViewModel =
        ref.read(coApplicantFocusProvider.notifier);
    final index = ref.watch(listIndex);
    final indexAdd = ref.watch(listIndex.notifier);

    return NetworkListener(
      context: context,
      child: Scaffold(
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
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                     BackButton(onPressed: () {
                      ref.read(pageViewModelProvider.notifier).setTabIndex(1);
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
                // SizedBox(
                //   height: displayHeight(context) * 0.02,
                // ),
                Expanded(
                  child: SingleChildScrollView(
                      padding: const EdgeInsets.only(top: 30),
                      physics: const AlwaysScrollableScrollPhysics(),
                      child: Wrap(
                          runSpacing: 15,
                          clipBehavior: Clip.none,
                          children: [
                            AppFloatTextField(
                              focusNode: coApplicationFocusViewModel
                                  .communicationAddress1FocusNode,
                              currentState: coApplicationFocusStates[
                                  'communicationAddress1FocusNode'],
                              controller: formListController[index]
                                  .communicationAddress1Controller,
                              onChange: (value) {
                                coApplicationFormViewModel
                                    .updateCommunicationAddress1(value, index);
                              },
                              height: !coApplicationFormState[index]
                                      .isCommunicationAddress1Valid
                                  ? displayHeight(context) * 0.09
                                  : null,
                              inerHint: 'Address1',
                              errorText: "Address1 is a required field",
                              isError: !coApplicationFormState[index]
                                  .isCommunicationAddress1Valid,
                              textInputAction: TextInputAction.next,
                            ),
                            SizedBox(
                              height: displayHeight(context) * 0.02,
                            ),
                            AppFloatTextField(
                              focusNode: coApplicationFocusViewModel
                                  .communicationAddress2FocusNode,
                              currentState: coApplicationFocusStates[
                                  'communicationAddress2FocusNode'],
                              controller: formListController[index]
                                  .communicationAddress2Controller,
                              onChange: (value) {
                                coApplicationFormViewModel
                                    .updateCommunicationAddress2(value, index);
                              },
                              height: !coApplicationFormState[index].isGenderValid
                                  ? displayHeight(context) * 0.09
                                  : null,
                              inerHint: 'Address2',
                              errorText: "Address2 is a required field",
                              isError: !coApplicationFormState[index]
                                  .isCommunicationAddress2Valid,
                              textInputAction: TextInputAction.next,
                            ),
                            SizedBox(
                              height: displayHeight(context) * 0.02,
                            ),
                            AppFloatTextField(
                              focusNode: coApplicationFocusViewModel
                                  .communicationCityFocusNode,
                              currentState: coApplicationFocusStates[
                                  'communicationCityFocusNode'],
                              controller: formListController[index]
                                  .communicationCityController,
                              onChange: (value) {
                                coApplicationFormViewModel
                                    .updateCommunicationCity(value, index);
                              },
                              height: !coApplicationFormState[index]
                                      .isCommunicationCityValid
                                  ? displayHeight(context) * 0.09
                                  : null,
                              inerHint: 'City',
                              errorText: "City is a required field",
                              isError: !coApplicationFormState[index]
                                  .isCommunicationCityValid,
                              textInputAction: TextInputAction.next,
                            ),
                            SizedBox(
                              height: displayHeight(context) * 0.02,
                            ),
                            AppFloatTextField(
                              focusNode: coApplicationFocusViewModel
                                  .communicationStateFocusNode,
                              currentState: coApplicationFocusStates[
                                  'communicationStateFocusNode'],
                              controller: formListController[index]
                                  .communicationStateController,
                              onChange: (value) {
                                coApplicationFormViewModel
                                    .updateCommunicationState(value, index);
                              },
                              height: !coApplicationFormState[index]
                                      .isCommunicationStateValid
                                  ? displayHeight(context) * 0.09
                                  : null,
                              inerHint: 'State',
                              errorText: "State is a required field",
                              isError: !coApplicationFormState[index]
                                  .isCommunicationStateValid,
                              textInputAction: TextInputAction.next,
                            ),
                            SizedBox(
                              height: displayHeight(context) * 0.02,
                            ),
                            AppFloatTextField(
                              focusNode: coApplicationFocusViewModel
                                  .communicationDistrictFocusNode,
                              currentState: coApplicationFocusStates[
                                  'communicationDistrictFocusNode'],
                              controller: formListController[index]
                                  .communicationDistrictController,
                              onChange: (value) {
                                coApplicationFormViewModel
                                    .updateCommunicationDistrict(value, index);
                              },
                              height: !coApplicationFormState[index]
                                      .isCommunicationDistrictValid
                                  ? displayHeight(context) * 0.09
                                  : null,
                              inerHint: 'District',
                              errorText: "District is a required field",
                              isError: !coApplicationFormState[index]
                                  .isCommunicationDistrictValid,
                              textInputAction: TextInputAction.next,
                            ),
                            SizedBox(
                              height: displayHeight(context) * 0.02,
                            ),
                            AppFloatTextField(
                              focusNode: coApplicationFocusViewModel
                                  .communicationPinCodeFocusNode,
                              currentState: coApplicationFocusStates[
                                  'communicationPinCodeFocusNode'],
                              controller: formListController[index]
                                  .communicationPinCodeController,
                              onChange: (value) {
                                coApplicationFormViewModel
                                    .updateCommunicationPinCode(value, index);
                              },
                              height: !coApplicationFormState[index]
                                      .isCommunicationPinCodeValid
                                  ? displayHeight(context) * 0.09
                                  : null,
                              inerHint: 'PinCode',
                              errorText: "PinCode is a required field",
                              isError: !coApplicationFormState[index]
                                  .isCommunicationPinCodeValid,
                              textInputAction: TextInputAction.next,
                            ),
                            SizedBox(
                              height: displayHeight(context) * 0.02,
                            ),
                            const Text('Same as permanent address'),
                            Row(
                              children: [
                                SizedBox(
                                  width: MediaQuery.of(context).size.width * 0.30,
                                  child: Row(
                                    children: [
                                      Radio<CoApplicantOptionRole>(
                                        value: CoApplicantOptionRole.Yes,
                                        groupValue: coAddressRadio,
                                        onChanged: (value) {
                                          if (value != null) {
                                            coAddressRadioViewModel
                                                .selectAddress(value);
                                            coApplicationFormViewModel
                                                .localAddCopyPermanentAdd(index);
                                          }
                                          // showBottomSheetIfYes(
                                          //   context: context,
                                          //   ref: ref,
                                          // );
                                        },
                                      ),
                                      const Text(
                                        'Yes',
                                      )
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  width: MediaQuery.of(context).size.width * 0.30,
                                  child: Row(
                                    children: [
                                      Radio<CoApplicantOptionRole>(
                                        value: CoApplicantOptionRole.NO,
                                        groupValue: coAddressRadio,
                                        onChanged: (value) {
                                          if (value != null) {
                                            coAddressRadioViewModel
                                                .selectAddress(value);
                                          }
                                          // showBottomSheetIfYes(
                                          //   context: context,
                                          //   ref: ref,
                                          // );
                                        },
                                      ),
                                      const Text(
                                        'No',
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            Visibility(
                                visible:
                                    coAddressRadio == CoApplicantOptionRole.NO,
                                child: Column(
                                  children: [
                                    AppFloatTextField(
                                      focusNode: coApplicationFocusViewModel
                                          .permanentAddress1FocusNode,
                                      currentState: coApplicationFocusStates[
                                          'permanentAddress1FocusNode'],
                                      controller: formListController[index]
                                          .permanentAddress1Controller,
                                      onChange: (value) {
                                        coApplicationFormViewModel
                                            .updatePermanentAddress1(
                                                value, index);
                                      },
                                      height: !coApplicationFormState[index]
                                              .isPermanentAddress1Valid
                                          ? displayHeight(context) * 0.09
                                          : null,
                                      inerHint: 'Address1',
                                      errorText: "Address1 is a required field",
                                      isError: !coApplicationFormState[index]
                                          .isPermanentAddress1Valid,
                                      textInputAction: TextInputAction.next,
                                    ),
                                    SizedBox(
                                      height: displayHeight(context) * 0.02,
                                    ),
                                    AppFloatTextField(
                                      focusNode: coApplicationFocusViewModel
                                          .permanentAddress2FocusNode,
                                      currentState: coApplicationFocusStates[
                                          'permanentAddress2FocusNode'],
                                      controller: formListController[index]
                                          .permanentAddress2Controller,
                                      onChange: (value) {
                                        coApplicationFormViewModel
                                            .updatePermanentAddress2(
                                                value, index);
                                      },
                                      height: !coApplicationFormState[index]
                                              .isPermanentAddress2Valid
                                          ? displayHeight(context) * 0.09
                                          : null,
                                      inerHint: 'Address2',
                                      errorText: "Address2 is a required field",
                                      isError: !coApplicationFormState[index]
                                          .isPermanentAddress2Valid,
                                      textInputAction: TextInputAction.next,
                                    ),
                                    SizedBox(
                                      height: displayHeight(context) * 0.02,
                                    ),
                                    AppFloatTextField(
                                      focusNode: coApplicationFocusViewModel
                                          .permanentCityFocusNode,
                                      currentState: coApplicationFocusStates[
                                          'permanentCityFocusNode'],
                                      controller: formListController[index]
                                          .permanentCityController,
                                      onChange: (value) {
                                        coApplicationFormViewModel
                                            .updatePermanentCity(value, index);
                                      },
                                      height: !coApplicationFormState[index]
                                              .isPermanentCityValid
                                          ? displayHeight(context) * 0.09
                                          : null,
                                      inerHint: 'City',
                                      errorText: "City is a required field",
                                      isError: !coApplicationFormState[index]
                                          .isPermanentCityValid,
                                      textInputAction: TextInputAction.next,
                                    ),
                                    SizedBox(
                                      height: displayHeight(context) * 0.02,
                                    ),
                                    AppFloatTextField(
                                      focusNode: coApplicationFocusViewModel
                                          .permanentStateFocusNode,
                                      currentState: coApplicationFocusStates[
                                          'permanentStateFocusNode'],
                                      controller: formListController[index]
                                          .permanentStateController,
                                      onChange: (value) {
                                        coApplicationFormViewModel
                                            .updatePermanentState(value, index);
                                      },
                                      height: !coApplicationFormState[index]
                                              .isPermanentStateValid
                                          ? displayHeight(context) * 0.09
                                          : null,
                                      inerHint: 'State',
                                      errorText: "State is a required field",
                                      isError: !coApplicationFormState[index]
                                          .isPermanentStateValid,
                                      textInputAction: TextInputAction.next,
                                    ),
                                    SizedBox(
                                      height: displayHeight(context) * 0.02,
                                    ),
                                    AppFloatTextField(
                                      focusNode: coApplicationFocusViewModel
                                          .permanentDistrictFocusNode,
                                      currentState: coApplicationFocusStates[
                                          'permanentDistrictFocusNode'],
                                      controller: formListController[index]
                                          .permanentDistrictController,
                                      onChange: (value) {
                                        coApplicationFormViewModel
                                            .updatePermanentDistrict(
                                                value, index);
                                      },
                                      height: !coApplicationFormState[index]
                                              .isPermanentDistrictValid
                                          ? displayHeight(context) * 0.09
                                          : null,
                                      inerHint: 'District',
                                      errorText: "District is a required field",
                                      isError: !coApplicationFormState[index]
                                          .isPermanentDistrictValid,
                                      textInputAction: TextInputAction.next,
                                    ),
                                    SizedBox(
                                      height: displayHeight(context) * 0.02,
                                    ),
                                    AppFloatTextField(
                                      focusNode: coApplicationFocusViewModel
                                          .permanentPinCodeFocusNode,
                                      currentState: coApplicationFocusStates[
                                          'permanentPinCodeFocusNode'],
                                      controller: formListController[index]
                                          .permanentPinCodeController,
                                      onChange: (value) {
                                        coApplicationFormViewModel
                                            .updatePermanentPinCode(value, index);
                                      },
                                      height: !coApplicationFormState[index]
                                              .isPermanentPinCodeValid
                                          ? displayHeight(context) * 0.09
                                          : null,
                                      inerHint: 'PinCode',
                                      errorText: "PinCode is a required field",
                                      isError: !coApplicationFormState[index]
                                          .isPermanentPinCodeValid,
                                      textInputAction: TextInputAction.next,
                                    ),
                                  ],
                                )),
                            InkWell(
                              onTap: () {
                                indexAdd.state = index + 1;
                                coApplicationFormViewModel.addForm();
                                formNotifierController.addFormData();
                                coAddressRadioViewModel
                                    .selectAddress(CoApplicantOptionRole.NON);
                                if (kDebugMode) {
                                  print(coApplicationFormState.length);
                                }
                                if (kDebugMode) {
                                  print(coApplicationFormState.toList());
                                }
                                ref.read(pageViewModelProvider.notifier).setTabIndex(0);
                              },
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  const Icon(
                                    Icons.add,
                                  ),
                                  SizedBox(
                                    width: displayWidth(context) * 0.01,
                                  ),
                                  const Text('Add more co-applicant')
                                ],
                              ),
                            ),
                            Column(
                              children: [
                                AppButton(
                                  textStyle:
                                      const TextStyle(color: AppColors.white),
                                  width: displayWidth(context),
                                  label: 'Next',
                                  onTap: () {
                                    // print('$index < ${coApplicationFormState.length-1}');
                                    // if (index < coApplicationFormState.length-1) {
                                    //   indexAdd.state = index + 1;
                                    //   Navigator.of(context).push(
                                    //       MaterialPageRoute(
                                    //           builder: (context) =>
                                    //               const CoApplicantForm1()));
      
                                    // } else {
                                      // coApplicationFormViewModel
                                      //     .submitCoApplicantForm(index)
                                      //     .then(
                                      //   (value) {
                                      //     if (value) {
                                            Navigator.pushNamed(context,
                                                AppRoutes.saleGuarantorForm1);
                                      //     }
                                      //   },
                                      // );
                                    // }
                                  },
                                ),
                                SizedBox(
                                  height: displayHeight(context) * 0.01,
                                ),
                                // AppButton(
                                //   textStyle:
                                //       const TextStyle(color: AppColors.white),
                                //   width: displayWidth(context),
                                //   label: 'Back',
                                //   onTap: () {},
                                // ),
                              ],
                            )
                          ])),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
