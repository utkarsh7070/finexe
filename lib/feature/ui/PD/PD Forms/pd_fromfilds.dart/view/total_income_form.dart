import 'package:finexe/feature/base/extentions/validation_extension.dart';
import 'package:finexe/feature/base/utils/namespase/app_colors.dart';
import 'package:finexe/feature/base/utils/namespase/app_style.dart';
import 'package:finexe/feature/base/utils/namespase/display_size.dart';
// import 'package:finexe/feature/ui/PD/view/PD%20Form/pd_fromfilds.dart/pd_update_data/model/Submit%20Data%20Models/total_income_modal.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../base/utils/widget/app_text_filed_login.dart';
import '../../../../../base/utils/widget/custom_snackbar.dart';
import '../view_model.dart/total_income_view_modal.dart';

// final isExpTotalIncomeProvider = StateProvider<bool>((ref) => false);
//
// class TotalIncomeDetailsForm extends ConsumerStatefulWidget {
//   // const TotalIncomeDetailsForm({super.key});
//   final String customerId;
//
//   const TotalIncomeDetailsForm({super.key, required this.customerId});
//
//   @override
//   _TotalIncomeDetailsFormState createState() => _TotalIncomeDetailsFormState();
// }

class TotalIncomeDetailsForm
    extends ConsumerWidget{
  final String customerId;

  const TotalIncomeDetailsForm({super.key, required this.customerId});
  // final TextEditingController totalincomeForm_yearlyIncomeController =
  //     TextEditingController();
  // final TextEditingController totalincomeForm_monthlyIncomeController =
  //     TextEditingController();
  // final TextEditingController totalincomeForm_expensesYearlyController =
  //     TextEditingController();
  // final TextEditingController totalincomeForm_expensesMonthlyController =
  //     TextEditingController();
  //
  // final _formKey = GlobalKey<FormState>();
  //
  // @override
  // void dispose() {
  //   // Dispose total income form controllers
  //   totalincomeForm_yearlyIncomeController.dispose();
  //   totalincomeForm_monthlyIncomeController.dispose();
  //   totalincomeForm_expensesYearlyController.dispose();
  //   totalincomeForm_expensesMonthlyController.dispose();
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context,WidgetRef ref) {
    final appState = ref.watch(pdIncomeDetailsProvider);
    final appStateVieModel = ref.read(pdIncomeDetailsProvider.notifier);

    final incomeDetails =
        ref.watch(totalIncomeDetailsProvider(customerId));
    return ExpansionTile(
      childrenPadding: const EdgeInsets.only(left: 16,right: 16, bottom: 10),
      shape: const Border(
        bottom: BorderSide(color: AppColors.dividerColor),
      ),
      title: const Text('Total Income'),
      onExpansionChanged: (expanded) {
        // ref.read(isExpTotalIncomeProvider.notifier).state = expanded;
        if (expanded) {
          // Trigger data fetch when the tile is expanded
          ref.refresh(totalIncomeDetailsProvider(customerId));
        }
      },
      initiallyExpanded: false,
      children: <Widget>[
        incomeDetails.when(
          data: (incomeData) {
            return Column(
              children: [
                constSizedbox(context),
                AppFloatTextField(
                  initialValue: incomeData.items?.totalIncomeDetails?.totalYearlyIncome,
                  onChange: (value) {
                    appStateVieModel.updateTotalYearlyIncome(value);
                  },

                  textInputType: TextInputType.number,
                  // isError: coappvalidate,
                  inerHint: 'Yearly Income',
                  textInputAction: TextInputAction.next,
                ),
                constSizedbox(context),
                AppFloatTextField(
                  initialValue:incomeData.items?.totalIncomeDetails?.totalMonthlyIncome,
                  // appState.totalMonthlyIncome,
                  onChange: (value) {
                    appStateVieModel.updateTotalMonthlyIncome(value);
                  },
                  textInputType: TextInputType.number,
                  inerHint: 'Monthly Income',
                ),
                constSizedbox(context),
                AppFloatTextField(
                  initialValue: incomeData.items?.totalIncomeDetails?.totalExpensesYearly,
                  textInputType: TextInputType.number,
                  // width: constraints.maxWidth,
                  inerHint: 'Expenses Yearly',
                  onChange: (value) {
                    appStateVieModel.updateTotalExpensesYearly(value);
                  },
                  onValidate: (value) {
                    return null;
                  },
                  textInputAction: TextInputAction.next,
                ),
                constSizedbox(context),
                AppFloatTextField(
                  initialValue: incomeData.items?.totalIncomeDetails?.totalExpensesMonthly,
                  textInputType: TextInputType.number,
                  // width: constraints.maxWidth,
                  inerHint: 'Expenses Monthly',
                  onChange: (value) {
                    appStateVieModel.updateTotalExpensesMonthly(value);
                  },
                  textInputAction: TextInputAction.next,
                ),
                constSizedbox(context),
                ElevatedButton(
                  onPressed: () async {
                      await ref
                          .read(pdIncomeDetailsProvider.notifier)
                          .submitIncomeDetails(
                            context: context,
                            customerId: customerId,
                            pdType: 'creditPd',
                            // incomeDetails: incomeDetails, // Pass the object here
                          )
                          .then(
                        (value) {
                          if (value == true) {
                            showCustomSnackBar(context,
                                'Form Saved successfully!', Colors.green);
                          }
                        },
                      );
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
                ),
              ],
            );
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
