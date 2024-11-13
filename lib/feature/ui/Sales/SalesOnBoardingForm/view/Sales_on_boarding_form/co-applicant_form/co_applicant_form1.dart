import 'dart:io';

import 'package:dropdown_textfield/dropdown_textfield.dart';
import 'package:finexe/feature/base/routes/routes.dart';

import 'package:finexe/feature/ui/Sales/SalesOnBoardingForm/view/Sales_on_boarding_form/co-applicant_form/bottom_sheet/co_applicant_if_no_bottom_sheet.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../../../base/utils/namespase/app_colors.dart';
import '../../../../../../base/utils/namespase/app_style.dart';
import '../../../../../../base/utils/namespase/display_size.dart';
import '../../../../../../base/utils/namespase/font_size.dart';
import '../../../../../../base/utils/widget/app_button.dart';
import '../../../../../../base/utils/widget/app_text_filed_login.dart';
import '../../../../../../base/utils/widget/upload_box.dart';
import '../../../view_model/co_applicant_form_view_model.dart';
import 'bottom_sheet/co_applicant_bottom_sheet.dart';
import 'co_applicant_form3.dart';

class CoApplicantForm1 extends ConsumerWidget {
  const CoApplicantForm1({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
//----------------controller-------------------------------------------------------
    final formListController = ref.watch(coApplicantController);
    final formNotifierController = ref.read(coApplicantController.notifier);
//---------------------------------------------------------------------------------
    final isPanIconChange = ref.watch(isCoPanLoading);
    final colorChangeState = ref.watch(isCoTickColorChange);
    final uploadCoDocs = ref.watch(uploadCoDoc);
    // final checkBoxTerms = ref.watch(checkBoxTermsConditionCoApplicant);
    final selectedValue = ref.watch(coApplicantRoleProvider);

    final coApplicationFormState = ref.watch(coApplicantViewModelProvider);
    final coApplicationFormViewModel =
        ref.read(coApplicantViewModelProvider.notifier);
    final coApplicationFocusStates = ref.watch(coApplicantFocusProvider);
    final isCoApplicationRemember = ref.watch(rememberCoProvider);
    final coApplicationFocusViewModel =
        ref.read(coApplicantFocusProvider.notifier);
    final index = ref.watch(listIndex);
    final indexAdd = ref.watch(listIndex.notifier);
    // final removeScreen = ref.watch(count);
    // final remove = ref.read(count.notifier);

    return Scaffold(
        body:
        Container(
      width: displayWidth(context),
      height: displayHeight(context),
      color: AppColors.primary,
      padding: const EdgeInsets.only(top: 100),
      child: Container(
        height: displayHeight(context),
        padding: const EdgeInsets.all(20),
        decoration: const BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30), topRight: Radius.circular(30))),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                BackButton(
                  onPressed: () {
                    print(index);
                    if (index != 0) {
                      ref.read(listIndex.notifier).state = index - 1;
                      ref.read(pageViewModelProvider.notifier).setTabIndex(0);
                    } else {
                      Navigator.pop(context);
                    }
                  },
                ),
                const Text(
                  textAlign: TextAlign.center,
                  'Co-Applicant Details',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(
                  height: displayHeight(context) * 0.06,
                  width: displayWidth(context) * 0.10,
                )
                // Visibility(
                //   replacement:SizedBox(
                //     width: displayWidth(context) * 0.10,
                //   ),
                //   visible: index>0,
                //   child: IconButton(onPressed: () {
                //     coApplicationFormViewModel.removeItem(index);
                //   }, icon: Icon(Icons.delete))
                // )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Visibility(
                    visible: index > 0,
                    child: Text(
                      'CoApplicant $index',
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                      ),
                    )),
                Visibility(
                    replacement: SizedBox(
                      width: displayWidth(context) * 0.10,
                    ),
                    visible: index > 0,
                    child: IconButton(
                        onPressed: () {
                          coApplicationFormViewModel.removeItem(index);
                          formNotifierController.removeFormData(index);
                          ref.read(listIndex.notifier).state = index - 1;
                        },
                        icon: const Icon(Icons.delete)))
              ],
            ),
            SizedBox(
              height: displayHeight(context) * 0.01,
            ),
            Expanded(
              child: SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                child: Wrap(
                  crossAxisAlignment: WrapCrossAlignment.center,
                  verticalDirection: VerticalDirection.down,
                  runSpacing: displayHeight(context) * 0.04,
                  clipBehavior: Clip.none,
                  // verticalDirection: VerticalDirection.down,
                  // runAlignment: WrapAlignment.center,
                  // alignment: WrapAlignment.center,
                  // direction: Axis.vertical,
                  children: [
                    GestureDetector(
                      onTap: () {
                        coApplicationFormViewModel.pickImages(index);
                      },
                      child: Visibility(
                        visible: coApplicationFormState[index]
                                .applicantPhotoFilePath ==
                            '',
                        replacement: SizedBox(
                          height: displayHeight(context) * 0.16,
                          width: displayWidth(context),
                          child: Image.file(File(coApplicationFormState[index]
                              .applicantPhotoFilePath)),
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
                        //       Radio<CoApplicantOptionRole>(
                        //         value: CoApplicantOptionRole.NO,
                        //         groupValue: selectedValue,
                        //         onChanged: (value) {
                        //           if (value != null) {
                        //             ref
                        //                 .read(coApplicantRoleProvider.notifier)
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
                        // SizedBox(
                        //   width: MediaQuery.of(context).size.width * 0.30,
                        //   child: Row(
                        //     children: [
                        //       Radio<CoApplicantOptionRole>(
                        //         value: CoApplicantOptionRole.Yes,
                        //         groupValue: selectedValue,
                        //         onChanged: (value) {
                        //           if (value != null) {
                        //             ref
                        //                 .read(coApplicantRoleProvider.notifier)
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
                        // aadhaarLinkRadios(
                        //     context: context,
                        //     title: 'No',
                        //     value: CoApplicantOptionRole.NO,
                        //     ref: ref,
                        //     selectedValue: selectedValue,
                        //     checkBoxTerms: checkBoxTerms,
                        //     aadhaarFocusStates: aadhaarFocusStates,
                        //     formState: applicantFormState,
                        //     formViewModel: applicantFormViewModel,
                        //     aadhaarFocusViewModel: aadhaarFocusViewModel),

                        // SizedBox(
                        //   height: displayHeight(context) * 0.03,
                        // ),
                        SizedBox(
                          height: displayHeight(context) * 0.02,
                        ),
                        Column(
                          children: [
                            AppFloatTextField(
                              controller:
                                  formListController[index].aadhaarController,
                              focusNode:
                                  coApplicationFocusViewModel.aadhaarFocusNode,
                              currentState:
                                  coApplicationFocusStates['aadhaarFocusNode'],
                              onChange: (value) {
                                coApplicationFormViewModel.updateAadhaar(
                                    value, index);
                              },
                              height:
                                  !coApplicationFormState[index].isAadhaarValid
                                      ? displayHeight(context) * 0.09
                                      : null,
                              inerHint: 'Enter Aadhaar Number',
                              errorText: "Aadhaar Number is a required field",
                              isError:
                                  !coApplicationFormState[index].isAadhaarValid,
                              textInputAction: TextInputAction.done,
                            ),

                            // Align(
                            //   alignment: Alignment.centerRight,
                            //   child: TextButton(
                            //       onPressed: () {
                            //
                            //       },
                            //       child: const Text('Get OTP',style: TextStyle(color: AppColors.white),)),
                            // )
                          ],
                        ),
                        SizedBox(
                          height: displayHeight(context) * 0.02,
                        ),
                        DropDownTextField(
                          textStyle: const TextStyle(fontSize: 12),
                          controller:
                              coApplicationFormViewModel.dropDownController,
                          // initialValue: "name4",
                          listSpace: 20,
                          listPadding: ListPadding(top: 20),
                          enableSearch: false,
                          dropDownList: const [
                            DropDownValueModel(
                                name: 'PAN Card', value: "PANCard"),
                            DropDownValueModel(
                                name: 'Driving License',
                                value: "DrivingLicense"),
                            DropDownValueModel(
                                name: 'VoterId', value: "VoterId"),
                          ],
                          listTextStyle:
                              const TextStyle(color: AppColors.primary),
                          dropDownItemCount: 3,
                          onChanged: (val) {
                            // formViewModel.updateKycDoc(val);
                          },
                          clearOption: false,
                          textFieldFocusNode:
                              coApplicationFocusViewModel.kycDocFocusNode,
                          textFieldDecoration: InputDecoration(
                            hintStyle:
                                const TextStyle(color: AppColors.textGray),
                            floatingLabelStyle:
                                coApplicationFocusStates['kycDocFocusNode']!
                                    ? AppStyles.subHeading
                                        .copyWith(color: AppColors.primary)
                                    : AppStyles.subHeading,
                            label: const Text(
                              'Kyc Document',
                              style: const TextStyle(
                                  color: AppColors.boxBorderGray),
                            ),

                            // errorText: isError! ? errorText : null,
                            enabledBorder: const OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: AppColors.gray, width: 1),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10))),
                            // filled: true,
                            // fillColor: AppColors.gray,
                            border: const OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: AppColors.gray, width: 2),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                            ),

                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: !coApplicationFormState[index]
                                            .isKycValid
                                        ? Colors.red
                                        : Colors.blue,
                                    width: 2),
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(10))),
                            // ),
                            // focusedErrorBorder: isError!
                            //     ? const OutlineInputBorder(
                            //     borderRadius: BorderRadius.all(Radius.circular(10)),
                            //     borderSide: BorderSide(color: Colors.red, width: 2))
                            //     : null       borderRadius: const BorderRadius.all(Radius.circular(10)),
                          ),
                        ),
                        SizedBox(
                          height: displayHeight(context) * 0.02,
                        ),
                        AppFloatTextField(
                          width: displayWidth(context),
                          focusNode: coApplicationFocusViewModel.panFocusNode,
                          currentState:
                              coApplicationFocusStates['panFocusNode'],
                          // controller: contactController,
                          onChange: (value) {
                            coApplicationFormViewModel.updatePan(value, index);
                            print(coApplicationFormState[index].pan);
                          },
                          controller: formListController[index].panController,
                          height: !coApplicationFormState[index].isPanValid
                              ? displayHeight(context) * 0.09
                              : null,
                          inerHint: coApplicationFormViewModel
                                      .dropDownController
                                      .dropDownValue
                                      ?.value ==
                                  'PANCard'
                              ? 'Pan'
                              : coApplicationFormViewModel.dropDownController
                                          .dropDownValue?.value ==
                                      'DrivingLicense'
                                  ? 'Driving License'
                                  : 'VoterId',
                          errorText: "Pan is a required field",
                          isError: !coApplicationFormState[index].isPanValid,
                          textInputAction: TextInputAction.next,
                        ),

                        Row(
                          children: [
                            Checkbox(
                              side: const BorderSide(
                                  color: AppColors.boxBorderGray, width: 1.5),
                              value: coApplicationFormState[index]
                                  .checkBoxTermsConditionCoApplicant,
                              onChanged: (value) {
                                if (value != null) {
                                  coApplicationFormViewModel.updateCheckBox(
                                      value, index);
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
                        SizedBox(
                          height: displayHeight(context) * 0.02,
                        ),
                        InkWell(
                          onTap: () {
                            indexAdd.state = index + 1;
                            coApplicationFormViewModel.addForm();
                            formNotifierController.addFormData();
                            // coAddressRadioViewModel
                            //     .selectAddress(CoApplicantOptionRole.NON);
                            if (kDebugMode) {
                              print(coApplicationFormState.length);
                            }
                            if (kDebugMode) {
                              print(coApplicationFormState.toList());
                            }
                            ref
                                .read(pageViewModelProvider.notifier)
                                .setTabIndex(0);
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              const Icon(
                                Icons.add,
                              ),
                              SizedBox(
                                width: displayWidth(context) * 0.01,
                              ),
                              const Text('Add   co-applicant')
                            ],
                          ),
                        ),
                        SizedBox(
                          height: displayHeight(context) * 0.02,
                        ),
                        coApplicationFormState[index].isLoading?const CircularProgressIndicator():AppButton(
                          textStyle: const TextStyle(color: AppColors.white),
                          onTap: () {
                            // showBottomSheetIfYes(
                            //   context: context,
                            //   ref: ref,
                            // );
                            bool isValid =  coApplicationFormViewModel.validateCoApplicant(index);
                            if(isValid){
                              coApplicationFormViewModel
                                  .fetchAadhaarNumber(index)
                                  .then(
                                    (value) {
                                  showBottomSheetIfYes(
                                    context: context,
                                    ref: ref,
                                  );
                                  ref.read(getOptCoApp.notifier).state = value;
                                },
                              );
                            }
                          },
                          label: 'Get OTP',
                          width: displayWidth(context),
                        ),
                        Visibility(
                          visible: index < coApplicationFormState.length - 1,
                          child: AppButton(
                            textStyle: const TextStyle(color: AppColors.white),
                            width: displayWidth(context),
                            label: index < coApplicationFormState.length - 1
                                ? 'Next'
                                : 'Done',
                            onTap: () {
                              if (index < coApplicationFormState.length - 1) {
                                print(coApplicationFormState.length);
                                print(
                                    "$index < ${coApplicationFormState.length - 1}");
                                indexAdd.state = index + 1;
                                // Navigator.of(context).push(
                                //     MaterialPageRoute(
                                //         builder: (context) =>
                                //             const CoApplicantForm1()));
                              } else {
                                Navigator.pushNamed(
                                    context, AppRoutes.saleGuarantorForm1);
                              }

                              // ref
                              //     .read(pageViewModelProvider.notifier)
                              //     .setTabIndex(1);
                              // print(remove.state);
                              // remove.state = removeScreen + 1;
                              // Navigator.of(context).push(MaterialPageRoute(
                              //     builder: (context) =>
                              //         const CoApplicantForm3()));
                              // Navigator.pushNamed(
                              //     context, AppRoutes.saleCoApplicationForm3);
                            },
                          ),
                        ),
                        SizedBox(
                          height: displayHeight(context) * 0.01,
                        ),
                        // AppButton(
                        //   textStyle: const TextStyle(color: AppColors.white),
                        //   width: displayWidth(context),
                        //   label: 'Back',
                        //   onTap: () {},
                        // ),

                        // Row(
                        //   children: [
                        //     AppFloatTextField(
                        //       width: displayWidth(context) * 0.75,
                        //       focusNode: personalFocusViewModel.panFocusNode,
                        //       currentState: personalFocusStates['panFocusNode'],
                        //       // controller: licenseController,
                        //       onChange: (value) {
                        //         personalFormViewModel.updatePan(value);
                        //       },
                        //       height: !personalFormState.isPanValid
                        //           ? displayHeight(context) * 0.09
                        //           : null,
                        //       inerHint: 'Pan',
                        //       errorText: "Pan is a required field",
                        //       isError: !personalFormState.isPanValid,
                        //       textInputAction: TextInputAction.next,
                        //     ),
                        //     SizedBox(
                        //       width: displayWidth(context) * 0.01,
                        //     ),
                        //     Container(
                        //       color: AppColors.boxBagGray,
                        //       width: displayWidth(context) * 0.12,
                        //       child: IconButton(
                        //         icon: const Icon(Icons.check),
                        //         onPressed: () {},
                        //       ),
                        //     )
                        //   ],
                        // ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    ));
  }

  Widget aadhaarLinkRadios(
      {required BuildContext context,
      required CoApplicantOptionRole selectedValue,
      required WidgetRef ref,
      required String title,
      required value,
      required formState,
      required formViewModel,
      required Map<String, bool> aadhaarFocusStates,
      required aadhaarFocusViewModel,
      required bool checkBoxTerms}) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.30,
      child: Row(
        children: [
          Radio<CoApplicantOptionRole>(
            value: value,
            groupValue: selectedValue,
            onChanged: (value) {
              if (value != null) {
                ref.read(coApplicantRoleProvider.notifier).select(value);
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
  //       required BuildContext context,
  //       required AadhaarFormState formState,
  //       required FormViewModel formViewModel,
  //       required Map<String, bool> aadhaarFocusStates,
  //       required AadhaarFocusViewModel aadhaarFocusViewModel,
  //       required bool checkBoxTerms}) {
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
  //           textInputAction: TextInputAction.next,
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
  //                 if (value != null) {
  //                   ref.read(checkBoxTermsConditionApplicant.notifier).state =
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
  //           child: TextButton(
  //               onPressed: () {
  //                 ref.read(getOpt.notifier).state = true;
  //               },
  //               child: const Text('Get OTP')),
  //         )
  //       ],
  //     ),
  //   );
  // }

  Widget ifNoLinkedAadhaar(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              UploadBox(
                height: displayHeight(context) * 0.15,
                width: displayWidth(context) * 0.35,
                color: AppColors.buttonBorderGray,
                iconData: Icons.file_upload_outlined,
                textColor: AppColors.titleGray,
                subTextColor: AppColors.textDarkGray,
                title: 'Max size: 10MB',
                subTitle: 'Front Image',
              ),
              view(),
              UploadBox(
                height: displayHeight(context) * 0.15,
                width: displayWidth(context) * 0.35,
                color: AppColors.buttonBorderGray,
                iconData: Icons.file_upload_outlined,
                textColor: AppColors.titleGray,
                subTextColor: AppColors.textDarkGray,
                title: 'Max size: 10MB',
                subTitle: 'Front Image',
              ),
            ],
          ),
        ),
        SizedBox(
          height: displayHeight(context) * 0.05,
        ),
        AppButton(
          isFill: true,
          bgColor: AppColors.primaryLight,
          borderColor: AppColors.primary,
          onTap: () {},
          label: 'Confirm',
          textStyle: AppStyles.smallTextStyleRich.copyWith(
              fontSize: FontSize.fontSize16, fontWeight: FontWeight.w500),
          width: displayWidth(context),
          height: displayHeight(context) * 0.07,
        )
      ],
    );
  }

  Widget view() {
    return Column(
      children: [
        const Icon(
          Icons.remove_red_eye_outlined,
          color: AppColors.gray10,
        ),
        Text(
          'View',
          style: AppStyles.subTextStyle.copyWith(color: AppColors.gray10),
        )
      ],
    );
  }

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
        return const CoApplicationBottomSheet();
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
        return const CoApplicationPhotoBottomSheet();
      },
    );
  }
}

enum CoApplicantOptionRole { Yes, NO, NON }
