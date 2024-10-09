import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../../base/routes/routes.dart';
import '../../../../../../base/utils/namespase/app_colors.dart';
import '../../../../../../base/utils/namespase/display_size.dart';
import '../../../../../../base/utils/widget/app_button.dart';
import '../../../../../../base/utils/widget/app_text_filed_login.dart';
import '../../../view_model/guarantor_form_view_model.dart';

class GuarantorForm2 extends ConsumerWidget {
  const GuarantorForm2({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    //----------------controller-------------------------------------------------------
    final formListController = ref.watch(guarantorController);
    final formNotifierController = ref.read(guarantorController.notifier);
//---------------------------------------------------------------------------------
    final personalFormState = ref.watch(guarantorViewModelProvider);
    final personalFormViewModel = ref.read(guarantorViewModelProvider.notifier);
    final personalFocusStates = ref.watch(guarantorFocusProvider);
    final personalFocusViewModel = ref.read(guarantorFocusProvider.notifier);
    final guarantorAddressRadio = ref.watch(guarantorAddressRoleProvider);
    final guarantorAddressRadioViewModel =
        ref.read(guarantorAddressRoleProvider.notifier);
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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
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
              SizedBox(
                height: displayHeight(context) * 0.01,
              ),
              Expanded(
                child: SingleChildScrollView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  child: Wrap(
                      clipBehavior: Clip.none,
                      runSpacing: displayHeight(context) * 0.04,
                      children: [
                        Column(
                            children: [
                          AppFloatTextField(
                            focusNode: personalFocusViewModel
                                .communicationAddress1FocusNode,
                            currentState: personalFocusStates[
                                'communicationAddress1FocusNode'],
                            controller: formListController.communicationAddress1Controller,
                            onChange: (value) {
                              personalFormViewModel
                                  .updateCommunicationAddress1(value);
                            },
                            height:
                                !personalFormState.isCommunicationAddress1Valid
                                    ? displayHeight(context) * 0.09
                                    : null,
                            inerHint: 'Address1',
                            errorText: "Address1 is a required field",
                            isError:
                                !personalFormState.isCommunicationAddress1Valid,
                            textInputAction: TextInputAction.done,
                          ),
                          SizedBox(
                            height: displayHeight(context) * 0.02,
                          ),
                          AppFloatTextField(
                            focusNode: personalFocusViewModel
                                .communicationAddress2FocusNode,
                            currentState: personalFocusStates[
                                'communicationAddress2FocusNode'],
                            controller: formListController.communicationAddress2Controller,
                            onChange: (value) {
                              personalFormViewModel
                                  .updateCommunicationAddress2(value);
                            },
                            height: !personalFormState.isGenderValid
                                ? displayHeight(context) * 0.09
                                : null,
                            inerHint: 'Address2',
                            errorText: "Address2 is a required field",
                            isError:
                                !personalFormState.isCommunicationAddress2Valid,
                            textInputAction: TextInputAction.done,
                          ),
                          SizedBox(
                            height: displayHeight(context) * 0.02,
                          ),
                          AppFloatTextField(
                            focusNode: personalFocusViewModel
                                .communicationCityFocusNode,
                            currentState: personalFocusStates[
                                'communicationCityFocusNode'],
                            controller: formListController.communicationCityController,
                            onChange: (value) {
                              personalFormViewModel
                                  .updateCommunicationCity(value);
                            },
                            height: !personalFormState.isCommunicationCityValid
                                ? displayHeight(context) * 0.09
                                : null,
                            inerHint: 'City',
                            errorText: "City is a required field",
                            isError:
                                !personalFormState.isCommunicationCityValid,
                            textInputAction: TextInputAction.done,
                          ),
                          SizedBox(
                            height: displayHeight(context) * 0.02,
                          ),
                          AppFloatTextField(
                            focusNode: personalFocusViewModel
                                .communicationStateFocusNode,
                            currentState: personalFocusStates[
                                'communicationStateFocusNode'],
                            controller: formListController.communicationStateController,
                            onChange: (value) {
                              personalFormViewModel
                                  .updateCommunicationState(value);
                            },
                            height: !personalFormState.isCommunicationStateValid
                                ? displayHeight(context) * 0.09
                                : null,
                            inerHint: 'State',
                            errorText: "State is a required field",
                            isError:
                                !personalFormState.isCommunicationStateValid,
                            textInputAction: TextInputAction.done,
                          ),
                          SizedBox(
                            height: displayHeight(context) * 0.02,
                          ),
                          AppFloatTextField(
                            focusNode: personalFocusViewModel
                                .communicationDistrictFocusNode,
                            currentState: personalFocusStates[
                                'communicationDistrictFocusNode'],
                            controller: formListController.communicationDistrictController,
                            onChange: (value) {
                              personalFormViewModel
                                  .updateCommunicationDistrict(value);
                            },
                            height:
                                !personalFormState.isCommunicationDistrictValid
                                    ? displayHeight(context) * 0.09
                                    : null,
                            inerHint: 'District',
                            errorText: "District is a required field",
                            isError:
                                !personalFormState.isCommunicationDistrictValid,
                            textInputAction: TextInputAction.done,
                          ),
                          SizedBox(
                            height: displayHeight(context) * 0.02,
                          ),
                          AppFloatTextField(
                            focusNode: personalFocusViewModel
                                .communicationPinCodeFocusNode,
                            currentState: personalFocusStates[
                                'communicationPinCodeFocusNode'],
                            controller: formListController.communicationPinCodeController,
                            onChange: (value) {
                              personalFormViewModel
                                  .updateCommunicationPinCode(value);
                            },
                            height:
                                !personalFormState.isCommunicationPinCodeValid
                                    ? displayHeight(context) * 0.09
                                    : null,
                            inerHint: 'PinCode',
                            errorText: "PinCode is a required field",
                            isError:
                                !personalFormState.isCommunicationPinCodeValid,
                            textInputAction: TextInputAction.done,
                          ),
                          SizedBox(
                            height: displayHeight(context) * 0.02,
                          ),
                          const Text('Same as permanent address',textAlign: TextAlign.start,),
                          Row(
                            children: [
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.30,
                                child: Row(
                                  children: [
                                    Radio<GuarantorOptionRole>(
                                      value: GuarantorOptionRole.Yes,
                                      groupValue: guarantorAddressRadio,
                                      onChanged: (value) {
                                        if (value != null) {
                                          guarantorAddressRadioViewModel
                                              .selectAddress(value);
                                          personalFormViewModel.localAddCopyPermanentAdd();
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
                                    Radio<GuarantorOptionRole>(
                                      value: GuarantorOptionRole.NO,
                                      groupValue: guarantorAddressRadio,
                                      onChanged: (value) {
                                        if (value != null) {
                                          guarantorAddressRadioViewModel
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
                              visible: guarantorAddressRadio ==
                                  GuarantorOptionRole.NO,
                              child: Column(
                                children: [
                                  AppFloatTextField(
                                    focusNode: personalFocusViewModel
                                        .permanentAddress1FocusNode,
                                    currentState: personalFocusStates[
                                        'permanentAddress1FocusNode'],
                                    controller: formListController.permanentAddress1Controller,
                                    onChange: (value) {
                                      personalFormViewModel
                                          .updatePermanentAddress1(value);
                                    },
                                    height: !personalFormState
                                            .isPermanentAddress1Valid
                                        ? displayHeight(context) * 0.09
                                        : null,
                                    inerHint: 'Address1',
                                    errorText: "Address1 is a required field",
                                    isError: !personalFormState
                                        .isPermanentAddress1Valid,
                                    textInputAction: TextInputAction.done,
                                  ),
                                  SizedBox(
                                    height: displayHeight(context) * 0.02,
                                  ),
                                  AppFloatTextField(
                                    focusNode: personalFocusViewModel
                                        .permanentAddress2FocusNode,
                                    currentState: personalFocusStates[
                                        'permanentAddress2FocusNode'],
                                    controller: formListController.permanentAddress2Controller,
                                    onChange: (value) {
                                      personalFormViewModel
                                          .updatePermanentAddress2(value);
                                    },
                                    height: !personalFormState
                                            .isPermanentAddress2Valid
                                        ? displayHeight(context) * 0.09
                                        : null,
                                    inerHint: 'Address2',
                                    errorText: "Address2 is a required field",
                                    isError: !personalFormState
                                        .isPermanentAddress2Valid,
                                    textInputAction: TextInputAction.done,
                                  ),
                                  SizedBox(
                                    height: displayHeight(context) * 0.02,
                                  ),
                                  AppFloatTextField(
                                    focusNode: personalFocusViewModel
                                        .permanentCityFocusNode,
                                    currentState: personalFocusStates[
                                        'permanentCityFocusNode'],
                                    controller: formListController.permanentCityController,
                                    onChange: (value) {
                                      personalFormViewModel
                                          .updatePermanentCity(value);
                                    },
                                    height:
                                        !personalFormState.isPermanentCityValid
                                            ? displayHeight(context) * 0.09
                                            : null,
                                    inerHint: 'City',
                                    errorText: "City is a required field",
                                    isError:
                                        !personalFormState.isPermanentCityValid,
                                    textInputAction: TextInputAction.done,
                                  ),
                                  SizedBox(
                                    height: displayHeight(context) * 0.02,
                                  ),
                                  AppFloatTextField(
                                    focusNode: personalFocusViewModel
                                        .permanentStateFocusNode,
                                    currentState: personalFocusStates[
                                        'permanentStateFocusNode'],
                                    controller: formListController.permanentStateController,
                                    onChange: (value) {
                                      personalFormViewModel
                                          .updatePermanentState(value);
                                    },
                                    height:
                                        !personalFormState.isPermanentStateValid
                                            ? displayHeight(context) * 0.09
                                            : null,
                                    inerHint: 'State',
                                    errorText: "State is a required field",
                                    isError: !personalFormState
                                        .isPermanentStateValid,
                                    textInputAction: TextInputAction.done,
                                  ),
                                  SizedBox(
                                    height: displayHeight(context) * 0.02,
                                  ),
                                  AppFloatTextField(
                                    focusNode: personalFocusViewModel
                                        .permanentDistrictFocusNode,
                                    currentState: personalFocusStates[
                                        'permanentDistrictFocusNode'],
                                    controller: formListController.permanentDistrictController,
                                    onChange: (value) {
                                      personalFormViewModel
                                          .updatePermanentDistrict(value);
                                    },
                                    height: !personalFormState
                                            .isPermanentDistrictValid
                                        ? displayHeight(context) * 0.09
                                        : null,
                                    inerHint: 'District',
                                    errorText: "District is a required field",
                                    isError: !personalFormState
                                        .isPermanentDistrictValid,
                                    textInputAction: TextInputAction.done,
                                  ),
                                  SizedBox(
                                    height: displayHeight(context) * 0.02,
                                  ),
                                  AppFloatTextField(
                                    focusNode: personalFocusViewModel
                                        .permanentPinCodeFocusNode,
                                    currentState: personalFocusStates[
                                        'permanentPinCodeFocusNode'],
                                    controller: formListController.permanentPinCodeController,
                                    onChange: (value) {
                                      personalFormViewModel
                                          .updatePermanentPinCode(value);
                                    },
                                    height: !personalFormState
                                            .isPermanentPinCodeValid
                                        ? displayHeight(context) * 0.09
                                        : null,
                                    inerHint: 'PinCode',
                                    errorText: "PinCode is a required field",
                                    isError: !personalFormState
                                        .isPermanentPinCodeValid,
                                    textInputAction: TextInputAction.done,
                                  ),
                                  SizedBox(
                                    height: displayHeight(context) * 0.02,
                                  ),

                                ],
                              )),
                          SizedBox(
                            height: displayHeight(context) * 0.01,
                          ),
                          AppButton(
                            textStyle: const TextStyle(color: AppColors.white),
                            width: displayWidth(context),
                            label: 'Next',
                            onTap: () {
                              Navigator.pushNamed(
                                  context, AppRoutes.saleReferenceForm);
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


                        ]),
                      ]),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
