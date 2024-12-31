import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:dropdown_textfield/dropdown_textfield.dart';
import 'package:finexe/feature/base/api/api.dart';
import 'package:finexe/feature/base/utils/namespase/app_colors.dart';
import 'package:finexe/feature/base/utils/namespase/app_style.dart';
import 'package:finexe/feature/base/utils/namespase/display_size.dart';
import 'package:finexe/feature/base/utils/widget/app_text_filed_login.dart';
import 'package:finexe/feature/base/utils/widget/custom_snackbar.dart';
import 'package:finexe/feature/base/utils/widget/upload_box.dart';
import 'package:finexe/feature/ui/PD/Common%20Widgets/common_textfield.dart';
import 'package:finexe/feature/ui/PD/Common%20Widgets/simple_dropdown.dart';
// import 'package:finexe/feature/ui/PD/view/PD%20Form/pd_fromfilds.dart/view_model.dart/applicant_view_model.dart';
// import 'package:finexe/feature/ui/PD/view/common%20imagePicker/image_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../common imagePicker/image_picker.dart';
import '../view_model.dart/applicant_view_model.dart';

class ApplicantForm extends ConsumerStatefulWidget {
  // const ApplicantForm({super.key});
  final String customerId;
  ApplicantForm({required this.customerId});

  @override
  _ApplicantFormState createState() => _ApplicantFormState();
}

class _ApplicantFormState extends ConsumerState<ApplicantForm> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  final _formKey = GlobalKey<FormState>();

  final TextEditingController applicantTypeController = TextEditingController();
  final TextEditingController businessTypeController = TextEditingController();
  final TextEditingController occupationController = TextEditingController();
  final TextEditingController nationalityController = TextEditingController();
  final TextEditingController religionController = TextEditingController();
  final TextEditingController casteController = TextEditingController();
  final TextEditingController categoryController = TextEditingController();
  final TextEditingController alternateMobileController =
      TextEditingController();
  final TextEditingController houseLandmarkController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController yearsAtCurrentAddressController =
      TextEditingController();
  final TextEditingController educationalDetailsController =
      TextEditingController();
  final TextEditingController dependentsController = TextEditingController();
  final TextEditingController residenceTypeController = TextEditingController();
  @override
  void dispose() {
    applicantTypeController.dispose();
    businessTypeController.dispose();
    occupationController.dispose();
    nationalityController.dispose();
    religionController.dispose();
    casteController.dispose();
    categoryController.dispose();
    alternateMobileController.dispose();
    houseLandmarkController.dispose();
    emailController.dispose();
    yearsAtCurrentAddressController.dispose();
    educationalDetailsController.dispose();
    dependentsController.dispose();
    residenceTypeController.dispose();
    super.dispose();
  }

  String applicantImageUrl = '';

  @override
  Widget build(BuildContext context) {
    final _isExpanded = ref.watch(isAppExpandedProvider);
    final applicantDetails = ref.watch(applicationDetailsProvider(widget.customerId));
    final appState = ref.watch(pdapplicantViewModelProvider);
    // final applicantImage = ref.watch(applicantImageProvider);

    return
         Form(
          key: _formKey,
          child: ExpansionTile(
            childrenPadding: const EdgeInsets.only(left: 16, bottom: 0,right: 15),
            shape: const Border(
              bottom: BorderSide(color: AppColors.dividerColor),
            ),
            title: const Text('Applicant Details'),
            onExpansionChanged: (expanded) {
              ref.read(isAppExpandedProvider.notifier).state = expanded;
              if (expanded) {
                // Trigger data fetch when the tile is expanded
                ref.refresh(applicationDetailsProvider(widget.customerId));
              }
            },
            initiallyExpanded: _isExpanded,
            children: <Widget>[
              applicantDetails.when(
                  data: (applicant) {


                    // print('applicantImageUrl ${Api.baseUrl}${applicant.applicant!}');
                    if (occupationController.text.isEmpty) {
                      occupationController.text = applicant.items?.applicant?.occupation ?? '';
                      applicantTypeController.text =
                          applicant.items?.applicant?.applicantType ?? '';
                      businessTypeController.text = applicant.items?.applicant?.businessType ?? '';
                      // occupationController.text = applicant.occupation ?? '';
                      nationalityController.text = applicant.items?.applicant?.nationality ?? '';
                      religionController.text = applicant.items?.applicant?.religion ?? '';
                      casteController.text = applicant.items?.applicant?.caste ?? '';
                      categoryController.text =applicant.items?.applicant?.category ?? '';
                      alternateMobileController.text =
                          applicant.items?.applicant?.alternateMobileNo ?? '';
                      houseLandmarkController.text =
                          applicant.items?.applicant?.houseLandMark ?? '';
                      emailController.text = applicant.items?.applicant?.email ?? '';
                      yearsAtCurrentAddressController.text =
                          applicant.items?.applicant?.noOfyearsAtCurrentAddress ?? '';
                      educationalDetailsController.text =
                          applicant.items?.applicant?.educationalDetails ?? '';
                      dependentsController.text =
                          applicant.items?.applicant?.noOfDependentWithCustomer ?? '';
                      residenceTypeController.text =
                          applicant.items?.applicant?.residenceType ?? '';
                    }
                    return Column(
                      children: [

                        Container(
                          alignment: Alignment.centerLeft,
                          child: const Text(
                            'Personal Information',
                            textAlign: TextAlign.left,
                          ),
                        ),

                        Text(
                          'Applicant Image',
                          // textAlign: TextAlign.left,
                        ),

                        CommonImagePicker(
                          applicantImage: applicant.items?.applicantImage ?? '',
                          onImageUploaded: (imageUrl) {
                            setState(() {
                              if(applicant.items !=null ){
                                applicant.items!.applicantImage!.isNotEmpty
                                    ? applicant.items?.applicantImage = imageUrl
                                    : // Update the image URL
                                applicantImageUrl = imageUrl;
                                print('applicantImageUrl:: $applicantImageUrl');
                              }

                            });
                          },
                        ),
                        constSizedbox(context),

                        CustomDropDownTextField(
                          labelText: 'Applicant Type',
                          controller: applicantTypeController,
                          items: [
                            DropDownValueModel(name: "Individual", value: "Individual"),
                            DropDownValueModel(
                                name: "Non Individual", value: "Non Individual"),
                          ],
                        ),
                        constSizedbox(context),

                        // Business Type

                        CustomDropDownTextField(
                          labelText: 'Business Type',
                          controller: businessTypeController,
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
                        constSizedbox(context),
                        // Occupation
                        CustomTextFormField(
                          // initialValue: applicant.occupation,
                          controller: occupationController,
                          width: displayWidth(context),
                          inerHint: 'Occupation',
                          onValidate: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Occupation is required';
                            }
                            return null;
                          },
                        ),
                        constSizedbox(context),

                        // Nationality and Religion in a row
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.only(right: 20),

                                child: CustomTextFormField(
                                  controller: nationalityController,
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
                                  controller: religionController,
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
                                  controller: casteController,
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
                                  controller: categoryController,
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

                        // Email
                        CustomTextFormField(
                          controller: emailController,
                          width: displayWidth(context),
                          inerHint: 'Email',
                          onValidate: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Email is required';
                            }
                            if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                              return 'Please enter a valid email address';
                            }
                            return null;
                          },
                        ),
                        constSizedbox(context),

                        // House Landmark
                        CustomTextFormField(
                          controller: houseLandmarkController,
                          width: displayWidth(context),
                          inerHint: 'House Landmark',
                          onValidate: (value) {
                            if (value == null || value.isEmpty) {
                              return 'House Landmark is required';
                            }
                            return null;
                          },
                        ),
                        constSizedbox(context),

                        // Alternate Mobile No
                        CustomTextFormField(
                           length: 10,
                          textInputType: TextInputType.number,
                          controller: alternateMobileController,
                          width: displayWidth(context),
                          inerHint: 'Alternate Mobile No',
                          onValidate: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Alternate Mobile No is required';
                            } else if(value.length<10){
                              return 'Mobile Number Must Be Exactly 10 Numeric Digits';
                            }
                            else if (!RegExp(r'^\+?[1-9]\d{1,14}$').hasMatch(value)) {
                              return 'Please enter a valid mobile number';
                            }
                            return null;
                          },
                        ),
                        constSizedbox(context),

                        Container(
                          alignment: Alignment.centerLeft,
                          child: const Text(
                            'Other’s Detail’s',
                            textAlign: TextAlign.left,
                          ),
                        ),
                        constSizedbox(context),

                        // Educational Details
                        CustomTextFormField(
                          controller: educationalDetailsController,
                          width: displayWidth(context),
                          inerHint: 'Educational Details',
                          onValidate: (value) {
                            if (value == null || value.isEmpty) {
                              return 'This field is required';
                            }
                            return null;
                          },
                        ),
                        constSizedbox(context),

                        // Years at Current Address
                        CustomTextFormField(
                          textInputType: TextInputType.numberWithOptions(),
                          controller: yearsAtCurrentAddressController,
                          width: displayWidth(context),
                          inerHint: 'Years at Current Address',
                          onValidate: (value) {
                            if (value == null || value.isEmpty) {
                              return 'This field is required';
                            }
                            return null;
                          },
                        ),
                        constSizedbox(context),

                        // No. of Dependents with Customer
                        CustomTextFormField(
                          textInputType: TextInputType.number,
                          controller: dependentsController,
                          width: displayWidth(context),
                          inerHint: 'No. of Dependents with Customer',
                          onValidate: (value) {
                            if (value == null || value.isEmpty) {
                              return 'This field is required';
                            }
                            return null;
                          },
                        ),
                        constSizedbox(context),

                        CustomDropDownTextField(
                          labelText: 'Residence Type',
                          controller: residenceTypeController,
                          items: [
                            DropDownValueModel(name: "Owned", value: "Owned"),
                            DropDownValueModel(name: "Rented", value: "Rented"),
                            DropDownValueModel(name: "Leased", value: "Leased"),
                          ],
                        ),
                        constSizedbox(context),
                        SizedBox(
                          width: displayWidth(context) * 0.4,
                          height: displayHeight(context) * 0.05,
                          child: ElevatedButton(
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                print(applicantTypeController.text);
                                print(businessTypeController.text);
                                print(residenceTypeController.text);

                                ref
                                    .read(pdapplicantViewModelProvider.notifier)
                                    .submitpdApplicantForm(
                                  context: context,
                                    applicantdImage: applicantImageUrl,
                                    customerId: widget.customerId,
                                    pdType: 'creditPd',
                                    alternateMobileNo: alternateMobileController.text,
                                    applicantType: applicantTypeController.text,
                                    businessType: businessTypeController.text,
                                    caste: casteController.text,
                                    category: categoryController.text,
                                    // dob: do,
                                    educationalDetails:
                                    educationalDetailsController.text,
                                    email: emailController.text,
                                    // gender:
                                    houseLandMark: houseLandmarkController.text,
                                    //maritalStatus:
                                    nationality: nationalityController.text,
                                    occupation: occupationController.text,
                                    religion: religionController.text,
                                    noOfyearsAtCurrentAddress:
                                    yearsAtCurrentAddressController.text,
                                    noOfDependentWithCustomer:
                                    dependentsController.text,
                                    residenceType: residenceTypeController.text)
                                    .then(
                                      (value) {
                                    if (value) {
                                      // ScaffoldMessenger.of(context).showSnackBar(
                                      //   SnackBar(
                                      //     backgroundColor: AppColors.green,
                                      //     content: Text(
                                      //       'Details Saved successfully!',
                                      //       style: AppStyles.whiteText16,
                                      //     ),
                                      //   ),
                                      // );
                                      showCustomSnackBar(
                                          context,'Details Saved successfully!', Colors.greenAccent);
                                    }
                                    // else {
                                    //   ScaffoldMessenger.of(context).showSnackBar(
                                    //     SnackBar(
                                    //       backgroundColor: AppColors.red,
                                    //       content: Text(
                                    //         'Network error form not saved.',
                                    //         style: AppStyles.whiteText16,
                                    //       ),
                                    //     ),
                                    //   );
                                    // }
                                  },
                                );
                              }
                              else {
                                // ScaffoldMessenger.of(context).showSnackBar(
                                //   SnackBar(
                                //     backgroundColor: AppColors.red,
                                //     content: Text(
                                //       'Please fill all required details!',
                                //       style: AppStyles.whiteText16,
                                //     ),
                                //   ),
                                // );
                                showCustomSnackBar(
                                    context,'Please fill all required details!', Colors.red);
                              }
                            },
                            child: appState.isLoading == true
                                ? const SizedBox(
                              width: 24, // Specify the width
                              height: 24, // Specify the height
                              child: CircularProgressIndicator(
                                color: AppColors.white,
                                strokeWidth: 3,
                                key: ValueKey(
                                    'loading'), // Key for progress indicator
                              ),
                            )
                                : Text(
                              'Save Form',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: displayHeight(context) * 0.01,
                        )
                      ],
                    );
                  },
                loading: () => const Center(child: CircularProgressIndicator()),
                error: (error, stackTrace) => Center(child: Text('Error: $error')),
              )

            ],
          ),
        );

  }

  Widget constSizedbox(BuildContext context) {
    return SizedBox(height: displayHeight(context) * 0.02);
  }
}
