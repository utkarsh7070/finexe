import 'dart:developer';

import 'package:finexe/feature/base/utils/namespase/app_colors.dart';
import 'package:finexe/feature/base/utils/namespase/app_style.dart';
import 'package:finexe/feature/base/utils/namespase/display_size.dart';
import 'package:finexe/feature/ui/PD/Common%20Widgets/common_textfield.dart';
import 'package:finexe/feature/ui/PD/view/PD%20Form/pd_fromfilds.dart/model/Submit%20Data%20Models/refrence_form_model.dart';
import 'package:finexe/feature/ui/PD/view/PD%20Form/pd_fromfilds.dart/view_model.dart/refrence_detail_vmodel.dart';
import 'package:finexe/feature/ui/Sales/SalesOnBoardingForm/view/Sales_on_boarding_form/referance/referance_details.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RefrenceDetailsForm extends ConsumerStatefulWidget {
  const RefrenceDetailsForm({super.key});

  @override
  _RefrenceDetailsFormState createState() => _RefrenceDetailsFormState();
}

class _RefrenceDetailsFormState extends ConsumerState<RefrenceDetailsForm> {
  late TextEditingController refrenceDetailsForm_refrenceController1;
  late TextEditingController refrenceDetailsForm_addressController1;
  late TextEditingController refrenceDetailsForm_relationController1;
  late TextEditingController refrenceDetailsForm_mobileNumberController1;

  late TextEditingController refrenceDetailsForm_refrenceController2;
  late TextEditingController refrenceDetailsForm_addressController2;
  late TextEditingController refrenceDetailsForm_relationController2;
  late TextEditingController refrenceDetailsForm_mobileNumberController2;

  @override
  void initState() {
    super.initState();
    // Initialize the controllers
    refrenceDetailsForm_refrenceController1 = TextEditingController();
    refrenceDetailsForm_addressController1 = TextEditingController();
    refrenceDetailsForm_relationController1 = TextEditingController();
    refrenceDetailsForm_mobileNumberController1 = TextEditingController();

    refrenceDetailsForm_refrenceController2 = TextEditingController();
    refrenceDetailsForm_addressController2 = TextEditingController();
    refrenceDetailsForm_relationController2 = TextEditingController();
    refrenceDetailsForm_mobileNumberController2 = TextEditingController();
  }

  final _formKey = GlobalKey<FormState>();
  bool isInitialDataSet = false;
  @override
  void dispose() {
    // Dispose of all TextEditingController instances
    refrenceDetailsForm_refrenceController1.dispose();
    refrenceDetailsForm_addressController1.dispose();
    refrenceDetailsForm_relationController1.dispose();
    refrenceDetailsForm_mobileNumberController1.dispose();

    refrenceDetailsForm_refrenceController2.dispose();
    refrenceDetailsForm_addressController2.dispose();
    refrenceDetailsForm_relationController2.dispose();
    refrenceDetailsForm_mobileNumberController2.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final appState = ref.watch(pdRefrenceSubmitProvider);
    final getFormData = ref.watch(getRefrenceDataProvider);
    if (kDebugMode) {
      print(
          'get refrence addres : ${getFormData.value?.items!.referenceDetails![0].address}');
      print(
          'get refrence addres : ${getFormData.value?.items!.referenceDetails![0].name}');
    }
    return getFormData.when(
      data: (refdata) {
        if (!isInitialDataSet && refdata.items != null) {
          refrenceDetailsForm_refrenceController1.text =
              refdata.items!.referenceDetails![0].name ?? '';
          refrenceDetailsForm_addressController1.text =
              refdata.items!.referenceDetails![0].address ?? '';
          refrenceDetailsForm_relationController1.text =
              refdata.items!.referenceDetails![0].relation ?? '';
          refrenceDetailsForm_mobileNumberController1.text =
              refdata.items!.referenceDetails![0].mobileNumber ?? '';

          refrenceDetailsForm_refrenceController2.text =
              refdata.items!.referenceDetails![1].name ?? '';
          refrenceDetailsForm_addressController2.text =
              refdata.items!.referenceDetails![1].address ?? '';
          refrenceDetailsForm_relationController2.text =
              refdata.items!.referenceDetails![1].relation ?? '';
          refrenceDetailsForm_mobileNumberController2.text =
              refdata.items!.referenceDetails![1].mobileNumber ?? '';

          isInitialDataSet = true;
        }
        return ExpansionTile(
          childrenPadding: const EdgeInsets.only(left: 16, bottom: 10),
          shape: const Border(
            bottom: BorderSide(color: AppColors.dividerColor),
          ),
          title: const Text('Reference Detail'),
          children: <Widget>[
            Form(
                key: _formKey,
                child: Column(
                  children: [
                    Container(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Reference Details 1',
                        textAlign: TextAlign.left,
                        style: AppStyles.blueText,
                      ),
                    ),
                    constSizedbox(context),
                    Padding(
                      padding: const EdgeInsets.only(right: 15),
                      child: CustomTextFormField(
                        inerHint: 'Reference Name',
                        onValidate: (value) {
                          if (value!.trim().isEmpty) {
                            return "This is a required field";
                          }
                          return null;
                        },
                        controller: refrenceDetailsForm_refrenceController1,
                        textInputAction: TextInputAction.next,
                      ),
                    ),
                    constSizedbox(context),
                    Padding(
                      padding: const EdgeInsets.only(right: 15),
                      child: CustomTextFormField(
                        inerHint: 'Address',
                        onValidate: (value) {
                          if (value!.trim().isEmpty) {
                            return "This is a required field";
                          }
                          return null;
                        },
                        controller: refrenceDetailsForm_addressController1,
                        textInputAction: TextInputAction.next,
                      ),
                    ),
                    constSizedbox(context),
                    Padding(
                      padding: const EdgeInsets.only(right: 15),
                      child: LayoutBuilder(
                        builder: (context, constraints) {
                          return CustomTextFormField(
                            width: constraints.maxWidth,
                            inerHint: 'Relation',
                            onValidate: (value) {
                              if (value!.trim().isEmpty) {
                                return "This is a required field";
                              }
                              return null;
                            },
                            controller: refrenceDetailsForm_relationController1,
                            textInputAction: TextInputAction.next,
                          );
                        },
                      ),
                    ),
                    constSizedbox(context),
                    Padding(
                      padding: const EdgeInsets.only(right: 15),
                      child: LayoutBuilder(
                        builder: (context, constraints) {
                          return CustomTextFormField(
                            textInputType: TextInputType.number,
                            width: constraints.maxWidth,
                            inerHint: 'Mobile Number',
                            onValidate: (value) {
                              if (value!.trim().isEmpty) {
                                return "This is a required field";
                              }
                              return null;
                            },
                            controller:
                                refrenceDetailsForm_mobileNumberController1,
                            textInputAction: TextInputAction.next,
                          );
                        },
                      ),
                    ),
                    constSizedbox(context),
                    Container(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Reference Details 2',
                        textAlign: TextAlign.left,
                        style: AppStyles.blueText,
                      ),
                    ),
                    constSizedbox(context),
                    Padding(
                      padding: const EdgeInsets.only(right: 15),
                      child: CustomTextFormField(
                        inerHint: 'Reference Name',
                        onValidate: (value) {
                          if (value!.trim().isEmpty) {
                            return "This is a required field";
                          }
                          return null;
                        },
                        controller: refrenceDetailsForm_refrenceController2,
                        textInputAction: TextInputAction.next,
                      ),
                    ),
                    constSizedbox(context),
                    Padding(
                      padding: const EdgeInsets.only(right: 15),
                      child: CustomTextFormField(
                        inerHint: 'Address',
                        onValidate: (value) {
                          if (value!.trim().isEmpty) {
                            return "This is a required field";
                          }
                          return null;
                        },
                        controller: refrenceDetailsForm_addressController2,
                        textInputAction: TextInputAction.next,
                      ),
                    ),
                    constSizedbox(context),
                    Padding(
                      padding: const EdgeInsets.only(right: 15),
                      child: LayoutBuilder(
                        builder: (context, constraints) {
                          return CustomTextFormField(
                            width: constraints.maxWidth,
                            inerHint: 'Relation',
                            onValidate: (value) {
                              if (value!.trim().isEmpty) {
                                return "This is a required field";
                              }
                              return null;
                            },
                            controller: refrenceDetailsForm_relationController2,
                            textInputAction: TextInputAction.next,
                          );
                        },
                      ),
                    ),
                    constSizedbox(context),
                    Padding(
                      padding: const EdgeInsets.only(right: 15),
                      child: LayoutBuilder(
                        builder: (context, constraints) {
                          return CustomTextFormField(
                            textInputType: TextInputType.number,
                            width: constraints.maxWidth,
                            inerHint: 'Mobile Number',
                            onValidate: (value) {
                              if (value!.trim().isEmpty) {
                                return "This is a required field";
                              }
                              return null;
                            },
                            controller:
                                refrenceDetailsForm_mobileNumberController2,
                            textInputAction: TextInputAction.next,
                          );
                        },
                      ),
                    ),
                    constSizedbox(context),
                    ElevatedButton(
                        onPressed: () {
                          // if (_formKey.currentState!.validate()) {

                          // } else {
                          //   // Validation failed, show a message
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
                          // Create the list of ReferenceDetailListModel
                          List<ReferenceDetailListModel> refrenceFormdata = [
                            ReferenceDetailListModel(
                              name: refrenceDetailsForm_refrenceController1.text
                                  .trim(),
                              address: refrenceDetailsForm_addressController1
                                  .text
                                  .trim(),
                              relation: refrenceDetailsForm_relationController1
                                  .text
                                  .trim(),
                              mobileNumber:
                                  refrenceDetailsForm_mobileNumberController1
                                      .text
                                      .trim(),
                            ),
                            ReferenceDetailListModel(
                              name: refrenceDetailsForm_refrenceController2.text
                                  .trim(),
                              address: refrenceDetailsForm_addressController2
                                  .text
                                  .trim(),
                              relation: refrenceDetailsForm_relationController2
                                  .text
                                  .trim(),
                              mobileNumber:
                                  refrenceDetailsForm_mobileNumberController2
                                      .text
                                      .trim(),
                            ),
                          ];

                          // Call the provider method
                          ref
                              .read(pdRefrenceSubmitProvider.notifier)
                              .submitpdRefrenceDetailsForm(
                                customerId: '66f53ffbd7011eb65160f292',
                                pdType: 'creditPd',
                                refrenceFormList: refrenceFormdata
                                    .map((e) => e.toJson())
                                    .toList(),
                              )
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
                                  key: ValueKey(
                                      'loading'), // Key for progress indicator
                                ),
                              )
                            : Text(
                                'Next',
                                style: AppStyles.whiteText16,
                              ))
                  ],
                ))
          ],
        );
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      //  error: (error, stackTrace) => Center(child: Text('Error: $error')),
      error: (error, stackTrace) {
        print('Error: $error');
        return Center(child: Text('faild to get data please try again'));
      },
    );
  }
}

constSizedbox(BuildContext context) {
  return SizedBox(
    height: displayHeight(context) * 0.02,
  );
}
