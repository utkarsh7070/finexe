import 'dart:io';

import 'package:dropdown_textfield/dropdown_textfield.dart';
import 'package:finexe/feature/base/utils/namespase/app_colors.dart';
import 'package:finexe/feature/base/utils/namespase/app_style.dart';
import 'package:finexe/feature/base/utils/namespase/display_size.dart';
import 'package:finexe/feature/base/utils/namespase/font_size.dart';
import 'package:finexe/feature/base/utils/widget/app_button.dart';
import 'package:finexe/feature/base/utils/widget/app_text_filed_login.dart';
import 'package:finexe/feature/base/utils/widget/upload_box.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobkit_dashed_border/mobkit_dashed_border.dart';

import '../modal/travel_expense_model.dart';
import '../view_model/travel_expense_view_model.dart';

class Travelform extends ConsumerWidget {
  const Travelform({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final getexpense = ref.watch(fetchexpensetypeProvider);
    final expensedetail = ref.watch(expensedata);
    final viewModel = ref.read(expensedata.notifier);

    return getexpense.when(
      data: (data) {
        return Scaffold(
          bottomSheet: Padding(
            padding: EdgeInsets.all(10),
            child: Row(
              children: [
                Expanded(
                  child: AppButton(
                    isFill: true,
                    bgColor: AppColors.primary,
                    borderColor: AppColors.primaryLight,
                    onTap: () {

                    },
                    label: 'Add Travel Expense',
                    textStyle: AppStyles.smallTextStyleRich.copyWith(
                        fontSize: FontSize.fontSize16,
                        fontWeight: FontWeight.w500),
                    width: displayWidth(context) * 0.4,
                    height: displayHeight(context) * 0.05,
                  ),
                ),
              ],
            ),
          ),
          appBar: AppBar(
            title: Text("Add Travel Expenses"),
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
          body: Padding(
            padding: const EdgeInsets.only(left: 16.0,right:10.0 ),
            child: SingleChildScrollView(
              physics: AlwaysScrollableScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                 const Text(
                    'Travel Expense form',
                    style: const TextStyle(
                        fontSize: 17, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: displayHeight(context) * 0.02,
                  ),
                  AppFloatTextField(
                    onTap: () async {
                      viewModel.showdatepicker(context, 'start');
                    },
                    isReadOnly: true,
                    inerHint: 'Start Travel Date',
                    controller: viewModel.startTravelController,
                    height: displayHeight(context) * 0.06,
                    onChange: (value) {},
                  ),
                  SizedBox(
                    height: displayHeight(context) * 0.02,
                  ),
                  AppFloatTextField(
                    isReadOnly: true,
                    onTap: () {
                      viewModel.showdatepicker(context, 'end');
                    },
                    inerHint: 'End Travel Date',
                    controller: viewModel.endTravelController,
                    height: displayHeight(context) * 0.06,
                    onChange: (value) {},
                  ),
                  SizedBox(
                    height: displayHeight(context) * 0.02,
                  ),
                  AppFloatTextField(
                    inerHint: 'Purpose of Travel',
                    controller: viewModel.purposeController,
                    height: displayHeight(context) * 0.06,
                    onChange: (value) {
                      viewModel.updateTravelData({
                        'purposeOfTravel': viewModel.purposeController.text,
                      });
                    },
                  ),
                  SizedBox(
                    height: displayHeight(context) * 0.02,
                  ),
                  DropDownTextField(
                    onChanged: (dropDown) {
                      if (dropDown != null) {

                      }
                    },

                    clearOption: true,

                    // listSpace: 20,
                    listPadding: ListPadding(top: 20),
                    enableSearch: false,
                    dropDownList: data,
                    listTextStyle: const TextStyle(color: AppColors.primary),
                    dropDownItemCount: data.length,
                    // textFieldFocusNode:
                    //     paymentFocusViewModel.modeOfCollection,
                    textFieldDecoration: InputDecoration(
                      isDense: true,
                      hintStyle: const TextStyle(color: AppColors.textGray),
                      floatingLabelStyle: AppStyles.subHeading,
                      label: const Text(
                        'Travel Along With',
                        style: const TextStyle(
                            fontSize: 14, color: AppColors.buttonBorderGray),
                      ),
                      enabledBorder: const OutlineInputBorder(
                          borderSide:
                          BorderSide(color: AppColors.gray, width: 1),
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                      // filled: true,
                      // fillColor: AppColors.gray,
                      border: const OutlineInputBorder(
                        borderSide: BorderSide(
                            color: AppColors.buttonBorderGray, width: 1),
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),

                      focusedBorder: const OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.blue, width: 2),
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                    ),
                  ),
                  SizedBox(
                    height: displayHeight(context) * 0.025,
                  ),
                  DropDownTextField(

                    clearOption: true,
                    // controller: ,

                    // listSpace: 20,
                    listPadding: ListPadding(top: 20),
                    enableSearch: false,
                    dropDownList: [
                      DropDownValueModel(name: 'vipul', value: 'x')
                    ],
                    listTextStyle: const TextStyle(color: AppColors.primary),
                    dropDownItemCount: 1,
                    // textFieldFocusNode:
                    //     paymentFocusViewModel.modeOfCollection,
                    textFieldDecoration: InputDecoration(
                      isDense: true,
                      hintStyle: const TextStyle(color: AppColors.textGray),
                      floatingLabelStyle: AppStyles.subHeading,
                      label: const Text(
                        'Travel Mode',
                        style: const TextStyle(
                            fontSize: 14, color: AppColors.buttonBorderGray),
                      ),
                      enabledBorder: const OutlineInputBorder(
                          borderSide:
                          BorderSide(color: AppColors.gray, width: 1),
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                      // filled: true,
                      // fillColor: AppColors.gray,
                      border: const OutlineInputBorder(
                        borderSide: BorderSide(
                            color: AppColors.buttonBorderGray, width: 1),
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),

                      focusedBorder: const OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.blue, width: 2),
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                    ),
                  ),
                  SizedBox(
                    height: displayHeight(context) * 0.01,
                  ),
                  SizedBox(
                    height: displayHeight(context) * 0.01,
                  ),
                  ListView.builder(
                    shrinkWrap: true,
                    primary: false,
                    itemCount: expensedetail.expenses.length,
                    itemBuilder: (context, index) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              SizedBox(
                                width: displayWidth(context) * 0.5,
                                height: displayHeight(context) * 0.15,
                                child: Column(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceAround,
                                  children: [
                                    DropDownTextField(
                                      // initialValue: ,
                                      controller: expensedetail
                                          .expenses[index].dropDownController,

                                      key: Key('dropdown $index'),
                                      onChanged: (dropDown) {

                                        if (dropDown != null &&
                                            dropDown is DropDownValueModel) {

                                          viewModel.updateExpenseController(
                                              index, {
                                            'expensetype':
                                            dropDown.name.toString()
                                          });
                                          // expensedetail
                                          //   .expenses[index].dropDownController.dropDownValue=dropDown;
                                        }
                                      },

                                      clearOption: true,
                                      readOnly: true,
                                      // controller: ,

                                      // listSpace: 20,
                                      listPadding: ListPadding(top: 20),
                                      enableSearch: false,
                                      dropDownList: data,
                                      listTextStyle: const TextStyle(
                                          color: AppColors.primary),
                                      dropDownItemCount: data.length,
                                      // textFieldFocusNode:
                                      //     paymentFocusViewModel.modeOfCollection,
                                      textFieldDecoration: InputDecoration(
                                        isDense: true,
                                        hintStyle: const TextStyle(
                                            color: AppColors.textGray),
                                        floatingLabelStyle:
                                        AppStyles.subHeading,
                                        label: const Text(
                                          'Expense Type',
                                          style: const TextStyle(
                                              fontSize: 14,
                                              color:
                                              AppColors.buttonBorderGray),
                                        ),
                                        enabledBorder: const OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: AppColors.gray,
                                                width: 1),
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(10))),
                                        // filled: true,
                                        // fillColor: AppColors.gray,
                                        border: const OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: AppColors.buttonBorderGray,
                                              width: 1),
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(10)),
                                        ),

                                        focusedBorder: const OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Colors.blue, width: 2),
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(10))),
                                      ),
                                    ),
                                    AppFloatTextField(
                                        inerHint: 'Expense Amount',
                                        controller: expensedetail
                                            .expenses[index].expensecontroller,
                                        height: displayHeight(context) * 0.06,
                                        onChange: (value) {
                                          viewModel.updateExpenseController(
                                              index, {'amount': value});
                                        }),
                                  ],
                                ),
                              ),
                              InkWell(
                                onTap: () => viewModel.pickImage(index),
                                child: Stack(
                                  children: [expensedetail
                                      .expenses[index].receiptUrl!=''?
                                  Container(
                                      padding: EdgeInsets.all(5),
                                      height: displayHeight(context) * 0.15,
                                      width: displayWidth(context) * 0.35,
                                      decoration: const BoxDecoration(
                                          border: DashedBorder.fromBorderSide(
                                            dashLength: 10,
                                            side: BorderSide(
                                                color: Colors.black,
                                                width: 1),
                                          ),
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(10)),
                                          color: AppColors.boxBagGray),
                                      child: Image.file(File(expensedetail
                                          .expenses[index].receiptUrl))):
                                  UploadBox(
                                    isImage: true,
                                    height: displayHeight(context) * 0.15,
                                    width: displayWidth(context) * 0.35,
                                    color: AppColors.buttonBorderGray,
                                    iconData: Icons.file_upload_outlined,
                                    textColor: AppColors.titleGray,
                                    subTextColor: AppColors.textDarkGray,
                                    title: 'Max size: 10MB',
                                    subTitle: 'Front Image',
                                  ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          Visibility(
                              visible: index == 0,
                              child: SizedBox(
                                height: displayHeight(context) * 0.03,
                              )),
                          Visibility(
                            visible: index != 0,
                            child: Padding(
                              padding: const EdgeInsets.all(16),
                              child:
                              InkWell(
                                onTap: () {
                                  viewModel.removeExpense(index);
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

                            ),
                          )
                        ],
                      );
                    },
                  ),
                  AppButton(
                    isFill: true,
                    bgColor: AppColors.primary,
                    borderColor: AppColors.primaryLight,
                    onTap: () {
                      viewModel.addEmptyExpense(Expense(
                        expenseType: '',
                        expenseAmount: 0,
                        receiptUrl: '',
                      ));
                    },
                    label: 'Add Expense',
                    textStyle: AppStyles.smallTextStyleRich.copyWith(
                        fontSize: FontSize.fontSize16,
                        fontWeight: FontWeight.w500),
                    width: displayWidth(context),
                    height: displayHeight(context) * 0.05,
                  ),
                  SizedBox(
                    height: displayHeight(context) * 0.08,
                  )
                ],
              ),
            ),
          ),
        );
      },
      error: (error, stackTrace) {
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
}