import 'package:finexe/feature/base/utils/namespase/display_size.dart';
import 'package:finexe/feature/base/utils/widget/app_text_filed_login.dart';
import 'package:flutter/Material.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../view_model.dart/cibil_vmodel.dart';

// class CibilDetailsForm extends ConsumerStatefulWidget {
//   final String customerId;
//
//   const CibilDetailsForm({super.key, required this.customerId});
//
//   @override
//   _CibilDetailsFormState createState() => _CibilDetailsFormState();
// }

class CibilDetailsForm extends ConsumerWidget {
  final String customerId;

  const CibilDetailsForm({required this.customerId, super.key});

  // final _formKey = GlobalKey<FormState>();
  // late TextEditingController cibildetailform_numberofLoanController;
  // late TextEditingController cibildetailform_currentLoanController;
  // late TextEditingController cibildetailform_resonforDPDController;

  // @override
  // void initState() {
  //   super.initState();
  //   cibildetailform_numberofLoanController = TextEditingController();
  //   cibildetailform_currentLoanController = TextEditingController();
  //   cibildetailform_resonforDPDController = TextEditingController();
  // }
  //
  // @override
  // void dispose() {
  //   cibildetailform_numberofLoanController.dispose();
  //   cibildetailform_currentLoanController.dispose();
  //   cibildetailform_resonforDPDController.dispose();
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    print('customerId in Cibil: $customerId');
    final isExpanded = ref.watch(isExpandedProvider);
    //pdCibilSubmitProvider
    final cibileData = ref.watch(cibilDetailsProvider(customerId));

    final appState = ref.watch(pdCibilSubmitProvider);
    final appSateViewModel = ref.read(pdCibilSubmitProvider.notifier);

    return ExpansionTile(
      title: const Text('Cibil Detail’s'),
      onExpansionChanged: (expanded) {
        ref.read(isExpandedProvider.notifier).state = expanded;
        if (expanded) {
          // Trigger data fetch when the tile is expanded
          ref.refresh(cibilDetailsProvider(customerId));
        }
      },
      initiallyExpanded: isExpanded,
      children: [
        cibileData.when(
          data: (cibileDataForm) {
            return Padding(
              padding: const EdgeInsets.only(left: 15, right: 15),
              child: Column(
                children: [
                  constSizedbox(context),
                  AppFloatTextField(
                    initialValue: cibileDataForm.items?.cibilAnalysis?.totalLoans,
                    textInputType: TextInputType.number,
                    inerHint: 'No. of total loan',
                    errorText: "total loan is a required field",
                    isError: !appState.isTotalLoans,
                    onChange: (value) {
                      appSateViewModel.updateTotalLoans(value);
                    },
                    textInputAction: TextInputAction.next,
                  ),
                  constSizedbox(context),
                  AppFloatTextField(
                    initialValue: cibileDataForm.items?.cibilAnalysis?.detailsOfCurrentLoans,
                    // width: displayWidth(context) * 0.8,
                    inerHint: 'Current loan detail’s',
                    errorText: "Current loan detail’s is a required field",
                    isError: !appState.isDetailsOfCurrentLoans,
                    onChange: (value) {
                      appSateViewModel.updateDetailsOfCurrentLoans(value);
                    },
                    textInputAction: TextInputAction.next,
                  ),
                  constSizedbox(context),
                  AppFloatTextField(
                    initialValue: cibileDataForm.items?.cibilAnalysis?.reasonforDpd,
                    // width: displayWidth(context) * 0.8,
                    inerHint: 'Reason for DPD',
                    errorText: "Reason for DPD is a required field",
                    isError: !appState.isReasonforDpd,
                    onChange: (value) {
                      appSateViewModel.updateReasonforDpd(value);
                    },
                    textInputAction: TextInputAction.next,
                  ),
                  constSizedbox(context),
                  // ElevatedButton(
                  //   onPressed: () {
                  //     if (_formKey.currentState!.validate()) {
                  //       final cibilFormDatat = CibilAnalysis(
                  //         detailsOfCurrentLoans: cibildetailform_currentLoanController.text,
                  //         totalLoans: cibildetailform_numberofLoanController.text,
                  //         reasonforDPD: cibildetailform_resonforDPDController.text,
                  //       );
                  //
                  //       ref.read(pdCibilSubmitProvider.notifier).submitpdCibilDetailsForm(
                  //         context: context,
                  //         customerId: widget.customerId,
                  //         pdType: 'creditPd',
                  //         cibilData: cibilFormDatat,
                  //       ).then(
                  //             (value) {
                  //           if (value == true) {
                  //             showCustomSnackBar(
                  //                 context,'Form Saved successfully!', Colors.green);
                  //           }
                  //         },
                  //       );
                  //     } else {
                  //       ScaffoldMessenger.of(context).showSnackBar(
                  //         SnackBar(
                  //           backgroundColor: AppColors.red,
                  //           content: Text(
                  //             'Please fill all required details!',
                  //             style: AppStyles.whiteText16,
                  //           ),
                  //         ),
                  //       );
                  //     }
                  //   },
                  //   child: appSate.isLoading == true
                  //       ? const SizedBox(
                  //     width: 24, // Specify the width
                  //     height: 24, // Specify the height
                  //     child: CircularProgressIndicator(
                  //       color: AppColors.white,
                  //       strokeWidth: 3,
                  //       key: ValueKey(
                  //           'loading'), // Key for progress indicator
                  //     ),
                  //   ):
                  //   Text(
                  //     'Save Form',
                  //     style: AppStyles.whiteText16,
                  //   ),
                  // )
                ],
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
