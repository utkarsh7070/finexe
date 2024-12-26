import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../base/utils/namespase/display_size.dart';
import '../../../base/utils/widget/app_button.dart';
import '../../../base/utils/widget/app_text_filed_login.dart';
import '../view_model/branch_expenses_view_model.dart';
import 'CustomerSelectorDroper/custom_radioButton_screen.dart';
import 'CustomerSelectorDroper/customlist_drop_drown.dart';

class BranchExpensesForm extends ConsumerStatefulWidget {
  const BranchExpensesForm({super.key}); // Removed const keyword here
  @override
  ConsumerState<BranchExpensesForm> createState() => _BranchExpensesFormState(index: 0);
}

class _BranchExpensesFormState extends ConsumerState<BranchExpensesForm> {
  final int index;
  _BranchExpensesFormState({required this.index}); // Correct constructor

  @override
  Widget build(BuildContext context) {
    final formDataController = ref.watch(branchExpensesProvider);
    final fromStateViewModel = ref.read(branchExpensesProvider.notifier);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Branch Expenses Form"),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
            ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: formDataController.length,
            itemBuilder: (context, index) {
              final entry = formDataController[index];
              return Padding(
                padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  key: ValueKey(index), // Ensure Flutter identifies each entry uniquely
                  children: [
                    // Claim Type Radio Button
                    CustomRadioButtonScreen(
                      heading: 'Pay Mode',
                      options: const ['Advance', 'Claim', 'To Pay'],
                      onSelect: (selectedOption) {
                        fromStateViewModel.updateClaimType(index, selectedOption);
                      },
                    ),
                    const SizedBox(height: 16),

                    // Branch Field
                    AppFloatTextField(
                      controller: entry.branchController,
                      onChange: (value) {
                        fromStateViewModel.updateExpenseField(index, 'branch', value);
                      },
                      inerHint: 'Branch',
                    ),
                    const SizedBox(height: 16),

                    // Type Dropdown
                    CustomList_Dropdown(
                      availableOptions: entry.branchType,
                      selectedOption: entry.selectedBranchType ?? '',
                      onSelectionChanged: (selectedOption) {
                        fromStateViewModel.updateExpenseField(index, 'branchType', selectedOption);
                      },
                      label: "Type",
                    ),
                    const SizedBox(height: 16),

                    // Amount Field
                    AppFloatTextField(
                      controller: entry.amountController,
                      onChange: (value) {
                        fromStateViewModel.updateExpenseField(index, 'amount', value);
                      },
                      inerHint: 'Amount',
                    ),
                    const SizedBox(height: 16),

                    // Remove Entry Button
                    if (formDataController.length > 1)
                      InkWell(
                        onTap: () {
                          fromStateViewModel.removeExpenseEntry(index);
                        },
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Icon(Icons.remove),
                            SizedBox(width: 8),
                            Text('Remove Form Entry'),
                          ],
                        ),
                      ),
                  ],
                ),
              );
            },
          ),


            // Add Entry Button
              AppButton(
                textStyle: const TextStyle(color: Colors.white),
                label: 'Add Another Entry',
                width: displayWidth(context)*0.91,
                height: displayHeight(context) * 0.05,
                onTap: () {
                  fromStateViewModel.addExpenseEntry();
                },
              ),
              const SizedBox(height: 16),

              // Submit Button
              AppButton(
                textStyle: const TextStyle(color: Colors.white),
                label: 'Submit Data',
                width: displayWidth(context)*0.91,
                height: displayHeight(context) * 0.05,
                onTap: () {
                  fromStateViewModel.submitBranchExpensesData();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}



