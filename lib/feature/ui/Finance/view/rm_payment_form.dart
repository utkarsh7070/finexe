import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../base/utils/namespase/app_colors.dart';
import '../../../base/utils/namespase/display_size.dart';
import '../../../base/utils/widget/app_button.dart';
import '../../../base/utils/widget/app_text_filed_login.dart';
import '../view_model/rm_payment_view_model.dart';
import 'CustomerSelectorDroper/custom_radioButton_screen.dart';
import 'CustomerSelectorDroper/customlist_drop_drown.dart';

class RmPaymentForm extends ConsumerStatefulWidget {
  const RmPaymentForm({Key? key})
      : super(key: key); // Removed const keyword here
  @override
  ConsumerState<RmPaymentForm> createState() => _RmPaymentFormState(index: 0);
}

class _RmPaymentFormState extends ConsumerState<RmPaymentForm> {
  final int index;

  _RmPaymentFormState({required this.index}); // Correct constructor

  @override
  Widget build(BuildContext context) {
    final formDataController = ref.watch(rmPaymentController);
    final loanViewModel = ref.read(rmPaymentController.notifier);
    final loanFromState = ref.watch(loanViewModelProvider);
    final loanFromStateViewModel = ref.read(loanViewModelProvider.notifier);

    return Scaffold(
      appBar: AppBar(
        title: Text("RM Payment Form"),
        centerTitle: true,
        flexibleSpace: Container(
          color: Colors.white,
        ),
        titleTextStyle: TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: 18,
          color: AppColors.black,
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: Container(
            padding: const EdgeInsets.only(left: 16.0, right: 10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Claim Type Radio Buttons
                CustomRadioButtonScreen(
                  heading: 'Claim Type',
                  options: ['Adjust Against Advance', 'Claim', 'Reimbursement'],
                  onSelect: (selectedOption) {
                    loanViewModel.selectedClaimTypeController(selectedOption);
                  },
                ),
                const SizedBox(height: 16),

                // Lender Dropdown
                CustomList_Dropdown(
                  availableOptions: formDataController.lenderOption,
                  selectedOption: formDataController.selectedOptions.isEmpty
                      ? ''
                      : formDataController.selectedOptions.first,
                  onSelectionChanged: (newSelectedOption) {
                    loanViewModel
                        .updateSelectedLenderOptions([newSelectedOption]);
                  },
                  label: "Lender",
                ),
                const SizedBox(height: 16),

                // Vendor Dropdown
                CustomList_Dropdown(
                  availableOptions: formDataController.vendorOptions,
                  selectedOption:
                      formDataController.selectedVendorOptions.isEmpty
                          ? ''
                          : formDataController.selectedVendorOptions.first,
                  onSelectionChanged: (newSelectedOption) {
                    loanViewModel
                        .updateSelectedVendorOptions([newSelectedOption]);
                  },
                  label: "Vendor",
                ),
                const SizedBox(height: 16),

                // List of Loan Forms
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: loanFromState.length,
                  itemBuilder: (context, index) {
                    final form = loanFromState[index];
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Loan Entries',
                          style: TextStyle(
                              fontWeight: FontWeight.w600, fontSize: 17),
                        ),
                        const SizedBox(height: 16),

                        // Loan No Field
                        AppFloatTextField(
                          currentState: false,
                          controller: form.paymentForm_loanNo,
                          textInputAction: TextInputAction.done,
                          onChange: (value) {
                            loanFromStateViewModel.updateLoanField(
                                value, form.id, 'loanNo');
                          },
                          inerHint: 'Loan No',
                          textCapitalize: TextCapitalization.characters,
                          textInputType: TextInputType.number,

                        ),
                        const SizedBox(height: 16),


                        // Loan Amount Field
                        AppFloatTextField(
                          controller: form.paymentForm_loanAmount,
                          // Ensure this is a TextEditingController
                          onChange: (value) {
                            loanFromStateViewModel.updateLoanField(
                                value, form.id, 'loanAmount');
                          },
                          inerHint: 'Loan Amount',
                          textInputType: TextInputType.number,
                        ),
                        const SizedBox(height: 16),

                        // Tehsil Name Field
                        AppFloatTextField(
                          controller: form.paymentForm_TehsilName,
                          onChange: (value) {
                            loanFromStateViewModel.updateLoanField(
                                value, form.id, 'tehsilName');
                          },
                          inerHint: 'Tehsil Name',
                          textInputType: TextInputType.name,
                        ),
                        const SizedBox(height: 16),

                        // Branch Dropdown
                        CustomList_Dropdown(
                          availableOptions: form.branchOptions,
                          selectedOption: form.selectedBranchOptions.isEmpty
                              ? ''
                              : form.selectedBranchOptions,
                          onSelectionChanged: (newSelectedOption) {
                            loanFromStateViewModel.updateSelectedBranch(
                              form.id,
                              // Pass the form ID to update the correct form
                              newSelectedOption, // Pass the selected branch (String, not a list)
                            );
                          },
                          label: "Branch",
                        ),

                        const SizedBox(height: 16),

                        // Remove Form Button
                        if (loanFromState.length > 1)
                          InkWell(
                            onTap: () {
                              loanFromStateViewModel.removeItem(form.id);
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: const [
                                Icon(Icons.remove),
                                SizedBox(width: 8),
                                Text('Remove Form Entry'),
                              ],
                            ),
                          ),
                        const SizedBox(height: 16),
                      ],
                    );
                  },
                ),

                // Add Loan Entrie Button
                const SizedBox(height: 36),
                AppButton(
                  textStyle: const TextStyle(color: AppColors.white),
                  width: displayWidth(context),
                  height: displayHeight(context) * 0.05,
                  label: 'Add Loan Entries',
                  onTap: () {
                    loanFromStateViewModel.addForm();
                  },
                  bgColor: AppColors.greypink,
                ),

                const SizedBox(height: 26),
                // Add Co-applicant Button
                AppButton(
                  width: displayWidth(context),
                  height: displayHeight(context) * 0.05,
                  textStyle: const TextStyle(color: AppColors.white),
                  label: index < loanFromStateViewModel.state.length
                      ? 'Add RM Payment'
                      : 'Done',
                  onTap: () {},
                ),
                const SizedBox(height: 28),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
