// import 'dart:developer';

import 'package:finexe/feature/base/utils/namespase/app_colors.dart';
import 'package:finexe/feature/base/utils/namespase/app_style.dart';
import 'package:finexe/feature/base/utils/namespase/display_size.dart';
// import 'package:finexe/feature/base/utils/widget/app_text_filed_login.dart';
import 'package:finexe/feature/ui/PD/Common%20Widgets/common_textfield.dart';
// import 'package:finexe/feature/ui/PD/view/PD%20Form/pd_fromfilds.dart/pd_update_data/view_model.dart/loan_detail_view_modal.dart';
// import 'package:finexe/feature/ui/PD/view/PD%20Form/pd_fromfilds.dart/view_model.dart/loan_detail_view_modal.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../base/utils/widget/custom_snackbar.dart';
import '../model/Submit Data Models/loan_detail_modal.dart';
import '../view_model.dart/loan_detail_view_modal.dart';
final isExpLoanDetailProvider = StateProvider<bool>((ref) => false);

class LoanDetailsForm extends ConsumerStatefulWidget {
  // const LoanDetailsForm({super.key});
  final String customerId;
  const LoanDetailsForm({super.key, required this.customerId});

  @override
  _LoanDetailsFormState createState() => _LoanDetailsFormState();
}

class _LoanDetailsFormState extends ConsumerState<LoanDetailsForm> {
  late TextEditingController LoanDetailsForm_customerDetailsController;
  late TextEditingController LoanDetailsForm_emiController;
  late TextEditingController LoanDetailsForm_approveAmountController;
  late TextEditingController LoanDetailsForm_tenureController;
  late TextEditingController LoanDetailsForm_roiController;
  late TextEditingController LoanDetailsForm_finaldecisionController;
  late TextEditingController LoanDetailsForm_endUseofloanController;

  @override
  void initState() {
    super.initState();
    LoanDetailsForm_customerDetailsController = TextEditingController();
    LoanDetailsForm_emiController = TextEditingController();
    LoanDetailsForm_approveAmountController = TextEditingController();
    LoanDetailsForm_tenureController = TextEditingController();
    LoanDetailsForm_roiController = TextEditingController();
    LoanDetailsForm_finaldecisionController = TextEditingController();
    LoanDetailsForm_endUseofloanController = TextEditingController();
  }

  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    LoanDetailsForm_customerDetailsController.dispose();
    LoanDetailsForm_emiController.dispose();
    LoanDetailsForm_approveAmountController.dispose();
    LoanDetailsForm_tenureController.dispose();
    LoanDetailsForm_roiController.dispose();
    LoanDetailsForm_finaldecisionController.dispose();
    LoanDetailsForm_endUseofloanController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final appState = ref.watch(pdLoanDetailsProvider);

    final isExpanded = ref.watch(isExpLoanDetailProvider);
    final getLoandata = ref.watch(loanDetailsGetProvider(widget.customerId));

    return  ExpansionTile(
          childrenPadding: const EdgeInsets.only(left: 16, bottom: 10),
          shape: const Border(
            bottom: BorderSide(color: AppColors.dividerColor),
          ),
          title: const Text('Loan Details Form'),
          onExpansionChanged: (expanded) {
            ref.read(isExpLoanDetailProvider.notifier).state = expanded;
            if (expanded) {
              // Trigger data fetch when the tile is expanded
              ref.refresh(loanDetailsGetProvider(widget.customerId));
            }
          },
          initiallyExpanded: isExpanded,
          children: <Widget>[
            getLoandata.when(
                data: (loanData) {
                  if (LoanDetailsForm_customerDetailsController.text.isEmpty) {
                    LoanDetailsForm_approveAmountController.text =
                        loanData?.approvedAmount?.toString() ?? '';
                    LoanDetailsForm_roiController.text = loanData?.roi?.toString() ?? '';
                    LoanDetailsForm_tenureController.text =
                        loanData?.tenure?.toString() ?? '';
                    LoanDetailsForm_emiController.text = loanData?.emi?.toString() ?? '';
                    LoanDetailsForm_customerDetailsController.text =
                        loanData?.demandLoanAmountByCustomer ?? '';
                    LoanDetailsForm_finaldecisionController.text =
                        loanData?.finalDecision?.toString() ?? '';
                    LoanDetailsForm_endUseofloanController.text =
                        loanData?.endUseOfLoan ?? '';
                  }
                  return   Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          Container(
                            alignment: Alignment.centerLeft,
                            child: const Text(
                              'Location Details',
                              textAlign: TextAlign.left,
                            ),
                          ),
                          constSizedbox(context),
                          Padding(
                            padding: const EdgeInsets.only(right: 15),
                            child: CustomTextFormField(
                              textInputType: TextInputType.number,
                              inerHint: 'Customer Demand Loan Amount',
                              onValidate: (value) {
                                if (value!.trim().isEmpty) {
                                  return "This is a required field";
                                }
                                return null;
                              },
                              controller: LoanDetailsForm_customerDetailsController,
                              textInputAction: TextInputAction.next,
                            ),
                          ),
                          // constSizedbox(context),
                          // Padding(
                          //   padding: const EdgeInsets.only(right: 15),
                          //   child: CustomTextFormField(
                          //     textInputType: TextInputType.number,
                          //     inerHint: 'Approved Amount',
                          //     onValidate: (value) {
                          //       print(value);
                          //       if (value!.trim().isEmpty) {
                          //         return "This is a required field";
                          //       }
                          //       return null;
                          //     },
                          //     controller: LoanDetailsForm_approveAmountController,
                          //     textInputAction: TextInputAction.next,
                          //   ),
                          // ),
                          constSizedbox(context),
                          Padding(
                            padding: const EdgeInsets.only(right: 15),
                            child: CustomTextFormField(
                              textInputType: TextInputType.number,
                              inerHint: 'EMI',
                              onValidate: (value) {
                                print(value);
                                if (value!.trim().isEmpty) {
                                  return "This is a required field";
                                }
                                return null;
                              },
                              controller: LoanDetailsForm_emiController,
                              textInputAction: TextInputAction.next,
                            ),
                          ),

                          constSizedbox(context),
                          Container(
                            alignment: Alignment.centerLeft,
                            child: const Text(
                              'Location Details',
                              textAlign: TextAlign.left,
                            ),
                          ),
                          constSizedbox(context),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                // padding: const EdgeInsets.only(right: 15),
                                child: Padding(
                                  padding: const EdgeInsets.only(right: 15),
                                  child: CustomTextFormField(
                                    width: displayWidth(context) * 0.4,
                                    textInputType: TextInputType.number,
                                    inerHint: 'ROI (%)',
                                    onValidate: (value) {
                                      print(value);
                                      if (value!.trim().isEmpty) {
                                        return "This is a required field";
                                      }
                                      return null;
                                    },
                                    controller: LoanDetailsForm_roiController,
                                    textInputAction: TextInputAction.next,
                                  ),
                                ),
                              ),
                              SizedBox(width: displayWidth(context) * 0.05),
                              Expanded(
                                // padding: const EdgeInsets.only(right: 15),
                                child: Padding(
                                  padding: const EdgeInsets.only(right: 15),
                                  child: CustomTextFormField(
                                    textInputType: TextInputType.number,
                                    inerHint: 'Tenure',
                                    onValidate: (value) {
                                      print(value);
                                      if (value!.trim().isEmpty) {
                                        return "This is a required field sajfoierfnsdionf";
                                      }
                                      return null;
                                    },
                                    controller: LoanDetailsForm_tenureController,
                                    textInputAction: TextInputAction.next,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          constSizedbox(context),
                          Container(
                            alignment: Alignment.centerLeft,
                            child: const Text(
                              'Decision & Purpose',
                              textAlign: TextAlign.left,
                            ),
                          ),
                          // constSizedbox(context),
                          // Padding(
                          //   padding: const EdgeInsets.only(right: 15),
                          //   child: CustomTextFormField(
                          //     textInputType: TextInputType.text,
                          //     inerHint: 'Final Amount Decision',
                          //     onValidate: (value) {
                          //       if (value!.trim().isEmpty) {
                          //         return "This is a required field";
                          //       }
                          //       return null;
                          //     },
                          //     controller: LoanDetailsForm_finaldecisionController,
                          //     textInputAction: TextInputAction.next,
                          //   ),
                          // ),
                          constSizedbox(context),
                          Padding(
                            padding: const EdgeInsets.only(right: 15),
                            child: CustomTextFormField(
                              textInputType: TextInputType.text,
                              inerHint: 'End use of loan',
                              onValidate: (value) {
                                print(value);
                                if (value!.trim().isEmpty) {
                                  return "This is a required field";
                                }
                                return null;
                              },
                              controller: LoanDetailsForm_endUseofloanController,
                              textInputAction: TextInputAction.next,
                            ),
                          ),
                          constSizedbox(context),
                          ElevatedButton(
                            onPressed: () async {
                              if (_formKey.currentState!.validate()) {
                                // Create the TotalLoanDetails object based on form inputs
                                final loanDetails = UpdateLoanDetails(
                                  approvedAmount: double.tryParse(
                                      LoanDetailsForm_approveAmountController
                                          .text) ??
                                      0,
                                  roi: double.tryParse(
                                      LoanDetailsForm_roiController.text),
                                  tenure: double.tryParse(
                                      LoanDetailsForm_tenureController.text),
                                  emi: double.tryParse(
                                      LoanDetailsForm_emiController.text),
                                  demandLoanAmountByCustomer:
                                  LoanDetailsForm_customerDetailsController.text,
                                  // finalDecision: int.tryParse(
                                  //         LoanDetailsForm_finaldecisionController
                                  //             .text) ??
                                  //     0,
                                  finalDecision: LoanDetailsForm_finaldecisionController.text,
                                  endUseOfLoan:
                                  LoanDetailsForm_endUseofloanController.text,
                                );

                                await ref
                                    .read(pdLoanDetailsProvider.notifier)
                                    .submitLoanDetails(
                                  customerId:  widget.customerId,
                                  pdType: 'creditPd',
                                  loanDetails: loanDetails, context: context,
                                )
                                    .then(
                                      (value) {
                                    if (value == true) {
                                      // Show success message
                                      showCustomSnackBar(
                                          context,'Form Saved successfully!', Colors.green);
                                    }

                                  },
                                );
                              } else {
                                // Show error message if validation fails
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    backgroundColor: AppColors.red,
                                    content: Text(
                                      'Please fill all required details!',
                                      style: AppStyles.whiteText16,
                                    ),
                                  ),
                                );
                              }
                            },
                            child: appState.isLoading == true
                                ? const SizedBox(
                              width: 24, // Specify the width
                              height: 24, // Specify the height
                              child: CircularProgressIndicator(
                                color: AppColors.white,
                                strokeWidth: 3,
                                key: ValueKey(
                                    'loading'), // Key for progress indicator
                              ),
                            )
                                : Text(
                              'Save Form',
                              style: AppStyles.whiteText16,
                            ),
                          )
                        ],
                      ));
                },
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (error, stackTrace) => Center(child: Text('Error: $error')),
            )

          ],
        );

  }
}

constSizedbox(BuildContext context) {
  return SizedBox(
    height: displayHeight(context) * 0.02,
  );
}
