import 'package:finexe/feature/base/utils/namespase/app_colors.dart';
import 'package:finexe/feature/base/utils/namespase/app_style.dart';
import 'package:finexe/feature/base/utils/namespase/display_size.dart';
import 'package:finexe/feature/ui/PD/common_textfield.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class GauranterFormScreen extends StatefulWidget {
  const GauranterFormScreen({super.key});

  @override
  State<GauranterFormScreen> createState() => _GauranterFormScreenState();
}

class _GauranterFormScreenState extends State<GauranterFormScreen> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _gauranterform_coapplicantController =
      TextEditingController();
  TextEditingController _gauranterform_bussController = TextEditingController();
  TextEditingController _gauranterform_occupationController =
      TextEditingController();
  TextEditingController _gauranterform_nationController =
      TextEditingController();
  TextEditingController _gauranterform_religionController =
      TextEditingController();
  TextEditingController _gauranterform_casteController =
      TextEditingController();
  TextEditingController _gauranterform_categoryController =
      TextEditingController();

  TextEditingController _gauranterform_altermobileController =
      TextEditingController();
  TextEditingController _gauranterform_houselandmarkController =
      TextEditingController();
  TextEditingController _gauranterform_residancetypeController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    // final coappvalidate = ref.watch(coappvalidation);
    //final coappvalidate = ref.watch(coappvalidation);

    return ExpansionTile(
      childrenPadding: const EdgeInsets.only(left: 16, bottom: 10),
      shape: const Border(
        bottom: BorderSide(color: AppColors.dividerColor),
      ),
      title: const Text('Guarantor Detail’s'),
      children: <Widget>[
        Form(
            key: _formKey,
            child: Column(
              children: [
                Container(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Personal Information',
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
                    inerHint: 'Co - Applicant Type',
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
                    controller: _gauranterform_coapplicantController,
                    textInputAction: TextInputAction.next,
                  ),
                ),
                constSizedbox(context),
                Padding(
                  padding: const EdgeInsets.only(right: 15),
                  child: CustomTextFormField(
                    // width: displayWidth(context) * 0.8,
                    inerHint: 'Business Type',
                    onValidate: (value) {
                      print(value);
                      if (value!.trim().isEmpty) {
                        return "This is a required field";
                      }
                      return null;
                    },
                    controller: _gauranterform_bussController,
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
                Padding(
                  padding: const EdgeInsets.only(right: 15),
                  child: LayoutBuilder(
                    builder: (context, constraints) {
                      return CustomTextFormField(
                        width: constraints.maxWidth,
                        inerHint: 'Occupation',
                        onValidate: (value) {
                          print(value);
                          if (value!.trim().isEmpty) {
                            return "username is a required field";
                          }
                          return null;
                        },
                        controller: _gauranterform_occupationController,
                        textInputAction: TextInputAction.next,
                      );
                    },
                  ),
                ),
                constSizedbox(context),
                Row(
                  children: [
                    Expanded(
                      child: LayoutBuilder(
                        builder: (context, constraints) {
                          return Padding(
                            padding: const EdgeInsets.only(right: 15),
                            child: CustomTextFormField(
                              inerHint: 'Nationality',
                              width: constraints
                                  .maxWidth, // Explicitly set the width based on constraints
                              onValidate: (value) {
                                if (value!.trim().isEmpty) {
                                  return "Nationality is a required field";
                                }
                                return null;
                              },
                              controller: _gauranterform_nationController,
                              textInputAction: TextInputAction.next,
                            ),
                          );
                        },
                      ),
                    ),
                    SizedBox(width: 10), // Add spacing if needed
                    Expanded(
                      child: LayoutBuilder(
                        builder: (context, constraints) {
                          return Padding(
                            padding: const EdgeInsets.only(right: 15),
                            child: CustomTextFormField(
                              inerHint: 'Religion',
                              width: constraints.maxWidth,
                              onValidate: (value) {
                                if (value!.trim().isEmpty) {
                                  return "Religion is a required field";
                                }
                                return null;
                              },
                              controller: _gauranterform_religionController,
                              textInputAction: TextInputAction.next,
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
                constSizedbox(context),
                Row(
                  children: [
                    Expanded(
                      child: LayoutBuilder(
                        builder: (context, constraints) {
                          return Padding(
                            padding: const EdgeInsets.only(right: 15),
                            child: CustomTextFormField(
                              inerHint: 'Caste',
                              width: constraints
                                  .maxWidth, // Explicitly set the width based on constraints
                              onValidate: (value) {
                                if (value!.trim().isEmpty) {
                                  return "Nationality is a required field";
                                }
                                return null;
                              },
                              controller: _gauranterform_casteController,
                              textInputAction: TextInputAction.next,
                            ),
                          );
                        },
                      ),
                    ),
                    SizedBox(width: 10), // Add spacing if needed
                    Expanded(
                      child: LayoutBuilder(
                        builder: (context, constraints) {
                          return Padding(
                            padding: const EdgeInsets.only(right: 15),
                            child: CustomTextFormField(
                              inerHint: 'Category',
                              width: constraints.maxWidth,
                              onValidate: (value) {
                                if (value!.trim().isEmpty) {
                                  return "Category is a required field";
                                }
                                return null;
                              },
                              controller: _gauranterform_categoryController,
                              textInputAction: TextInputAction.next,
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
                constSizedbox(context),
                Container(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Contact Information',
                    textAlign: TextAlign.left,
                  ),
                ),
                constSizedbox(context),
                Padding(
                  padding: const EdgeInsets.only(right: 15),
                  child: CustomTextFormField(
                    textInputType: TextInputType.number,
                    // initialValue: 'dfgbfgbnx',
                    //  focusNode: focusViewModel.userFocusNode,
                    // currentState: focusStates['userFocusNode'],

                    inerHint: 'Alternate Mobile No',
                    //  height: coappvalidate ? displayHeight(context) * 0.09 : null,
                    // onFiledSubmitted: (value) {
                    //   ref
                    //       .read(coappvalidation.notifier)
                    //       .checkUsername(value.toString());
                    // },
                    onValidate: (value) {
                      print(value);
                      if (value!.trim().isEmpty) {
                        return "Please give alternative contact number";
                      }
                      return null;
                    },
                    //  errorText: "username is a required field",
                    // isError: coappvalidate,
                    controller: _gauranterform_altermobileController,
                    textInputAction: TextInputAction.next,
                  ),
                ),
                constSizedbox(context),
                Padding(
                  padding: const EdgeInsets.only(right: 15),
                  child: CustomTextFormField(
                    width: displayWidth(context) * 0.8,
                    inerHint: 'House Landmark',
                    onValidate: (value) {
                      print(value);
                      if (value!.trim().isEmpty) {
                        return "It is a required field";
                      }
                      return null;
                    },
                    controller: _gauranterform_houselandmarkController,
                    textInputAction: TextInputAction.next,
                  ),
                ),
                constSizedbox(context),
                Padding(
                  padding: const EdgeInsets.only(right: 15),
                  child: CustomTextFormField(
                    width: displayWidth(context) * 0.8,
                    inerHint: 'Residence Type',
                    onValidate: (value) {
                      print(value);
                      if (value!.trim().isEmpty) {
                        return "Please fill this field";
                      }
                      return null;
                    },
                    controller: _gauranterform_residancetypeController,
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
