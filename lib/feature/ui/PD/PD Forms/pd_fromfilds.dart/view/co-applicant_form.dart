import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:dropdown_textfield/dropdown_textfield.dart';
import 'package:finexe/feature/base/api/api.dart';
import 'package:finexe/feature/base/utils/namespase/app_colors.dart';
import 'package:finexe/feature/base/utils/namespase/app_style.dart';
import 'package:finexe/feature/base/utils/namespase/display_size.dart';
import 'package:finexe/feature/base/utils/widget/app_text_filed_login.dart';
import 'package:finexe/feature/base/utils/widget/upload_box.dart';
import 'package:finexe/feature/ui/PD/Common%20Widgets/common_textfield.dart';
import 'package:finexe/feature/ui/PD/Common%20Widgets/simple_dropdown.dart';
// import 'package:finexe/feature/ui/PD/view/PD%20Form/pd_fromfilds.dart/model/Submit%20Data%20Models/coapplicant_model.dart';
// import 'package:finexe/feature/ui/PD/view/PD%20Form/pd_fromfilds.dart/view_model.dart/applicant_view_model.dart';
// import 'package:finexe/feature/ui/PD/view/PD%20Form/pd_fromfilds.dart/view_model.dart/co_applicant_viewmodel.dart';
// import 'package:finexe/feature/ui/PD/view/PD%20Form/pd_fromfilds.dart/view_model.dart/garaunter_view_model.dart';
// import 'package:finexe/feature/ui/PD/view/common%20imagePicker/image_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../common imagePicker/image_picker.dart';
import '../model/Submit Data Models/coapplicant_model.dart';
import '../view_model.dart/co_applicant_viewmodel.dart';
final isExpCoappProvider = StateProvider<bool>((ref) => false);

class CoApplicantForm extends ConsumerStatefulWidget {
  // final CoApplicant? data;

  // const CoApplicantForm({super.key,});
  final String customerId;
  CoApplicantForm({required this.customerId});

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
  //----------------------------form 02-----------------------------------------
  //  final TextEditingController coaaplicantform02_applicantTypeController =
  //     TextEditingController();
  // final TextEditingController coaaplicantform02_businessTypeController =
  //     TextEditingController();
  // final TextEditingController coaaplicantform02_occupationController =
  //     TextEditingController();
  // final TextEditingController coaaplicantform02_nationalityController =
  //     TextEditingController();
  // final TextEditingController coaaplicantform02_religionController =
  //     TextEditingController();
  // final TextEditingController coaaplicantform02_casteController =
  //     TextEditingController();
  // final TextEditingController coaaplicantform02_categoryController =
  //     TextEditingController();
  // final TextEditingController coaaplicantform02_alternateMobileController =
  //     TextEditingController();
  // final TextEditingController coaaplicantform02_houseLandmarkController =
  //     TextEditingController();
  // final TextEditingController coaaplicantform02_emailController =
  //     TextEditingController();
  // final TextEditingController coaaplicantform02_educationalDetailsController =
  //     TextEditingController();
  // final TextEditingController coaaplicantform02_dependentsController =
  //     TextEditingController();
  // final TextEditingController coaaplicantform02_residenceTypeController =
  //     TextEditingController();

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

  String coApplicantImageUrl = '';
  @override
  Widget build(BuildContext context) {

    print('customerId in coapp:: ${widget.customerId}');
    // final coapplicantDetails = ref.watch(coApplicantDetailsProvider(0));
    final coapplicantDetails = ref.watch(
      coApplicantDetailsProvider(widget.customerId),
    );
    final coappState = ref.watch(pdCoapplicantViewModelProvider);
    // final coapplicantFistImage = ref.watch(coapplicantImageFirst);

    return coapplicantDetails.when(
      data: (coapplicantData) {
        print('Data fetched: ${coapplicantData.toJson()}');
        CoApplicant  coApplicantItems = coapplicantData.coApplicant![0];
        // String coApplicantImages = coapplicantData.coApplicantImage![0];
        String? coApplicantImages = coapplicantData.coApplicantImage!.isNotEmpty
            ? coapplicantData.coApplicantImage![0]
            : null;
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
            // onExpansionChanged: (expanded) {
            //   ref.read(isAssetProvider.notifier).state = expanded;
            //   if (expanded) {
            //     // Trigger data fetch when the tile is expanded
            //     ref.refresh(getAssetDetailFromProvider(widget.customerId));
            //   }
            // },
            // initiallyExpanded: _isExpanded,
            childrenPadding: const EdgeInsets.only(left: 16, bottom: 0,right: 20),
            shape: const Border(
              bottom: BorderSide(color: AppColors.dividerColor),
            ),
            title: const Text('Co-Applicant Details'),
            children: <Widget>[
              // Container(
              //   alignment: Alignment.centerLeft,
              //   child: const Text(
              //     'Co-Applicant Details 01',
              //     textAlign: TextAlign.left,
              //   ),
              // ),
              // coapplicantDetails.when(
              //     data: ,
              //     error: error, loading: loading
              // )
              Container(
                alignment: Alignment.centerLeft,
                child: const Text(
                  'Personal Information',
                  textAlign: TextAlign.left,
                ),
              ),
              constSizedbox(context),

              Text(
                'CoApplicant Image',
                // textAlign: TextAlign.left,
              ),

              CommonImagePicker(
                applicantImage: coApplicantImages ?? '',
                onImageUploaded: (imageUrl) {
                  setState(() {
                    coApplicantImages!.isNotEmpty
                        ? coApplicantImages = imageUrl
                        : // Update the image URL
                        coApplicantImageUrl = imageUrl;
                    print('coApplicantImageUrl:: $coApplicantImageUrl');
                  });
                },
              ),
              constSizedbox(context),

              CustomDropDownTextField(
                labelText: 'Applicant Type',
                controller: coaaplicantform1_applicantTypeController,
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
              constSizedbox(context),

                CustomTextFormField(
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

              constSizedbox(context),

              // Nationality and Religion in a row
              Row(
                children: [
                  Expanded(
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
                  Expanded(
                    child:  CustomTextFormField(
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
                ],
              ),
              constSizedbox(context),

              // Caste and Category in a row
              Row(
                children: [
                  Expanded(
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
                  Expanded(
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
               CustomTextFormField(
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
              constSizedbox(context),

              // Alternate Mobile No
              CustomTextFormField(
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

              constSizedbox(context),

              // Residence Type
              CustomDropDownTextField(
                labelText: 'Residence Type',
                controller: coaaplicantform1_residenceTypeController,
                items: [
                  DropDownValueModel(name: "Owned", value: "Owned"),
                  DropDownValueModel(name: "Rented", value: "Rented"),
                  DropDownValueModel(name: "Leased", value: "Leased"),
                ],
              ),
              constSizedbox(context),

              ElevatedButton(
                onPressed: () {
                  final coapplicantFirstFormdata = CoApplicant(
                    coApplicantType:
                        coaaplicantform1_applicantTypeController.text,
                    businessType: coaaplicantform1_businessTypeController.text,
                    occupation: coaaplicantform1_occupationController.text,
                    // dOB: coaaplicantform02_dob,
                    // emailId: email,
                    houseLandMark:
                        coaaplicantform1_houseLandmarkController.text,
                    alternateMobileNo:
                        coaaplicantform1_alternateMobileController.text,
                    // noOfyearsAtCurrentAddress:  coaaplicantform02.text,
                    // gender:  coaaplicantform02_.text,
                    religion: coaaplicantform1_religionController.text,
                    nationality: coaaplicantform1_nationalityController.text,
                    category: coaaplicantform1_categoryController.text,
                    caste: coaaplicantform1_casteController.text,
                    // maritalStatus:  coaaplicantform02_m.text,
                    educationalDetails:
                        coaaplicantform1_educationalDetailsController.text,
                    residenceType:
                        coaaplicantform1_residenceTypeController.text,
                  );
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
                          customerId:  widget.customerId,
                          pdType: 'creditPd',
                          // coApplicant: coapplicantSecondFormdata,
                          coApplicatFirstData: coapplicantFirstFormdata,
                          coapplicantImages: [coApplicantImageUrl]).then(
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
                              'Faild to save the details please try again',
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
      // loading: () => const Center(child: CircularProgressIndicator()),
      loading: () {
        // print('Data fetched: ${coapplicantDetails.value!.coApplicant![0].coApplicantType}');

        return Center(child: CircularProgressIndicator());
      },
      // error: (error, stackTrace) => Center(child: Text('Error: $error')),
      error: (error, stackTrace) {
        print('Error: $error');
        return Center(child: Text('faild to get data please check network'));
      },
    );
  }
}

Widget constSizedbox(BuildContext context) {
  return SizedBox(height: displayHeight(context) * 0.03);
}
