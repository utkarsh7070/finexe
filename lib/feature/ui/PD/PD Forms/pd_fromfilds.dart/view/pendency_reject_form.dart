import 'package:dio/dio.dart';
import 'package:dropdown_textfield/dropdown_textfield.dart';
import 'package:finexe/feature/base/utils/namespase/app_colors.dart';
import 'package:finexe/feature/base/utils/namespase/app_style.dart';
import 'package:finexe/feature/base/utils/namespase/display_size.dart';
import 'package:finexe/feature/ui/PD/Common%20Widgets/common_textfield.dart';
import 'package:finexe/feature/ui/PD/dialog/CustomPopup.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../base/api/dio_exception.dart';
import '../../../../../base/utils/widget/custom_snackbar.dart';
import '../../../Common Widgets/simple_dropdown.dart';
import '../../../dialog/RejectPDFile/rejectpd_file.dart';
import '../model/Submit Data Models/pendency_reject_modal.dart';
import '../view_model.dart/pendency_view_modal.dart';
final isExpPendencyRlProvider = StateProvider<bool>((ref) => false);

class PendencyReject extends ConsumerStatefulWidget {
  // const PendencyReject({super.key});
  final String customerId;
  const PendencyReject({super.key, required this.customerId});
  @override
  ConsumerState<PendencyReject> createState() => _PendencyRejectState();
}

class _PendencyRejectState extends ConsumerState<PendencyReject> {
  TextEditingController pendencyDetailFormApproveAmount =
      TextEditingController();
  TextEditingController pendencyDetailFormFinalDecision =
      TextEditingController();
  TextEditingController pendencyDetailFormRemark = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    pendencyDetailFormApproveAmount.dispose();
    pendencyDetailFormFinalDecision.dispose();
    pendencyDetailFormRemark.dispose();
    super.dispose();
  }

  SizedBox sizedBoxWithContext(BuildContext context, double heightFactor) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * heightFactor,
    );
  }

  @override
  Widget build(BuildContext context) {
    final pendencyDetailsState =
        ref.watch(getPendencyDetailsProvider(widget.customerId));
    final isExpanded =
    ref.watch(isExpPendencyRlProvider);

    return ExpansionTile(
          backgroundColor: Colors.white,
          childrenPadding: const EdgeInsets.only(left: 16, bottom: 10),
          shape: const BeveledRectangleBorder(side: BorderSide.none),
          title: const Text("Pendency & Reject"),
          onExpansionChanged: (expanded) {
            ref.read(isExpPendencyRlProvider.notifier).state = expanded;
            if (expanded) {
              // Trigger data fetch when the tile is expanded
              ref.refresh(getPendencyDetailsProvider(widget.customerId));
            }
          },
          initiallyExpanded: isExpanded,
          children: <Widget>[
            pendencyDetailsState.when(
                data: (pendencyData) {
                  if (pendencyDetailFormApproveAmount.text.isEmpty) {
                    pendencyDetailFormApproveAmount.text =
                        pendencyData?.approveLoanDetails?.approvedAmount?.toString() ?? '';
                    pendencyDetailFormFinalDecision.text =
                        pendencyData?.approveLoanDetails?.finalDecision?.toString() ?? '';
                    pendencyDetailFormRemark.text =
                        pendencyData?.remarkByPd.toString() ?? '';
                  }
                  return Form(
                    key: _formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(right: 15),
                          child: CustomTextFormField(
                            inerHint: 'Approved Amount',
                            onValidate: (value) {
                              if (value?.trim().isEmpty ?? true) {
                                return "This is a required field";
                              }
                              return null;
                            },
                            controller: pendencyDetailFormApproveAmount,
                            textInputAction: TextInputAction.next,
                            textInputType: TextInputType.number,
                          ),
                        ),
                        sizedBoxWithContext(context, 0.03),

                        Padding(
                          padding: const EdgeInsets.only(right: 15),
                          child: CustomDropDownTextField(
                            labelText: 'Final Decision',
                            controller: pendencyDetailFormFinalDecision,
                            items: const [
                              DropDownValueModel(name: "Rejected", value: "Rejected"),
                              DropDownValueModel(
                                  name: "Approve With Remark", value: "Approve With Remark"),
                              DropDownValueModel(
                                  name: "Approve", value: "Approve"),
                            ],
                          ),
                        ),
                        sizedBoxWithContext(context, 0.03),
                        Padding(
                          padding: const EdgeInsets.only(right: 15),
                          child: CustomTextFormField(
                            inerHint: 'Remark',
                            onValidate: (value) {
                              if (value?.trim().isEmpty ?? true) {
                                return "This is a required field";
                              }
                              return null;
                            },
                            controller: pendencyDetailFormRemark,
                            textInputAction: TextInputAction.next,
                            textInputType: TextInputType.name,
                          ),
                        ),
                        sizedBoxWithContext(context, 0.03),
                        SizedBox(
                          width: displayWidth(context) * 0.9,
                          height: 50,
                          child: ElevatedButton(
                            onPressed: () {
                              CustomPopup.showPopup(
                                context: context,
                                title: 'Mark as Complete',
                                message:
                                'This will mark the entry as \n rejected. Are you sure you want to proceed?',
                                imagePath: 'assets/images/confirmComplete.png',
                                buttonName: 'Set as Complete',
                                buttonColor: const Color(0xFFEE6C52),
                                rejectText: 'No, I Don\'t',
                                rejectTextColor: Colors.grey,
                                onReject: () {
                                  Navigator.of(context).pop();
                                },
                                onCancel: () async {
                                  print('object------------');
                                  Navigator.of(context).pop();

                                  // Create the model with the data from the UI
                                  PendencyDetailsFormModel model =
                                  PendencyDetailsFormModel(
                                    customerId:
                                    widget.customerId, // Example customerId
                                    pdType: "creditPd", // Example pdType
                                    statabyPd: 'complete',
                                    remarkByPd: pendencyDetailFormRemark
                                        .text, // Using the remark from UI
                                    approveLoanDetails: PendencyApproveLoanDetails(
                                        approvedAmount: int.parse(
                                            pendencyDetailFormApproveAmount.text),
                                        // finalDecision: int.parse(
                                        //     pendencyDetailFormFinalDecision.text),
                                        finalDecision: pendencyDetailFormFinalDecision.text
                                      // roi: 0,
                                      // tenure: 55,
                                      // emi: 123,
                                      // demandLoanAmountByCustomer: "123",
                                      // endUseOfLoan: "popular",
                                    ),
                                  );

                                  // Call the FutureProvider to post the data
                                  ref
                                      .read(postPendencyDetailsProvider(model).future)
                                      .then((response) {
                                    if (response.statusCode == 200) {
                                      print(
                                          "Data submitted successfully: ${response.data}");
                                      showCustomSnackBar(
                                          context,'Form Saved successfully!', Colors.green);
                                    }
                                  }).catchError((error) {
                                    print("Error: $error");
                                    DioExceptions.fromDioError(error as DioException, context);
                                  });
                                },
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.blue,
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 8, vertical: 14),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Image.asset(
                                  'assets/images/right_white.png',
                                  height: 20,
                                  width: 20,
                                ),
                                const SizedBox(width: 4),
                                const Text(
                                  "Complete",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Center(
                            child: Text(
                              'Or',
                              style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          // crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(
                              width: displayWidth(context) * 0.42,
                              height: displayHeight(context) * 0.065,
                              child: ElevatedButton(
                                onPressed: () {
                                  CustomPopup.showPopup(
                                    context: context,
                                    title: 'Set as Pending',
                                    message:
                                    'This will mark the entry as \n rejected. Are you sure you want to proceed?',
                                    imagePath: 'assets/images/confirmpending.png',
                                    buttonName: 'Yes i Do',
                                    buttonColor: const Color(0xFFEE6C52),
                                    rejectText: "Cancel",
                                    rejectTextColor: Colors.grey,
                                    onReject: () {
                                      Navigator.of(context).pop();
                                      // Handle rejection logic here
                                    },
                                    onCancel: () {
                                      Navigator.of(context).pop();
                                      // Handle cancel logic here
                                    },
                                  );
                                },
                                style: ElevatedButton.styleFrom(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 24, vertical: 12),
                                  backgroundColor: AppColors.greypink,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Image.asset(
                                      'assets/images/pendingicon.png',
                                      height: 30,
                                      width: 30,
                                    ),
                                    const SizedBox(width: 8),
                                    Text(
                                      "Pending",
                                      // style: TextStyle(
                                      //     color: Color(0xFFFFA500),
                                      //     fontSize: 16,
                                      //     fontWeight: FontWeight.w500),
                                      style: AppStyles.yellowText16,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.only(right: 10),
                              width: displayWidth(context) * 0.42,
                              height: displayHeight(context) * 0.065,
                              child: ElevatedButton(
                                onPressed: () {
                                  // CustomPopup.showPopup(
                                  //   context: context,
                                  //   title: 'Rejection Confirm',
                                  //   message:
                                  //   'This will mark the entry as \n rejected. Are you sure you want to proceed?',
                                  //   imagePath: 'assets/images/confirmReject.png',
                                  //   // buttonName: 'No, I Don\'t',
                                  //   buttonName: 'Reject Form',
                                  //   buttonColor: Color(0xFFEE6C52),
                                  //   rejectText: "Cancel",
                                  //   rejectTextColor: Colors.grey,
                                  //   onReject: () {
                                  //     // Handle rejection logic here
                                  //
                                  //
                                  //
                                  //     Navigator.of(context).pop();
                                  //
                                  //   },
                                  //   onCancel: () {
                                  //     Navigator.of(context).pop();
                                  //     // Handle cancel logic here
                                  //   },
                                  // );
                                  PdRijectDialogue.requestRijectDialogue(context: context, customerID:widget.customerId);
                                },
                                style: ElevatedButton.styleFrom(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 24, vertical: 12),
                                  backgroundColor: AppColors.greypink,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Image.asset(
                                      'assets/images/rejecticon.png',
                                      height: 20,
                                      width: 20,
                                    ),
                                    const SizedBox(width: 8),
                                    Text(
                                      "Reject",
                                      style: AppStyles.redText16,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: displayHeight(context)*0.04,)

                      ],
                    ),
                  );
                },
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (error, stackTrace) => Center(child: Text('Error: $error')),
            )

          ],


    );
  }

  void showCustomPopup(
    BuildContext context,
    String title,
    String message,
    String buttonName,
    String imagePath, {
    Color buttonColor =
        Colors.blue, // Customizable button color with default value
    String rejectText =
        "Reject", // Customizable reject button text with default value
    Color rejectTextColor =
        Colors.red, // Customizable reject text color with default value
  }) {
    showDialog(
      context: context,
      builder: (context) {
        return CustomPopup(
          title: title,
          message: message,
          imagePath: imagePath,
          buttonName: buttonName,
          onReject: () {
            // Implement Reject action here
            Navigator.of(context).pop();
          },
          onCancel: () {
            // Dismiss the popup
            Navigator.of(context).pop();
          },
          buttonColor: buttonColor, // Pass custom button color
          rejectText: rejectText, // Pass custom reject button text
          rejectTextColor: rejectTextColor, // Pass custom reject text color
        );
      },
    );
  }
}
