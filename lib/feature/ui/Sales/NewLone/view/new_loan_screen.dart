import 'package:dropdown_textfield/dropdown_textfield.dart';
import 'package:finexe/feature/base/routes/routes.dart';
import 'package:finexe/feature/base/utils/namespase/display_size.dart';
import 'package:finexe/feature/base/utils/namespase/font_size.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';
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
    final getAllProduct = ref.watch(fetchDataProvider);
    // final selectedValue = ref.watch(dropdownValueProvider);
    final phoneState = ref.watch(personalDetailViewModelProvider);
    final phoneViewModel = ref.read(personalDetailViewModelProvider.notifier);
    final personalFocusStates = ref.watch(newLoanFocusProvider);
    final phoneFocusViewModel = ref.read(newLoanFocusProvider.notifier);

    final loanAmount = ref.watch(newLoanAmount);
    final interestRate = ref.watch(newInterestRate);
    final tenure = ref.watch(newTenureRate);
    // final getAllProducts = getAllProduct.value?.items.where((element) => element.productName == phoneViewModel.dropDownController.dropDownValue?.name,);

    // getAllProductsList.select(
    //   (value) {
    //     value?.where(
    //       (element) {
    //         return element.productName ==
    //             phoneViewModel.dropDownController.dropDownValue?.name
    //                 .toString();
    //       },
    //     );
    //   },
    // );

    return Scaffold(
      // appBar: AppBar(
      //   title: const Text('New Loan'),
      // ),
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
                        // List<Item> list = data.items;
                        // final Item filteredData =list.where(test);
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
                                  inerHint: 'Payment Amount',
                                  errorText:
                                      "Payment Amount is a required field",
                                  isError: !phoneState.isPhoneNumberValid,
                                  textInputAction: TextInputAction.done,
                                ),
                                SizedBox(
                                  height: displayHeight(context) * 0.01,
                                ),
                                DropDownTextField(
                                  controller: phoneViewModel.dropDownController,
                                  // initialValue: phoneViewModel.dropDownController.dropDownValue?.name,
                                  listSpace: 20,
                                  listPadding: ListPadding(top: 20),
                                  enableSearch: false,
                                  dropDownList: const [
                                    DropDownValueModel(
                                        name: 'MICRO LAP', value: "microLap"),
                                    DropDownValueModel(
                                        name: 'LAp', value: "lap"),
                                    DropDownValueModel(
                                        name: 'LAp1', value: "lap1"),
                                    DropDownValueModel(
                                        name: 'LAp2', value: "lap2"),
                                    DropDownValueModel(
                                        name: 'Local stage',
                                        value: "localStage"),
                                    DropDownValueModel(
                                        name: 'Test', value: "test"),
                                    DropDownValueModel(
                                        name: 'FIN PRODUCT 1RS',
                                        value: "finProduct1Rs"),
                                    DropDownValueModel(
                                        name: 'FIN PRODUCT',
                                        value: "finProduct"),
                                    DropDownValueModel(
                                        name: 'Test 3', value: "test3"),
                                    DropDownValueModel(
                                        name: 'FIN CAR', value: "finCar"),
                                    DropDownValueModel(
                                        name: 'New Producet Added ',
                                        value: "newProducetAdded"),
                                    DropDownValueModel(
                                        name: 'LAp4', value: "Lap4"),
                                    DropDownValueModel(
                                        name: 'testBT', value: "testBt"),
                                    DropDownValueModel(
                                        name: 'NEW PRODUCT FIN COOPERS 28',
                                        value: "newProductFinCoopers28"),
                                    DropDownValueModel(
                                        name: 'Product Name FIN',
                                        value: "productNameFin"),
                                    DropDownValueModel(
                                        name: '3rd product',
                                        value: "3rdProduct"),
                                    DropDownValueModel(
                                        name: 'Secured LAP MICRO',
                                        value: "securedLapMicro"),
                                  ],
                                  listTextStyle:
                                      const TextStyle(color: AppColors.primary),
                                  dropDownItemCount: 9,
                                  onChanged: (val) {
                                    // phoneViewModel.updateProduct(val);
                                    // ref.read(dropdownValueProvider.notifier).state = val;
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
                                      // style: const TextStyle(color: AppColors.textGray),
                                    ),

                                    // errorText: isError! ? errorText : null,
                                    enabledBorder: const OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: AppColors.gray, width: 2),
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
                                  height: displayHeight(context) * 0.04,
                                ),
                                amountShow(context),
                                SizedBox(
                                  height: displayHeight(context) * 0.04,
                                ),
                                amountTextShow(
                                    data: 'Loan Amount',
                                    price: '${loanAmount.toInt()}'),
                                // Text('Loan Amount',
                                //     style: AppStyles.subTextStyle.copyWith(
                                //         color: AppColors.grayColor3,
                                //         fontWeight: FontWeight.w500)),
                                SizedBox(
                                  height: displayHeight(context) * 0.01,
                                ),
                                SfLinearGauge(
                                  axisTrackStyle: const LinearAxisTrackStyle(
                                      edgeStyle: LinearEdgeStyle.bothCurve,
                                      color: AppColors.linearBarColor),
                                  minimum: 200,
                                  maximum: 100000,
                                  showTicks: true,
                                  showLabels: false,
                                  minorTicksPerInterval: 1,
                                  majorTickStyle:
                                      const LinearTickStyle(length: 7),
                                  minorTickStyle:
                                      const LinearTickStyle(length: 5),
                                  axisLabelStyle: const TextStyle(fontSize: 12),
                                  markerPointers: [
                                    // Widget for the draggable pointer
                                    LinearWidgetPointer(
                                        value: loanAmount,
                                        onChanged: (double value) {
                                          // Update the loan amount using Riverpod state
                                          ref
                                              .read(newLoanAmount.notifier)
                                              .updateLoanAmount(value);
                                        },
                                        child: const Icon(
                                          Icons.circle,
                                          color: AppColors.primary,
                                          size: 15,
                                        )),
                                  ],
                                  ranges: [
                                    LinearGaugeRange(
                                      edgeStyle: LinearEdgeStyle.bothCurve,
                                      position: LinearElementPosition.cross,
                                      startValue: 0,
                                      endValue: loanAmount,
                                      color: AppColors.primary,
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: displayHeight(context) * 0.03,
                                ),
                                amountTextShow(
                                    data: 'Interest Rate',
                                    price: '${interestRate.toInt()}%'),
                                SizedBox(
                                  height: displayHeight(context) * 0.01,
                                ),
                                SfLinearGauge(
                                  axisTrackStyle: const LinearAxisTrackStyle(
                                      color: AppColors.linearBarColor,
                                      edgeStyle: LinearEdgeStyle.bothCurve),
                                  minimum: 100,
                                  maximum:  1000,
                                  showTicks: true,
                                  showLabels: false,
                                  majorTickStyle:
                                      const LinearTickStyle(length: 7),
                                  minorTickStyle:
                                      const LinearTickStyle(length: 5),
                                  axisLabelStyle: const TextStyle(fontSize: 12),
                                  markerPointers: [
                                    // Widget for the draggable pointer
                                    LinearWidgetPointer(
                                        value: interestRate,
                                        onChanged: (double value) {
                                          // Update the loan amount using Riverpod state
                                          ref
                                              .read(newInterestRate.notifier)
                                              .updateInterestLone(value);
                                        },
                                        child: const Icon(
                                          Icons.circle,
                                          color: AppColors.primary,
                                          size: 15,
                                        )),
                                  ],
                                  ranges: [
                                    LinearGaugeRange(
                                      edgeStyle: LinearEdgeStyle.bothCurve,
                                      position: LinearElementPosition.cross,
                                      startValue: 0,
                                      endValue: interestRate,
                                      color: AppColors.primary,
                                    ),
                                  ],
                                ),

                                SizedBox(
                                  height: displayHeight(context) * 0.03,
                                ),
                                amountTextShow(
                                    data: 'Tenure', price: '${tenure.toInt()}'),
                                // Text('Tenure',
                                //     style: AppStyles.subTextStyle.copyWith(
                                //         color: AppColors.grayColor3,
                                //         fontWeight: FontWeight.w500)),
                                SizedBox(
                                  height: displayHeight(context) * 0.01,
                                ),
                                SfLinearGauge(
                                  showAxisTrack: true,
                                  axisTrackStyle: const LinearAxisTrackStyle(
                                      color: AppColors.linearBarColor,
                                      edgeStyle: LinearEdgeStyle.bothCurve),
                                  minimum: 0,
                                  maximum: 100,
                                  showTicks: true,
                                  showLabels: false,
                                  majorTickStyle: const LinearTickStyle(
                                      length: 7,
                                      color: AppColors.linearBarColor,
                                      thickness: 2),
                                  minorTickStyle: const LinearTickStyle(
                                      length: 5,
                                      color: AppColors.linearBarColor,
                                      thickness: 2),
                                  // axisLabelStyle: const TextStyle(fontSize: 12),
                                  markerPointers: [
                                    // Widget for the draggable pointer
                                    LinearWidgetPointer(
                                        value: tenure,
                                        onChanged: (double value) {
                                          ref
                                              .read(newTenureRate.notifier)
                                              .updateTenureRate(value);
                                        },
                                        child: const Icon(
                                          CupertinoIcons.circle_fill,
                                          color: AppColors.primary,
                                          size: 15,
                                        )),
                                  ],
                                  ranges: [
                                    LinearGaugeRange(
                                      edgeStyle: LinearEdgeStyle.bothCurve,
                                      startValue: 0,
                                      endValue: tenure,
                                      color: AppColors.primary,
                                      position: LinearElementPosition.cross,
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: displayHeight(context) * 0.01,
                                ),

                                SizedBox(
                                  height: displayHeight(context) * 0.04,
                                ),
                                AppButton(
                                  width: displayWidth(context),
                                  onTap: () {
                                    Navigator.pushNamed(
                                        context, AppRoutes.saleApplicationForm);
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

  Widget amountShow(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      height: displayHeight(context) * 0.20,
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
              text: '₹ 13,030.00 ',
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
            height: displayHeight(context) * 0.01,
          ),
          IntrinsicHeight(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                amount(context, title: 'Loan Amount', amount: '₹ 20,000.00'),
                VerticalDivider(
                  width: displayWidth(context) * 0.05,
                  color: AppColors.grayColor4,
                  thickness: 1,
                ),
                amount(context, title: 'Interest', amount: '₹ 45,000.00'),
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
