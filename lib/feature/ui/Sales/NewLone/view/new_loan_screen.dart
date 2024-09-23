import 'package:dropdown_textfield/dropdown_textfield.dart';
import 'package:finexe/feature/base/utils/namespase/display_size.dart';
import 'package:finexe/feature/base/utils/namespase/font_size.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';
import '../../../../base/utils/namespase/app_colors.dart';
import '../../../../base/utils/namespase/app_style.dart';
import '../view_model/new_loan_view_model.dart';

class NewLoanScreen extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final phoneState = ref.watch(personalDetailViewModelProvider);
    final phoneViewModel = ref.read(personalDetailViewModelProvider.notifier);
    final personalFocusStates = ref.watch(newLoanFocusProvider);
    final phoneFocusViewModel = ref.read(newLoanFocusProvider.notifier);
    return Scaffold(
      appBar: AppBar(
        title: const Text('New Loan'),
      ),
      body: SafeArea(
          child: Column(
        children: [
          // AppFloatTextField(),
          DropDownTextField(
            // controller: _kycDocumentController,
            // initialValue: "name4",
            listSpace: 20,
            listPadding: ListPadding(top: 20),
            enableSearch: false,
            dropDownList: const [
              DropDownValueModel(name: 'MICRO LAP', value: "microLap"),
              DropDownValueModel(name: 'LAp', value: "lap"),
              DropDownValueModel(name: 'LAp1', value: "lap1"),
              DropDownValueModel(name: 'LAp2', value: "lap2"),
              DropDownValueModel(name: 'Local stage', value: "localStage"),
              DropDownValueModel(name: 'Test', value: "test"),
              DropDownValueModel(
                  name: 'FIN PRODUCT 1RS', value: "finProduct1Rs"),
              DropDownValueModel(name: 'FIN PRODUCT', value: "finProduct"),
              DropDownValueModel(name: 'Test 3', value: "test3"),
              DropDownValueModel(name: 'FIN CAR', value: "finCar"),
              DropDownValueModel(
                  name: 'New Producet Added ', value: "newProducetAdded"),
              DropDownValueModel(name: 'LAp4', value: "Lap4"),
              DropDownValueModel(name: 'testBT', value: "testBt"),
              DropDownValueModel(
                  name: 'NEW PRODUCT FIN COOPERS 28',
                  value: "newProductFinCoopers28"),
              DropDownValueModel(
                  name: 'Product Name FIN', value: "productNameFin"),
              DropDownValueModel(name: '3rd product', value: "3rdProduct"),
              DropDownValueModel(
                  name: 'Secured LAP MICRO', value: "securedLapMicro"),
            ],
            listTextStyle: const TextStyle(color: AppColors.primery),
            dropDownItemCount: 3,
            onChanged: (val) {
              phoneViewModel.updatePhoneNumber(val);
            },
            textFieldFocusNode: phoneFocusViewModel.kycDocFocusNode,
            textFieldDecoration: InputDecoration(
              hintStyle: const TextStyle(color: AppColors.textGray),
              floatingLabelStyle: personalFocusStates['kycDocFocusNode']!
                  ? AppStyles.subHeading.copyWith(color: AppColors.primery)
                  : AppStyles.subHeading,
              label: const Text(
                'Kyc Document',
                // style: const TextStyle(color: AppColors.textGray),
              ),

              // errorText: isError! ? errorText : null,
              enabledBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: AppColors.gray, width: 2),
                  borderRadius: BorderRadius.all(Radius.circular(10))),
              // filled: true,
              // fillColor: AppColors.gray,
              border: const OutlineInputBorder(
                borderSide: BorderSide(color: AppColors.gray, width: 2),
                borderRadius: BorderRadius.all(Radius.circular(10)),
              ),

              focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                      color: !phoneState.isPhoneNumberValid
                          ? Colors.red
                          : Colors.blue,
                      width: 2),
                  borderRadius: const BorderRadius.all(Radius.circular(10))),
              // ),
              // focusedErrorBorder: isError!
              //     ? const OutlineInputBorder(
              //     borderRadius: BorderRadius.all(Radius.circular(10)),
              //     borderSide: BorderSide(color: Colors.red, width: 2))
              //     : null       borderRadius: const BorderRadius.all(Radius.circular(10)),
            ),
          ),
          SizedBox(
            height: displayHeight(context) * 0.04,
          ),
          Container(
            decoration: BoxDecoration(
                border: Border.all(color: AppColors.boxBorderGray),
                borderRadius: const BorderRadius.all(Radius.circular(10))),
            padding: const EdgeInsets.all(16),
            height: displayHeight(context) * 0.60,
            child: Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                      border: Border.all(color: AppColors.boxBorderGray),
                      borderRadius:
                          const BorderRadius.all(Radius.circular(10))),
                  child: Card(
                    elevation: 0,
                    child: Column(
                      children: [
                        RichText(
                          text: TextSpan(
                            text: '₹ 13,030.00 ',
                            style: AppStyles.headingTextStyle2,
                            children: <TextSpan>[
                              TextSpan(
                                  text: '/Monthly EmI',
                                  style: AppStyles.cardTextStyle16
                                      .copyWith(color: AppColors.grayColor3)),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: displayHeight(context) * 0.01,
                        ),
                        const Divider(
                          color: AppColors.grayColor4,
                          thickness: 2,
                        ),
                        IntrinsicHeight(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              amount(
                                  title: 'Loan Amount', amount: '₹ 20,000.00'),
                              VerticalDivider(
                                width: displayWidth(context) * 0.05,
                                color: AppColors.grayColor4,
                                thickness: 2,
                              ),
                              amount(title: 'Interest', amount: '₹ 45,000.00'),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: displayHeight(context) * 0.02,
                ),
                SfLinearGauge(
                    minimum: 0.0,
                    maximum: 100.0,
                    orientation: LinearGaugeOrientation.horizontal,
                    majorTickStyle: const LinearTickStyle(length: 20),
                    axisLabelStyle:
                        const TextStyle(fontSize: 12.0, color: Colors.black),
                    axisTrackStyle: const LinearAxisTrackStyle(
                        color: Colors.cyan,
                        edgeStyle: LinearEdgeStyle.bothFlat,
                        thickness: 15.0,
                        borderColor: Colors.grey)),
              ],
            ),
          ),
        ],
      )),
    );
  }

  Widget amount({required String amount, required String title}) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            const Icon(
              Icons.circle,
              color: AppColors.primery,
              size: 16,
            ),
            Text(title,
                style: AppStyles.cardTextStyle16.copyWith(
                    color: AppColors.grayColor3,
                    fontSize: FontSize.fontSize16)),
          ],
        ),
        Text(
          amount,
          style: AppStyles.termsConditionText.copyWith(fontSize: 19),
        )
      ],
    );
  }
}
