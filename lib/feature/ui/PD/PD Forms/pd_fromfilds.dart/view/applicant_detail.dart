import 'package:dropdown_textfield/dropdown_textfield.dart';
import 'package:finexe/feature/base/api/api.dart';
import 'package:finexe/feature/base/utils/namespase/app_colors.dart';
import 'package:finexe/feature/base/utils/namespase/app_style.dart';
import 'package:finexe/feature/base/utils/namespase/display_size.dart';
import 'package:finexe/feature/ui/PD/Common%20Widgets/common_textfield.dart';
import 'package:finexe/feature/ui/PD/Common%20Widgets/simple_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../common imagePicker/image_picker.dart';
import '../view_model.dart/applicant_view_model.dart';

class ApplicantForm extends ConsumerStatefulWidget {
  // const ApplicantForm({super.key});
  final String customerId;
  const ApplicantForm({super.key, required this.customerId});

  @override
  _ApplicantFormState createState() => _ApplicantFormState();
}

class _ApplicantFormState extends ConsumerState<ApplicantForm> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
// class ApplicantForm extends ConsumerWidget{

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
                    print('applicantImageUrl ${Api.baseUrl}${applicant.applicant!}');
                    if (occupationController.text.isEmpty) {
                      occupationController.text = applicant.applicant!.occupation ?? '';
                      applicantTypeController.text =
                          applicant.applicant!.applicantType ?? '';
                      businessTypeController.text = applicant.applicant!.businessType ?? '';
                      // occupationController.text = applicant.occupation ?? '';
                      nationalityController.text = applicant.applicant!.nationality ?? '';
                      religionController.text = applicant.applicant!.religion ?? '';
                      casteController.text = applicant.applicant!.caste ?? '';
                      categoryController.text = applicant.applicant!.category ?? '';
                      alternateMobileController.text =
                          applicant.applicant!.alternateMobileNo ?? '';
                      houseLandmarkController.text =
                          applicant.applicant!.houseLandMark ?? '';
                      emailController.text = applicant.applicant!.email ?? '';
                      yearsAtCurrentAddressController.text =
                          applicant.applicant!.noOfyearsAtCurrentAddress ?? '';
                      educationalDetailsController.text =
                          applicant.applicant!.educationalDetails ?? '';
                      dependentsController.text =
                          applicant.applicant!.noOfDependentWithCustomer ?? '';
                      residenceTypeController.text =
                          applicant.applicant!.residenceType ?? '';
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

                        const Text(
                          'Applicant Image',
                          // textAlign: TextAlign.left,
                        ),

                        CommonImagePicker(
                          applicantImage: applicant.applicantImage ?? '',
                          onImageUploaded: (imageUrl) {
                            setState(() {
                              applicant.applicantImage!.isNotEmpty
                                  ? applicant.applicantImage = imageUrl
                                  : // Update the image URL
                              applicantImageUrl = imageUrl;
                              print('applicantImageUrl:: $applicantImageUrl');
                            });
                          },
                        ),
                        constSizedbox(context),

                        CustomDropDownTextField(
                          labelText: 'Applicant Type',
                          controller: applicantTypeController,
                          items: const[
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
                          items: const[
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
                            }
                            if (!RegExp(r'^\+?[1-9]\d{1,14}$').hasMatch(value)) {
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
                          textInputType: const TextInputType.numberWithOptions(),
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
                            const DropDownValueModel(name: "Owned", value: "Owned"),
                            const DropDownValueModel(name: "Rented", value: "Rented"),
                            const DropDownValueModel(name: "Leased", value: "Leased"),
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
                                : const Text(
                              'Next',
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
