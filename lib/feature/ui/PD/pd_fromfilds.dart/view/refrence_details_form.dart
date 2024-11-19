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

class RefrenceDetailsForm extends ConsumerStatefulWidget {
  const RefrenceDetailsForm({super.key});

  @override
  _RefrenceDetailsFormState createState() => _RefrenceDetailsFormState();
}

class _RefrenceDetailsFormState extends ConsumerState<RefrenceDetailsForm> {
  TextEditingController refrenceDetailsForm_refrenceController =
      TextEditingController();
  TextEditingController refrenceDetailsForm_addressController =
      TextEditingController();
  TextEditingController refrenceDetailsForm_relationController =
      TextEditingController();
  TextEditingController refrenceDetailsForm_mobileNumberController =
      TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      childrenPadding: const EdgeInsets.only(left: 16, bottom: 10),
      shape: const Border(
        bottom: BorderSide(color: AppColors.dividerColor),
      ),
      title: const Text('Reference Detail'),
      children: <Widget>[
        Form(
            key: _formKey,
            child: Column(
              children: [
                constSizedbox(context),
                Padding(
                  padding: const EdgeInsets.only(right: 15),
                  child: CustomTextFormField(
                    inerHint: 'Refrence Name',
                    onValidate: (value) {
                      if (value!.trim().isEmpty) {
                        return "This is a required field";
                      }
                      return null;
                    },
                    controller: refrenceDetailsForm_refrenceController,
                    textInputAction: TextInputAction.next,
                  ),
                ),
                constSizedbox(context),
                Padding(
                  padding: const EdgeInsets.only(right: 15),
                  child: CustomTextFormField(
                    inerHint: 'Address',
                    onValidate: (value) {
                      if (value!.trim().isEmpty) {
                        return "This is a required field";
                      }
                      return null;
                    },
                    controller: refrenceDetailsForm_addressController,
                    textInputAction: TextInputAction.next,
                  ),
                ),
                constSizedbox(context),
                Padding(
                  padding: const EdgeInsets.only(right: 15),
                  child: LayoutBuilder(
                    builder: (context, constraints) {
                      return CustomTextFormField(
                        width: constraints.maxWidth,
                        inerHint: 'Relation',
                        onValidate: (value) {
                          if (value!.trim().isEmpty) {
                            return "This is a required field";
                          }
                          return null;
                        },
                        controller: refrenceDetailsForm_relationController,
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
                        inerHint: 'Mobile Number',
                        onValidate: (value) {
                          if (value!.trim().isEmpty) {
                            return "This is a required field";
                          }
                          return null;
                        },
                        controller: refrenceDetailsForm_mobileNumberController,
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
