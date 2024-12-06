import 'package:finexe/feature/base/utils/namespase/app_colors.dart';
import 'package:finexe/feature/base/utils/namespase/app_style.dart';
import 'package:finexe/feature/base/utils/namespase/display_size.dart';
import 'package:finexe/feature/ui/PD/Common%20Widgets/common_textfield.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PoliceStationForm extends ConsumerWidget {
  const PoliceStationForm({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // final coappvalidate = ref.watch(coappvalidation);
    //final coappvalidate = ref.watch(coappvalidation);
    final _formKey = GlobalKey<FormState>();
    TextEditingController policestationForm_nameController =
        TextEditingController();
    TextEditingController policestationForm_addressController =
        TextEditingController();
    return ExpansionTile(
      childrenPadding: const EdgeInsets.only(left: 16, bottom: 10),
      shape: const Border(
        bottom: BorderSide(color: AppColors.dividerColor),
      ),
      title: const Text('Police Station'),
      children: <Widget>[
        Form(
            key: _formKey,
            child: Column(
              children: [
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
                    inerHint: 'Station Name',
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
                    controller: policestationForm_nameController,
                    textInputAction: TextInputAction.next,
                  ),
                ),
                constSizedbox(context),
                Padding(
                  padding: const EdgeInsets.only(right: 15),
                  child: CustomTextFormField(
                    // width: displayWidth(context) * 0.8,
                    inerHint: 'Station Address',
                    onValidate: (value) {
                      print(value);
                      if (value!.trim().isEmpty) {
                        return "This is a required field";
                      }
                      return null;
                    },
                    controller: policestationForm_addressController,
                    textInputAction: TextInputAction.next,
                    //  inerHint: 'Occupation',
                    //     onValidate: (value) {
                    //       print(value);
                    //       if (value!.trim().isEmpty) {
                    //         return "username is a required field";
                    //       }
                    //       return '';
                    //     },
                    //     controller: coppApplicantForm2_occupationController,
                    //     textInputAction: TextInputAction.next,
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
