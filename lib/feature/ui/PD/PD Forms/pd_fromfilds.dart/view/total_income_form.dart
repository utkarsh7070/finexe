import 'package:finexe/feature/base/utils/namespase/app_colors.dart';
import 'package:finexe/feature/base/utils/namespase/app_style.dart';
import 'package:finexe/feature/base/utils/namespase/display_size.dart';
import 'package:finexe/feature/ui/PD/Common%20Widgets/common_textfield.dart';
// import 'package:finexe/feature/ui/PD/view/PD%20Form/pd_fromfilds.dart/pd_update_data/model/Submit%20Data%20Models/total_income_modal.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../model/Submit Data Models/total_income_modal.dart';
import '../view_model.dart/total_income_view_modal.dart';
final isExpTotalIncomeProvider = StateProvider<bool>((ref) => false);

class TotalIncomeDetailsForm extends ConsumerStatefulWidget {
  // const TotalIncomeDetailsForm({super.key});
  final String customerId;
  const TotalIncomeDetailsForm({super.key, required this.customerId});
  @override
  _TotalIncomeDetailsFormState createState() => _TotalIncomeDetailsFormState();
}

class _TotalIncomeDetailsFormState
    extends ConsumerState<TotalIncomeDetailsForm> {
  final TextEditingController totalincomeForm_yearlyIncomeController =
  TextEditingController();
  final TextEditingController totalincomeForm_monthlyIncomeController =
  TextEditingController();
  final TextEditingController totalincomeForm_expensesYearlyController =
  TextEditingController();
  final TextEditingController totalincomeForm_expensesMonthlyController =
  TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    // Dispose total income form controllers
    totalincomeForm_yearlyIncomeController.dispose();
    totalincomeForm_monthlyIncomeController.dispose();
    totalincomeForm_expensesYearlyController.dispose();
    totalincomeForm_expensesMonthlyController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //isExpTotalIncomeProvider
    final appState = ref.watch(pdIncomeDetailsProvider);
    final isExpanded = ref.watch(isExpTotalIncomeProvider);

    final incomeDetails = ref.watch(totalIncomeDetailsProvider(widget.customerId));
    // print('appState:: ${incomeDetails}');

    return ExpansionTile(
          childrenPadding: const EdgeInsets.only(left: 16, bottom: 10),
          shape: const Border(
            bottom: BorderSide(color: AppColors.dividerColor),
          ),
          title: const Text('Total Income'),
          onExpansionChanged: (expanded) {
            ref.read(isExpTotalIncomeProvider.notifier).state = expanded;
            if (expanded) {
              // Trigger data fetch when the tile is expanded
              ref.refresh(totalIncomeDetailsProvider(widget.customerId));
            }
          },
          initiallyExpanded: isExpanded,
          children: <Widget>[
            incomeDetails.when(
                data: (incomeData) {
                  if (totalincomeForm_yearlyIncomeController.text.isEmpty) {
                    totalincomeForm_expensesYearlyController.text =
                        incomeData.totalExpensesYearly ?? '';
                    totalincomeForm_expensesMonthlyController.text =
                        incomeData.totalExpensesMonthly ?? '';
                    totalincomeForm_yearlyIncomeController.text =
                        incomeData.totalYearlyIncome ?? '';
                    totalincomeForm_monthlyIncomeController.text =
                        incomeData.totalMonthlyIncome ?? '';
                  }
                  return  Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          constSizedbox(context),
                          Padding(
                            padding: const EdgeInsets.only(right: 15),
                            child: CustomTextFormField(
                              textInputType: TextInputType.number,

                              // isError: coappvalidate,
                              inerHint: 'Yearly Income',
                              onValidate: (value) {
                                if (value!.trim().isEmpty) {
                                  return "This is a required field";
                                }
                                return null;
                              },
                              controller: totalincomeForm_yearlyIncomeController,
                              textInputAction: TextInputAction.next,
                            ),
                          ),
                          constSizedbox(context),
                          Padding(
                            padding: const EdgeInsets.only(right: 15),
                            child: CustomTextFormField(
                              textInputType: TextInputType.number,
                              inerHint: 'Monthly Income',
                              onValidate: (value) {
                                if (value!.trim().isEmpty) {
                                  return "This is a required field";
                                }
                                return null;
                              },
                              controller: totalincomeForm_monthlyIncomeController,
                              // textInputAction: TextInputAction.next,
                            ),
                          ),
                          constSizedbox(context),
                          Padding(
                            padding: const EdgeInsets.only(right: 15),
                            child: LayoutBuilder(
                              builder: (context, constraints) {
                                return CustomTextFormField(
                                  textInputType: TextInputType.number,
                                  width: constraints.maxWidth,
                                  inerHint: 'Expenses Yearly',
                                  onValidate: (value) {
                                    if (value!.trim().isEmpty) {
                                      return "This is a required field";
                                    }
                                    return null;
                                  },
                                  controller:
                                  totalincomeForm_expensesYearlyController,
                                  textInputAction: TextInputAction.next,
                                );
                              },
                            ),
                          ),
                          constSizedbox(context),
                          Padding(
                            padding: const EdgeInsets.only(right: 15),
                            child: LayoutBuilder(
                              builder: (context, constraints) {
                                return CustomTextFormField(
                                  textInputType: TextInputType.number,
                                  width: constraints.maxWidth,
                                  inerHint: 'Expenses Monthly',
                                  onValidate: (value) {
                                    if (value!.trim().isEmpty) {
                                      return "This is a required field";
                                    }
                                    return null;
                                  },
                                  controller:
                                  totalincomeForm_expensesMonthlyController,
                                  textInputAction: TextInputAction.next,
                                );
                              },
                            ),
                          ),
                          constSizedbox(context),
                          ElevatedButton(
                            onPressed: () async {
                              if (_formKey.currentState!.validate()) {
                                final incomeDetails = TotalIncomeDetails(
                                  totalYearlyIncome:
                                  totalincomeForm_yearlyIncomeController.text,
                                  totalMonthlyIncome:
                                  totalincomeForm_monthlyIncomeController.text,
                                  totalExpensesYearly:
                                  totalincomeForm_expensesYearlyController.text,
                                  totalExpensesMonthly:
                                  totalincomeForm_expensesMonthlyController.text,
                                );

                                // Call the provider method with the `TotalIncomeDetails` object
                                await ref
                                    .read(pdIncomeDetailsProvider.notifier)
                                    .submitIncomeDetails(
                                  customerId:  widget.customerId,
                                  pdType: 'creditPd',
                                  incomeDetails:
                                  incomeDetails, // Pass the object here
                                );

                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    backgroundColor: AppColors.green,
                                    content: Text(
                                      'Form submitted successfully!',
                                      style: AppStyles.whiteText16,
                                    ),
                                  ),
                                );
                              } else {
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
                              'Next',
                              style: AppStyles.whiteText16,
                            ),
                          ),
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
