import 'dart:io';
import 'package:dropdown_textfield/dropdown_textfield.dart';
import 'package:finexe/feature/base/utils/widget/custom_snackbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../../base/utils/namespase/app_colors.dart';
import '../../../../../base/utils/namespase/app_style.dart';
import '../../../../../base/utils/namespase/display_size.dart';
import '../../../../../base/utils/namespase/font_size.dart';
import '../../../../../base/utils/widget/app_button.dart';
import '../../../../../base/utils/widget/app_text_filed_login.dart';
import '../../../Collection cases/model/visit_pending_items_model.dart';
import '../../../Collection cases/view_model/visit_pending_view_model.dart';

class UpdateEmiDialogContent extends ConsumerWidget {
  final ItemsDetails? item;
  final int? index;

  const UpdateEmiDialogContent(
      {super.key, required this.index, required this.item});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final paymentState = ref.watch(updateEmiViewModelProvider);
    final paymentViewModel = ref.read(updateEmiViewModelProvider.notifier);
    final paymentFocusStates = ref.watch(updateEmiFocusProvider);
    final paymentFocusViewModel = ref.read(updateEmiFocusProvider.notifier);
    final getCollectionMode = ref.watch(fetchGetAllModeOfCollectionProvider);

    return getCollectionMode.when(
      data: (data) {
        List<DropDownValueModel> dropdown = [];
        for (var element in data) {
          if (element.title.isNotEmpty) {
            dropdown.add(
                DropDownValueModel(name: element.title, value: element.id));
          }
        }
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
                                    'Update EMI',
                                    style: AppStyles.cardTextStyle16,
                                  ))),
                          IconButton(
                              onPressed: () {
                                paymentViewModel.updatePhotoValue(context);
                                ref.invalidate(updateEmiViewModelProvider);
                              },
                              icon: const Icon(Icons.cancel_sharp))
                        ],
                      ),
                      SizedBox(
                        height: displayHeight(context) * 0.02,
                      ),
                      topWidget(context,
                          text1: item!.ld!, text2: item!.partner!),
                      SizedBox(
                        height: displayHeight(context) * 0.01,
                      ),
                      nameField(
                          text1: 'Customer Name',
                          text2:
                              '${item!.customerName} S/O ${item!.fatherName!}'),
                      nameField(
                          text1: 'Collection Type',
                          text2: item!.collectionType!),
                      SizedBox(
                        height: displayHeight(context) * 0.02,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          boxData(
                            context,
                            text1: 'EMI Amount',
                            text2: item!.emiAmount!,
                          ),
                          boxData(
                            context,
                            text1: 'Old Due',
                            text2: item!.oldDue!,
                          ),
                          boxData(
                            context,
                            text1: 'Net Due.',
                            text2: item!.netDue!,
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
                  padding:
                      const EdgeInsets.only(left: 16.0, right: 16, bottom: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      AppFloatTextField(
                        focusNode: paymentFocusViewModel.emiAmountFocusNode,
                        currentState: paymentFocusStates['emiAmountFocusNode'],
                        // controller: licenseController,
                        onChange: (value) {
                          paymentViewModel.updateEmiAmount(value);
                        },
                        height: !paymentState.isEmiAmount
                            ? displayHeight(context) * 0.09
                            : null,
                        inerHint: 'Received EMI Amount',
                        errorText: "EMI Amount is a required field",
                        isError: !paymentState.isEmiAmount,
                        textInputAction: TextInputAction.done,
                        textInputType: TextInputType.phone,
                      ),
                      SizedBox(
                        height: displayHeight(context) * 0.01,
                      ),
                      DropDownTextField(
                        onChanged: (dropDown) {
                          if (dropDown != null) {
                            print('drop down $dropDown');
                            paymentViewModel.openFeilds(dropDown.value);
                          }
                        },
                        clearOption: false,
                        controller: paymentViewModel.modeOfCollectionController,
                        listSpace: 20,
                        listPadding: ListPadding(top: 20),
                        enableSearch: false,
                        dropDownList: dropdown,
                        listTextStyle:
                            const TextStyle(color: AppColors.primary),
                        dropDownItemCount: data.length,
                        textFieldFocusNode:
                            paymentFocusViewModel.modeOfCollection,
                        textFieldDecoration: InputDecoration(
                          hintStyle: const TextStyle(color: AppColors.textGray),
                          floatingLabelStyle:
                              paymentFocusStates['modeOfCollection']!
                                  ? AppStyles.subHeading
                                      .copyWith(color: AppColors.primary)
                                  : AppStyles.subHeading,
                          label: const Text(
                            'Mode Of Collection',
                          ),
                          enabledBorder: const OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: AppColors.buttonBorderGray, width: 1),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10))),
                          // filled: true,
                          // fillColor: AppColors.gray,
                          border: const OutlineInputBorder(
                            borderSide: BorderSide(
                                color: AppColors.buttonBorderGray, width: 1),
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                          ),

                          focusedBorder: const OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.blue, width: 2),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10))),
                        ),
                      ),
                      SizedBox(
                        height: displayHeight(context) * 0.01,
                      ),
                      Visibility(
                        visible: paymentState.modeTitle == 'okCreditAssign' &&
                            paymentState.isExtraFormOpen,
                        child: DropDownTextField(
                          clearOption: false,
                          controller: paymentViewModel.creditPersonController,
                          listSpace: 20,
                          listPadding: ListPadding(top: 20),
                          enableSearch: false,
                          dropDownList: paymentState.subDropdown,
                          listTextStyle:
                              const TextStyle(color: AppColors.primary),
                          dropDownItemCount: 4,
                          onChanged: (val) {
                            print(val);
                            paymentViewModel.updateCreditPerson(val.value);
                          },
                          textFieldFocusNode:
                              paymentFocusViewModel.creditPersonFocusNode,
                          textFieldDecoration: InputDecoration(
                            hintStyle:
                                const TextStyle(color: AppColors.textGray),
                            floatingLabelStyle:
                                paymentFocusStates['creditPersonFocusNode']!
                                    ? AppStyles.subHeading
                                        .copyWith(color: AppColors.primary)
                                    : AppStyles.subHeading,
                            label: const Text(
                              'Credit Person',
                            ),
                            enabledBorder: const OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: AppColors.buttonBorderGray,
                                    width: 1),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10))),
                            border: const OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: AppColors.buttonBorderGray, width: 1),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                            ),
                            focusedBorder: const OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.blue, width: 2),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10))),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: displayHeight(context) * 0.01,
                      ),
                      Visibility(
                        visible: paymentState.modeTitle == 'bankName' &&
                            paymentState.isExtraFormOpen,
                        child: DropDownTextField(
                          clearOption: false,
                          controller: paymentViewModel.bankNameController,
                          listSpace: 20,
                          listPadding: ListPadding(top: 20),
                          enableSearch: false,
                          dropDownList: paymentState.subDropdown,
                          listTextStyle:
                              const TextStyle(color: AppColors.primary),
                          dropDownItemCount: 4,
                          onChanged: (val) {
                            paymentViewModel.updateCreditPerson(val.value);
                            paymentViewModel.updateBankName(val.value);
                          },
                          textFieldFocusNode:
                              paymentFocusViewModel.bankNameFocusNode,
                          textFieldDecoration: InputDecoration(
                            hintStyle:
                                const TextStyle(color: AppColors.textGray),
                            floatingLabelStyle:
                                paymentFocusStates['bankNameFocusNode']!
                                    ? AppStyles.subHeading
                                        .copyWith(color: AppColors.primary)
                                    : AppStyles.subHeading,
                            label: const Text(
                              'Select Bank Name',
                            ),
                            enabledBorder: const OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: AppColors.buttonBorderGray,
                                    width: 1),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10))),
                            border: const OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: AppColors.buttonBorderGray, width: 1),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                            ),
                            focusedBorder: const OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.blue, width: 2),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10))),
                          ),
                        ),
                      ),

                      SizedBox(
                        height: displayHeight(context) * 0.01,
                      ),
                      Visibility(
                        visible: paymentState.isEmailVisible,
                        child: AppFloatTextField(
                          focusNode: paymentFocusViewModel.receiptFocusNode,
                          currentState: paymentFocusStates['receiptFocusNode'],
                          // controller: licenseController,
                          onChange: (value) {
                            paymentViewModel.updateReceipt(value);
                          },
                          height: !paymentState.isReceipt
                              ? displayHeight(context) * 0.09
                              : null,
                          inerHint: 'Mention Mail For Receipt',
                          errorText:
                              "Date To Receive/Revisit Date is a required field",
                          isError: !paymentState.isReceipt,
                          textInputAction: TextInputAction.done,
                        ),
                      ),
                      SizedBox(
                        height: displayHeight(context) * 0.01,
                      ),

                      Visibility(
                        visible: paymentState.isTransactionIdVisible,
                        child: AppFloatTextField(
                          focusNode:
                              paymentFocusViewModel.transactionIdFocusNode,
                          currentState:
                              paymentFocusStates['transactionIdFocusNode'],
                          // controller: licenseController,
                          onChange: (value) {
                            paymentViewModel.updateTransactionId(value);
                          },
                          height: !paymentState.isTransactionId
                              ? displayHeight(context) * 0.09
                              : null,
                          inerHint: 'Transaction Id',
                          errorText: "Transaction Id is a required field",
                          isError: !paymentState.isTransactionId,
                          textInputAction: TextInputAction.done,
                          textInputType: TextInputType.text,
                        ),
                      ),
                      SizedBox(
                        height: displayHeight(context) * 0.01,
                      ),
                      AppFloatTextField(
                        maxLine: 5,
                        focusNode: paymentFocusViewModel.remarkFocusNode,
                        currentState: paymentFocusStates['remarkFocusNode'],
                        // controller: licenseController,
                        onChange: (value) {
                          paymentViewModel.updateRemark(value);
                        },
                        height: !paymentState.isRemark
                            ? displayHeight(context) * 0.16
                            : displayHeight(context) * 0.13,

                        inerHint: 'Remark*',
                        errorText: "Remark* is a required field",
                        isError: !paymentState.isRemark,
                        textInputAction: TextInputAction.done,
                        textInputType: TextInputType.text,
                      ),
                      SizedBox(
                        height: displayHeight(context) * 0.01,
                      ),

                      Visibility(
                        visible: paymentState.isTransactionImageVisible,
                        child: GestureDetector(
                          onTap: () {
                            paymentViewModel.clickPhoto().then(
                              (value) {
                                if (value != null) {
                                  // imagePath = value.path;
                                  // print('imagepath ${imagePath}');
                                  paymentViewModel.uploadImage(value.path);
                                } else {
                                  // ref.watch(updateEmiViewModelProvider.notifier);
                                  // paymentState.isLoading = false;
                                  print('elsepart');
                                }
                              },
                            );
                          },
                          child:
                          !paymentState.isLoading ?
                          Visibility(
                                  visible: paymentState.photoFile.isNotEmpty,
                                  replacement: const Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.file_upload_outlined,
                                        color: AppColors.primary,
                                      ),
                                      Text('Upload Transaction Image')
                                    ],
                                  ),
                                  child: SizedBox(
                                      height: displayHeight(context) * 0.07,
                                      width: displayWidth(context),
                                      child: Image.file(
                                          File(paymentState.photoFile))))
                              : SizedBox(
                                  height: displayHeight(context) * 0.04,
                                  width: displayWidth(context) * 0.07,
                                  child: const CircularProgressIndicator()),
                        ),
                      ),
                      // AppButton(
                      //   textStyle: AppStyles.buttonLightTextStyle,
                      //   width: displayWidth(context) ,
                      //   onTap: () {},
                      //   label: 'Take Photo Visit',
                      // ),
                      SizedBox(
                        height: displayHeight(context) * 0.01,
                      ),
                      AppButton(
                        textStyle: AppStyles.buttonLightTextStyle,
                        width: displayWidth(context),
                        isDisabled: !paymentState.isButtonVissible,
                        onTap: () {
                          if (paymentViewModel.modeOfCollectionController
                                  .dropDownValue?.name !=
                              null) {
                            final bool value = paymentViewModel.validation(
                                paymentViewModel.modeOfCollectionController
                                    .dropDownValue!.name,
                                context);
                            print(value);
                            if (value) {
                              paymentViewModel.updateEmiSubmitButton(
                                  detail: item!, context: context, ref: ref);
                            }
                          } else {
                            showCustomSnackBar(
                                context,
                                'Please Select Mode of Collection',
                                Colors.red.shade300);
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
      },
      error: (error, stackTrace) {
        print(error.toString());
        return Text(error.toString());
      },
      loading: () {
        return SizedBox(
            height: displayHeight(context) * 0.07,
            width: displayWidth(context),
            child: Center(
                child: SizedBox(
                    height: displayHeight(context) * 0.04,
                    width: displayWidth(context) * 0.10,
                    child: const CircularProgressIndicator())));
      },
    );
  }

  Widget topWidget(context, {required String text1, required String text2}) {
    return SizedBox(
      width: displayWidth(context),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            text1,
            style: AppStyles.headingTextStyleXL1
                .copyWith(fontSize: FontSize.fontSizeXL),
          ),
          Text(
            text2,
            style: AppStyles.headingTextStyleXL2
                .copyWith(fontSize: FontSize.fontSize16),
          ),
        ],
      ),
    );
  }

  Widget nameField({required String text1, required String text2}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          text1,
          style: AppStyles.subHeadingW500
              .copyWith(color: AppColors.gray7, fontSize: FontSize.fontSizeXS),
        ),
        Text(
          text2,
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
            text2,
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

void showLoadingDialog(BuildContext context) {
  showDialog(
    context: context,
    barrierDismissible: false, // Prevents dismissing the dialog by tapping outside
    builder: (context) {
      return Dialog(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        child: const Padding(
          padding: EdgeInsets.all(16.0),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              CircularProgressIndicator(),
              SizedBox(width: 16),
              Text("Loading..."),
            ],
          ),
        ),
      );
    },
  );
}
