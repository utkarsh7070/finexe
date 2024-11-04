import 'dart:io';
import 'package:dropdown_textfield/dropdown_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
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
  const UpdateEmiDialogContent({super.key,   required this.index,
    required this.item});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // final dropDownControllers = ref.watch(dropDownControllerProvider);
    // final dropDownData = ref.read(modeOfCollectionDropDown);
    // final bankDownData = ref.read(bankDropDown);
    // final creditDropData = ref.read(creditDropDown);
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
        return
          SingleChildScrollView(
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
                                paymentViewModel.updatePhotoValue('', context);
                                ref.invalidate(updateEmiViewModelProvider);

                              },
                              icon: const Icon(Icons.cancel_sharp))
                        ],
                      ),
                      SizedBox(
                        height: displayHeight(context) * 0.02,
                      ),
                      topWidget(context, text1: 'FINC956', text2: 'UGRO'),
                      SizedBox(
                        height: displayHeight(context) * 0.01,
                      ),
                      nameField(
                          text1: 'Customer Name',
                          text2: 'Lakhan S/O  Ramprasad'),
                      nameField(text1: 'Collection Type', text2: 'Bounce EMI'),
                      SizedBox(
                        height: displayHeight(context) * 0.02,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          boxData(
                            context,
                            text1: 'Closure Am.',
                            text2: '₹14384',
                          ),
                          boxData(
                            context,
                            text1: 'Closure Am.',
                            text2: '₹14384',
                          ),
                          boxData(
                            context,
                            text1: 'Closure Am.',
                            text2: '₹14384',
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
                            // style: const TextStyle(color: AppColors.textGray),
                          ),

                          // errorText: isError! ? errorText : null,
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
                        // paymentViewModel.modeOfCollectionController
                        //         .dropDownValue?.name ==
                        //     'okcredit' ,
                        // && paymentState.isExtraFormOpen,
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
                        // paymentViewModel.modeOfCollectionController
                        //         .dropDownValue?.name ==
                        //     'online'&& paymentState.isExtraFormOpen ,
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
                        visible: paymentState.isEmail,
                        // paymentViewModel.modeOfCollectionController
                        //             .dropDownValue?.name ==
                        //         'online' ||
                        //     paymentViewModel.modeOfCollectionController
                        //             .dropDownValue?.name ==
                        //         'okCredit',
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
                      AppFloatTextField(
                        focusNode: paymentFocusViewModel.transactionIdFocusNode,
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
                      ),
                      SizedBox(
                        height: displayHeight(context) * 0.01,
                      ),

                      GestureDetector(
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
                      // AppButton(
                      //   textStyle: AppStyles.buttonLightTextStyle,
                      //   width: displayWidth(context) ,
                      //   onTap: () {},
                      //   label: 'Take Photo Visit',
                      // ),
                      SizedBox(height: displayHeight(context)*0.01,),
                      AppButton(
                        textStyle: AppStyles.buttonLightTextStyle,
                        width: displayWidth(context),
                        onTap: () {
                          paymentViewModel.updateEmiSubmitButton(detail: item!,context: context,ref: ref);
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
        return  Text(error.toString());
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
