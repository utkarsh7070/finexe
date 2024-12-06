import 'package:dropdown_textfield/dropdown_textfield.dart';
import 'package:finexe/feature/base/utils/namespase/app_colors.dart';
import 'package:finexe/feature/base/utils/namespase/app_style.dart';
import 'package:finexe/feature/base/utils/namespase/display_size.dart';
import 'package:finexe/feature/base/utils/widget/app_text_filed_login.dart';
import 'package:finexe/feature/ui/PD/Common%20Widgets/common_textfield.dart';
import 'package:finexe/feature/ui/PD/Common%20Widgets/simple_dropdown.dart';
import 'package:finexe/feature/ui/PD/view/PD%20Form/pd_fromfilds.dart/model/Submit%20Data%20Models/coapplicant_model.dart';
import 'package:finexe/feature/ui/PD/view/PD%20Form/pd_fromfilds.dart/view_model.dart/applicant_view_model.dart';
import 'package:finexe/feature/ui/PD/view/PD%20Form/pd_fromfilds.dart/view_model.dart/co_applicant_viewmodel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CoApplicantForm extends ConsumerStatefulWidget {
  final CoApplicant? data;

  const CoApplicantForm({super.key, this.data});

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
  void dispose() {
    coaaplicantform1_applicantTypeController.dispose();
    coaaplicantform1_businessTypeController.dispose();
    coaaplicantform1_occupationController.dispose();
    coaaplicantform1_nationalityController.dispose();
    coaaplicantform1_religionController.dispose();
    coaaplicantform1_casteController.dispose();
    coaaplicantform1_categoryController.dispose();
    coaaplicantform1_alternateMobileController.dispose();
    coaaplicantform1_houseLandmarkController.dispose();
    coaaplicantform1_emailController.dispose();
    coaaplicantform1_educationalDetailsController.dispose();
    coaaplicantform1_dependentsController.dispose();
    coaaplicantform1_residenceTypeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final coapplicantDetails = ref.watch(coApplicantDetailsProvider(0));
    final coappState = ref.watch(pdCoapplicantViewModelProvider);
    return coapplicantDetails.when(
      data: (coapplicantData) {
        var coApplicantItems = coapplicantData.coApplicant![0];
        var coApplicantImages = coapplicantData.coApplicantImage![0];
        if (coaaplicantform1_occupationController.text.isEmpty) {
          coaaplicantform1_applicantTypeController.text =
              coApplicantItems.coApplicantType ?? '';
          coaaplicantform1_businessTypeController.text =
              coApplicantItems.businessType ?? '';
          coaaplicantform1_occupationController.text =
              coApplicantItems.occupation ?? '';
          coaaplicantform1_nationalityController.text =
              coApplicantItems.nationality ?? '';
          coaaplicantform1_religionController.text =
              coApplicantItems.religion ?? '';
          coaaplicantform1_casteController.text = coApplicantItems.caste ?? '';
          coaaplicantform1_categoryController.text =
              coApplicantItems.category ?? '';
          coaaplicantform1_alternateMobileController.text =
              coApplicantItems.alternateMobileNo ?? '';
          coaaplicantform1_houseLandmarkController.text =
              coApplicantItems.houseLandMark ?? '';
          coaaplicantform1_emailController.text =
              coApplicantItems.emailId ?? '';
          // coa.text =
          //     coApplicantItems.noOfyearsAtCurrentAddress ?? '';
          coaaplicantform1_educationalDetailsController.text =
              coApplicantItems.educationalDetails ?? '';
          // dependentsController.text = coApplicantItems.de ?? '';
          coaaplicantform1_residenceTypeController.text =
              coApplicantItems.residenceType ?? '';
        }

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
                child: CustomDropDownTextField(
                  labelText: 'Applicant Type',
                  controller: coaaplicantform1_applicantTypeController,
                  items: [
                    DropDownValueModel(name: "Individual", value: "Individual"),
                    DropDownValueModel(
                        name: "Non Individual", value: "Non Individual"),
                  ],
                ),
              ),
              constSizedbox(context),

              // Business Type

              Padding(
                padding: const EdgeInsets.only(right: 20),
                child: CustomDropDownTextField(
                  labelText: 'Business Type',
                  controller: coaaplicantform1_businessTypeController,
                  items: [
                    DropDownValueModel(
                        name: "Self Employed Proffessional",
                        value: "Self Employed Proffessional"),
                    DropDownValueModel(
                        name: "Self Emplyed Non Proffessional",
                        value: "Self Emplyed Non Proffessional"),
                    DropDownValueModel(
                        name: "Agriculture Business",
                        value: "Agriculture Business"),
                    DropDownValueModel(name: "House Wife", value: "House Wife"),
                    DropDownValueModel(name: "Retired", value: "Retired"),
                    DropDownValueModel(name: "Salaried", value: "Salaried"),
                    DropDownValueModel(name: "Other", value: "Other"),
                  ],
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
                child: CustomDropDownTextField(
                  labelText: 'Residence Type',
                  controller: coaaplicantform1_residenceTypeController,
                  items: [
                    DropDownValueModel(name: "Owned", value: "Owned"),
                    DropDownValueModel(name: "Rented", value: "Rented"),
                    DropDownValueModel(name: "Leased", value: "Leased"),
                  ],
                ),
              ),
              constSizedbox(context),

              ElevatedButton(
                onPressed: () {
                  // if (_formKey.currentState!.validate()) {
                  //   ScaffoldMessenger.of(context).showSnackBar(
                  //     SnackBar(
                  //       backgroundColor: AppColors.green,
                  //       content: Text(
                  //         'Form submitted successfully!',
                  //         style: AppStyles.whiteText16,
                  //       ),
                  //     ),
                  //   );
                  // } else {
                  //   ScaffoldMessenger.of(context).showSnackBar(
                  //     SnackBar(
                  //       backgroundColor: AppColors.red,
                  //       content: Text(
                  //         'Please fill all required details!',
                  //         style: AppStyles.whiteText16,
                  //       ),
                  //     ),
                  //   );
                  // }
                  ref
                      .read(pdCoapplicantViewModelProvider.notifier)
                      .submitpdCoApplicantForm(
                          customerId: '66f53ffbd7011eb65160f292',
                          pdType: 'creditPd',
                          alternateMobileNo:
                              coaaplicantform1_alternateMobileController.text,
                          coapplicantType:
                              coaaplicantform1_applicantTypeController.text,
                          businessType:
                              coaaplicantform1_businessTypeController.text,
                          caste: coaaplicantform1_casteController.text,
                          category: coaaplicantform1_categoryController.text,
                          // dob: do,
                          educationalDetails:
                              coaaplicantform1_educationalDetailsController
                                  .text,
                          email: coaaplicantform1_emailController.text,
                          // gender:
                          houseLandMark:
                              coaaplicantform1_houseLandmarkController.text,
                          //maritalStatus:
                          nationality:
                              coaaplicantform1_nationalityController.text,
                          occupation:
                              coaaplicantform1_occupationController.text,
                          religion: coaaplicantform1_religionController.text,
                          // noOfyearsAtCurrentAddress:
                          //     coa.text,
                          noOfDependentWithCustomer:
                              coaaplicantform1_dependentsController.text,
                          residenceType:
                              coaaplicantform1_residenceTypeController.text)
                      .then(
                    (value) {
                      if (value) {
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
                  );
                },
                child: coappState.isLoading == true
                    ? const SizedBox(
                        width: 24, // Specify the width
                        height: 24, // Specify the height
                        child: CircularProgressIndicator(
                          color: AppColors.white,
                          strokeWidth: 3,
                          key:
                              ValueKey('loading'), // Key for progress indicator
                        ),
                      )
                    : Text(
                        'Next',
                        style: TextStyle(color: Colors.white),
                      ),
              ),
            ],
          ),
        );
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, stackTrace) => Center(child: Text('Error: $error')),
    );
  }
}

Widget constSizedbox(BuildContext context) {
  return SizedBox(height: displayHeight(context) * 0.03);
}
