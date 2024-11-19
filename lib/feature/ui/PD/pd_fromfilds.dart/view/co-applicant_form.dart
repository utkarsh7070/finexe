import 'package:finexe/feature/base/utils/namespase/app_colors.dart';
import 'package:finexe/feature/base/utils/namespase/app_style.dart';
import 'package:finexe/feature/base/utils/namespase/display_size.dart';
import 'package:finexe/feature/base/utils/widget/app_text_filed_login.dart';
import 'package:finexe/feature/ui/PD/common_textfield.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CoApplicantForm extends ConsumerStatefulWidget {
  const CoApplicantForm({super.key});

  @override
  _CoApplicantFormState createState() => _CoApplicantFormState();
}

class _CoApplicantFormState extends ConsumerState<CoApplicantForm> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController coaaplicantform1_applicantTypeController =
      TextEditingController();
  final TextEditingController coaaplicantform1_businessTypeController =
      TextEditingController();
  final TextEditingController coaaplicantform1_occupationController =
      TextEditingController();
  final TextEditingController coaaplicantform1_nationalityController =
      TextEditingController();
  final TextEditingController coaaplicantform1_religionController =
      TextEditingController();
  final TextEditingController coaaplicantform1_casteController =
      TextEditingController();
  final TextEditingController coaaplicantform1_categoryController =
      TextEditingController();
  final TextEditingController coaaplicantform1_alternateMobileController =
      TextEditingController();
  final TextEditingController coaaplicantform1_houseLandmarkController =
      TextEditingController();
  final TextEditingController coaaplicantform1_emailController =
      TextEditingController();
  final TextEditingController coaaplicantform1_educationalDetailsController =
      TextEditingController();
  final TextEditingController coaaplicantform1_dependentsController =
      TextEditingController();
  final TextEditingController coaaplicantform1_residenceTypeController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: ExpansionTile(
        childrenPadding: const EdgeInsets.only(left: 16, bottom: 0),
        shape: const Border(
          bottom: BorderSide(color: AppColors.dividerColor),
        ),
        title: const Text('Co-Applicant Details'),
        children: <Widget>[
          Container(
            alignment: Alignment.centerLeft,
            child: const Text(
              'Personal Information',
              textAlign: TextAlign.left,
            ),
          ),
          constSizedbox(context),

          // Applicant Type
          Padding(
            padding: const EdgeInsets.only(right: 20),
            child: CustomTextFormField(
              controller: coaaplicantform1_applicantTypeController,
              width: displayWidth(context),
              inerHint: 'Applicant Type',
              onValidate: (value) {
                if (value == null || value.isEmpty) {
                  return 'Applicant Type is required';
                }
                return null;
              },
            ),
          ),
          constSizedbox(context),

          // Business Type
          Padding(
            padding: const EdgeInsets.only(right: 20),
            child: CustomTextFormField(
              controller: coaaplicantform1_businessTypeController,
              width: displayWidth(context),
              inerHint: 'Business Type',
              onValidate: (value) {
                if (value == null || value.isEmpty) {
                  return 'Business Type is required';
                }
                return null;
              },
            ),
          ),
          constSizedbox(context),

          // Occupation
          Padding(
            padding: const EdgeInsets.only(right: 20),
            child: CustomTextFormField(
              controller: coaaplicantform1_occupationController,
              width: displayWidth(context),
              inerHint: 'Occupation',
              onValidate: (value) {
                if (value == null || value.isEmpty) {
                  return 'Occupation is required';
                }
                return null;
              },
            ),
          ),
          constSizedbox(context),

          // Nationality and Religion in a row
          Row(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(right: 20),
                  child: CustomTextFormField(
                    controller: coaaplicantform1_nationalityController,
                    inerHint: 'Nationality',
                    onValidate: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Nationality is required';
                      }
                      return null;
                    },
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(right: 20),
                  child: CustomTextFormField(
                    controller: coaaplicantform1_religionController,
                    inerHint: 'Religion',
                    onValidate: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Religion is required';
                      }
                      return null;
                    },
                  ),
                ),
              ),
            ],
          ),
          constSizedbox(context),

          // Caste and Category in a row
          Row(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(right: 20),
                  child: CustomTextFormField(
                    controller: coaaplicantform1_casteController,
                    width: displayWidth(context) * 0.4,
                    inerHint: 'Caste',
                    onValidate: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Caste is required';
                      }
                      return null;
                    },
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(right: 20),
                  child: CustomTextFormField(
                    controller: coaaplicantform1_categoryController,
                    width: displayWidth(context) * 0.4,
                    inerHint: 'Category',
                    onValidate: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Category is required';
                      }
                      return null;
                    },
                  ),
                ),
              ),
            ],
          ),
          constSizedbox(context),

          Container(
            alignment: Alignment.centerLeft,
            child: const Text(
              'Contact Information',
              textAlign: TextAlign.left,
            ),
          ),
          constSizedbox(context),

          // House Landmark
          Padding(
            padding: const EdgeInsets.only(right: 20),
            child: CustomTextFormField(
              controller: coaaplicantform1_houseLandmarkController,
              width: displayWidth(context),
              inerHint: 'House Landmark',
              onValidate: (value) {
                if (value == null || value.isEmpty) {
                  return 'House Landmark is required';
                }
                return null;
              },
            ),
          ),
          constSizedbox(context),

          // Alternate Mobile No
          Padding(
            padding: const EdgeInsets.only(right: 20),
            child: CustomTextFormField(
              textInputType: TextInputType.number,
              controller: coaaplicantform1_alternateMobileController,
              width: displayWidth(context),
              inerHint: 'Alternate Mobile No',
              onValidate: (value) {
                if (value == null || value.isEmpty) {
                  return 'Alternate Mobile No is required';
                }
                if (!RegExp(r'^\+?[1-9]\d{1,14}$').hasMatch(value)) {
                  return 'Please enter a valid mobile number';
                }
                return null;
              },
            ),
          ),

          constSizedbox(context),

          // Residence Type
          Padding(
            padding: const EdgeInsets.only(right: 20),
            child: CustomTextFormField(
              controller: coaaplicantform1_residenceTypeController,
              width: displayWidth(context),
              inerHint: 'Residence Type',
              onValidate: (value) {
                if (value == null || value.isEmpty) {
                  return 'This field is required';
                }
                return null;
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
    );
  }
}

Widget constSizedbox(BuildContext context) {
  return SizedBox(height: displayHeight(context) * 0.03);
}
