import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../base/utils/namespase/app_colors.dart';
import '../../../../../base/utils/namespase/app_style.dart';
import '../../../../../base/utils/namespase/display_size.dart';
import '../../../../../base/utils/namespase/font_size.dart';
import '../../../../../base/utils/widget/app_button.dart';
import '../../../../../base/utils/widget/app_text_filed_login.dart';
import '../../../Collection cases/view_model/visit_pending_view_model.dart';


class ClosuerDialogContent extends ConsumerWidget {
  const ClosuerDialogContent({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // final dropDownControllers = ref.watch(dropDownControllerProvider);
    // final dropDownData = ref.read(updateVisitDropDown);
    final paymentState = ref.watch(closuerViewModelProvider);
    final paymentViewModel = ref.read(closuerViewModelProvider.notifier);
    final paymentFocusStates =
    ref.watch(closuerFocusProvider);
    final paymentFocusViewModel =
    ref.read(closuerFocusProvider.notifier);
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
                      SizedBox(height: displayHeight(context)*0.02,width: displayWidth(context)*0.10,),
                      SizedBox(
                          child: Align(
                              alignment: Alignment.center,
                              child: Text(
                                'Closure Form',
                                style: AppStyles.cardTextStyle16,
                              ))),
                      IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                          }, icon: const Icon(Icons.cancel_sharp))
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
                      text1: 'Customer Name', text2: 'Lakhan S/O  Ramprasad'),
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
              padding: const EdgeInsets.only(left: 16.0, right: 16, bottom: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  AppFloatTextField(
                    focusNode: paymentFocusViewModel.amountClosuerFocusNode,
                    currentState:
                    paymentFocusStates['amountClosuerFocusNode'],
                    // controller: licenseController,
                    onChange: (value) {
                      paymentViewModel.updateAmount(value);
                    },
                    height: !paymentState.isAmount
                        ? displayHeight(context) * 0.09
                        : null,
                    inerHint: 'Payment Amount',
                    errorText: "Payment Amount is a required field",
                    isError: !paymentState.isAmount,
                    textInputAction: TextInputAction.done,
                  ),
                  SizedBox(
                    height: displayHeight(context) * 0.01,
                  ),
                  AppFloatTextField(
                    focusNode: paymentFocusViewModel.dateClosuerFocusNode,
                    currentState: paymentFocusStates['dateClosuerFocusNode'],
                    // controller: licenseController,
                    onChange: (value) {
                      paymentViewModel.updateDate(value);
                    },
                    height: !paymentState.isDate
                        ? displayHeight(context) * 0.09
                        : null,
                    inerHint: 'Date To Receive/Revisit Date',
                    errorText:
                    "Date To Receive/Revisit Date is a required field",
                    isError: !paymentState.isDate,
                    textInputAction: TextInputAction.done,
                  ),
                  SizedBox(
                    height: displayHeight(context) * 0.01,
                  ),
                  AppFloatTextField(
                    maxLine: 5,
                    focusNode: paymentFocusViewModel.reasonClosuerFocusNode,
                    currentState: paymentFocusStates['reasonClosuerFocusNode'],
                    // controller: licenseController,
                    onChange: (value) {
                      paymentViewModel.updateReason(value);
                    },
                    height: !paymentState.isReason
                        ? displayHeight(context) * 0.16
                        : displayHeight(context) * 0.13,
                    inerHint: 'Settlement For Reason*',
                    errorText: "Reason is a required field",
                    isError: !paymentState.isReason,
                    textInputAction: TextInputAction.done,
                  ),
                  SizedBox(
                    height: displayHeight(context) * 0.01,
                  ),
                  AppButton(
                    textStyle: AppStyles.buttonLightTextStyle,
                    width: displayWidth(context),
                    onTap: () {},
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
