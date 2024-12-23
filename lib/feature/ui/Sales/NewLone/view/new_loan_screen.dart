import 'dart:math';

import 'package:dropdown_textfield/dropdown_textfield.dart';
import 'package:finexe/feature/base/routes/routes.dart';
import 'package:finexe/feature/base/utils/namespase/display_size.dart';
import 'package:finexe/feature/base/utils/namespase/font_size.dart';
import 'package:finexe/feature/base/utils/widget/custom_snackbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../base/utils/namespase/app_colors.dart';
import '../../../../base/utils/namespase/app_style.dart';
import '../../../../base/utils/widget/app_button.dart';
import '../../../../base/utils/widget/app_text_filed_login.dart';
import '../model/get_All_Product_model.dart';
import '../view_model/new_loan_view_model.dart';

class NewLoanScreen extends ConsumerWidget {
  const NewLoanScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    //-----------------------------------------------------------------------------
    final getAllProduct = ref.watch(fetchDataProvider);
    final phoneState = ref.watch(personalDetailViewModelProvider);
    final phoneViewModel = ref.read(personalDetailViewModelProvider.notifier);
    final personalFocusStates = ref.watch(newLoanFocusProvider);
    final phoneFocusViewModel = ref.read(newLoanFocusProvider.notifier);

    return Scaffold(
      body: Container(
        width: displayWidth(context),
        height: displayHeight(context),
        color: AppColors.primary,
        padding: const EdgeInsets.only(top: 80),
        child: Container(
          height: displayHeight(context),
          padding: const EdgeInsets.all(20),
          decoration: const BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30), topRight: Radius.circular(30))),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const BackButton(),
                  const Text(
                    textAlign: TextAlign.center,
                    'New Loan',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(
                    width: displayWidth(context) * 0.10,
                  )
                ],
              ),
              SizedBox(
                height: displayHeight(context) * 0.01,
              ),
              Expanded(
                child: SingleChildScrollView(
                    physics: const AlwaysScrollableScrollPhysics(),
                    child: getAllProduct.when(
                      data: (data) {
                        List<DropDownValueModel> dropdown = [];
                        for (var element in data) {
                          if (element.productName.isNotEmpty) {
                            dropdown.add(DropDownValueModel(
                                name: element.productName, value: element.id));
                          }
                        }

                        final item = data.firstWhere(
                          (element) =>
                              element.productName ==
                              phoneViewModel
                                  .dropDownController.dropDownValue?.name,
                          orElse: () => Item(
                              loanAmount: LoanAmount(min: 0, max: 100),
                              roi: LoanAmount(min: 0, max: 100),
                              tenure: LoanAmount(min: 0, max: 100),
                              id: '0',
                              productName: 'productName',
                              loginFees: 0,
                              status: 'status',
                              createdAt: DateTime(000),
                              updatedAt: DateTime(000),
                              v: 0,
                              permissionFormId: 'permissionFormId',
                              productFinId: 'productFinId'),
                        );

                        final int division = (item.loanAmount.max?.toDouble()??0/5).toInt();
                        print('division ${division}');

                        return Wrap(
                          crossAxisAlignment: WrapCrossAlignment.center,
                          verticalDirection: VerticalDirection.down,
                          // runSpacing: displayHeight(context) * 0.04,
                          clipBehavior: Clip.none,
                          children: [
                            Column(
                              children: [
                                SizedBox(
                                  height: displayHeight(context) * 0.01,
                                ),
                                AppFloatTextField(
                                  focusNode:
                                      phoneFocusViewModel.phoneNumberFocusNode,
                                  currentState: personalFocusStates[
                                      'phoneNumberFocusNode'],
                                  // controller: licenseController,
                                  onChange: (value) {
                                    phoneViewModel.updatePhoneNumber(value);
                                  },
                                  height: !phoneState.isPhoneNumberValid
                                      ? displayHeight(context) * 0.09
                                      : null,
                                  inerHint: 'Customer Mobile no',
                                  errorText: "Mobile no is a required field",
                                  isError: !phoneState.isPhoneNumberValid,
                                  textInputType: TextInputType.phone,
                                  textInputAction: TextInputAction.done,
                                ),
                                SizedBox(
                                  height: displayHeight(context) * 0.01,
                                ),
                                DropDownTextField(
                                  clearOption: false,
                                  controller: phoneViewModel.dropDownController,
                                  listSpace: 20,
                                  listPadding: ListPadding(top: 20),
                                  enableSearch: false,
                                  dropDownList: dropdown,
                                  listTextStyle:
                                      const TextStyle(color: AppColors.primary),
                                  dropDownItemCount: 9,
                                  onChanged: (dropDown) {
                                    if (kDebugMode) {
                                      print(dropDown.name);
                                    }
                                    phoneViewModel.updateProduct(
                                        dropDown.name, data);
                                  },
                                  textFieldFocusNode:
                                      phoneFocusViewModel.productFocusNode,
                                  textFieldDecoration: InputDecoration(
                                    hintStyle: const TextStyle(
                                        color: AppColors.textGray),
                                    floatingLabelStyle:
                                        personalFocusStates['productFocusNode']!
                                            ? AppStyles.subHeading.copyWith(
                                                color: AppColors.primary)
                                            : AppStyles.subHeading,
                                    label: const Text(
                                      'Product',
                                    ),
                                    enabledBorder: const OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: AppColors.gray, width: 1),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10))),
                                    // filled: true,
                                    // fillColor: AppColors.gray,
                                    border: const OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: AppColors.gray, width: 2),
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(10)),
                                    ),

                                    focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color:
                                                !phoneState.isPhoneNumberValid
                                                    ? Colors.red
                                                    : Colors.blue,
                                            width: 2),
                                        borderRadius: const BorderRadius.all(
                                            Radius.circular(10))),
                                  ),
                                ),
                                SizedBox(
                                  height: displayHeight(context) * 0.02,
                                ),
                                amountShow(
                                    context,
                                    phoneState.loanAmount,
                                    phoneState.roi,
                                    phoneState.tenure,
                                    phoneState.emi),
                                SizedBox(
                                  height: displayHeight(context) * 0.02,
                                ),
                                // SizedBox(
                                //   height: displayHeight(context) * 0.01,
                                // ),
                                AppFloatTextField(
                                  // focusNode:
                                  // phoneFocusViewModel.phoneNumberFocusNode,
                                  // currentState: personalFocusStates[
                                  // 'phoneNumberFocusNode'],
                                  // controller: licenseController,
                                  onChange: (value) {
                                    final double val = double.parse(value);
                                    if(val >= item.loanAmount.min! && val <= item.loanAmount.max!) {
                                      phoneViewModel.updateLoanAmount(val);
                                      phoneViewModel.updateEmi();
                                    }
                                  },
                                  // height: !phoneState.isPhoneNumberValid
                                  //     ? displayHeight(context) * 0.09
                                  //     : null,
                                  inerHint: 'Enter Lone Amount',
                                  // errorText: "Mobile no is a required field",
                                  // isError: !(phoneState.loanAmount >= item.loanAmount.min! && phoneState.loanAmount <= item.loanAmount.max!),
                                  textInputType: TextInputType.phone,
                                  textInputAction: TextInputAction.done,
                                ),
                                SizedBox(height: displayHeight(context)*0.01,),
                                amountTextShow(
                                    data: 'Loan Amount (Lack)',
                                    price: '${phoneState.loanAmount.toInt()}'),
                                // SizedBox(
                                //   height: displayHeight(context) * 0.01,
                                // ),
                                // SfLinearGauge(
                                //   interval: 50000,
                                //   axisTrackStyle: const LinearAxisTrackStyle(
                                //       edgeStyle: LinearEdgeStyle.bothCurve,
                                //       color: AppColors.linearBarColor),
                                //   minimum: item.loanAmount.min.toDouble(),
                                //   maximum: item.loanAmount.max.toDouble(),
                                //   showTicks: true,
                                //   showLabels: false,
                                //   minorTicksPerInterval: 1,
                                //   majorTickStyle:
                                //       const LinearTickStyle(length: 7),
                                //   minorTickStyle:
                                //       const LinearTickStyle(length: 5),
                                //   axisLabelStyle: const TextStyle(fontSize: 12),
                                //   markerPointers: [
                                //     // Widget for the draggable pointer
                                //     LinearWidgetPointer(
                                //         value: phoneState.loanAmount,
                                //         onChanged: (double value) {
                                //           phoneViewModel
                                //               .updateLoanAmount(value);
                                //           phoneViewModel.updateEmi();
                                //         },
                                //         child: const Icon(
                                //           Icons.circle,
                                //           color: AppColors.primary,
                                //           size: 20,
                                //         )),
                                //   ],
                                //   ranges: [
                                //     LinearGaugeRange(
                                //       edgeStyle: LinearEdgeStyle.bothCurve,
                                //       position: LinearElementPosition.cross,
                                //       startValue:
                                //           item.loanAmount.min.toDouble(),
                                //       endValue: phoneState.loanAmount,
                                //       color: AppColors.primary,
                                //     ),
                                //   ],
                                // ),
                                Slider(
                                  activeColor: AppColors.primary,
                                  inactiveColor: AppColors.linearBarColor,
                                  value: phoneState.loanAmount,
                                  min: item.loanAmount.min?.toDouble()??0,
                                  max: item.loanAmount.max?.toDouble()??0,
                                  divisions: 4,
                                  // label: phoneState.loanAmount.round().toString(),
                                  onChanged: (double value) {
                                    phoneViewModel.updateLoanAmount(value);
                                    phoneViewModel.updateEmi();
                                  },
                                ),

                                // SizedBox(
                                //       height: displayHeight(context) * 0.02,
                                // ),
                                 amountTextShow(
                                    data: 'Interest Rate',
                                    price: '${phoneState.roi.toInt()}%'),
                                Slider(
                                  activeColor: AppColors.primary,
                                  inactiveColor: AppColors.linearBarColor,
                                  value: phoneState.roi,
                                  min: item.roi.min?.toDouble()??0,
                                  max: item.roi.max?.toDouble()??0,
                                  // divisions: 4??division,
                                  // label: phoneState.loanAmount.round().toString(),
                                  onChanged: (double value) {
                                    phoneViewModel.updateInterestLone(value);
                                    phoneViewModel.updateEmi();
                                  },
                                ),
                                // SizedBox(
                                //   height: displayHeight(context) * 0.01,
                                // ),
                                // SfLinearGauge(
                                //   axisTrackStyle: const LinearAxisTrackStyle(
                                //       color: AppColors.linearBarColor,
                                //       edgeStyle: LinearEdgeStyle.bothCurve),
                                //   minimum: item.roi.min.toDouble(),
                                //   maximum: item.roi.max.toDouble(),
                                //   showTicks: true,
                                //   showLabels: false,
                                //   majorTickStyle:
                                //       const LinearTickStyle(length: 7),
                                //   minorTickStyle:
                                //       const LinearTickStyle(length: 5),
                                //   axisLabelStyle: const TextStyle(fontSize: 12),
                                //   markerPointers: [
                                //     // Widget for the draggable pointer
                                //     LinearWidgetPointer(
                                //         value: phoneState.roi,
                                //         onChanged: (double value) {
                                //           phoneViewModel
                                //               .updateInterestLone(value);
                                //           phoneViewModel.updateEmi();
                                //         },
                                //         child: const Icon(
                                //           Icons.circle,
                                //           color: AppColors.primary,
                                //           size: 20,
                                //         )),
                                //   ],
                                //   ranges: [
                                //     LinearGaugeRange(
                                //       edgeStyle: LinearEdgeStyle.bothCurve,
                                //       position: LinearElementPosition.cross,
                                //       startValue: item.roi.min.toDouble(),
                                //       endValue: phoneState.roi,
                                //       color: AppColors.primary,
                                //     ),
                                //   ],
                                // ),
                                // SizedBox(
                                //   height: displayHeight(context) * 0.03,
                                // ),
                                amountTextShow(
                                    data: 'Tenure',
                                    price: '${phoneState.tenure.toInt()}'),
                                Slider(
                                  activeColor: AppColors.primary,
                                  inactiveColor: AppColors.linearBarColor,
                                  value: phoneState.tenure,
                                  min: item.tenure.min?.toDouble()??0,
                                  max: item.tenure.max?.toDouble()??0,
                                  // divisions: 4??division,
                                  // label: phoneState.loanAmount.round().toString(),
                                  onChanged: (double value) {
                                    phoneViewModel.updateTenureRate(value);
                                    phoneViewModel.updateEmi();
                                  },
                                ),
                                // SizedBox(
                                //   height: displayHeight(context) * 0.01,
                                // ),
                                // SfLinearGauge(
                                //   showAxisTrack: true,
                                //   axisTrackStyle: const LinearAxisTrackStyle(
                                //       color: AppColors.linearBarColor,
                                //       edgeStyle: LinearEdgeStyle.bothCurve),
                                //   minimum: item.tenure.min.toDouble(),
                                //   maximum: item.tenure.max.toDouble(),
                                //   showTicks: true,
                                //   showLabels: false,
                                //   majorTickStyle: const LinearTickStyle(
                                //       length: 7,
                                //       color: AppColors.linearBarColor,
                                //       thickness: 2),
                                //   minorTickStyle: const LinearTickStyle(
                                //       length: 5,
                                //       color: AppColors.linearBarColor,
                                //       thickness: 2),
                                //   // axisLabelStyle: const TextStyle(fontSize: 12),
                                //   markerPointers: [
                                //     // Widget for the draggable pointer
                                //     LinearWidgetPointer(
                                //         value: phoneState.tenure,
                                //         onChanged: (double value) {
                                //           phoneViewModel
                                //               .updateTenureRate(value);
                                //           phoneViewModel.updateEmi();
                                //         },
                                //         child: const Icon(
                                //           CupertinoIcons.circle_fill,
                                //           color: AppColors.primary,
                                //           size: 20,
                                //         )),
                                //   ],
                                //   ranges: [
                                //     LinearGaugeRange(
                                //       edgeStyle: LinearEdgeStyle.bothCurve,
                                //       startValue: item.tenure.min.toDouble(),
                                //       endValue: phoneState.tenure,
                                //       color: AppColors.primary,
                                //       position: LinearElementPosition.cross,
                                //     ),
                                //   ],
                                // ),
                                // SizedBox(
                                //   height: displayHeight(context) * 0.01,
                                // ),
                                SizedBox(
                                  height: displayHeight(context) * 0.02,
                                ),
                                AppButton(
                                  width: displayWidth(context),
                                  onTap: () {
                                    bool isValidate =
                                        phoneViewModel.validation();
                                    if (isValidate) {
                                      phoneViewModel
                                          .submitNewLoan(item.id)
                                          .then(
                                        (value) {
                                          if (value) {
                                            print(phoneState.phoneNumber);
                                            showCustomSnackBar(
                                                context,
                                                'New Loan is Created Successfully',
                                                Colors.green);
                                            Navigator.pushNamedAndRemoveUntil(
                                              context,
                                              AppRoutes.saleApplicationForm,
                                              (route) => false,
                                              arguments: {
                                                'phoneNumber': phoneState.phoneNumber,
                                              },
                                            );
                                            // goPayment.payWithRazorPay(phoneState.loanAmount.toDouble());
                                          }
                                        },
                                      );
                                    }
                                  },
                                  label: 'Submit',
                                  textStyle:
                                      const TextStyle(color: AppColors.white),
                                ),
                              ],
                            )
                          ],
                        );
                      },
                      error: (error, stackTrace) => const Text('data'),
                      loading: () =>
                          const Center(child: CircularProgressIndicator()),
                    )),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget amount(context, {required String amount, required String title}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const Icon(
              Icons.circle,
              color: AppColors.grayLine,
              size: 8,
            ),
            SizedBox(
              width: displayWidth(context) * 0.01,
            ),
            Text(title,
                style: AppStyles.subTextStyle.copyWith(
                    color: AppColors.grayLine, fontWeight: FontWeight.w500)),
          ],
        ),
        SizedBox(
          height: displayHeight(context) * 0.01,
        ),
        Text(
          amount,
          style: AppStyles.buttonLightTextStyle
              .copyWith(fontSize: 16, fontWeight: FontWeight.w500),
        )
      ],
    );
  }

  Widget amountShow(BuildContext context, double loanAmount, double interest,
      double tenure, emi) {
    return Container(
      padding: const EdgeInsets.all(16),
      height: displayHeight(context) * 0.18,
      decoration: BoxDecoration(
          gradient: const LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Color(0xFF09ABFF),
                Color(0xFF0082C6),
              ]),
          border: Border.all(color: AppColors.boxBorderGray),
          borderRadius: const BorderRadius.all(Radius.circular(10))),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          RichText(
            text: TextSpan(
              text: '${emi}',
              style: AppStyles.buttonLightTextStyle
                  .copyWith(fontSize: FontSize.fontSizeL),
              children: <TextSpan>[
                TextSpan(
                    text: '/Monthly EmI',
                    style: AppStyles.cardTextStyle16
                        .copyWith(color: AppColors.grayLine)),
              ],
            ),
          ),
          SizedBox(
            height: displayHeight(context) * 0.01,
          ),
          const Divider(
            color: AppColors.grayColor4,
            thickness: 1,
          ),
          SizedBox(
            height: displayHeight(context) * 0.003,
          ),
          IntrinsicHeight(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                amount(context,
                    title: 'Loan Amount', amount: '${loanAmount.toInt()}'),
                VerticalDivider(
                  width: displayWidth(context) * 0.05,
                  color: AppColors.grayColor4,
                  thickness: 1,
                ),
                amount(context,
                    title: 'Interest', amount: '${interest.toInt()}%'),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget amountTextShow({
    required String data,
    required String price,
  }) {
    return SizedBox(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(data,
              style: AppStyles.subTextStyle.copyWith(
                  color: AppColors.grayColor3, fontWeight: FontWeight.w500)),
          Text(
            price,
            style: AppStyles.termsConditionText.copyWith(
                fontSize: FontSize.fontSizeS, fontWeight: FontWeight.w500),
          )
        ],
      ),
    );
  }
}
