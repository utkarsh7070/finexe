import 'package:cached_network_image/cached_network_image.dart';
import 'package:dropdown_textfield/dropdown_textfield.dart';
import 'package:finexe/feature/base/api/api.dart';
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

class CoApplicantSecondForm extends ConsumerStatefulWidget {
  final CoApplicant? data;

  const CoApplicantSecondForm({super.key, this.data});

  @override
  _CoApplicantSecondFormState createState() => _CoApplicantSecondFormState();
}

class _CoApplicantSecondFormState extends ConsumerState<CoApplicantSecondForm> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController coaaplicantform02_applicantTypeController =
      TextEditingController();
  final TextEditingController coaaplicantform02_businessTypeController =
      TextEditingController();
  final TextEditingController coaaplicantform02_occupationController =
      TextEditingController();
  final TextEditingController coaaplicantform02_nationalityController =
      TextEditingController();
  final TextEditingController coaaplicantform02_religionController =
      TextEditingController();
  final TextEditingController coaaplicantform02_casteController =
      TextEditingController();
  final TextEditingController coaaplicantform02_categoryController =
      TextEditingController();
  final TextEditingController coaaplicantform02_alternateMobileController =
      TextEditingController();
  final TextEditingController coaaplicantform02_houseLandmarkController =
      TextEditingController();
  final TextEditingController coaaplicantform02_emailController =
      TextEditingController();
  final TextEditingController coaaplicantform02_educationalDetailsController =
      TextEditingController();
  final TextEditingController coaaplicantform02_dependentsController =
      TextEditingController();
  final TextEditingController coaaplicantform02_residenceTypeController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    final appState = ref.watch(pdapplicantViewModelProvider);

    if (coaaplicantform02_occupationController.text.isEmpty) {
      coaaplicantform02_applicantTypeController.text =
          widget.data!.coApplicantType ?? '';
      coaaplicantform02_businessTypeController.text =
          widget.data!.businessType ?? '';
      coaaplicantform02_occupationController.text =
          widget.data!.occupation ?? '';
      coaaplicantform02_nationalityController.text =
          widget.data!.nationality ?? '';
      coaaplicantform02_religionController.text = widget.data!.religion ?? '';
      coaaplicantform02_casteController.text = widget.data!.caste ?? '';
      coaaplicantform02_categoryController.text = widget.data!.category ?? '';
      coaaplicantform02_alternateMobileController.text =
          widget.data!.alternateMobileNo ?? '';
      coaaplicantform02_houseLandmarkController.text =
          widget.data!.houseLandMark ?? '';
      coaaplicantform02_emailController.text = widget.data!.emailId ?? '';
      // coa.text =
      //     coApplicantItems.noOfyearsAtCurrentAddress ?? '';
      coaaplicantform02_educationalDetailsController.text =
          widget.data!.educationalDetails ?? '';
      // dependentsController.text = coApplicantItems.de ?? '';
      coaaplicantform02_residenceTypeController.text =
          widget.data!.residenceType ?? '';
    }

    return Form(
      key: _formKey,
      child: ExpansionTile(
        childrenPadding: const EdgeInsets.only(left: 16, bottom: 0),
        shape: const Border(
          bottom: BorderSide(color: AppColors.dividerColor),
        ),
        title: const Text('Co-Applicant Details 02'),
        children: <Widget>[
          Container(
            alignment: Alignment.centerLeft,
            child: const Text(
              'Personal Information',
              textAlign: TextAlign.left,
            ),
          ),
//               constSizedbox(context),

// ClipRRect(
//                           borderRadius: BorderRadius.circular(10),
//                           child: CachedNetworkImage(
//                             imageUrl: '${Api.imageUrl}${coApplicantImages[1]}',
//                             height: 56,
//                             width: 56,
//                             fit: BoxFit.cover,
//                             placeholder: (context, url) => const Center(
//                               child: CircularProgressIndicator(),
//                             ),
//                             errorWidget: (context, url, error) => Image.asset(
//                               'assets/images/no_internet.jpg',
//                               height: 56,
//                               width: 56,
//                               fit: BoxFit.cover,
//                             ),
//                           ),
//                         ),
          constSizedbox(context),
          // Applicant Type
          Padding(
            padding: const EdgeInsets.only(right: 20),
            child: CustomDropDownTextField(
              labelText: 'Applicant Type',
              controller: coaaplicantform02_applicantTypeController,
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
              controller: coaaplicantform02_businessTypeController,
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
          Padding(
            padding: const EdgeInsets.only(right: 20),
            child: CustomTextFormField(
              controller: coaaplicantform02_occupationController,
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
                    controller: coaaplicantform02_nationalityController,
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
                    controller: coaaplicantform02_religionController,
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
                    controller: coaaplicantform02_casteController,
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
                    controller: coaaplicantform02_categoryController,
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
              controller: coaaplicantform02_houseLandmarkController,
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
              controller: coaaplicantform02_alternateMobileController,
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

          // Occupation
          Padding(
            padding: const EdgeInsets.only(right: 20),
            child: CustomDropDownTextField(
              labelText: 'Residence Type',
              controller: coaaplicantform02_residenceTypeController,
              items: [
                DropDownValueModel(name: "Owned", value: "Owned"),
                DropDownValueModel(name: "Rented", value: "Rented"),
                DropDownValueModel(name: "Leased", value: "Leased"),
              ],
            ),
          ),
          constSizedbox(context),
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
                          coaaplicantform02_alternateMobileController.text,
                      coapplicantType:
                          coaaplicantform02_applicantTypeController.text,
                      businessType:
                          coaaplicantform02_businessTypeController.text,
                      caste: coaaplicantform02_casteController.text,
                      category: coaaplicantform02_categoryController.text,
                      // dob: do,
                      educationalDetails:
                          coaaplicantform02_educationalDetailsController.text,
                      email: coaaplicantform02_emailController.text,
                      // gender:
                      houseLandMark:
                          coaaplicantform02_houseLandmarkController.text,
                      //maritalStatus:
                      nationality: coaaplicantform02_nationalityController.text,
                      occupation: coaaplicantform02_occupationController.text,
                      religion: coaaplicantform02_religionController.text,
                      // noOfyearsAtCurrentAddress:
                      //     coa.text,
                      noOfDependentWithCustomer:
                          coaaplicantform02_dependentsController.text,
                      residenceType:
                          coaaplicantform02_residenceTypeController.text)
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
            child: appState.isLoading == true
                ? const SizedBox(
                    width: 24, // Specify the width
                    height: 24, // Specify the height
                    child: CircularProgressIndicator(
                      color: AppColors.white,
                      strokeWidth: 3,
                      key: ValueKey('loading'), // Key for progress indicator
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
  }
}

Widget constSizedbox(BuildContext context) {
  return SizedBox(height: displayHeight(context) * 0.03);
}
