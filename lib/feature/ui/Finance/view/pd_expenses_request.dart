import 'package:finexe/feature/base/internetConnection/networklistener.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../../base/utils/namespase/display_size.dart';
import '../../../base/utils/widget/app_button.dart';
import '../../../base/utils/widget/app_text_filed_login.dart';
import '../view_model/pd_expenses_view-model.dart';
import 'CustomerSelectorDroper/customlist_drop_drown.dart';

class PdExpensesRequestForm extends ConsumerStatefulWidget {
  const PdExpensesRequestForm({super.key}); // Removed const keyword here
  @override
  ConsumerState<PdExpensesRequestForm> createState() => _PdExpensesRequestFormState(index: 0);
}

class _PdExpensesRequestFormState extends ConsumerState<PdExpensesRequestForm> {
  final int index;
  _PdExpensesRequestFormState({required this.index}); // Correct constructor

  @override
  Widget build(BuildContext context) {
    final formDataController = ref.watch(pdExpensesProvider); // This for Text data
    final fromStateViewModel = ref.read(pdExpensesProvider.notifier); // This for stateNotifier

    return NetworkListener(
      context: context,
      child: Scaffold(
        appBar: AppBar(
          title: const Text("PD Request Form"),
          centerTitle: true,
          flexibleSpace: Container(
            color: Colors.white,
          ),
          titleTextStyle: const TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 18,
            color: Colors.black,
          ),
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            child: Container(
              padding: const EdgeInsets.only(left: 3.0,right:10.0 ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: formDataController.length,
                    itemBuilder: (context, index) {
                      final entry = formDataController[index];
      
                      return Padding(
                        padding: const EdgeInsets.only(left: 16.0,right:10.0 ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Date of Visit Field
                            AppFloatTextField(
                              isReadOnly: true,
                              onChange: (value) {
                                // Update the date in the ViewModel
                                fromStateViewModel.updateExpenseField(index, 'dateOfVisit', value);
                              },
                              height: displayHeight(context) * 0.09,
                              inerHint: 'Date of visit',
                              errorText: "Date To Receive/Revisit Date is a required field",
                              // isError: !entry.isRentDateValid,
                              controller: TextEditingController(
                                text: entry.dateOfVisit.isNotEmpty
                                    ? DateFormat('yyyy-MM-dd').format(DateTime.parse(entry.dateOfVisit))
                                    : '',
                              ),
                              onTap: () async {
                                // Handle date selection and update in the ViewModel
                                await fromStateViewModel.openDatePicker(index, context);
                              },
                              textInputAction: TextInputAction.done,
                              suffixIcon: Icons.calendar_today,
                              isSuffix: true,
                            ),
                            const SizedBox(height: 16),
      
                            // File No Field
                            AppFloatTextField(
                              controller: entry.fileNoController,
                              onChange: (value) {
                                fromStateViewModel.updateExpenseField(index, 'fileNo', value);
                              },
                              inerHint: 'File No.',
                              textInputAction: TextInputAction.done,
                              textInputType: TextInputType.name,
                            ),
                            const SizedBox(height: 16),
      
                            // Customer Name Field
                            AppFloatTextField(
                              controller: entry.customerNameController,
                              onChange: (value) {
                                fromStateViewModel.updateExpenseField(index, 'customerName', value);
                              },
                              inerHint: 'Customer Name',
                              textInputAction: TextInputAction.done,
                              textInputType: TextInputType.name,
                            ),
                            const SizedBox(height: 16),
      
                            // KM Travel from branch Field
                            AppFloatTextField(
                              controller: entry.kmTravelFromBranchController,
                              onChange: (value) {
                                fromStateViewModel.updateExpenseField(index, 'kmTravelFromBranch', value);
                              },
                              inerHint: 'KM Travel from branch',
                              textInputAction: TextInputAction.done,
                              textInputType: TextInputType.name,
                            ),
                            const SizedBox(height: 16),
      
                            // Denominator Dropdown
                            CustomList_Dropdown(
                              availableOptions: entry.denominator,
                              selectedOption: entry.denominator.isNotEmpty ? entry.denominator[0] : '', // First option or empty
                              onSelectionChanged: (String selectedOption) {
                                fromStateViewModel.updateDenominator(index, [selectedOption]); // Update with list
                              },
                              label: "Case Status",
                            ),
                            const SizedBox(height: 16),
      
                            // Remove Form Button
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
                  const SizedBox(height: 18),
      
                  // Add entry Button
                  AppButton(
                    textStyle: const TextStyle(color: Colors.white),
                    width: displayWidth(context)*0.91,
                    height: displayHeight(context) * 0.05,
                    label: 'Add Another Entry',
                    onTap: () {
                      fromStateViewModel.addExpenseEntry();
                    },
                    bgColor: Colors.grey,
                  ),
                  const SizedBox(height: 26),
      
                  // Submit Button
                  AppButton(
                    width: displayWidth(context)*0.91,
                    height: displayHeight(context) * 0.05,
                    textStyle: const TextStyle(color: Colors.white),
                    label: 'Submit Data',
                    onTap: () {
                      fromStateViewModel.submitPdExpensesData();
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

}
