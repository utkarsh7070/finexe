import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../../base/utils/namespase/app_colors.dart';
import '../../../../../../base/utils/namespase/display_size.dart';
import '../../../../../../base/utils/widget/app_button.dart';
import '../../../../../../base/utils/widget/app_text_filed_login.dart';
import '../../../view_model/referance_details_view_model.dart';

class ReferenceDetails extends ConsumerWidget {
  const ReferenceDetails({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final personalFormState = ref.watch(referenceViewModelProvider);
    final payment = ref.watch(paymentProvider);
    final goPayment = ref.read(paymentProvider.notifier);
    final personalFormViewModel = ref.read(referenceViewModelProvider.notifier);
    final personalFocusStates = ref.watch(referenceFocusProvider);
    final personalFocusViewModel = ref.read(referenceFocusProvider.notifier);

    return Scaffold(
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
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const BackButton(),
                const Text(
                  textAlign: TextAlign.center,
                  'Reference',
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
            Expanded(
              child: SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                child:
                    Wrap(runSpacing: displayHeight(context) * 0.04, children: [
                  const Text('Reference -01'),
                  SizedBox(
                    height: displayHeight(context) * 0.02,
                  ),
                  Column(
                    children: [
                      AppFloatTextField(
                        focusNode: personalFocusViewModel.referenceName,
                        currentState: personalFocusStates['referenceName'],
                        // controller: licenseController,
                        onChange: (value) {
                          personalFormViewModel.updateReferenceName(value);
                        },
                        height: !personalFormState.isReferenceNameValid
                            ? displayHeight(context) * 0.09
                            : null,
                        inerHint: 'Reference Name',
                        errorText: "Reference Name is a required field",
                        isError: !personalFormState.isReferenceNameValid,
                        textInputAction: TextInputAction.done,
                      ),
                      SizedBox(
                        height: displayHeight(context) * 0.02,
                      ),
                      AppFloatTextField(
                        focusNode: personalFocusViewModel.relationWithApplicant,
                        currentState:
                            personalFocusStates['relationWithApplicant'],
                        // controller: motherController,
                        onChange: (value) {
                          personalFormViewModel
                              .updateRelationWithApplicant(value);
                        },
                        height: !personalFormState.isRelationWithApplicantValid
                            ? displayHeight(context) * 0.09
                            : null,
                        inerHint: 'Relation With Applicant',
                        errorText:
                            "Relation With Applicant is a required field",
                        isError:
                            !personalFormState.isRelationWithApplicantValid,
                        textInputAction: TextInputAction.done,
                      ),
                      SizedBox(
                        height: displayHeight(context) * 0.02,
                      ),
                      AppFloatTextField(
                        focusNode: personalFocusViewModel.address,
                        currentState: personalFocusStates['address'],
                        // controller: contactController,
                        onChange: (value) {
                          personalFormViewModel.updateAddress(value);
                        },
                        height: !personalFormState.isAddressValid
                            ? displayHeight(context) * 0.09
                            : null,
                        inerHint: 'Address',
                        errorText: "Address is a required field",
                        isError: !personalFormState.isAddressValid,
                        textInputAction: TextInputAction.done,
                      ),
                      SizedBox(
                        height: displayHeight(context) * 0.02,
                      ),
                      AppFloatTextField(
                        focusNode: personalFocusViewModel.contact,
                        currentState: personalFocusStates['contact'],
                        // controller: emailController,
                        onChange: (value) {
                          personalFormViewModel.updateContact(value);
                        },
                        height: !personalFormState.isContactValid
                            ? displayHeight(context) * 0.09
                            : null,
                        inerHint: 'Contact',
                        errorText: "Contact is a required field",
                        isError: !personalFormState.isContactValid,
                        textInputAction: TextInputAction.done,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: displayHeight(context) * 0.03,
                  ),
                  const Text('Reference -02'),
                  SizedBox(
                    height: displayHeight(context) * 0.02,
                  ),
                  Column(
                    children: [
                      AppFloatTextField(
                        focusNode: personalFocusViewModel.referenceName2,
                        currentState: personalFocusStates['referenceName2'],
                        // controller: licenseController,
                        onChange: (value) {
                          personalFormViewModel.updateReferenceName(value);
                        },
                        height: !personalFormState.isReferenceName2Valid
                            ? displayHeight(context) * 0.09
                            : null,
                        inerHint: 'Reference Name',
                        errorText: "Reference Name is a required field",
                        isError: !personalFormState.isReferenceName2Valid,
                        textInputAction: TextInputAction.done,
                      ),
                      SizedBox(
                        height: displayHeight(context) * 0.02,
                      ),
                      AppFloatTextField(
                        focusNode:
                            personalFocusViewModel.relationWithApplicant2,
                        currentState:
                            personalFocusStates['relationWithApplicant2'],
                        // controller: motherController,
                        onChange: (value) {
                          personalFormViewModel
                              .updateRelationWithApplicant(value);
                        },
                        height: !personalFormState.isRelationWithApplicant2Valid
                            ? displayHeight(context) * 0.09
                            : null,
                        inerHint: 'Relation With Applicant',
                        errorText:
                            "Relation With Applicant is a required field",
                        isError:
                            !personalFormState.isRelationWithApplicant2Valid,
                        textInputAction: TextInputAction.done,
                      ),
                      SizedBox(
                        height: displayHeight(context) * 0.02,
                      ),
                      AppFloatTextField(
                        focusNode: personalFocusViewModel.address2,
                        currentState: personalFocusStates['address2'],
                        // controller: contactController,
                        onChange: (value) {
                          personalFormViewModel.updateAddress(value);
                        },
                        height: !personalFormState.isAddress2Valid
                            ? displayHeight(context) * 0.09
                            : null,
                        inerHint: 'Address',
                        errorText: "Address is a required field",
                        isError: !personalFormState.isAddress2Valid,
                        textInputAction: TextInputAction.done,
                      ),
                      SizedBox(
                        height: displayHeight(context) * 0.02,
                      ),
                      AppFloatTextField(
                        focusNode: personalFocusViewModel.contact2,
                        currentState: personalFocusStates['contact2'],
                        // controller: emailController,
                        onChange: (value) {
                          personalFormViewModel.updateContact(value);
                        },
                        height: !personalFormState.isContact2Valid
                            ? displayHeight(context) * 0.09
                            : null,
                        inerHint: 'Contact',
                        errorText: "Contact is a required field",
                        isError: !personalFormState.isContact2Valid,
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
                          goPayment.payWithRazorPay(10);
                          // Navigator.pushNamed(
                          //     context, AppRoutes.saleCoApplicationForm);
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
                ]),
              ),
            )
          ]),
        ),
      ),
    );
  }
}
