import 'dart:developer';

import 'package:dropdown_textfield/dropdown_textfield.dart';
import 'package:finexe/feature/base/utils/namespase/app_colors.dart';
import 'package:finexe/feature/base/utils/namespase/app_style.dart';
import 'package:finexe/feature/base/utils/namespase/display_size.dart';
import 'package:finexe/feature/base/utils/widget/app_text_filed_login.dart';
import 'package:finexe/feature/ui/PD/common_textfield.dart';
import 'package:finexe/feature/ui/PD/pd_fromfilds.dart/Common%20Dropdown/common_dropdown.dart';
import 'package:finexe/feature/ui/PD/pd_fromfilds.dart/view_model.dart/co_applicant_viewmodel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class IncomeDetailsForm extends ConsumerStatefulWidget {
  const IncomeDetailsForm({super.key});

  @override
  _IncomeDetailsFormState createState() => _IncomeDetailsFormState();
}

class _IncomeDetailsFormState extends ConsumerState<IncomeDetailsForm> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController incomeDetails_bussinessNatureController =
      TextEditingController();
  TextEditingController incomeDetails_monthlyIncomeController =
      TextEditingController();
  TextEditingController incomeDetails_yearlyIncomeController =
      TextEditingController();
  TextEditingController incomeDetails_bussnessSinceController =
      TextEditingController();
  TextEditingController incomeDetails_bussinessDescripController =
      TextEditingController();
  // List to hold multiple income details sets
  List<Map<String, TextEditingController>> incomeDetailsControllers = [
    // _createIncomeDetailsControllers(),
  ];

  static Map<String, TextEditingController> _createIncomeDetailsControllers() {
    return {
      'businessNature': TextEditingController(),
      'monthlyIncome': TextEditingController(),
      'yearlyIncome': TextEditingController(),
      'businessSince': TextEditingController(),
      'businessDescription': TextEditingController(),
    };
  }

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      childrenPadding: const EdgeInsets.only(left: 16, bottom: 10),
      shape: const Border(
        bottom: BorderSide(color: AppColors.dividerColor),
      ),
      title: const Text('Income Details Form'),
      children: <Widget>[
        Form(
          key: _formKey,
          child: Column(
            children: [
              constSizedbox(context),
              Padding(
                padding: const EdgeInsets.only(right: 18),
                child: CustomDropDownTextField(
                  labelText: 'Income Source Type',
                  items: [
                    DropDownValueModel(name: 'Option 1', value: '1'),
                    DropDownValueModel(name: 'Option 2', value: '2'),
                    DropDownValueModel(name: 'Option 3', value: '3'),
                    DropDownValueModel(name: 'Option 4', value: '4'),
                  ],
                ),
              ),
              constSizedbox(context),
              Padding(
                padding: const EdgeInsets.only(right: 15),
                child: CustomTextFormField(
                  inerHint: 'Business Nature',
                  onValidate: (value) {
                    if (value!.trim().isEmpty) {
                      return "This is a required field";
                    }
                    return null;
                  },
                  controller: incomeDetails_bussinessNatureController,
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
                  controller: incomeDetails_monthlyIncomeController,
                  textInputAction: TextInputAction.next,
                ),
              ),
              constSizedbox(context),
              Padding(
                padding: const EdgeInsets.only(right: 15),
                child: CustomTextFormField(
                  textInputType: TextInputType.number,
                  inerHint: 'Yearly Income',
                  onValidate: (value) {
                    if (value!.trim().isEmpty) {
                      return "This is a required field";
                    }
                    return null;
                  },
                  controller: incomeDetails_yearlyIncomeController,
                  textInputAction: TextInputAction.next,
                ),
              ),
              constSizedbox(context),
              Padding(
                padding: const EdgeInsets.only(right: 15),
                child: CustomTextFormField(
                  textInputType: TextInputType.number,
                  inerHint: 'Business Since Yrs',
                  onValidate: (value) {
                    if (value!.trim().isEmpty) {
                      return "This is a required field";
                    }
                    return null;
                  },
                  controller: incomeDetails_bussnessSinceController,
                  textInputAction: TextInputAction.next,
                ),
              ),
              constSizedbox(context),
              Padding(
                padding: const EdgeInsets.only(right: 15),
                child: CustomTextFormField(
                  inerHint: 'Business Description',
                  onValidate: (value) {
                    if (value!.trim().isEmpty) {
                      return "This is a required field";
                    }
                    return null;
                  },
                  controller: incomeDetails_bussinessDescripController,
                  textInputAction: TextInputAction.next,
                ),
              ),
              for (int i = 0; i < incomeDetailsControllers.length; i++) ...[
                constSizedbox(context),
                _buildIncomeFields(i, incomeDetailsControllers[i], context),
                constSizedbox(context),
              ],
              Container(
                alignment: Alignment.centerRight,
                padding: EdgeInsets.only(right: 15),
                child: ElevatedButton(
                  onPressed: () {
                    setState(() {
                      // Add new set of controllers for additional income details
                      incomeDetailsControllers
                          .add(_createIncomeDetailsControllers());
                    });
                  },
                  child: Text(
                    'Add Income',
                    style: AppStyles.whiteText16,
                  ),
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        backgroundColor: AppColors.green,
                        content: Text(
                          'Form submitted successfully!',
                          style: AppStyles.whiteText16,
                        ),
                      ),
                    );
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        backgroundColor: AppColors.red,
                        content: Text(
                          'Please fill all required details!',
                          style: AppStyles.whiteText16,
                        ),
                      ),
                    );
                  }
                },
                child: Text(
                  'Next',
                  style: AppStyles.whiteText16,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  // Method to build income fields for each income details entry
  Widget _buildIncomeFields(int index,
      Map<String, TextEditingController> controllers, BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Income Source ${incomeDetailsControllers.length.toString()}'),
            IconButton(
                onPressed: () {
                  setState(() {
                    incomeDetailsControllers.removeAt(index);
                  });
                },
                icon: Icon(Icons.delete_outline))
          ],
        ),
        // constSizedbox(context),
        Padding(
          padding: const EdgeInsets.only(right: 18),
          child: CustomDropDownTextField(
            labelText: 'Income Source Type',
            items: [
              DropDownValueModel(name: 'Option 1', value: '1'),
              DropDownValueModel(name: 'Option 2', value: '2'),
              DropDownValueModel(name: 'Option 3', value: '3'),
              DropDownValueModel(name: 'Option 4', value: '4'),
            ],
          ),
        ),
        constSizedbox(context),
        Padding(
          padding: const EdgeInsets.only(right: 15),
          child: CustomTextFormField(
            inerHint: 'Business Nature',
            onValidate: (value) {
              if (value!.trim().isEmpty) {
                return "This is a required field";
              }
              return null;
            },
            controller: controllers['businessNature'],
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
            controller: controllers['monthlyIncome'],
            textInputAction: TextInputAction.next,
          ),
        ),
        constSizedbox(context),
        Padding(
          padding: const EdgeInsets.only(right: 15),
          child: CustomTextFormField(
            textInputType: TextInputType.number,
            inerHint: 'Yearly Income',
            onValidate: (value) {
              if (value!.trim().isEmpty) {
                return "This is a required field";
              }
              return null;
            },
            controller: controllers['yearlyIncome'],
            textInputAction: TextInputAction.next,
          ),
        ),
        constSizedbox(context),
        Padding(
          padding: const EdgeInsets.only(right: 15),
          child: CustomTextFormField(
            textInputType: TextInputType.number,
            inerHint: 'Business Since Yrs',
            onValidate: (value) {
              if (value!.trim().isEmpty) {
                return "This is a required field";
              }
              return null;
            },
            controller: controllers['businessSince'],
            textInputAction: TextInputAction.next,
          ),
        ),
        // constSizedbox(context),
        // Padding(
        //   padding: const EdgeInsets.only(right: 15),
        //   child: CustomTextFormField(
        //     inerHint: 'Business Description',
        //     onValidate: (value) {
        //       if (value!.trim().isEmpty) {
        //         return "This is a required field";
        //       }
        //       return null;
        //     },
        //     controller: controllers['businessDescription'],
        //     textInputAction: TextInputAction.next,
        //   ),
        // ),
      ],
    );
  }

  // Spacing widget
  Widget constSizedbox(BuildContext context) {
    return SizedBox(
      height: displayHeight(context) * 0.02,
    );
  }
}
