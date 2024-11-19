import 'dart:developer';

import 'package:finexe/feature/base/utils/namespase/app_colors.dart';
import 'package:finexe/feature/base/utils/namespase/app_style.dart';
import 'package:finexe/feature/base/utils/namespase/display_size.dart';
import 'package:finexe/feature/base/utils/widget/app_text_filed_login.dart';
import 'package:finexe/feature/ui/PD/common_textfield.dart';
import 'package:finexe/feature/ui/PD/pd_fromfilds.dart/view_model.dart/co_applicant_viewmodel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TotalIncomeDetailsForm extends ConsumerStatefulWidget {
  const TotalIncomeDetailsForm({super.key});

  @override
  _TotalIncomeDetailsFormState createState() => _TotalIncomeDetailsFormState();
}

class _TotalIncomeDetailsFormState
    extends ConsumerState<TotalIncomeDetailsForm> {
  TextEditingController totalincomeForm_yearlyIncomeController =
      TextEditingController();
  TextEditingController totalincomeForm_monthlyIncomeController =
      TextEditingController();
  TextEditingController totalincomeForm_expensesYearlyController =
      TextEditingController();
  TextEditingController totalincomeForm_expensesMonthlyController =
      TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      childrenPadding: const EdgeInsets.only(left: 16, bottom: 10),
      shape: const Border(
        bottom: BorderSide(color: AppColors.dividerColor),
      ),
      title: const Text('Total Income'),
      children: <Widget>[
        Form(
            key: _formKey,
            child: Column(
              children: [
                constSizedbox(context),
                Padding(
                  padding: const EdgeInsets.only(right: 15),
                  child: CustomTextFormField(
                    textInputType: TextInputType.number,

                    // isError: coappvalidate,
                    inerHint: 'Yearly Income',
                    onValidate: (value) {
                      if (value!.trim().isEmpty) {
                        return "This is a required field";
                      }
                      return null;
                    },
                    controller: totalincomeForm_yearlyIncomeController,
                    textInputAction: TextInputAction.next,
                  ),
                ),
                constSizedbox(context),
                Padding(
                  padding: const EdgeInsets.only(right: 15),
                  child: CustomTextFormField(
                    textInputType: TextInputType.number,
                    inerHint: 'Monthly Income',
                    onValidate: (value) {
                      if (value!.trim().isEmpty) {
                        return "This is a required field";
                      }
                      return null;
                    },
                    controller: totalincomeForm_monthlyIncomeController,
                    textInputAction: TextInputAction.next,
                  ),
                ),
                constSizedbox(context),
                Padding(
                  padding: const EdgeInsets.only(right: 15),
                  child: LayoutBuilder(
                    builder: (context, constraints) {
                      return CustomTextFormField(
                        textInputType: TextInputType.number,
                        width: constraints.maxWidth,
                        inerHint: 'Expenses Yearly',
                        onValidate: (value) {
                          if (value!.trim().isEmpty) {
                            return "This is a required field";
                          }
                          return null;
                        },
                        controller: totalincomeForm_expensesYearlyController,
                        textInputAction: TextInputAction.next,
                      );
                    },
                  ),
                ),
                constSizedbox(context),
                Padding(
                  padding: const EdgeInsets.only(right: 15),
                  child: LayoutBuilder(
                    builder: (context, constraints) {
                      return CustomTextFormField(
                        textInputType: TextInputType.number,
                        width: constraints.maxWidth,
                        inerHint: 'Expenses Monthly',
                        onValidate: (value) {
                          if (value!.trim().isEmpty) {
                            return "This is a required field";
                          }
                          return null;
                        },
                        controller: totalincomeForm_expensesMonthlyController,
                        textInputAction: TextInputAction.next,
                      );
                    },
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
                    child: Text(
                      'Next',
                      style: AppStyles.whiteText16,
                    ))
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
