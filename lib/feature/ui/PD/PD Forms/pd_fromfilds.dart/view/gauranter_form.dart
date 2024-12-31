import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:dropdown_textfield/dropdown_textfield.dart';
import 'package:finexe/feature/base/api/api.dart';
import 'package:finexe/feature/base/utils/namespase/app_colors.dart';
import 'package:finexe/feature/base/utils/namespase/app_style.dart';
import 'package:finexe/feature/base/utils/namespase/display_size.dart';
import 'package:finexe/feature/base/utils/widget/upload_box.dart';
import 'package:finexe/feature/ui/PD/Common%20Widgets/common_textfield.dart';
import 'package:finexe/feature/ui/PD/Common%20Widgets/simple_dropdown.dart';
// import 'package:finexe/feature/ui/PD/view/PD%20Form/pd_fromfilds.dart/view_model.dart/garaunter_view_model.dart';
// import 'package:finexe/feature/ui/PD/view/common%20imagePicker/image_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../base/utils/widget/custom_snackbar.dart';
import '../../../common imagePicker/image_picker.dart';
import '../view_model.dart/garaunter_view_model.dart';
final isExpGaurantProvider = StateProvider<bool>((ref) => false);

class GauranterFormScreen extends ConsumerStatefulWidget {
  // const GauranterFormScreen({super.key});
  final String customerId;
  GauranterFormScreen({required this.customerId});
  @override
  ConsumerState<GauranterFormScreen> createState() =>
      _GauranterFormScreenState();
}

class _GauranterFormScreenState extends ConsumerState<GauranterFormScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _gauranterform_gauranterTypeController =
      TextEditingController();
  final TextEditingController _gauranterform_bussController =
      TextEditingController();
  final TextEditingController _gauranterform_occupationController =
      TextEditingController();
  final TextEditingController _gauranterform_nationController =
      TextEditingController();
  final TextEditingController _gauranterform_religionController =
      TextEditingController();
  final TextEditingController _gauranterform_casteController =
      TextEditingController();
  final TextEditingController _gauranterform_categoryController =
      TextEditingController();
  final TextEditingController _gauranterform_yearsAtcurrentAddress =
      TextEditingController();
  final TextEditingController _gauranterform_altermobileController =
      TextEditingController();
  final TextEditingController _gauranterform_houselandmarkController =
      TextEditingController();
  final TextEditingController _gauranterform_residancetypeController =
      TextEditingController();
  final TextEditingController _gauranterform_emailController =
      TextEditingController();
  final TextEditingController _gauranterform_educationController =
      TextEditingController();

  @override
  void dispose() {
    // Dispose all controllers
    _gauranterform_gauranterTypeController.dispose();
    _gauranterform_bussController.dispose();
    _gauranterform_occupationController.dispose();
    _gauranterform_nationController.dispose();
    _gauranterform_religionController.dispose();
    _gauranterform_casteController.dispose();
    _gauranterform_categoryController.dispose();
    _gauranterform_yearsAtcurrentAddress.dispose();
    _gauranterform_altermobileController.dispose();
    _gauranterform_houselandmarkController.dispose();
    _gauranterform_residancetypeController.dispose();
    _gauranterform_emailController.dispose();
    _gauranterform_educationController.dispose();

    super.dispose();
  }

  String gauranterUrl = '';

  @override
  Widget build(BuildContext context) {
    final gauranterDeatils = ref.watch(gauranterrDetailsProvider(widget.customerId));
    // final gauranteraImage = ref.watch(gaurnterImageProvider);
    final appState = ref.watch(pdsubmitgauranterProvider);

    final _isExpanded = ref.watch(isExpGaurantProvider);
    return ExpansionTile(
          childrenPadding: const EdgeInsets.only(left: 16, bottom: 0,right: 15),
          shape: const Border(
            bottom: BorderSide(color: AppColors.dividerColor),
          ),
          title: const Text('Gaurantor Details'),
          onExpansionChanged: (expanded) {
            ref.read(isExpGaurantProvider.notifier).state = expanded;
            if (expanded) {
              // Trigger data fetch when the tile is expanded
              ref.refresh(gauranterrDetailsProvider(widget.customerId));
            }
          },
          initiallyExpanded: _isExpanded,
          children: <Widget>[
            gauranterDeatils.when(
                data: (gauranterItems) {
                  if (_gauranterform_occupationController.text.isEmpty) {
                    _gauranterform_occupationController.text =
                        gauranterItems?.items?.guarantor?.occupation ?? '';
                    _gauranterform_gauranterTypeController.text =
                        gauranterItems?.items?.guarantor?.guarantorType ?? '';
                    _gauranterform_bussController.text =
                        gauranterItems?.items?.guarantor?.businessType ?? '';
                    // occupationController.text = applicant.occupation ?? '';
                    _gauranterform_nationController.text =
                        gauranterItems?.items?.guarantor?.nationality ?? '';
                    _gauranterform_religionController.text =
                        gauranterItems?.items?.guarantor?.religion ?? '';
                    _gauranterform_casteController.text =
                        gauranterItems?.items?.guarantor?.caste ?? '';
                    _gauranterform_categoryController.text =
                        gauranterItems?.items?.guarantor?.category ?? '';
                    _gauranterform_altermobileController.text =
                        gauranterItems?.items?.guarantor?.alternateMobileNo ?? '';
                    _gauranterform_houselandmarkController.text =
                        gauranterItems?.items?.guarantor?.houseLandMark ?? '';
                    _gauranterform_emailController.text =
                        gauranterItems?.items?.guarantor?.emailId ?? '';
                    _gauranterform_yearsAtcurrentAddress.text =
                        gauranterItems?.items?.guarantor?.noOfyearsAtCurrentAddress ?? '';
                    _gauranterform_educationController.text =
                        gauranterItems?.items?.guarantor?.educationalDetails ?? '';
                    // _gauranterform_casteController.text = gauranter.noOfDependentWithCustomer ?? '';
                    _gauranterform_residancetypeController.text =
                        gauranterItems?.items?.guarantor?.residenceType ?? '';
                  }
                  return Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          Container(
                            alignment: Alignment.centerLeft,
                            child: const Text(
                              'Personal Information',
                              textAlign: TextAlign.left,
                            ),
                          ),

                          constSizedbox(context),
                          Text(
                            'Guaranter Image',
                            // textAlign: TextAlign.left,
                          ),

                          CommonImagePicker(
                            applicantImage: gauranterItems?.items?.guarantorImage ?? '',
                            onImageUploaded: (imageUrl) {
                              setState(() {
                                if( gauranterItems?.items?.guarantorImage != null){
                                  gauranterItems!.items!.guarantorImage!.isNotEmpty
                                      ? gauranterItems.items!.guarantorImage = imageUrl
                                      : // Update the image URL
                                  gauranterUrl = imageUrl;
                                  print('gauranterUrl:: $gauranterUrl');
                                }

                              });
                            },
                          ),
                          constSizedbox(context),
                          Padding(
                            padding: const EdgeInsets.only(right: 20),
                            child: CustomDropDownTextField(
                              labelText: 'Gaurantor Type',
                              controller: _gauranterform_gauranterTypeController,
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
                              controller: _gauranterform_bussController,
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
                              // initialValue: applicant.occupation,
                              controller: _gauranterform_occupationController,
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
                                    controller: _gauranterform_nationController,
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
                                    controller: _gauranterform_religionController,
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
                                    controller: _gauranterform_casteController,
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
                                    controller: _gauranterform_categoryController,
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
                          Padding(
                            padding: const EdgeInsets.only(right: 20),
                            child: CustomTextFormField(
                              controller: _gauranterform_emailController,
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
                          ),
                          constSizedbox(context),

                          // House Landmark
                          Padding(
                            padding: const EdgeInsets.only(right: 20),
                            child: CustomTextFormField(
                              controller: _gauranterform_houselandmarkController,
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
                              length: 10,
                              textInputType: TextInputType.number,
                              controller: _gauranterform_altermobileController,
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

                          Container(
                            alignment: Alignment.centerLeft,
                            child: const Text(
                              'Other’s Detail’s',
                              textAlign: TextAlign.left,
                            ),
                          ),
                          constSizedbox(context),

                          // Educational Details
                          Padding(
                            padding: const EdgeInsets.only(right: 20),
                            child: CustomTextFormField(
                              controller: _gauranterform_educationController,
                              width: displayWidth(context),
                              inerHint: 'Educational Details',
                              onValidate: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'This field is required';
                                }
                                return null;
                              },
                            ),
                          ),
                          constSizedbox(context),

                          // Years at Current Address
                          Padding(
                            padding: const EdgeInsets.only(right: 20),
                            child: CustomTextFormField(
                              textInputType: TextInputType.numberWithOptions(),
                              controller: _gauranterform_yearsAtcurrentAddress,
                              width: displayWidth(context),
                              inerHint: 'Years at Current Address',
                              onValidate: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'This field is required';
                                }
                                return null;
                              },
                            ),
                          ),
                          constSizedbox(context),

                          // No. of Dependents with Customer
                          // Padding(
                          //   padding: const EdgeInsets.only(right: 20),
                          //   child: CustomTextFormField(
                          //     textInputType: TextInputType.number,
                          //     controller: dependentsController,
                          //     width: displayWidth(context),
                          //     inerHint: 'No. of Dependents with Customer',
                          //     onValidate: (value) {
                          //       if (value == null || value.isEmpty) {
                          //         return 'This field is required';
                          //       }
                          //       return null;
                          //     },
                          //   ),
                          // ),
                          // constSizedbox(context),

                          Padding(
                            padding: const EdgeInsets.only(right: 20),
                            child: CustomDropDownTextField(
                              labelText: 'Residence Type',
                              controller: _gauranterform_residancetypeController,
                              items: [
                                DropDownValueModel(name: "Owned", value: "Owned"),
                                DropDownValueModel(name: "Rented", value: "Rented"),
                                DropDownValueModel(name: "Leased", value: "Leased"),
                              ],
                            ),
                          ),
                          constSizedbox(context),
                          SizedBox(
                            width: displayWidth(context) * 0.4,
                            height: displayHeight(context) * 0.05,
                            child: ElevatedButton(
                              onPressed: () {
                                if (_formKey.currentState!.validate()) {
                                  ref
                                      .read(pdsubmitgauranterProvider.notifier)
                                      .submitpdGarunterForm(
                                    context: context,
                                      gauranterImg: gauranterUrl,
                                      customerId:  widget.customerId,
                                      pdType: 'creditPd',
                                      alternateMobileNo:
                                      _gauranterform_altermobileController.text,
                                      coapplicantType:
                                      _gauranterform_gauranterTypeController.text,
                                      businessType: _gauranterform_bussController.text,
                                      caste: _gauranterform_casteController.text,
                                      category: _gauranterform_categoryController.text,
                                      // dob: do,
                                      educationalDetails:
                                      _gauranterform_educationController.text,
                                      email: _gauranterform_emailController.text,
                                      // gender:
                                      houseLandMark:
                                      _gauranterform_houselandmarkController.text,
                                      //maritalStatus:
                                      nationality: _gauranterform_nationController.text,
                                      occupation:
                                      _gauranterform_occupationController.text,
                                      religion: _gauranterform_religionController.text,
                                      noOfyearsAtCurrentAddress:
                                      _gauranterform_yearsAtcurrentAddress.text,
                                      // noOfDependentWithCustomer:
                                      //     _gauranterform_.text,
                                      residenceType:
                                      _gauranterform_residancetypeController.text)
                                      .then(
                                        (value) {
                                      if (value) {
                                        showCustomSnackBar(
                                            context,'Form Saved successfully!', Colors.green);
                                      }
                                    }
                                  );
                                } else {
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
                      )
                  );
                },

        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stackTrace) => Center(child: Text('Error: $error')),
                )

          ],

    );
  }

  constSizedbox(BuildContext context) {
    return SizedBox(
      height: displayHeight(context) * 0.02,
    );
  }
}
