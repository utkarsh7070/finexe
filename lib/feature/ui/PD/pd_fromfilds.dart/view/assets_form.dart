import 'package:finexe/feature/base/utils/namespase/app_colors.dart';
import 'package:finexe/feature/base/utils/namespase/app_style.dart';
import 'package:finexe/feature/base/utils/namespase/display_size.dart';
import 'package:finexe/feature/ui/PD/common_textfield.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PdAssetsForm extends StatefulWidget {
  const PdAssetsForm({super.key});

  @override
  State<PdAssetsForm> createState() => _PdAssetsFormState();
}

class _PdAssetsFormState extends State<PdAssetsForm> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController pdassetform_nameController = TextEditingController();
  TextEditingController pdassetform_purchaseController =
      TextEditingController();
  TextEditingController pdassetform_marketvalueController =
      TextEditingController();

  // Initial set of controllers for the first member
  final List<Map<String, TextEditingController>> memberControllers = [
    // {
    //   'name': TextEditingController(),
    //   'purchase': TextEditingController(),
    //   'marketValue': TextEditingController(),
    // }
  ];

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      title: const Text('Assets Detail’s'),
      children: [
        Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.only(left: 15),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 15),
                  child: CustomTextFormField(
                    inerHint: 'Name',
                    onValidate: (value) {
                      if (value!.trim().isEmpty) {
                        return "This field is required";
                      }
                      return null;
                    },
                    controller: pdassetform_nameController,
                    textInputAction: TextInputAction.next,
                  ),
                ),
                constSizedbox(context),
                Padding(
                  padding: const EdgeInsets.only(right: 15),
                  child: CustomTextFormField(
                    textInputType: TextInputType.number,
                    width: displayWidth(context) * 0.8,
                    inerHint: 'Purchase values',
                    onValidate: (value) {
                      if (value!.trim().isEmpty) {
                        return "Enter purchase value";
                      }
                      return null;
                    },
                    controller: pdassetform_purchaseController,
                    textInputAction: TextInputAction.next,
                  ),
                ),
                constSizedbox(context),
                Padding(
                  padding: const EdgeInsets.only(right: 15),
                  child: CustomTextFormField(
                    textInputType: TextInputType.number,
                    width: displayWidth(context) * 0.8,
                    inerHint: 'Market values',
                    onValidate: (value) {
                      if (value!.trim().isEmpty) {
                        return "Please enter market value";
                      }
                      return null;
                    },
                    controller: pdassetform_marketvalueController,
                    textInputAction: TextInputAction.next,
                  ),
                ),
                constSizedbox(context),
                // Loop through each member's controllers to generate form fields
                for (int i = 0; i < memberControllers.length; i++) ...[
                  constSizedbox(context),
                  Padding(
                    padding: const EdgeInsets.only(right: 15),
                    child: CustomTextFormField(
                      textInputType: TextInputType.text,
                      inerHint: 'Name',
                      onValidate: (value) {
                        if (value!.trim().isEmpty) {
                          return "This field is required";
                        }
                        return null;
                      },
                      controller: memberControllers[i]['name'],
                      textInputAction: TextInputAction.next,
                    ),
                  ),
                  constSizedbox(context),
                  Padding(
                    padding: const EdgeInsets.only(right: 15),
                    child: CustomTextFormField(
                      textInputType: TextInputType.number,
                      width: displayWidth(context) * 0.8,
                      inerHint: 'Purchase values',
                      onValidate: (value) {
                        if (value!.trim().isEmpty) {
                          return "Enter purchase value";
                        }
                        return null;
                      },
                      controller: memberControllers[i]['purchase'],
                      textInputAction: TextInputAction.next,
                    ),
                  ),
                  constSizedbox(context),
                  Padding(
                    padding: const EdgeInsets.only(right: 15),
                    child: CustomTextFormField(
                      textInputType: TextInputType.number,
                      width: displayWidth(context) * 0.8,
                      inerHint: 'Market values',
                      onValidate: (value) {
                        if (value!.trim().isEmpty) {
                          return "Please enter market value";
                        }
                        return null;
                      },
                      controller: memberControllers[i]['marketValue'],
                      textInputAction: TextInputAction.next,
                    ),
                  ),
                  constSizedbox(context),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      IconButton(
                        onPressed: () {
                          setState(() {
                            memberControllers.removeAt(i);
                          });
                        },
                        icon: Icon(Icons.remove_circle_outline,
                            color: Colors.red),
                      ),
                    ],
                  ),
                ],
                Container(
                  alignment: Alignment.centerLeft,
                  child: ElevatedButton(
                    onPressed: () {
                      setState(() {
                        // Add a new set of controllers for the new member
                        memberControllers.add({
                          'name': TextEditingController(),
                          'purchase': TextEditingController(),
                          'marketValue': TextEditingController(),
                        });
                      });
                    },
                    child: const Text(
                      'Add Member',
                      style: TextStyle(color: Colors.white),
                    ),
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
                  child: const Text(
                    'Next',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget constSizedbox(BuildContext context) {
    return SizedBox(
      height: displayHeight(context) * 0.02,
    );
  }

  @override
  void dispose() {
    // Dispose of each controller when the widget is removed
    for (var member in memberControllers) {
      member['name']?.dispose();
      member['purchase']?.dispose();
      member['marketValue']?.dispose();
    }
    super.dispose();
  }
}
