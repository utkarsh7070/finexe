import 'dart:io';

import 'package:flutter/Material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../../base/utils/namespase/app_colors.dart';
import '../../../base/utils/namespase/display_size.dart';
import '../../../base/utils/widget/app_button.dart';
import '../../../base/utils/widget/app_text_filed_login.dart';
import '../../../base/utils/widget/upload_box.dart';
import '../view_model/branch_request_view_model.dart';
import 'CustomerSelectorDroper/customlist_drop_drown.dart';

class BranchRequestForm extends ConsumerStatefulWidget {
  const BranchRequestForm({super.key}); // Removed const keyword here
  @override
  ConsumerState<BranchRequestForm> createState() => _BranchRequestFormState(index: 0);
}

class _BranchRequestFormState extends ConsumerState<BranchRequestForm> {
  final int index;
  _BranchRequestFormState({required this.index}); // Correct constructor

  @override
  Widget build(BuildContext context) {
    final formData = ref.watch(bankRequestController);
    final ReadformData = ref.read(bankRequestController.notifier);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Branch Request Form",style: TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: 18,
          color: AppColors.black,
        ),),
        centerTitle: true,
        flexibleSpace: Container(
          color: Colors.white,
        ),

      ),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: Container(
            padding: const EdgeInsets.only(left: 16.0,right:10.0 ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Branch Detail-----
                const Text(
                  'Branch Detail',
                  style: TextStyle(
                      fontWeight: FontWeight.w600, fontSize: 17),
                ),

                const SizedBox(height: 16),

                AppFloatTextField(
                  controller: formData.branchNameController,
                  onChange: (value) {
                    ReadformData.updateBranchName(value);
                  },
                  inerHint: 'Branch Name',
                  textInputType: TextInputType.name,
                ),
                const SizedBox(height: 13),

                // Cluster Dropdown
                CustomList_Dropdown(
                  availableOptions: formData.clusterOptions,
                  selectedOption: formData.selectedClusterOptions.isEmpty
                      ? ''
                      : formData.selectedClusterOptions.first,
                  onSelectionChanged: (newSelectedOption) {
                    ReadformData.updateClusterSelection(
                        [newSelectedOption]);
                  },
                  label: "Cluster office",
                ),

                const SizedBox(height: 16),
                AppFloatTextField(
                  controller: formData.branchAddressController,
                  onChange: (value) {
                    ReadformData.updateBranchAddress(value);
                  },
                  inerHint: 'Branch Address',
                  textInputType: TextInputType.name,
                ),
                const SizedBox(height: 16),
                 const Icon(Icons.my_location),

                // ----------- Owner ------
                const SizedBox(height: 16),
                const Text(
                  'Owner Detail',
                  style: TextStyle(
                      fontWeight: FontWeight.w600, fontSize: 17),
                ),
                const SizedBox(height: 8),
                AppFloatTextField(
                  controller: formData.ownerNameController,
                  onChange: (value) {
                    ReadformData.updateOwnerName(value);
                  },
                  inerHint: 'Owner Name',
                  textInputType: TextInputType.name,
                ),
                const SizedBox(height: 16),

                AppFloatTextField(
                  controller: formData.ownerContactController,
                  onChange: (value) {
                    ReadformData.updateOwnerContact(value);
                  },
                  inerHint: 'Branch Contact',
                  textInputType: TextInputType.name,
                ),

                const SizedBox(height: 16),
                AppFloatTextField(
                  controller: formData.residentialAddressController,
                  onChange: (value) {
                    ReadformData.updateOwnerResidential(value);
                  },
                  inerHint: 'Residential Address',
                  textInputType: TextInputType.name,
                ),
                const Text(
                  'Special Characters are not allowed.',
                  style: TextStyle(
                      fontWeight: FontWeight.w400, fontSize: 13),
                ),

                // ----------- Account ------
                const SizedBox(height: 16),
                const Text(
                  'Account Detail',
                  style: TextStyle(
                      fontWeight: FontWeight.w600, fontSize: 17),
                ),
                const SizedBox(height: 16),
                AppFloatTextField(
                  controller: formData.accountNameController,
                  onChange: (value) {
                    ReadformData.updateAccountNameValidation(value);
                  },
                  inerHint: 'Account Name',
                  textInputType: TextInputType.name,
                ),

                const SizedBox(height: 16),
                AppFloatTextField(
                  controller: formData.accountNumberController,
                  onChange: (value) {
                    ReadformData.updateAccountNumberValidation(value);
                  },
                  inerHint: 'Account Number',
                  textInputType: TextInputType.number,
                ),

                const SizedBox(height: 16),
                AppFloatTextField(
                  controller: formData.accountIfscController,
                  onChange: (value) {
                    ReadformData.updateAccountIfscValidation(value);
                  },
                  inerHint: 'IFSC',
                  textInputType: TextInputType.name,
                ),

                const SizedBox(height: 16),
                AppFloatTextField(
                  controller: formData.accountBankNameController,
                  onChange: (value) {
                    ReadformData.updateAccountBankNameValidation(value);
                  },
                  inerHint: 'Bank Name',
                  textInputType: TextInputType.name,
                ),


                // ----------- Broker ------
                const SizedBox(height: 16),
                const Text(
                  'Broker Detail',
                  style: TextStyle(
                      fontWeight: FontWeight.w600, fontSize: 17),
                ),
                const SizedBox(height: 16),
                AppFloatTextField(
                  controller: formData.brokerNameController,
                  onChange: (value) {
                    ReadformData.updateBrokerNameValidation(value);
                  },
                  inerHint: 'Broker Name',
                  textInputType: TextInputType.name,
                ),

                const SizedBox(height: 16),
                AppFloatTextField(
                  controller: formData.brokerAccountNumberController,
                  onChange: (value) {
                    ReadformData.updateBrokerAccountNumberValidation(value);
                  },
                  inerHint: 'Account Number',
                  textInputType: TextInputType.number,
                ),

                const SizedBox(height: 16),
                AppFloatTextField(
                  controller: formData.brokerIfscController,
                  onChange: (value) {
                    ReadformData.updateBrokerIfscValidation(value);
                  },
                  inerHint: 'IFSC',
                  textInputType: TextInputType.name,
                ),

                const SizedBox(height: 16),
                AppFloatTextField(
                  controller: formData.brokerBankNameController,
                  onChange: (value) {
                    ReadformData.updateBrokerBankValidation(value);
                  },
                  inerHint: 'Bank Name',
                  textInputType: TextInputType.name,
                ),


                // ----------- Rent ------
                const SizedBox(height: 16),
                const Text(
                  'Rent Detail',
                  style: TextStyle(
                      fontWeight: FontWeight.w600, fontSize: 17),
                ),
                const SizedBox(height: 16),
                AppFloatTextField(
                  controller: formData.pmRentController,
                  onChange: (value) {
                    ReadformData.updateRentPMRentValidation(value);
                  },
                  inerHint: 'Pm Rent',
                  textInputType: TextInputType.name,
                ),

                const SizedBox(height: 16),
                AppFloatTextField(
                  controller: formData.rentAdvanceAmountController,
                  onChange: (value) {
                    ReadformData.updateRentAmountValidation(value);
                  },
                  inerHint: 'Advance Amount',
                  textInputType: TextInputType.number,
                ),

                const SizedBox(height: 16),
                AppFloatTextField(
                  controller: formData.rentBrokerExpenseController,
                  onChange: (value) {
                    ReadformData.updateRentBrokerExpensValidation(value);
                  },
                  inerHint: 'Rent Broker Expenses',
                  textInputType: TextInputType.name,
                ),
                const SizedBox(height: 16),

                AppFloatTextField(
                  isReadOnly: true,
                  focusNode: formData.rentDateFocusNode,
                  onChange: (value) {
                    ReadformData.updateDate(DateTime.parse(
                        value)); // Parse the date string into DateTime
                  },
                  height: !formData.isRentDateValid
                      ? displayHeight(context) * 0.09
                      : null,
                  inerHint: 'Date To Receive/Revisit Date',
                  errorText:
                  "Date To Receive/Revisit Date is a required field",
                  isError: !formData.isRentDateValid,
                  controller: TextEditingController(
                    text: ref.watch(dateProvider) != null
                        ? DateFormat('yyyy-MM-dd')
                        .format(ref.watch(dateProvider)!)
                        : '',
                  ),
                  onTap: () async {
                    await ReadformData.openDatePicker(
                        ref, ref.watch(dateProvider));
                    // Update the date provider after selection
                    final pickedDate = ref.watch(dateProvider);
                    if (pickedDate != null) {
                      ref.read(dateProvider.notifier).updateDate(pickedDate);
                    }
                  },
                  textInputAction: TextInputAction.done,
                  suffixIcon: Icons.calendar_today,
                  isSuffix: true,
                ),

                const SizedBox(height: 16),
                GestureDetector(
                  onTap: () async {
                    await ReadformData.pickImage('uploadedImages');
                  },
                  child: Visibility(
                    visible: formData.uploadedImages == '',
                    replacement: SizedBox(
                      height: displayHeight(context) * 0.16,
                      width: displayWidth(context),
                      child: Image.file(
                        fit: BoxFit.contain,
                        File(formData.uploadedImages),
                      ),
                    ),
                    child: UploadBox(
                      isImage: true,
                      height: displayHeight(context) * 0.16,
                      width: displayWidth(context),
                      color: AppColors.buttonBorderGray,
                      iconData: Icons.file_upload_outlined,
                      textColor: AppColors.gray5,
                      subTextColor: AppColors.primary,
                      title: 'Support: JPG, PNG',
                      subTitle: 'Upload Branch Front',
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                GestureDetector(
                  onTap: () async {
                     await ReadformData.pickImage('uploadedImagesOne');
                  },
                  child: Visibility(
                    visible: formData.uploadedImagesOne == '',
                    replacement: SizedBox(
                      height: displayHeight(context) * 0.16,
                      width: displayWidth(context),
                      child: Image.file(
                        fit: BoxFit.contain,
                        File(formData.uploadedImagesOne),
                      ),
                    ),
                    child: UploadBox(
                      isImage: true,
                      height: displayHeight(context) * 0.16,
                      width: displayWidth(context),
                      color: AppColors.buttonBorderGray,
                      iconData: Icons.file_upload_outlined,
                      textColor: AppColors.gray5,
                      subTextColor: AppColors.primary,
                      title: 'Support: JPG, PNG',
                      subTitle: 'Upload Branch Inside 1',
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                GestureDetector(
                  onTap: () async {
                    await ReadformData.pickImage('uploadedImagesTwo');
                  },
                  child: Visibility(
                    visible: formData.uploadedImagesTwo == '',
                    replacement: SizedBox(
                      height: displayHeight(context) * 0.16,
                      width: displayWidth(context),
                      child: Image.file(
                        fit: BoxFit.contain,
                        File(formData.uploadedImagesTwo),
                      ),
                    ),
                    child: UploadBox(
                      isImage: true,
                      height: displayHeight(context) * 0.16,
                      width: displayWidth(context),
                      color: AppColors.buttonBorderGray,
                      iconData: Icons.file_upload_outlined,
                      textColor: AppColors.gray5,
                      subTextColor: AppColors.primary,
                      title: 'Support: JPG, PNG',
                      subTitle: 'Upload Branch Inside 2',
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                GestureDetector(
                  onTap: () async {
                    await ReadformData.pickImage('uploadedImagesThree');
                  },
                  child: Visibility(
                    visible: formData.uploadedImagesThree == '',
                    replacement: SizedBox(
                      height: displayHeight(context) * 0.16,
                      width: displayWidth(context),
                      child: Image.file(
                        fit: BoxFit.contain,
                        File(formData.uploadedImagesThree),
                      ),
                    ),
                    child: UploadBox(
                      isImage: true,
                      height: displayHeight(context) * 0.16,
                      width: displayWidth(context),
                      color: AppColors.buttonBorderGray,
                      iconData: Icons.file_upload_outlined,
                      textColor: AppColors.gray5,
                      subTextColor: AppColors.primary,
                      title: 'Support: JPG, PNG',
                      subTitle: 'Upload Branch Inside 3',
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                GestureDetector(
                  onTap: () async {
                    await ReadformData.pickImage('uploadedImagesFour');
                  },
                  child: Visibility(
                    visible: formData.uploadedImagesFour == '',
                    replacement: SizedBox(
                      height: displayHeight(context) * 0.16,
                      width: displayWidth(context),
                      child: Image.file(
                        fit: BoxFit.contain,
                        File(formData.uploadedImagesFour),
                      ),
                    ),
                    child: UploadBox(
                      isImage: true,
                      height: displayHeight(context) * 0.16,
                      width: displayWidth(context),
                      color: AppColors.buttonBorderGray,
                      iconData: Icons.file_upload_outlined,
                      textColor: AppColors.gray5,
                      subTextColor: AppColors.primary,
                      title: 'Support: JPG, PNG',
                      subTitle: 'Upload Branch Inside 4',
                    ),
                  ),
                ),
  
                const SizedBox(height: 26),
                AppButton(
                  height: displayHeight(context) * 0.05,
                  width:displayWidth(context),
                  textStyle: const TextStyle(color: AppColors.white),
                  label:'Add Branch Request',
                  onTap: () {},
                ),
                const SizedBox(height: 16),
              ],
            ),
          ),
        ),
      ),
    );
  }
}