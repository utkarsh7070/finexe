import 'dart:developer';

import 'package:finexe/feature/base/utils/namespase/app_colors.dart';
import 'package:finexe/feature/base/utils/namespase/app_style.dart';
import 'package:finexe/feature/base/utils/namespase/display_size.dart';
import 'package:finexe/feature/base/utils/widget/app_text_filed_login.dart';
import 'package:finexe/feature/ui/PD/Common%20Widgets/common_textfield.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LoanDetailsForm extends ConsumerStatefulWidget {
  const LoanDetailsForm({super.key});

  @override
  _LoanDetailsFormState createState() => _LoanDetailsFormState();
}

class _LoanDetailsFormState extends ConsumerState<LoanDetailsForm> {
  TextEditingController LoanDetailsForm_customerDetailsController =
      TextEditingController();
  TextEditingController LoanDetailsForm_emiController = TextEditingController();
  TextEditingController LoanDetailsForm_approveAmountController =
      TextEditingController();
  TextEditingController LoanDetailsForm_nationController =
      TextEditingController();
  TextEditingController LoanDetailsForm_religionController =
      TextEditingController();
  TextEditingController LoanDetailsForm_finaldecisionController =
      TextEditingController();
  TextEditingController LoanDetailsForm_endUseofloanController =
      TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      childrenPadding: const EdgeInsets.only(left: 16, bottom: 10),
      shape: const Border(
        bottom: BorderSide(color: AppColors.dividerColor),
      ),
      title: const Text('Loan Details Form'),
      children: <Widget>[
        Form(
            key: _formKey,
            child: Column(
              children: [
                Container(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Location Details',
                    textAlign: TextAlign.left,
                  ),
                ),
                constSizedbox(context),
                Padding(
                  padding: const EdgeInsets.only(right: 15),
                  child: CustomTextFormField(
                    textInputType: TextInputType.number,
                    inerHint: 'Customer Demand Loan Amount',
                    onValidate: (value) {
                      if (value!.trim().isEmpty) {
                        return "This is a required field";
                      }
                      return null;
                    },
                    controller: LoanDetailsForm_customerDetailsController,
                    textInputAction: TextInputAction.next,
                  ),
                ),
                constSizedbox(context),
                Padding(
                  padding: const EdgeInsets.only(right: 15),
                  child: CustomTextFormField(
                    textInputType: TextInputType.number,
                    inerHint: 'Approved Amount',
                    onValidate: (value) {
                      print(value);
                      if (value!.trim().isEmpty) {
                        return "This is a required field";
                      }
                      return null;
                    },
                    controller: LoanDetailsForm_approveAmountController,
                    textInputAction: TextInputAction.next,
                  ),
                ),
                constSizedbox(context),
                Padding(
                  padding: const EdgeInsets.only(right: 15),
                  child: CustomTextFormField(
                    textInputType: TextInputType.number,
                    inerHint: 'EMI',
                    onValidate: (value) {
                      print(value);
                      if (value!.trim().isEmpty) {
                        return "This is a required field";
                      }
                      return null;
                    },
                    controller: LoanDetailsForm_emiController,
                    textInputAction: TextInputAction.next,
                  ),
                ),
                constSizedbox(context),
                Container(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Location Details',
                    textAlign: TextAlign.left,
                  ),
                ),
                constSizedbox(context),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      // padding: const EdgeInsets.only(right: 15),
                      child: Padding(
                        padding: const EdgeInsets.only(right: 15),
                        child: CustomTextFormField(
                          width: displayWidth(context) * 0.4,
                          textInputType: TextInputType.number,
                          inerHint: 'ROI (%)',
                          onValidate: (value) {
                            print(value);
                            if (value!.trim().isEmpty) {
                              return "This is a required field";
                            }
                            return null;
                          },
                          controller: LoanDetailsForm_emiController,
                          textInputAction: TextInputAction.next,
                        ),
                      ),
                    ),
                    SizedBox(width: displayWidth(context) * 0.05),
                    Expanded(
                      // padding: const EdgeInsets.only(right: 15),
                      child: Padding(
                        padding: const EdgeInsets.only(right: 15),
                        child: CustomTextFormField(
                          textInputType: TextInputType.number,
                          inerHint: 'Tenure',
                          onValidate: (value) {
                            print(value);
                            if (value!.trim().isEmpty) {
                              return "This is a required field sajfoierfnsdionf";
                            }
                            return null;
                          },
                          controller: LoanDetailsForm_emiController,
                          textInputAction: TextInputAction.next,
                        ),
                      ),
                    ),
                  ],
                ),
                constSizedbox(context),
                Container(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Decision & Purpose',
                    textAlign: TextAlign.left,
                  ),
                ),
                constSizedbox(context),
                Padding(
                  padding: const EdgeInsets.only(right: 15),
                  child: CustomTextFormField(
                    textInputType: TextInputType.text,
                    inerHint: 'Final Decision',
                    onValidate: (value) {
                      if (value!.trim().isEmpty) {
                        return "This is a required field";
                      }
                      return null;
                    },
                    controller: LoanDetailsForm_finaldecisionController,
                    textInputAction: TextInputAction.next,
                  ),
                ),
                constSizedbox(context),
                Padding(
                  padding: const EdgeInsets.only(right: 15),
                  child: CustomTextFormField(
                    textInputType: TextInputType.text,
                    inerHint: 'End use of loan',
                    onValidate: (value) {
                      print(value);
                      if (value!.trim().isEmpty) {
                        return "This is a required field";
                      }
                      return null;
                    },
                    controller: LoanDetailsForm_endUseofloanController,
                    textInputAction: TextInputAction.next,
                  ),
                ),
                constSizedbox(context),
                ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                              backgroundColor: AppColors.green,
                              content: Text(
                                'Form submitted successfully!',
                                style: AppStyles.whiteText16,
                              )),
                        );
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                              backgroundColor: AppColors.red,
                              content: Text(
                                'Please fill all required details!',
                                style: AppStyles.whiteText16,
                              )),
                        );
                      }
                    },
                    child: Text('Next'))
              ],
            ))
      ],
    );
  }

  constSizedbox(BuildContext context) {
    return SizedBox(
      height: displayHeight(context) * 0.02,
    );
  }
}
