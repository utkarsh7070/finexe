import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../../../base/service/session_service.dart';
import '../../../../../../base/utils/namespase/app_colors.dart';
import '../../../../../../base/utils/namespase/app_style.dart';
import '../../../../../../base/utils/namespase/display_size.dart';
import '../../../../../../base/utils/widget/app_button.dart';
import '../../../../../../base/utils/widget/app_text_filed_login.dart';
import '../../../../../../base/utils/widget/upload_box.dart';
import '../../../../NewLone/view_model/new_loan_view_model.dart';
import '../../../view_model/guarantor_form_view_model.dart';
import 'bottom_sheet/bottom_sheet_if_no.dart';
import 'bottom_sheet/guarantor_bottom_sheet.dart';
import 'dialog/form_completed_dialog.dart';

class GuarantorDetails extends ConsumerStatefulWidget {
  const GuarantorDetails({super.key});

  @override
  _GuarantorDetails createState() => _GuarantorDetails();
}

class _GuarantorDetails extends ConsumerState<GuarantorDetails> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // if (ref.watch(paymentProvider).status == 'success') {
    //   FormSubmitDialog().formSubmitDialog(context: context);
    // }
  }

  // const GuarantorDetails({super.key});
  // FormSubmitDialog().formSubmitDialog(context: context);
  @override
  Widget build(BuildContext context) {
    //----------------controller-------------------------------------------------------
    final formListController = ref.watch(guarantorController);
    final formNotifierController = ref.read(guarantorController.notifier);
//---------------------------------------------------------------------------------
//     final isPanIconChange = ref.watch(isGuarantorPanLoading);
//     final colorChangeState = ref.watch(isGuarantorTickColorChange);
//     final upload = ref.watch(uploadGuarantorDoc);
//     // final checkBoxTerms = ref.watch(checkBoxTermsConditionGuarantor);
//     final selectedValue = ref.watch(guarantorRoleProvider);
    final paymentViewModel = ref.read(paymentProvider(context).notifier);
    final getMobileNo = ref.watch(personalDetailViewModelProvider);
    final personalFormState = ref.watch(guarantorViewModelProvider);
    final personalFormViewModel = ref.read(guarantorViewModelProvider.notifier);
    final personalFocusStates = ref.watch(guarantorFocusProvider);
    // final isRemember = ref.watch(guarantorRememberProvider);
    final personalFocusViewModel = ref.read(guarantorFocusProvider.notifier);

    return Scaffold(
        backgroundColor: AppColors.white,
        body: Container(
          color: AppColors.primary,
          padding: const EdgeInsets.only(top: 100),
          child: Container(
            height: displayHeight(context),
            padding: const EdgeInsets.all(20),
            decoration: const BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30))),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const BackButton(),
                    const Text(
                      textAlign: TextAlign.center,
                      'Guarantor Details',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(
                      width: displayWidth(context) * 0.10,
                    )
                  ],
                ),
                SizedBox(
                  height: displayHeight(context) * 0.01,
                ),
                Expanded(
                  child: SingleChildScrollView(
                    physics: const AlwaysScrollableScrollPhysics(),
                    child: Wrap(
                        runSpacing: displayHeight(context) * 0.04,
                        children: [
                          GestureDetector(
                            onTap: () {
                              personalFormViewModel.pickImages();
                            },
                            child: Visibility(
                              visible:
                                  personalFormState.applicantPhotoFilePath ==
                                      '',
                              replacement: SizedBox(
                                height: displayHeight(context) * 0.16,
                                width: displayWidth(context),
                                child: Image.file(File(
                                    personalFormState.applicantPhotoFilePath)),
                              ),
                              child: UploadBox(
                                isImage: true,
                                height: displayHeight(context) * 0.16,
                                width: displayWidth(context),
                                color: AppColors.buttonBorderGray,
                                iconData: Icons.file_upload_outlined,
                                textColor: AppColors.gray5,
                                subTextColor: AppColors.primary,
                                title: 'Support: JPG, PNG',
                                subTitle: 'Click Applicant Image',
                              ),
                            ),
                          ),
                          SizedBox(
                            height: displayHeight(context) * 0.04,
                          ),
                          Column(
                            // mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Customer Mobile No. Is Must Be Linked With Aadhaar.',
                                maxLines: 2,
                              ),
                              // SizedBox(
                              //   width: MediaQuery.of(context).size.width * 0.30,
                              //   child: Row(
                              //     children: [
                              //       Radio<GuarantorOptionRole>(
                              //         value: GuarantorOptionRole.Yes,
                              //         groupValue: selectedValue,
                              //         onChanged: (value) {
                              //           if (value != null) {
                              //             ref
                              //                 .read(guarantorRoleProvider
                              //                     .notifier)
                              //                 .select(value);
                              //           }
                              //           showBottomSheetIfYes(
                              //             context: context,
                              //             ref: ref,
                              //           );
                              //         },
                              //       ),
                              //       const Text(
                              //         'Yes',
                              //       )
                              //     ],
                              //   ),
                              // ),
                              //
                              // SizedBox(
                              //   width: MediaQuery.of(context).size.width * 0.30,
                              //   child: Row(
                              //     children: [
                              //       Radio<GuarantorOptionRole>(
                              //         value: GuarantorOptionRole.NO,
                              //         groupValue: selectedValue,
                              //         onChanged: (value) {
                              //           if (value != null) {
                              //             ref
                              //                 .read(guarantorRoleProvider.notifier)
                              //                 .select(value);
                              //           }
                              //           showBottomSheetIfNo(
                              //             context: context,
                              //             ref: ref,
                              //           );
                              //         },
                              //       ),
                              //       const Text(
                              //         'No',
                              //       )
                              //     ],
                              //   ),
                              // ),
                              SizedBox(
                                height: displayHeight(context) * 0.02,
                              ),
                              AppFloatTextField(
                                focusNode:
                                    personalFocusViewModel.aadhaarFocusNode,
                                currentState:
                                    personalFocusStates['aadhaarFocusNode'],
                                onChange: (value) {
                                  personalFormViewModel.updateAadhar(value);
                                },
                                // height: !personalFocusStates.isAadhaarValid
                                //     ? displayHeight(context) * 0.09
                                //     : null,
                                inerHint: 'Enter Aadhaar Number',
                                errorText: "Aadhaar Number is a required field",
                                // isError: !applicantFormState.isAadhaarValid,
                                textInputAction: TextInputAction.done,
                              ),
                              SizedBox(
                                height: displayHeight(context) * 0.02,
                              ),
                              AppFloatTextField(
                                width: displayWidth(context),
                                focusNode: personalFocusViewModel.panFocusNode,
                                currentState:
                                    personalFocusStates['panFocusNode'],
                                controller: formListController.panController,
                                onChange: (value) {
                                  personalFormViewModel.updatePan(value);
                                },
                                height: !personalFormState.isPanValid
                                    ? displayHeight(context) * 0.09
                                    : null,
                                inerHint: 'Pan',
                                errorText: "Pan is a required field",
                                isError: !personalFormState.isPanValid,
                                textInputAction: TextInputAction.next,
                              ),
                              SizedBox(
                                height: displayHeight(context) * 0.02,
                              ),
                              Row(
                                children: [
                                  Checkbox(
                                    side: const BorderSide(
                                        color: AppColors.boxBorderGray,
                                        width: 1.5),
                                    // semanticLabel: 'jkdhsjk',
                                    value: personalFormState
                                        .checkBoxTermsConditionGuarantor,
                                    onChanged: (value) {
                                      if (value != null) {
                                        personalFormViewModel
                                            .updateCheckBox(value);
                                        // ref
                                        //     .read(
                                        //         checkBoxTermsConditionApplicant
                                        //             .notifier)
                                        //     .state = value;
                                      }
                                    },
                                  ),
                                  SizedBox(
                                      width: displayWidth(context) * 0.68,
                                      child: Text(
                                        'I have read the Terms and Conditions and give my consent for the same.',
                                        style: AppStyles.termsConditionText,
                                      )),
                                ],
                              ),
                              personalFormState.isLoading
                                  ? const Center(
                                      child: CircularProgressIndicator())
                                  : AppButton(
                                      textStyle: const TextStyle(
                                          color: AppColors.white),
                                      onTap: () {
                                        bool isValid = personalFormViewModel
                                            .validateForm();
                                        if (isValid) {
                                          personalFormViewModel
                                              .fetchAadhaarNumber(context)
                                              .then(
                                            (value) {
                                              showBottomSheetIfYes(
                                                context: context,
                                                ref: ref,
                                              );
                                            },
                                          );
                                        }
                                      },
                                      label: 'Get OTP',
                                      width: displayWidth(context),
                                    ),
                              Center(
                                child: TextButton(
                                  child: Text(
                                    'Skip',
                                    style: AppStyles.nameText.copyWith(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w600),
                                  ),
                                  onPressed: () async {
                                    String? paymentMode = await SessionService.getPaymentMode();
                                    if(paymentMode=='Razorpay'){

                                      personalFormViewModel
                                          .paymentInitiate()
                                          .then(
                                            (value) {
                                          if (kDebugMode) {
                                            print(getMobileNo.phoneNumber);
                                          }
                                          if (value.items.customerDetail
                                              .loginFees !=
                                              0) {
                                            paymentViewModel.payWithRazorPay(
                                                amount: value.items.customerDetail
                                                    .loginFees,
                                                mobile: getMobileNo.phoneNumber,
                                                orderId: value.items
                                                    .customerDetail.orderId);
                                            // FormSubmitDialog().formSubmitDialog(
                                            //     context: context);
                                          } else {
                                            FormSubmitDialog().formSubmitDialog(
                                                context: context);
                                          }
                                        },
                                      );

                                    }else {

                                      personalFormViewModel
                                          .paymentInitiate()
                                          .then(
                                            (value) {
                                          if (kDebugMode) {
                                            print(getMobileNo.phoneNumber);
                                          }
                                          if (value.items.customerDetail
                                              .loginFees !=
                                              0) {
                                            paymentViewModel.payWithRazorPay(
                                                amount: value.items.customerDetail
                                                    .loginFees,
                                                mobile: getMobileNo.phoneNumber,
                                                orderId: value.items
                                                    .customerDetail.orderId);
                                            // FormSubmitDialog().formSubmitDialog(
                                            //     context: context);
                                          } else {
                                            FormSubmitDialog().formSubmitDialog(
                                                context: context);
                                          }
                                        },
                                      );

                                    }

                                  },

                                 /* onPressed: () async {
                                    String? paymentMode = await SessionService.getPaymentMode();
                                    personalFormViewModel
                                        .paymentInitiate()
                                        .then(
                                          (value) {
                                        if (kDebugMode) {
                                          print(getMobileNo.phoneNumber);
                                        }
                                        if (value.items.customerDetail
                                            .loginFees !=
                                            0) {
                                          paymentViewModel.payWithRazorPay(
                                              amount: value.items.customerDetail
                                                  .loginFees,
                                              mobile: getMobileNo.phoneNumber,
                                              orderId: value.items
                                                  .customerDetail.orderId);
                                          // FormSubmitDialog().formSubmitDialog(
                                          //     context: context);
                                        } else {
                                          FormSubmitDialog().formSubmitDialog(
                                              context: context);
                                        }
                                      },
                                    );
                                  },*/


                                ),
                              )



                            ],
                          ),
                        ]),
                  ),
                )
              ],
            ),
          ),
        ));
  }

  Widget aadhaarLinkRadios(
      {required BuildContext context,
      required GuarantorOptionRole selectedValue,
      required WidgetRef ref,
      required String title,
      required GuarantorOptionRole value}) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.30,
      child: Row(
        children: [
          Radio<GuarantorOptionRole>(
            value: value,
            groupValue: selectedValue,
            onChanged: (value) {
              if (value != null) {
                ref.read(guarantorRoleProvider.notifier).select(value);
              }
            },
          ),
          Text(
            title,
          )
        ],
      ),
    );
  }

  // Widget ifYesLinkedAadhaar(
  //     {required WidgetRef ref,
  //     required BuildContext context,
  //     // required TextEditingController aadhaarController,
  //     required formState,
  //     required formViewModel,
  //     required Map<String, bool> aadhaarFocusStates,
  //     required aadhaarFocusViewModel,
  //     required bool checkBoxTerms}) {
  //   return Container(
  //     padding: const EdgeInsets.only(left: 16, right: 16, top: 30, bottom: 16),
  //     decoration: BoxDecoration(
  //       border: Border.all(color: AppColors.boxBorderGray),
  //       borderRadius: const BorderRadius.all(Radius.circular(10)),
  //     ),
  //     width: displayWidth(context),
  //     child: Column(
  //       children: [
  //         // const Text('Aadhar Number'),
  //         AppFloatTextField(
  //           focusNode: aadhaarFocusViewModel.aadhaarFocusNode,
  //           currentState: aadhaarFocusStates['aadhaarFocusNode'],
  //           // controller: aadhaarController,
  //           onChange: (value) {
  //             formViewModel.updateAadhaar(value);
  //           },
  //           height: !formState.isAadhaarValid
  //               ? displayHeight(context) * 0.09
  //               : null,
  //           inerHint: 'Enter Aadhaar Number',
  //           errorText: "Aadhaar Number is a required field",
  //           isError: !formState.isAadhaarValid,
  //           textInputAction: TextInputAction.done,
  //           // hint: 'Password',
  //         ),
  //         Row(
  //           children: [
  //             Checkbox(
  //               side: const BorderSide(
  //                   color: AppColors.boxBorderGray, width: 1.5),
  //               // semanticLabel: 'jkdhsjk',
  //               value: checkBoxTerms,
  //               onChanged: (value) {
  //
  //                 if (value != null) {
  //                   ref.read(checkBoxTermsConditionGuarantor.notifier).state =
  //                       value;
  //                 }
  //               },
  //             ),
  //             SizedBox(
  //                 width: displayWidth(context) * 0.68,
  //                 child: Text(
  //                   'I have read the Terms and Conditions and give my consent for the same.',
  //                   style: AppStyles.termsConditionText,
  //                 )),
  //           ],
  //         ),
  //         Align(
  //           alignment: Alignment.centerRight,
  //           child: TextButton(onPressed: () {}, child: const Text('Get OTP')),
  //         )
  //       ],
  //     ),
  //   );
  // }

  Future<void> showBottomSheetIfYes({
    required WidgetRef ref,
    required BuildContext context,
  }) {
    return showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(10.0), topRight: Radius.circular(10.0)),
      ),
      builder: (ctx) {
        return const GuarantorBottomSheet();
      },
    );
  }

  Future<void> showBottomSheetIfNo({
    required WidgetRef ref,
    required BuildContext context,
  }) {
    return showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(10.0), topRight: Radius.circular(10.0)),
      ),
      builder: (ctx) {
        return const GuarantorPhotoBottomSheet();
      },
    );
  }

  Widget commonText(
      {required BuildContext context,
      required String heading,
      required String value}) {
    return SizedBox(
      width: displayWidth(context),
      child: Row(
        children: [
          SizedBox(width: displayWidth(context) * 0.30, child: Text(heading)),
          SizedBox(
              width: displayWidth(context) * 0.50,
              child: Text(
                value,
                maxLines: 4,
              ))
        ],
      ),
    );
  }
}
