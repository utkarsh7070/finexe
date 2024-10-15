import 'package:dropdown_textfield/dropdown_textfield.dart';
import 'package:finexe/feature/base/utils/namespase/app_colors.dart';
import 'package:finexe/feature/base/utils/widget/app_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../../base/utils/namespase/app_style.dart';
import '../../../../../base/utils/namespase/display_size.dart';
import '../../../../../base/utils/widget/app_text_filed_login.dart';
import '../../view_model/visit_pending_view_model.dart';


class UpdateVisit extends ConsumerWidget {
  const UpdateVisit({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // final dropDownControllers = ref.watch(dropDownControllerProvider);
    final dropDownData = ref.read(updateVisitDropDown);

    final paymentState = ref.watch(paymentStatusViewModelProvider);
    final paymentViewModel = ref.read(paymentStatusViewModelProvider.notifier);
    final paymentFocusStates =
        ref.watch(paymentStatusFocusProviderFocusProvider);
    final paymentFocusViewModel =
        ref.read(paymentStatusFocusProviderFocusProvider.notifier);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Visit Form'),
      ),
      body: Container(
        padding: const EdgeInsets.all(16),
        height: displayHeight(context),
        width: displayWidth(context),
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: Column(
            children: [
              customerDetails(context),
              coApplicantDetails(context),
              gtrDetails(context),
              SizedBox(
                height: displayHeight(context) * 0.02,
              ),
              DropDownTextField(
                clearOption: false,
                controller: paymentViewModel.dropDownControllerProvider,
                listSpace: 20,
                listPadding: ListPadding(top: 20),
                enableSearch: false,
                dropDownList: dropDownData,
                listTextStyle: const TextStyle(color: AppColors.primary),
                dropDownItemCount: 4,
                onChanged: (val) {
                  // paymentViewModel.updatePaymentStatus(val);
                },
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
                visible:  paymentViewModel.dropDownControllerProvider.dropDownValue?.value ==
                    'CustomerWillPayEmi',
                child: AppFloatTextField(
                  focusNode: paymentFocusViewModel.paymentAmountFocusNode,
                  currentState: paymentFocusStates['paymentAmountFocusNode'],
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
                visible:  paymentViewModel.dropDownControllerProvider.dropDownValue?.value ==
                        'CustomerWillPayEmi' ||
                    paymentViewModel.dropDownControllerProvider.dropDownValue?.value ==
                        'CustomerWillNotPayEmi' ||
                    paymentViewModel.dropDownControllerProvider.dropDownValue?.value ==
                        'CustomerNotContactable',
                child: AppFloatTextField(
                  focusNode: paymentFocusViewModel.dateFocusNode,
                  currentState: paymentFocusStates['dateFocusNode'],
                  // controller: licenseController,
                  onChange: (value) {
                    paymentViewModel.updateDate(value);
                  },
                  height: !paymentState.isDateValid
                      ? displayHeight(context) * 0.09
                      : null,
                  inerHint: 'Date To Receive/Revisit Date',
                  errorText: "Date To Receive/Revisit Date is a required field",
                  isError: !paymentState.isDateValid,
                  textInputAction: TextInputAction.done,
                ),
              ),
              SizedBox(
                height: displayHeight(context) * 0.01,
              ),
              Visibility(
                visible:  paymentViewModel.dropDownControllerProvider.dropDownValue?.value ==
                        'CustomerWillNotPayEmi' ||
                    paymentViewModel.dropDownControllerProvider.dropDownValue?.value ==
                        'CustomerNotContactable',
                child: AppFloatTextField(
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
                  inerHint:  paymentViewModel.dropDownControllerProvider.dropDownValue?.value ==
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
                visible:  paymentViewModel.dropDownControllerProvider.dropDownValue?.value ==
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
              AppButton(
                textStyle: AppStyles.buttonLightTextStyle,
                width: displayWidth(context) ,
                onTap: () {},
                label: 'Take Photo Visit',
              ),
              AppButton(
                textStyle: AppStyles.buttonLightTextStyle,
                width: displayWidth(context),
                onTap: () {},
                label: 'Submit',
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget customerDetails(context) {
    return Card(
      elevation: 5,
      child: Container(
        padding: EdgeInsets.all(8),
        child: Column(
          children: [
            customerDetailsText(context,
                heading: 'Customer Name', data: 'Raamswaroop Nagar'),
            customerDetailsText(context,
                heading: 'Father Name', data: 'Jagnandan Nangar'),
            customerDetailsText(context, heading: 'LD', data: 'FINC1576'),
            customerDetailsText(context, heading: 'Net Due', data: '14,655'),
            customerDetailsText(context, heading: 'EMI Amount', data: '145634'),
            customerDetailsText(context,
                heading: 'Collection Type', data: 'BOUNCE EMI'),
            customerDetailsText(context, heading: 'Partner', data: 'UGRO'),
          ],
        ),
      ),
    );
  }

  Widget coApplicantDetails(context) {
    return Card(
      elevation: 5,
      child: Container(
        padding: EdgeInsets.all(8),
        child: Column(
          children: [
            customerDetailsText(context,
                heading: 'Co-Applicant Name',
                data: 'PRAKASH dsjhkcgdjhcvzxbczxvchXVCjzxCVZXBNVChxvhxcb'),
            customerDetailsText(context,
                heading: 'Co-Applicant Mobile', data: 'PRAKASH'),
            customerDetailsText(context,
                heading: 'Co-Applicant Address', data: 'PRAKASH'),
          ],
        ),
      ),
    );
  }

  Widget gtrDetails(context) {
    return Card(
      elevation: 5,
      child: Container(
        padding: EdgeInsets.all(8),
        child: Column(
          children: [
            customerDetailsText(context, heading: 'GTR Name', data: 'PRAKASH'),
            customerDetailsText(context,
                heading: 'GTR Father Name', data: 'PRAKASH'),
            customerDetailsText(context,
                heading: 'GTR Address', data: 'PRAKASH'),
            customerDetailsText(context,
                heading: 'GTR Mobile No', data: 'PRAKASH'),
          ],
        ),
      ),
    );
  }

  Widget customerDetailsText(context,
      {required String heading, required String data}) {
    return SizedBox(
      width: displayWidth(context),
      child: Column(
        children: [
          Row(
            children: [
              Text(
                '$heading:',
                style: AppStyles.subTextStyle,
              ),
              SizedBox(
                width: displayWidth(context) * 0.01,
              ),
              Flexible(
                child: Text(
                  data,
                  style: AppStyles.subTextStyle.copyWith(
                    overflow: TextOverflow.ellipsis,
                  ),
                  maxLines: 2,
                ),
              ),
            ],
          ),
          const Divider(
            thickness: 1,
            color: AppColors.boxBagGray,
          )
        ],
      ),
    );
  }
}
