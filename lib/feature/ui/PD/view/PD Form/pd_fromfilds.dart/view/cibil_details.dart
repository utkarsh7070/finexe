import 'package:finexe/feature/base/utils/namespase/app_colors.dart';
import 'package:finexe/feature/base/utils/namespase/app_style.dart';
import 'package:finexe/feature/base/utils/namespase/display_size.dart';
import 'package:finexe/feature/ui/PD/Common%20Widgets/common_textfield.dart';
import 'package:flutter/Material.dart';
import 'package:flutter/cupertino.dart';

class CibilDetailsForm extends StatefulWidget {
  const CibilDetailsForm({super.key});

  @override
  State<CibilDetailsForm> createState() => _CibilDetailsFormState();
}

class _CibilDetailsFormState extends State<CibilDetailsForm> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController cibildetailform_numberofLoanController =
      TextEditingController();
  TextEditingController cibildetailform_currentLoanController =
      TextEditingController();
  TextEditingController cibildetailform_resonforDPDController =
      TextEditingController();
  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      title: Text('Cibil Detail’s'),
      children: [
        Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.only(left: 15),
              child: Column(
                children: [
                  constSizedbox(context),
                  Padding(
                    padding: const EdgeInsets.only(right: 15),
                    child: CustomTextFormField(
                      textInputType: TextInputType.number,
                      // initialValue: 'dfgbfgbnx',
                      //  focusNode: focusViewModel.userFocusNode,
                      // currentState: focusStates['userFocusNode'],

                      inerHint: 'No. of total loan',
                      //  height: coappvalidate ? displayHeight(context) * 0.09 : null,
                      // onFiledSubmitted: (value) {
                      //   ref
                      //       .read(coappvalidation.notifier)
                      //       .checkUsername(value.toString());
                      // },
                      onValidate: (value) {
                        print(value);
                        if (value!.trim().isEmpty) {
                          return "Please enter No. of total loan";
                        }
                        return null;
                      },
                      //  errorText: "username is a required field",
                      // isError: coappvalidate,
                      controller: cibildetailform_numberofLoanController,
                      textInputAction: TextInputAction.next,
                    ),
                  ),
                  constSizedbox(context),
                  Padding(
                    padding: const EdgeInsets.only(right: 15),
                    child: CustomTextFormField(
                      width: displayWidth(context) * 0.8,
                      inerHint: 'Current loan detail’s',
                      onValidate: (value) {
                        print(value);
                        if (value!.trim().isEmpty) {
                          return "It is a required field";
                        }
                        return null;
                      },
                      controller: cibildetailform_currentLoanController,
                      textInputAction: TextInputAction.next,
                    ),
                  ),
                  constSizedbox(context),
                  Padding(
                    padding: const EdgeInsets.only(right: 15),
                    child: CustomTextFormField(
                      width: displayWidth(context) * 0.8,
                      inerHint: 'Reason for DPD',
                      onValidate: (value) {
                        print(value);
                        if (value!.trim().isEmpty) {
                          return "Please Enter reason for DPD";
                        }
                        return null;
                      },
                      controller: cibildetailform_resonforDPDController,
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
              ),
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
