import 'package:finexe/feature/base/utils/namespase/app_colors.dart';
import 'package:finexe/feature/base/utils/namespase/app_style.dart';
import 'package:finexe/feature/base/utils/namespase/display_size.dart';
import 'package:finexe/feature/ui/PD/Common%20Widgets/common_textfield.dart';
import 'package:finexe/feature/ui/PD/view/PD%20Form/pd_fromfilds.dart/view_model.dart/bankdetails_view_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class BankDetailsForm extends ConsumerStatefulWidget {
  const BankDetailsForm({super.key});

  @override
  ConsumerState<BankDetailsForm> createState() => _BankDetailsFormState();
}

class _BankDetailsFormState extends ConsumerState<BankDetailsForm> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController bankdetailsform_busstypeController =
      TextEditingController();
  final TextEditingController bankdetailsform_banknameController =
      TextEditingController();
  final TextEditingController bankdetailsform_branchController =
      TextEditingController();
  final TextEditingController bankdetailsform_accountnumberController =
      TextEditingController();
  final TextEditingController bankdetailsform_accountholdernameController =
      TextEditingController();
  final TextEditingController bankdetailsform_accounttypeController =
      TextEditingController();
  final TextEditingController bankdetailsform_ifscCodeController =
      TextEditingController();

  @override
  void dispose() {
    bankdetailsform_busstypeController.dispose();
    bankdetailsform_accountholdernameController.dispose();
    bankdetailsform_accountnumberController.dispose();
    bankdetailsform_banknameController.dispose();
    bankdetailsform_branchController.dispose();
    bankdetailsform_ifscCodeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bankDetails = ref.watch(bankdetailsDetailsProvider);
    final appState = ref.watch(pdsubmitbankdetailsProvider);
    return bankDetails.when(
      data: (bankData) {
        if (bankdetailsform_branchController.text.isEmpty) {
          bankdetailsform_branchController.text = bankData.branchName ?? '';
          bankdetailsform_accountholdernameController.text =
              bankData.accountHolderName ?? '';
          bankdetailsform_accounttypeController.text =
              bankData.accountType ?? '';
          bankdetailsform_accountnumberController.text =
              bankData.accountNo ?? '';
          bankdetailsform_banknameController.text = bankData.nameOfBank ?? '';
          bankdetailsform_ifscCodeController.text = bankData.iFSCCode ?? '';
        }
        return ExpansionTile(
          childrenPadding: const EdgeInsets.only(left: 16, bottom: 10),
          shape: const Border(
            bottom: BorderSide(color: AppColors.dividerColor),
          ),
          title: const Text('Bank Details'),
          children: <Widget>[
            Form(
                key: _formKey,
                child: Column(
                  children: [
                    // Container(
                    //   alignment: Alignment.centerLeft,
                    //   child: Text(
                    //     'Business and Banking Information',
                    //     textAlign: TextAlign.left,
                    //   ),
                    // ),
                    // constSizedbox(context),
                    Padding(
                      padding: const EdgeInsets.only(right: 15),
                      child: CustomTextFormField(
                        // onChange: (value) {
                        //   log("coappvalidate " + coappvalidate.toString());
                        //   ref.read(coappvalidation.notifier).checkUsername(
                        //       coppApplicantForm2_coapplicantController);
                        // },
                        // initialValue: 'dfgbfgbnx',
                        //  focusNode: focusViewModel.userFocusNode,
                        // currentState: focusStates['userFocusNode'],
                        // isError: coappvalidate,
                        inerHint: 'IFSC Code',
                        //  height: coappvalidate ? displayHeight(context) * 0.09 : null,
                        // onFiledSubmitted: (value) {
                        //   ref
                        //       .read(coappvalidation.notifier)
                        //       .checkUsername(value.toString());
                        // },
                        onValidate: (value) {
                          print('Co - Applicant Type: ${value}');
                          if (value!.trim().isEmpty) {
                            return "This is a required field";
                          }
                          return null;
                        },
                        //  errorText: "username is a required field",
                        // isError: coappvalidate,
                        controller: bankdetailsform_ifscCodeController,
                        textInputAction: TextInputAction.next,
                      ),
                    ),
                    constSizedbox(context),
                    Padding(
                      padding: const EdgeInsets.only(right: 15),
                      child: CustomTextFormField(
                        // width: displayWidth(context) * 0.8,
                        inerHint: 'Bank Name',
                        onValidate: (value) {
                          print(value);
                          if (value!.trim().isEmpty) {
                            return "This is a required field";
                          }
                          return null;
                        },
                        controller: bankdetailsform_banknameController,
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
                            inerHint: 'Branch',
                            onValidate: (value) {
                              print(value);
                              if (value!.trim().isEmpty) {
                                return "Enter your bank branch";
                              }
                              return null;
                            },
                            controller: bankdetailsform_branchController,
                            textInputAction: TextInputAction.next,
                          );
                        },
                      ),
                    ),
                    constSizedbox(context),
                    // Container(
                    //   alignment: Alignment.centerLeft,
                    //   child: Text(
                    //     'Account Details',
                    //     textAlign: TextAlign.left,
                    //   ),
                    // ),
                    // constSizedbox(context),
                    Padding(
                      padding: const EdgeInsets.only(right: 15),
                      child: CustomTextFormField(
                        // initialValue: 'dfgbfgbnx',
                        //  focusNode: focusViewModel.userFocusNode,
                        // currentState: focusStates['userFocusNode'],
                        textInputType: TextInputType.number,
                        inerHint: 'Account No',
                        //  height: coappvalidate ? displayHeight(context) * 0.09 : null,
                        // onFiledSubmitted: (value) {
                        //   ref
                        //       .read(coappvalidation.notifier)
                        //       .checkUsername(value.toString());
                        // },
                        onValidate: (value) {
                          print(value);
                          if (value!.trim().isEmpty) {
                            return "Please enter your account number";
                          }
                          return null;
                        },
                        //  errorText: "username is a required field",
                        // isError: coappvalidate,
                        controller: bankdetailsform_accountnumberController,
                        textInputAction: TextInputAction.next,
                      ),
                    ),
                    constSizedbox(context),
                    Padding(
                      padding: const EdgeInsets.only(right: 15),
                      child: CustomTextFormField(
                        width: displayWidth(context) * 0.8,
                        inerHint: 'Account Holder Name',
                        onValidate: (value) {
                          print(value);
                          if (value!.trim().isEmpty) {
                            return "It is a required field";
                          }
                          return null;
                        },
                        controller: bankdetailsform_accountholdernameController,
                        textInputAction: TextInputAction.next,
                      ),
                    ),
                    constSizedbox(context),
                    Padding(
                      padding: const EdgeInsets.only(right: 15),
                      child: CustomTextFormField(
                        width: displayWidth(context) * 0.8,
                        inerHint: 'Account Type',
                        onValidate: (value) {
                          print(value);
                          if (value!.trim().isEmpty) {
                            return "Please Enter account type";
                          }
                          return null;
                        },
                        controller: bankdetailsform_accounttypeController,
                        textInputAction: TextInputAction.next,
                      ),
                    ),
                    constSizedbox(context),
                    ElevatedButton(
                      onPressed: () {
                        // if (_formKey.currentState!.validate()) {
                        //   ScaffoldMessenger.of(context).showSnackBar(
                        //     SnackBar(
                        //         backgroundColor: AppColors.green,
                        //         content: Text(
                        //           'Form submitted successfully!',
                        //           style: AppStyles.whiteText16,
                        //         )),
                        //   );
                        // } else {
                        //   ScaffoldMessenger.of(context).showSnackBar(
                        //     SnackBar(
                        //         backgroundColor: AppColors.red,
                        //         content: Text(
                        //           'Please fill all requred details!',
                        //           style: AppStyles.whiteText16,
                        //         )),
                        //   );
                        // }
                        ref
                            .read(pdsubmitbankdetailsProvider.notifier)
                            .submitpdBankDetailsForm(
                                customerId: '66f53ffbd7011eb65160f292',
                                pdType: 'creditPd',
                                accountholerdName:
                                    bankdetailsform_accountholdernameController
                                        .text,
                                accountno:
                                    bankdetailsform_accountnumberController
                                        .text,
                                accounttype:
                                    bankdetailsform_accounttypeController.text,
                                ifscCode:
                                    bankdetailsform_ifscCodeController.text,
                                branch: bankdetailsform_branchController.text,
                                nameofBank:
                                    bankdetailsform_banknameController.text)
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
                              style: TextStyle(color: Colors.white),
                            ),
                    )
                  ],
                ))
          ],
        );
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, stackTrace) => Center(child: Text('Error: $error')),
    );
  }

  constSizedbox(BuildContext context) {
    return SizedBox(
      height: displayHeight(context) * 0.02,
    );
  }
}
