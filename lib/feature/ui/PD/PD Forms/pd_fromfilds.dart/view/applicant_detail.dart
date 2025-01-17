import 'package:cached_network_image/cached_network_image.dart';
import 'package:dropdown_textfield/dropdown_textfield.dart';
import 'package:finexe/feature/base/utils/namespase/app_colors.dart';
import 'package:finexe/feature/base/utils/namespase/display_size.dart';
import 'package:finexe/feature/base/utils/widget/app_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../../base/api/api.dart';
import '../../../../../base/utils/widget/app_text_filed_login.dart';
import '../../../../../base/utils/widget/upload_box.dart';
import '../view_model.dart/applicant_view_model.dart';

class ApplicantForm extends ConsumerWidget {
  final String customerId;

  const ApplicantForm({super.key, required this.customerId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isExpanded = ref.watch(isAppExpandedProvider);
    final applicantDetails = ref.watch(apiCallInitially(customerId));
    final appState = ref.watch(pdapplicantViewModelProvider);
    final appStateViewModel = ref.read(pdapplicantViewModelProvider.notifier);

    return ExpansionTile(
      childrenPadding: const EdgeInsets.only(left: 16, bottom: 0, right: 15),
      shape: const Border(
        bottom: BorderSide(color: AppColors.dividerColor),
      ),
      title: const Text('Applicant Details'),
      onExpansionChanged: (expanded) {
        ref.read(isAppExpandedProvider.notifier).state = expanded;
        if (expanded) {
          // Trigger data fetch when the tile is expanded
          ref.refresh(applicationDetailsProvider(customerId));
        }
      },
      initiallyExpanded: isExpanded,
      children: <Widget>[
        Builder(builder: (BuildContext context) {
          return applicantDetails.when(
            data: (applicant) {
              return Column(
                children: [
                  Container(
                    alignment: Alignment.centerLeft,
                    child: const Text(
                      'Personal Information',
                      textAlign: TextAlign.left,
                    ),
                  ),
                  SizedBox(
                    height: displayHeight(context) * 0.02,
                  ),
                  GestureDetector(
                    onTap: () {
                      appStateViewModel.applicantImage();
                    },
                    child: Visibility(
                      replacement: CachedNetworkImage(
                        height: displayHeight(context) * 0.16,
                        imageUrl: '${Api.baseUrl}${appState.applicantImage}',
                      ),
                      visible: appState.applicantImage.isEmpty,
                      child: UploadBox(
                        // isError: !personalFormState.isApplicantPhoto,
                        isImage: true,
                        height: displayHeight(context) * 0.16,
                        width: displayWidth(context),
                        color: AppColors.buttonBorderGray,
                        iconData: Icons.file_upload_outlined,
                        textColor: AppColors.gray5,
                        subTextColor: AppColors.primary,
                        title: 'Support: JPG, PNG',
                        subTitle: 'Click Applicant Image',
                      ),
                    ),
                  ),
                  constSizedbox(context),
                  DropDownTextField(
                    initialValue: appState.applicantType,
                    key: const Key('applicantType'),
                    clearOption: false,
                    listSpace: 20,
                    listPadding: ListPadding(top: 20),
                    enableSearch: false,
                    dropDownList:
                        appStateViewModel.applicantTypeDropdownMenuItem,
                    listTextStyle: const TextStyle(color: AppColors.primary),
                    dropDownItemCount: 2,
                    onChanged: (val) {
                      appStateViewModel.updateApplicantType(val.value);
                    },
                    textFieldDecoration: const InputDecoration(
                      hintStyle: TextStyle(color: AppColors.textGray),
                      label: Text(
                        'Applicant Type',
                      ),
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: AppColors.buttonBorderGray, width: 1),
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: AppColors.buttonBorderGray, width: 1),
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                    ),
                  ),
                  constSizedbox(context),
                  DropDownTextField(
                    initialValue: appState.businessType,
                    key: const Key('businessType'),
                    clearOption: false,
                    listSpace: 20,
                    listPadding: ListPadding(top: 20),
                    enableSearch: false,
                    dropDownList:
                        appStateViewModel.businessTypeDropdownMenuItem,
                    listTextStyle: const TextStyle(color: AppColors.primary),
                    dropDownItemCount: 2,
                    onChanged: (val) {
                      appStateViewModel.updateBusinessType(val.value);
                    },
                    textFieldDecoration: const InputDecoration(
                      hintStyle: TextStyle(color: AppColors.textGray),
                      label: Text(
                        'Business Type',
                      ),
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: AppColors.buttonBorderGray, width: 1),
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: AppColors.buttonBorderGray, width: 1),
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: displayHeight(context) * 0.01,
                  ),
                  AppFloatTextField(
                    initialValue: appState.occupation,
                    onChange: (value) {
                      appStateViewModel.updateOccupation(value);
                    },
                    errorText: "Occupation is a required field",
                    inerHint: 'Occupation',
                    isError: !appState.isOccupation,
                    textInputAction: TextInputAction.done,
                  ),
                  SizedBox(
                    height: displayHeight(context) * 0.01,
                  ),
                  AppFloatTextField(
                    initialValue: appState.yearCurrentAddress,
                    // focusNode: paymentFocusViewModel.reasonFocusNode,
                    // currentState: paymentFocusStates['reasonFocusNode'],
                    // controller: licenseController,
                    onChange: (value) {
                      appStateViewModel.updateYearCurrentAddress(value);
                    },
                    errorText: "Years at Current Address is a required field",
                    inerHint: 'Years at Current Address',
                    isError: !appState.isYearCurrentAddress,
                    textInputAction: TextInputAction.done,
                  ),
                  SizedBox(
                    height: displayHeight(context) * 0.01,
                  ),
                  AppFloatTextField(
                    initialValue: appState.houseLandmark,
                    // focusNode: paymentFocusViewModel.reasonFocusNode,
                    // currentState: paymentFocusStates['reasonFocusNode'],
                    // controller: licenseController,
                    onChange: (value) {
                      appStateViewModel.updateHouseLandmark(value);
                    },
                    errorText: "House Landmark is a required field",
                    inerHint: 'House Landmark',
                    isError: !appState.isHouseLandmark,
                    textInputAction: TextInputAction.done,
                  ),
                  SizedBox(
                    height: displayHeight(context) * 0.01,
                  ),
                  AppFloatTextField(
                    initialValue: appState.alternativeMobile,
                    // focusNode: paymentFocusViewModel.reasonFocusNode,
                    // currentState: paymentFocusStates['reasonFocusNode'],
                    // controller: licenseController,
                    onChange: (value) {
                      appStateViewModel.updateAlternativeMobile(value);
                    },
                    errorText: "Alternative Mobile is a required field",
                    inerHint: 'Alternative Mobile No',
                    isError: !appState.isAlternativeMobile,
                    textInputAction: TextInputAction.done,
                  ),
                  SizedBox(
                    height: displayHeight(context) * 0.01,
                  ),
                  AppFloatTextField(
                    initialValue: appState.email,
                    // focusNode: paymentFocusViewModel.reasonFocusNode,
                    // currentState: paymentFocusStates['reasonFocusNode'],
                    // controller: licenseController,
                    onChange: (value) {
                      appStateViewModel.updateEmail(value);
                    },
                    errorText: "Email is a required field",
                    inerHint: 'Email',
                    isError: !appState.isEmail,
                    textInputAction: TextInputAction.done,
                  ),
                  SizedBox(
                    height: displayHeight(context) * 0.01,
                  ),
                  AppFloatTextField(
                    initialValue: appState.religion,
                    // focusNode: paymentFocusViewModel.reasonFocusNode,
                    // currentState: paymentFocusStates['reasonFocusNode'],
                    // controller: licenseController,
                    onChange: (value) {
                      appStateViewModel.updateReligion(value);
                    },
                    errorText: "Religion is a required field",
                    inerHint: 'Religion',
                    isError: !appState.isReligion,
                    textInputAction: TextInputAction.done,
                  ),
                  SizedBox(
                    height: displayHeight(context) * 0.01,
                  ),
                  AppFloatTextField(
                    initialValue: appState.nationality,
                    // focusNode: paymentFocusViewModel.reasonFocusNode,
                    // currentState: paymentFocusStates['reasonFocusNode'],
                    // controller: licenseController,
                    onChange: (value) {
                      appStateViewModel.updateNationality(value);
                    },
                    errorText: "Nationality is a required field",
                    inerHint: 'Nationality',
                    isError: !appState.isNationality,
                    textInputAction: TextInputAction.done,
                  ),
                  SizedBox(
                    height: displayHeight(context) * 0.01,
                  ),
                  AppFloatTextField(
                    initialValue: appState.category,
                    // focusNode: paymentFocusViewModel.reasonFocusNode,
                    // currentState: paymentFocusStates['reasonFocusNode'],
                    // controller: licenseController,
                    onChange: (value) {
                      appStateViewModel.updateCategory(value);
                    },
                    errorText: "Category is a required field",
                    inerHint: 'Category',
                    isError: !appState.isCategory,
                    textInputAction: TextInputAction.done,
                  ),
                  SizedBox(
                    height: displayHeight(context) * 0.01,
                  ),
                  AppFloatTextField(
                    initialValue: appState.caste,
                    // focusNode: paymentFocusViewModel.reasonFocusNode,
                    // currentState: paymentFocusStates['reasonFocusNode'],
                    // controller: licenseController,
                    onChange: (value) {
                      appStateViewModel.updateCaste(value);
                    },
                    errorText: "Caste is a required field",
                    inerHint: 'Caste',
                    isError: !appState.isCaste,
                    textInputAction: TextInputAction.done,
                  ),
                  SizedBox(
                    height: displayHeight(context) * 0.01,
                  ),
                  AppFloatTextField(
                    initialValue: appState.dependentsWithCustomer,
                    // focusNode: paymentFocusViewModel.reasonFocusNode,
                    // currentState: paymentFocusStates['reasonFocusNode'],
                    // controller: licenseController,
                    onChange: (value) {
                      appStateViewModel.updateDependentsWithCustomer(value);
                    },
                    errorText: "Dependents with Customer is a required field",
                    inerHint: 'No. of Dependents with Customer',
                    isError: !appState.isDependentsWithCustomer,
                    textInputAction: TextInputAction.done,
                  ),
                  SizedBox(
                    height: displayHeight(context) * 0.01,
                  ),
                  DropDownTextField(
                    initialValue: appState.residenceType,
                    key: const Key('residenceType'),
                    clearOption: false,
                    listSpace: 20,
                    listPadding: ListPadding(top: 20),
                    enableSearch: false,
                    dropDownList:
                        appStateViewModel.residenceTypeDropdownMenuItem,
                    listTextStyle: const TextStyle(color: AppColors.primary),
                    dropDownItemCount: 3,
                    onChanged: (val) {
                      appStateViewModel.updateResidenceType(val.value);
                    },
                    textFieldDecoration: const InputDecoration(
                      hintStyle: TextStyle(color: AppColors.textGray),
                      label: Text(
                        'Residence Type',
                      ),
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: AppColors.buttonBorderGray, width: 1),
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: AppColors.buttonBorderGray, width: 1),
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: displayHeight(context) * 0.02,
                  ),
                  AppButton(
                    width: displayWidth(context),
                    bgColor: AppColors.white,
                    borderColor: AppColors.primary,
                    isBorderColor: true,
                    onTap: () {
                      final validateForm =
                          appStateViewModel.validateClickButton();
                      if (validateForm) {
                        appStateViewModel.submitPdApplicantForm(customerId);
                        ExpansionTileController.of(context).collapse();
                      }
                    },
                    label: 'Save Form',
                  ),
                  SizedBox(
                    height: displayHeight(context) * 0.01,
                  )
                ],
              );
            },
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (error, stackTrace) => Center(child: Text('Error: $error')),
          );
        })
      ],
    );
  }

  Widget constSizedbox(BuildContext context) {
    return SizedBox(height: displayHeight(context) * 0.02);
  }
}
