import 'dart:io';

import 'package:dropdown_textfield/dropdown_textfield.dart';
import 'package:finexe/feature/base/extentions/capital_letter.dart';
import 'package:finexe/feature/ui/Collection/Collection%20cases/model/visit_pending_items_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../../base/utils/namespase/app_colors.dart';
import '../../../../../base/utils/namespase/app_style.dart';
import '../../../../../base/utils/namespase/display_size.dart';
import '../../../../../base/utils/namespase/font_size.dart';
import '../../../../../base/utils/widget/app_button.dart';
import '../../../../../base/utils/widget/app_text_filed_login.dart';
import '../../../Collection cases/view_model/visit_pending_view_model.dart';

class UpdateVisitDialogContent extends ConsumerWidget {
  final ItemsDetails? item;
  final int? index;

  const UpdateVisitDialogContent(
      {super.key, required this.index, required this.item});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // final dropDownControllers = ref.watch(dropDownControllerProvider);
    final dropDownData = ref.read(updateVisitDropDown);
    final paymentState = ref.watch(updateVisitViewModelProvider);
    final paymentViewModel = ref.read(updateVisitViewModelProvider.notifier);
    final paymentFocusStates =
        ref.watch(paymentStatusFocusProviderFocusProvider);
    final paymentFocusViewModel =
        ref.read(paymentStatusFocusProviderFocusProvider.notifier);
    String? imagePath;
    return SingleChildScrollView(
      physics: const AlwaysScrollableScrollPhysics(),
      child: SizedBox(
        width: displayWidth(context),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 16, right: 16, top: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        height: displayHeight(context) * 0.02,
                        width: displayWidth(context) * 0.10,
                      ),
                      SizedBox(
                          child: Align(
                              alignment: Alignment.center,
                              child: Text(
                                'Update Visit',
                                style: AppStyles.cardTextStyle16,
                              ))),
                      IconButton(
                          onPressed: () {

                            paymentViewModel.updatePhotoValue( context);
                            ref.invalidate(updateVisitViewModelProvider);
                          },
                          icon: const Icon(Icons.cancel_sharp))
                    ],
                  ),
                  SizedBox(
                    height: displayHeight(context) * 0.02,
                  ),
                  topWidget(context, text1: item?.ld!, text2: item?.partner!),
                  SizedBox(
                    height: displayHeight(context) * 0.01,
                  ),
                  nameField(
                      text1: 'Customer Name',
                      text2: '${item?.customerName}  S/O ${item?.fatherName}'),
                  nameField(
                      text1: 'Collection Type', text2: item!.collectionType),
                  SizedBox(
                    height: displayHeight(context) * 0.02,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      boxData(
                        context,
                        text1: 'Emi Amount',
                        text2: '₹${item?.emiAmount}',
                      ),
                      boxData(
                        context,
                        text1: 'Net Due',
                        text2: '₹${item?.netDue}',
                      ),
                      boxData(
                        context,
                        text1: 'Old Due',
                        text2: '₹${item?.oldDue}',
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(
              height: displayHeight(context) * 0.02,
            ),
            Container(
              padding: const EdgeInsets.only(left: 16),
              height: displayHeight(context) * 0.05,
              width: displayWidth(context),
              color: AppColors.primaryLight1,
              child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Additional Form',
                    style: AppStyles.TextStyle16.copyWith(
                        fontSize: FontSize.fontSizeS),
                  )),
            ),
            SizedBox(
              height: displayHeight(context) * 0.02,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 16.0, right: 16, bottom: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  DropDownTextField(
                    clearOption: false,
                    controller: paymentViewModel.dropDownControllerProvider,
                    listSpace: 20,
                    listPadding: ListPadding(top: 20),
                    enableSearch: false,
                    dropDownList: dropDownData,
                    listTextStyle: const TextStyle(color: AppColors.primary),
                    dropDownItemCount: 4,
                    // onChanged: (val) {
                    //   paymentViewModel.updatePaymentStatus(val);
                    // },
                    textFieldFocusNode:
                        paymentFocusViewModel.paymentStatusFocusNode,
                    textFieldDecoration: InputDecoration(
                      hintStyle: const TextStyle(color: AppColors.textGray),
                      floatingLabelStyle:
                          paymentFocusStates['paymentStatusFocusNode']!
                              ? AppStyles.subHeading
                                  .copyWith(color: AppColors.primary)
                              : AppStyles.subHeading,
                      label: const Text(
                        'Payment Status',
                        // style: const TextStyle(color: AppColors.textGray),
                      ),

                      // errorText: isError! ? errorText : null,
                      enabledBorder: const OutlineInputBorder(
                          borderSide: BorderSide(
                              color: AppColors.buttonBorderGray, width: 1),
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                      // filled: true,
                      // fillColor: AppColors.gray,
                      border: const OutlineInputBorder(
                        borderSide: BorderSide(
                            color: AppColors.buttonBorderGray, width: 1),
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),

                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: !paymentState.isPaymentStatusValid
                                  ? Colors.red
                                  : Colors.blue,
                              width: 2),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(10))),
                    ),
                  ),
                  SizedBox(
                    height: displayHeight(context) * 0.01,
                  ),
                  Visibility(
                    visible: paymentViewModel
                            .dropDownControllerProvider.dropDownValue?.value ==
                        'CustomerWillPayEmi',
                    child: AppFloatTextField(
                      focusNode: paymentFocusViewModel.paymentAmountFocusNode,
                      currentState:
                          paymentFocusStates['paymentAmountFocusNode'],
                      // controller: licenseController,
                      onChange: (value) {
                        paymentViewModel.updatePaymentAmount(value);
                      },
                      height: !paymentState.isPaymentAmountValid
                          ? displayHeight(context) * 0.09
                          : null,
                      inerHint: 'Payment Amount',
                      errorText: "Payment Amount is a required field",
                      isError: !paymentState.isPaymentAmountValid,
                      textInputAction: TextInputAction.done,
                    ),
                  ),
                  SizedBox(
                    height: displayHeight(context) * 0.01,
                  ),
                  Visibility(
                    visible: paymentViewModel.dropDownControllerProvider
                                .dropDownValue?.value ==
                            'CustomerWillPayEmi' ||
                        paymentViewModel.dropDownControllerProvider
                                .dropDownValue?.value ==
                            'CustomerWillNotPayEmi' ||
                        paymentViewModel.dropDownControllerProvider
                                .dropDownValue?.value ==
                            'CustomerNotContactable',
                    child: AppFloatTextField(
                      isReadOnly: true,
                      isSuffix: true,
                      suffixIcon: Icons.date_range,
                      suffixOnTap: () {
                        paymentViewModel.dateFilter(context);
                      },
                      focusNode: paymentFocusViewModel.dateFocusNode,
                      currentState: paymentFocusStates['dateFocusNode'],
                      controller: paymentViewModel.dateController,
                      onChange: (value) {
                        paymentViewModel.updateDate(value);
                      },
                      height: !paymentState.isDateValid
                          ? displayHeight(context) * 0.09
                          : null,
                      inerHint: 'Date To Receive/Revisit Date',
                      errorText:
                          "Date To Receive/Revisit Date is a required field",
                      isError: !paymentState.isDateValid,
                      textInputAction: TextInputAction.done,
                    ),
                  ),
                  SizedBox(
                    height: displayHeight(context) * 0.01,
                  ),
                  Visibility(
                    visible: paymentViewModel.dropDownControllerProvider
                                .dropDownValue?.value ==
                            'CustomerWillNotPayEmi' ||
                        paymentViewModel.dropDownControllerProvider
                                .dropDownValue?.value ==
                            'CustomerNotContactable',
                    child:
                    AppFloatTextField(
                      maxLine: 5,
                      focusNode: paymentFocusViewModel.reasonFocusNode,
                      currentState: paymentFocusStates['reasonFocusNode'],
                      // controller: licenseController,
                      onChange: (value) {
                        paymentViewModel.updateReason(value);
                      },
                      height: !paymentState.isReasonValid
                          ? displayHeight(context) * 0.16
                          : displayHeight(context) * 0.13,
                      inerHint: paymentViewModel.dropDownControllerProvider
                                  .dropDownValue?.value ==
                              'CustomerNotContactable'
                          ? 'Reason For Customer Not Contactable*'
                          : 'Reason For Not Pay (500 Character)*',
                      errorText: "Reason For Not Pay is a required field",
                      isError: !paymentState.isReasonValid,
                      textInputAction: TextInputAction.done,
                    ),
                  ),
                  SizedBox(
                    height: displayHeight(context) * 0.01,
                  ),
                  Visibility(
                    visible: paymentViewModel
                            .dropDownControllerProvider.dropDownValue?.value ==
                        'CustomerWillNotPayEmi',
                    child: AppFloatTextField(
                      maxLine: 5,
                      focusNode: paymentFocusViewModel.solutionFocusNode,
                      currentState: paymentFocusStates['solutionFocusNode'],
                      // controller: licenseController,
                      onChange: (value) {
                        paymentViewModel.updateSolution(value);
                      },
                      height: !paymentState.isSolutionValid
                          ? displayHeight(context) * 0.16
                          : displayHeight(context) * 0.13,

                      inerHint: 'Solution (500 Character)*',
                      errorText: "Solution is a required field",
                      isError: !paymentState.isReasonValid,
                      textInputAction: TextInputAction.done,
                    ),
                  ),
                  SizedBox(
                    height: displayHeight(context) * 0.01,
                  ),
                  GestureDetector(
                    onTap: () {
                      paymentViewModel.clickPhoto();
                      //     .then(
                      //   (value) {
                      //     if (value != null) {
                      //       imagePath = value.path;
                      //
                      //       // paymentViewModel.updateTransactionImage(imagePath!);
                      //
                      //       print('imagepath $imagePath');
                      //
                      //     } else {
                      //       print('elsepart');
                      //     }
                      //   },
                      // );
                    },
                    child: !paymentState.isLoading
                        ? Visibility(
                            visible: paymentState.photoFile.isNotEmpty,
                            replacement: const Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.file_upload_outlined,
                                  color: AppColors.primary,
                                ),
                                Text('Take Visit Photo')
                              ],
                            ),
                            child: SizedBox(
                                height: displayHeight(context) * 0.07,
                                width: displayWidth(context),
                                child:
                                    Image.file(File(paymentState.photoFile))))
                        : SizedBox(
                            height: displayHeight(context) * 0.04,
                            width: displayWidth(context) * 0.10,
                            child: const CircularProgressIndicator()),
                  ),
                  SizedBox(
                    height: displayHeight(context) * 0.02,
                  ),
                  AppButton(
                    textStyle: AppStyles.buttonLightTextStyle,
                    width: displayWidth(context),
                    isDisabled: paymentState.isButtonVissible,
                    onTap: () {
                        final isValid = paymentViewModel.validateForm(
                            paymentViewModel.dropDownControllerProvider
                                .dropDownValue?.value,context);
                        if (isValid) {
                          paymentViewModel.visitFormSubmit(datas: item!,context: context).then(
                            (value) {

                              paymentViewModel.updatePhotoValue(context);
                            },
                          );
                        }
                    },
                    label: 'Submit',
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget topWidget(context, {required String? text1, required String? text2}) {
    return SizedBox(
      width: displayWidth(context),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            text1!,
            style: AppStyles.headingTextStyleXL1
                .copyWith(fontSize: FontSize.fontSizeXL),
          ),
          Text(
            text2!,
            style: AppStyles.headingTextStyleXL2
                .copyWith(fontSize: FontSize.fontSize16),
          ),
        ],
      ),
    );
  }

  Widget nameField({required String? text1, required String? text2}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          text1!,
          style: AppStyles.subHeadingW500
              .copyWith(color: AppColors.gray7, fontSize: FontSize.fontSizeXS),
        ),
        Text(
          text2!.capitalize(), // Use for only first Letter capital.
          style: AppStyles.nameText.copyWith(
              fontSize: FontSize.fontSizeS, fontWeight: FontWeight.w600),
        ),
      ],
    );
  }

  Widget boxData(context, {required String text1, required String text2}) {
    return Container(
      width: displayWidth(context) * 0.25,
      height: displayHeight(context) * 0.09,
      decoration: const BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              colors: [
                Color(0xFF09ABFF),
                Color(0xFF0082C6),
              ]),
          borderRadius: BorderRadius.all(Radius.circular(10))),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            text1,
            style: AppStyles.subTextStyle.copyWith(color: AppColors.white),
          ),
          Text(
            text2.capitalize(),
            style: AppStyles.nameText.copyWith(
                fontWeight: FontWeight.w600,
                color: AppColors.white,
                fontSize: 16),
          )
        ],
      ),
    );
  }
}
