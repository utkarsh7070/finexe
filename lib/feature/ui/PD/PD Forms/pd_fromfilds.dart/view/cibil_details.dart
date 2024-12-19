import 'package:finexe/feature/base/utils/namespase/app_colors.dart';
import 'package:finexe/feature/base/utils/namespase/app_style.dart';
import 'package:finexe/feature/base/utils/namespase/display_size.dart';
import 'package:finexe/feature/ui/PD/Common%20Widgets/common_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../model/Submit Data Models/cibil_form_model.dart';
import '../view_model.dart/cibil_vmodel.dart';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CibilDetailsForm extends ConsumerStatefulWidget {
  final String customerId;

  CibilDetailsForm({required this.customerId});

  @override
  _CibilDetailsFormState createState() => _CibilDetailsFormState();
}

class _CibilDetailsFormState extends ConsumerState<CibilDetailsForm> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController cibildetailform_numberofLoanController;
  late TextEditingController cibildetailform_currentLoanController;
  late TextEditingController cibildetailform_resonforDPDController;

  @override
  void initState() {
    super.initState();
    cibildetailform_numberofLoanController = TextEditingController();
    cibildetailform_currentLoanController = TextEditingController();
    cibildetailform_resonforDPDController = TextEditingController();
  }

  @override
  void dispose() {
    cibildetailform_numberofLoanController.dispose();
    cibildetailform_currentLoanController.dispose();
    cibildetailform_resonforDPDController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print('customerId in Cibil: ${widget.customerId}');
    final isExpanded = ref.watch(isExpandedProvider);
    //pdCibilSubmitProvider
    final cibileData = ref.watch(cibilDetailsProvider(widget.customerId));

    final _appSate = ref.watch(pdCibilSubmitProvider);

    return ExpansionTile(
      title: Text('Cibil Detail’s'),
      onExpansionChanged: (expanded) {
        ref.read(isExpandedProvider.notifier).state = expanded;
        if (expanded) {
          // Trigger data fetch when the tile is expanded
          ref.refresh(cibilDetailsProvider(widget.customerId));
        }
      },
      initiallyExpanded: isExpanded,
      children: [
        cibileData.when(
          data: (cibileDataForm) {
            if (cibildetailform_numberofLoanController.text.isEmpty) {
              cibildetailform_numberofLoanController.text = cibileDataForm.totalLoans ?? '';
              cibildetailform_currentLoanController.text = cibileDataForm.detailsOfCurrentLoans ?? '';
              cibildetailform_resonforDPDController.text = cibileDataForm.reasonforDPD ?? '';
            }
            return Form(
              key: _formKey,
              child: Padding(
                padding: const EdgeInsets.only(left: 15,right: 15),
                child: Column(
                  children: [
                    constSizedbox(context),
                    CustomTextFormField(
                      textInputType: TextInputType.number,
                      inerHint: 'No. of total loan',
                      onValidate: (value) {
                        if (value!.trim().isEmpty) {
                          return "Please enter No. of total loan";
                        }
                        return null;
                      },
                      controller: cibildetailform_numberofLoanController,
                      textInputAction: TextInputAction.next,
                    ),
                    constSizedbox(context),
                    CustomTextFormField(
                      width: displayWidth(context) * 0.8,
                      inerHint: 'Current loan detail’s',
                      onValidate: (value) {
                        if (value!.trim().isEmpty) {
                          return "It is a required field";
                        }
                        return null;
                      },
                      controller: cibildetailform_currentLoanController,
                      textInputAction: TextInputAction.next,
                    ),
                    constSizedbox(context),
                    CustomTextFormField(
                      width: displayWidth(context) * 0.8,
                      inerHint: 'Reason for DPD',
                      onValidate: (value) {
                        if (value!.trim().isEmpty) {
                          return "Please Enter reason for DPD";
                        }
                        return null;
                      },
                      controller: cibildetailform_resonforDPDController,
                      textInputAction: TextInputAction.next,
                    ),
                    constSizedbox(context),
                    ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          final cibilFormDatat = CibilAnalysis(
                            detailsOfCurrentLoans: cibildetailform_currentLoanController.text,
                            totalLoans: cibildetailform_numberofLoanController.text,
                            reasonforDPD: cibildetailform_resonforDPDController.text,
                          );

                          ref.read(pdCibilSubmitProvider.notifier).submitpdCibilDetailsForm(
                            customerId: widget.customerId,
                            pdType: 'creditPd',
                            cibilData: cibilFormDatat,
                          ).then(
                                (value) {
                              if (value == true) {
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
                                      'An Error occurred while submitting the form. Please try again!',
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
                      child: _appSate.isLoading == true
                          ? const SizedBox(
                        width: 24, // Specify the width
                        height: 24, // Specify the height
                        child: CircularProgressIndicator(
                          color: AppColors.white,
                          strokeWidth: 3,
                          key: ValueKey(
                              'loading'), // Key for progress indicator
                        ),
                      ):
                      Text(
                        'Next',
                        style: AppStyles.whiteText16,
                      ),
                    )
                  ],
                ),
              ),
            );
          },
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (error, stackTrace) => Center(child: Text('Error: $error')),
        ),
      ],
    );
  }

  constSizedbox(BuildContext context) {
    return SizedBox(
      height: displayHeight(context) * 0.02,
    );
  }
}
