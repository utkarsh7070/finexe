import 'package:finexe/feature/base/utils/namespase/app_colors.dart';
import 'package:finexe/feature/base/utils/namespase/app_style.dart';
import 'package:finexe/feature/base/utils/namespase/display_size.dart';
import 'package:finexe/feature/ui/PD/common_textfield.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BankDetailsForm extends StatefulWidget {
  const BankDetailsForm({super.key});

  @override
  State<BankDetailsForm> createState() => _BankDetailsFormState();
}

class _BankDetailsFormState extends State<BankDetailsForm> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController bankdetailsform_busstypeController =
      TextEditingController();
  TextEditingController bankdetailsform_banknameController =
      TextEditingController();
  TextEditingController bankdetailsform_branchController =
      TextEditingController();
  TextEditingController bankdetailsform_accountnumberController =
      TextEditingController();
  TextEditingController bankdetailsform_accountholdernameController =
      TextEditingController();
  TextEditingController bankdetailsform_accounttypeController =
      TextEditingController();
  TextEditingController bankdetailsform_ifscCodeController =
      TextEditingController();
  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      childrenPadding: const EdgeInsets.only(left: 16, bottom: 10),
      shape: const Border(
        bottom: BorderSide(color: AppColors.dividerColor),
      ),
      title: const Text('Bank Details'),
      children: <Widget>[
        Form(
            key: _formKey,
            child: Column(
              children: [
                Container(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Business and Banking Information',
                    textAlign: TextAlign.left,
                  ),
                ),
                constSizedbox(context),
                Padding(
                  padding: const EdgeInsets.only(right: 15),
                  child: CustomTextFormField(
                    // onChange: (value) {
                    //   log("coappvalidate " + coappvalidate.toString());
                    //   ref.read(coappvalidation.notifier).checkUsername(
                    //       coppApplicantForm2_coapplicantController);
                    // },
                    // initialValue: 'dfgbfgbnx',
                    //  focusNode: focusViewModel.userFocusNode,
                    // currentState: focusStates['userFocusNode'],
                    // isError: coappvalidate,
                    inerHint: 'Business Type',
                    //  height: coappvalidate ? displayHeight(context) * 0.09 : null,
                    // onFiledSubmitted: (value) {
                    //   ref
                    //       .read(coappvalidation.notifier)
                    //       .checkUsername(value.toString());
                    // },
                    onValidate: (value) {
                      print('Co - Applicant Type: ${value}');
                      if (value!.trim().isEmpty) {
                        return "This is a required field";
                      }
                      return null;
                    },
                    //  errorText: "username is a required field",
                    // isError: coappvalidate,
                    controller: bankdetailsform_busstypeController,
                    textInputAction: TextInputAction.next,
                  ),
                ),
                constSizedbox(context),
                Padding(
                  padding: const EdgeInsets.only(right: 15),
                  child: CustomTextFormField(
                    // width: displayWidth(context) * 0.8,
                    inerHint: 'Bank Name',
                    onValidate: (value) {
                      print(value);
                      if (value!.trim().isEmpty) {
                        return "This is a required field";
                      }
                      return null;
                    },
                    controller: bankdetailsform_banknameController,
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
                        inerHint: 'Branch',
                        onValidate: (value) {
                          print(value);
                          if (value!.trim().isEmpty) {
                            return "Enter your bank branch";
                          }
                          return null;
                        },
                        controller: bankdetailsform_branchController,
                        textInputAction: TextInputAction.next,
                      );
                    },
                  ),
                ),
                constSizedbox(context),
                Container(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Account Details',
                    textAlign: TextAlign.left,
                  ),
                ),
                constSizedbox(context),
                Padding(
                  padding: const EdgeInsets.only(right: 15),
                  child: CustomTextFormField(
                    // initialValue: 'dfgbfgbnx',
                    //  focusNode: focusViewModel.userFocusNode,
                    // currentState: focusStates['userFocusNode'],
                    textInputType: TextInputType.number,
                    inerHint: 'Account No',
                    //  height: coappvalidate ? displayHeight(context) * 0.09 : null,
                    // onFiledSubmitted: (value) {
                    //   ref
                    //       .read(coappvalidation.notifier)
                    //       .checkUsername(value.toString());
                    // },
                    onValidate: (value) {
                      print(value);
                      if (value!.trim().isEmpty) {
                        return "Please enter your account number";
                      }
                      return null;
                    },
                    //  errorText: "username is a required field",
                    // isError: coappvalidate,
                    controller: bankdetailsform_accountnumberController,
                    textInputAction: TextInputAction.next,
                  ),
                ),
                constSizedbox(context),
                Padding(
                  padding: const EdgeInsets.only(right: 15),
                  child: CustomTextFormField(
                    width: displayWidth(context) * 0.8,
                    inerHint: 'Account Holder Name',
                    onValidate: (value) {
                      print(value);
                      if (value!.trim().isEmpty) {
                        return "It is a required field";
                      }
                      return null;
                    },
                    controller: bankdetailsform_accountholdernameController,
                    textInputAction: TextInputAction.next,
                  ),
                ),
                constSizedbox(context),
                Padding(
                  padding: const EdgeInsets.only(right: 15),
                  child: CustomTextFormField(
                    width: displayWidth(context) * 0.8,
                    inerHint: 'Account Type',
                    onValidate: (value) {
                      print(value);
                      if (value!.trim().isEmpty) {
                        return "Please Enter account type";
                      }
                      return null;
                    },
                    controller: bankdetailsform_accounttypeController,
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
                                'Please fill all requred details!',
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
