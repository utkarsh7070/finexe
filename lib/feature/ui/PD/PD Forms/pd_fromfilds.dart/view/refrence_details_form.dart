import 'package:finexe/feature/base/utils/namespase/app_colors.dart';
import 'package:finexe/feature/base/utils/namespase/app_style.dart';
import 'package:finexe/feature/base/utils/namespase/display_size.dart';
import 'package:finexe/feature/base/utils/widget/app_button.dart';
import 'package:finexe/feature/base/utils/widget/app_text_filed_login.dart';
// import 'package:finexe/feature/ui/PD/view/PD%20Form/pd_fromfilds.dart/model/Submit%20Data%20Models/refrence_form_model.dart';
// import 'package:finexe/feature/ui/PD/view/PD%20Form/pd_fromfilds.dart/view_model.dart/refrence_detail_vmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../base/utils/widget/custom_snackbar.dart';
import '../view_model.dart/refrence_detail_vmodel.dart';

// final isExpRefrenceDetProvider = StateProvider<bool>((ref) => false);
//
// class RefrenceDetailsForm extends ConsumerStatefulWidget {
//   // const RefrenceDetailsForm({super.key});
//   final String customerId;
//   const RefrenceDetailsForm({super.key, required this.customerId});
//   @override
//   _RefrenceDetailsFormState createState() => _RefrenceDetailsFormState();
// }

class RefrenceDetailsForm extends ConsumerWidget {
  final String customerId;

  RefrenceDetailsForm({required this.customerId, super.key});

  // late TextEditingController refrenceDetailsForm_refrenceController1;
  // late TextEditingController refrenceDetailsForm_addressController1;
  // late TextEditingController refrenceDetailsForm_relationController1;
  // late TextEditingController refrenceDetailsForm_mobileNumberController1;
  //
  // late TextEditingController refrenceDetailsForm_refrenceController2;
  // late TextEditingController refrenceDetailsForm_addressController2;
  // late TextEditingController refrenceDetailsForm_relationController2;
  // late TextEditingController refrenceDetailsForm_mobileNumberController2;

  // @override
  // void initState() {
  //   super.initState();
  //   // Initialize the controllers
  //   refrenceDetailsForm_refrenceController1 = TextEditingController();
  //   refrenceDetailsForm_addressController1 = TextEditingController();
  //   refrenceDetailsForm_relationController1 = TextEditingController();
  //   refrenceDetailsForm_mobileNumberController1 = TextEditingController();
  //
  //   refrenceDetailsForm_refrenceController2 = TextEditingController();
  //   refrenceDetailsForm_addressController2 = TextEditingController();
  //   refrenceDetailsForm_relationController2 = TextEditingController();
  //   refrenceDetailsForm_mobileNumberController2 = TextEditingController();
  // }

  final _formKey = GlobalKey<FormState>();
  bool isInitialDataSet = false;

  // @override
  // void dispose() {
  //   // Dispose of all TextEditingController instances
  //   refrenceDetailsForm_refrenceController1.dispose();
  //   refrenceDetailsForm_addressController1.dispose();
  //   refrenceDetailsForm_relationController1.dispose();
  //   refrenceDetailsForm_mobileNumberController1.dispose();
  //
  //   refrenceDetailsForm_refrenceController2.dispose();
  //   refrenceDetailsForm_addressController2.dispose();
  //   refrenceDetailsForm_relationController2.dispose();
  //   refrenceDetailsForm_mobileNumberController2.dispose();
  //
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appState = ref.watch(pdRefrenceSubmitProvider);
    final appStateViewModel = ref.read(pdRefrenceSubmitProvider.notifier);
    final getFormData = ref.watch(getRefrenceDataProvider(customerId));

    return ExpansionTile(
      childrenPadding: const EdgeInsets.only(left: 16, bottom: 10),
      shape: const Border(
        bottom: BorderSide(color: AppColors.dividerColor),
      ),
      title: const Text('Reference Detail'),
      onExpansionChanged: (expanded) {
        // ref.read(isExpRefrenceDetProvider.notifier).state = expanded;
        if (expanded) {
          // Trigger data fetch when the tile is expanded
          ref.refresh(getRefrenceDataProvider(customerId));
        }
      },
      // initiallyExpanded: isExpanded,
      children: <Widget>[
        getFormData.when(
          data: (refdata) {
            // if(refdata.items?.referenceDetails != null) {
            //   if (refdata.items!.referenceDetails!.isNotEmpty) {
            //     if (!isInitialDataSet && refdata.items != null) {
            //       refrenceDetailsForm_refrenceController1.text =
            //           refdata.items!.referenceDetails?[0].name ?? '';
            //       refrenceDetailsForm_addressController1.text =
            //           refdata.items!.referenceDetails?[0].address ?? '';
            //       refrenceDetailsForm_relationController1.text =
            //           refdata.items!.referenceDetails?[0].relation ?? '';
            //       refrenceDetailsForm_mobileNumberController1.text =
            //           refdata.items!.referenceDetails?[0].mobileNumber ??
            //               '';
            //       if (refdata.items!.referenceDetails != null &&
            //           refdata.items!.referenceDetails!.length > 1) {
            //         // Populate the second reference details
            //         refrenceDetailsForm_refrenceController2.text =
            //             refdata.items!.referenceDetails?[1].name ?? '';
            //         refrenceDetailsForm_addressController2.text =
            //             refdata.items!.referenceDetails?[1].address ?? '';
            //         refrenceDetailsForm_relationController2.text =
            //             refdata.items!.referenceDetails?[1].relation ??
            //                 '';
            //         refrenceDetailsForm_mobileNumberController2.text =
            //             refdata.items!.referenceDetails?[1]
            //                 .mobileNumber ?? '';
            //       }
            //
            //       isInitialDataSet = true;
            //     }
            //   }
            // }
            return Column(
              children: [
                ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  primary: true,
                  itemCount: appState.referenceList.length,
                  itemBuilder: (context, index) {
                    return Column(
                      children: [
                        Container(
                          padding: const EdgeInsets.only(top: 16),
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'Reference Details ${index + 1}',
                            textAlign: TextAlign.left,
                            style: AppStyles.blueText,
                          ),
                        ),
                        constSizedbox(context),
                        AppFloatTextField(
                          initialValue:
                              appState.referenceList[index].referenceName,
                          onChange: (value) {
                            appStateViewModel.updateReferenceName(value, index);
                          },
                          inerHint: 'Reference Name',
                          textInputAction: TextInputAction.next,
                        ),
                        constSizedbox(context),
                        AppFloatTextField(
                          initialValue:
                              appState.referenceList[index].referenceAddress,
                          inerHint: 'Address',
                          textInputAction: TextInputAction.next,
                          onChange: (value) {
                            appStateViewModel.updateReferenceAddress(
                                value, index);
                          },
                        ),
                        constSizedbox(context),
                        AppFloatTextField(
                          initialValue:
                              appState.referenceList[index].referenceRelation,
                          inerHint: 'Relation',
                          textInputAction: TextInputAction.next,
                          onChange: (value) {
                            appStateViewModel.updateReferenceRelation(
                                value, index);
                          },
                        ),
                        constSizedbox(context),
                        AppFloatTextField(
                          initialValue:
                              appState.referenceList[index].referenceMobile,
                          textInputType: TextInputType.number,
                          inerHint: 'Mobile Number',
                          textInputAction: TextInputAction.next,
                          onChange: (value) {
                            appStateViewModel.updateReferenceMobile(
                                value, index);
                          },
                        ),
                      ],
                    );
                  },
                ),

                // constSizedbox(context),
                // Container(
                //   alignment: Alignment.centerLeft,
                //   child: Text(
                //     'Reference Details 2',
                //     textAlign: TextAlign.left,
                //     style: AppStyles.blueText,
                //   ),
                // ),
                // constSizedbox(context),
                // Padding(
                //   padding: const EdgeInsets.only(right: 15),
                //   child: CustomTextFormField(
                //     inerHint: 'Reference Name',
                //     onValidate: (value) {
                //       if (value!.trim().isEmpty) {
                //         return "This is a required field";
                //       }
                //       return null;
                //     },
                //     // controller: refrenceDetailsForm_refrenceController2,
                //     textInputAction: TextInputAction.next,
                //   ),
                // ),
                // constSizedbox(context),
                // Padding(
                //   padding: const EdgeInsets.only(right: 15),
                //   child: CustomTextFormField(
                //     inerHint: 'Address',
                //     onValidate: (value) {
                //       if (value!.trim().isEmpty) {
                //         return "This is a required field";
                //       }
                //       return null;
                //     },
                //     // controller: refrenceDetailsForm_addressController2,
                //     textInputAction: TextInputAction.next,
                //   ),
                // ),
                // constSizedbox(context),
                // Padding(
                //   padding: const EdgeInsets.only(right: 15),
                //   child: LayoutBuilder(
                //     builder: (context, constraints) {
                //       return CustomTextFormField(
                //         width: constraints.maxWidth,
                //         inerHint: 'Relation',
                //         // onValidate: (value) {
                //         //   if (value!.trim().isEmpty) {
                //         //     return "This is a required field";
                //         //   }
                //         //   return null;
                //         // },
                //         // controller: refrenceDetailsForm_relationController2,
                //         textInputAction: TextInputAction.next,
                //       );
                //     },
                //   ),
                // ),
                // constSizedbox(context),
                // Padding(
                //   padding: const EdgeInsets.only(right: 15),
                //   child: LayoutBuilder(
                //     builder: (context, constraints) {
                //       return CustomTextFormField(
                //         textInputType: TextInputType.number,
                //         width: constraints.maxWidth,
                //         inerHint: 'Mobile Number',
                //         onValidate: (value) {
                //           if (value!.trim().isEmpty) {
                //             return "This is a required field";
                //           }
                //           return null;
                //         },
                //         // controller:
                //         // refrenceDetailsForm_mobileNumberController2,
                //         textInputAction: TextInputAction.next,
                //       );
                //     },
                //   ),
                // ),
                // constSizedbox(context),
                AppButton(
                  isBorderColor: true,
                  borderColor: AppColors.primary,
                  bgColor: AppColors.white,
                  width: displayWidth(context),
                  label: 'Save Form',
                  onTap: () {
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
                    // List<ReferenceDetailListModel> refrenceFormdata = [
                    //   ReferenceDetailListModel(
                    //     name: refrenceDetailsForm_refrenceController1.text
                    //         .trim(),
                    //     address: refrenceDetailsForm_addressController1
                    //         .text
                    //         .trim(),
                    //     relation: refrenceDetailsForm_relationController1
                    //         .text
                    //         .trim(),
                    //     mobileNumber:
                    //     refrenceDetailsForm_mobileNumberController1
                    //         .text
                    //         .trim(),
                    //   ),
                    //   ReferenceDetailListModel(
                    //     name: refrenceDetailsForm_refrenceController2.text
                    //         .trim(),
                    //     address: refrenceDetailsForm_addressController2
                    //         .text
                    //         .trim(),
                    //     relation: refrenceDetailsForm_relationController2
                    //         .text
                    //         .trim(),
                    //     mobileNumber:
                    //     refrenceDetailsForm_mobileNumberController2
                    //         .text
                    //         .trim(),
                    //   ),
                    // ];

                    // Call the provider method
                    appStateViewModel.submitPdReferenceDetailsForm(
                        context: context,
                        customerId: customerId,
                        // refrenceFormdata
                        //     .map((e) => e.toJson())
                        //     .toList(),
                        ).then(
                      (value) {
                        if (value) {
                          showCustomSnackBar(context,
                              'Form Saved successfully!', Colors.green);
                        }
                        // else {
                        //   ScaffoldMessenger.of(context).showSnackBar(
                        //     SnackBar(
                        //       backgroundColor: AppColors.red,
                        //       content: Text(
                        //         'Faild to save the form please try again!',
                        //         style: AppStyles.whiteText16,
                        //       ),
                        //     ),
                        //   );
                        // }
                      },
                    );
                  },
                  // child: appState.isLoading == true
                  //     ? const SizedBox(
                  //         width: 24, // Specify the width
                  //         height: 24, // Specify the height
                  //         child: CircularProgressIndicator(
                  //           color: AppColors.white,
                  //           strokeWidth: 3,
                  //           key: ValueKey(
                  //               'loading'), // Key for progress indicator
                  //         ),
                  //       )
                  //     : Text(
                  //         'Save Form',
                  //         style: AppStyles.whiteText16,
                  //       )
                )
              ],
            );
          },
          loading: () => const Center(child: CircularProgressIndicator()),
          //  error: (error, stackTrace) => Center(child: Text('Error: $error')),
          error: (error, stackTrace) {
            print('Error: $error');
            return const Center(
                child: Text('faild to get data please try again'));
          },
        )
      ],
    );
  }
}

constSizedbox(BuildContext context) {
  return SizedBox(
    height: displayHeight(context) * 0.02,
  );
}
