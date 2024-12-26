import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../base/utils/namespase/app_colors.dart';
import '../../../base/utils/namespase/display_size.dart';
import '../../../base/utils/widget/app_button.dart';
import '../../../base/utils/widget/app_text_filed_login.dart';
import '../view_model/stamp_request_view_model.dart';
import 'CustomerSelectorDroper/customlist_drop_drown.dart';

class StampRequestForm extends ConsumerStatefulWidget {
  const StampRequestForm({super.key}); // Removed const keyword here
  @override
  ConsumerState<StampRequestForm> createState() => _StampRequestFormState(index: 0);
}

class _StampRequestFormState extends ConsumerState<StampRequestForm> {
  final int index;
  _StampRequestFormState({required this.index}); // Correct constructor

  @override
  Widget build(BuildContext context) {
    final formDataController = ref.watch(stampControllerProvider);
    final loanFromStateViewModel = ref.read(stampControllerProvider.notifier);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Stamp Request Form"),
        centerTitle: true,
        flexibleSpace: Container(
          color: Colors.white,
        ),
        titleTextStyle: const TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: 18,
          color: AppColors.black,
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: Container(
            padding: const EdgeInsets.only(left: 10.0,right:10.0 ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [

                // List of Loan Forms
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: formDataController.loanNoControllers.length,
                  itemBuilder: (context, index) {
                    final controller = formDataController.loanNoControllers[index];

                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Lender Dropdown
                          CustomList_Dropdown(
                            availableOptions: formDataController.lenderOptions,
                            selectedOption: formDataController.selectedLenderOptions.length > index
                                ? formDataController.selectedLenderOptions[index]
                                : '',
                            onSelectionChanged: (option) {
                              loanFromStateViewModel.updateSelectedLenderOptions(option, index);
                            },
                            label: "Lender",
                          ),
                          const SizedBox(height: 16),

                          // Vendor Dropdown
                          CustomList_Dropdown(
                            availableOptions: formDataController.vendorOptions,
                            selectedOption: formDataController.selectedVendorOptions.length > index
                                ? formDataController.selectedVendorOptions[index]
                                : '',
                            onSelectionChanged: (option) {
                              loanFromStateViewModel.updateSelectedVendorOptions(option, index);
                            },
                            label: "Vendor",
                          ),
                          const SizedBox(height: 16),

                          // Loan No Field
                          AppFloatTextField(
                            controller: controller,
                            onChange: (value) {
                              loanFromStateViewModel.updateLoanField(value, index);
                            },
                            inerHint: 'Loan No',
                          ),
                          const SizedBox(height: 16),

                          // Denominator Dropdown
                          CustomList_Dropdown(
                            availableOptions: formDataController.denominator,
                            selectedOption: formDataController.selectedDenominatorOptions.length > index
                                ? formDataController.selectedDenominatorOptions[index]
                                : '',
                            onSelectionChanged: (option) {
                              loanFromStateViewModel.updateSelectedDenominatorOptions(option, index);
                            },
                            label: "Denominator",
                          ),
                          const SizedBox(height: 16),

                          // Quantity Dropdown
                          CustomList_Dropdown(
                            availableOptions: formDataController.quantity,
                            selectedOption: formDataController.selectedQuantityOptions.length > index
                                ? formDataController.selectedQuantityOptions[index]
                                : '',
                            onSelectionChanged: (option) {
                              loanFromStateViewModel.updateSelectedQuantityOptions(option, index);
                            },
                            label: "Quantity",
                          ),
                          const SizedBox(height: 16),

                          // Remove Form Button
                          if (formDataController.loanNoControllers.length > 1)
                            InkWell(
                              onTap: () {
                                loanFromStateViewModel.removeLoanNoField(index);
                              },
                              child:const Row(
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


                const SizedBox(height: 28),
              // Add Co-applicant Button
                AppButton(
                  textStyle: const TextStyle(color: AppColors.white),
                  width: displayWidth(context)*0.91,
                  height: displayHeight(context) * 0.05,
                  label: 'Add Another Entries',
                  onTap: () {
                    loanFromStateViewModel.addLoanNoField(); // Add a new loan number field
                  },
                  bgColor: AppColors.greypink,
                ),

                const SizedBox(height: 30),

                // Submit Button
                AppButton(
                  width: displayWidth(context)*0.91,
                  height: displayHeight(context) * 0.05,
                  textStyle: const TextStyle(color: AppColors.white),
                  label: loanFromStateViewModel.state.loanNoControllers.length > 1
                      ? 'Add Stamp Request'
                      : 'Done',
                  onTap: () {
                    // Handle the submission action here
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

}
