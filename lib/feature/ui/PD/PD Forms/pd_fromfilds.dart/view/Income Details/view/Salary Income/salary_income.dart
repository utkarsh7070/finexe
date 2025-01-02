// import 'package:finexe/feature/ui/PD/view/PD%20Form/pd_fromfilds.dart/pd_update_data/view/Income%20Details/view/Salary%20Income/salary_model/salary_income_model.dart';
// import 'package:finexe/feature/ui/PD/view/PD%20Form/pd_fromfilds.dart/pd_update_data/view/Income%20Details/view/Salary%20Income/salary_view_model.dart';
import 'package:finexe/feature/base/utils/namespase/app_colors.dart';
import 'package:finexe/feature/base/utils/namespase/app_style.dart';
import 'package:finexe/feature/ui/PD/Common%20Widgets/common_textfield.dart';
import 'package:finexe/feature/ui/PD/PD%20Forms/pd_fromfilds.dart/view/Income%20Details/view/Salary%20Income/salary_view_model.dart';
// import 'package:finexe/feature/ui/PD/view/PD%20Form/pd_fromfilds.dart/view/Income%20Details/view/Salary%20Income/salary_view_model.dart';
// import 'package:finexe/feature/ui/PD/view/common%20imagePicker/dynamic_listing_images.dart';
// import 'package:finexe/feature/ui/PD/view/common%20imagePicker/image_picker.dart';
import 'package:flutter/Material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../../common imagePicker/dynamic_listing_images.dart';
import '../../../../../../common imagePicker/image_picker.dart';
import 'salary_model/salary_income_model.dart';

// import '../../../../../../../../../../base/utils/namespase/app_colors.dart';
// import '../../../../../../../../../../base/utils/namespase/app_style.dart';
// import '../../../../../../../../Common Widgets/common_textfield.dart';

class Salaryincomedetail extends ConsumerStatefulWidget {
  // const Salaryincomedetail({super.key});
  final String customerId;
  Salaryincomedetail({required this.customerId});
  @override
  ConsumerState<Salaryincomedetail> createState() => _SalaryIncomeFormState();
}

class _SalaryIncomeFormState extends ConsumerState<Salaryincomedetail> {
  // Text editing controllers
  final TextEditingController SalaryincomeForm_CompanyName =
      TextEditingController();
  final TextEditingController SalaryincomeForm_AddressSalayProvider =
      TextEditingController();
  final TextEditingController SalaryincomeForm_MobileNo =
      TextEditingController();
  final TextEditingController SalaryincomeForm_FromNumberYear =
      TextEditingController();
  final TextEditingController SalaryincomeForm_SalaryPaid =
      TextEditingController();
  final TextEditingController SalaryincomeForm_MonthlySalary =
      TextEditingController();

  final _formKey = GlobalKey<FormState>();

  // Dispose controllers
  @override
  void dispose() {
    SalaryincomeForm_CompanyName.dispose();
    SalaryincomeForm_AddressSalayProvider.dispose();
    SalaryincomeForm_MobileNo.dispose();
    SalaryincomeForm_FromNumberYear.dispose();
    SalaryincomeForm_SalaryPaid.dispose();
    SalaryincomeForm_MonthlySalary.dispose();
    super.dispose();
  }

  String bankStatementUrl = '';
  @override
  Widget build(BuildContext context) {
    // final images = ref.watch(salaryImageUploadProvider); // Watch the image list state
    // final imageNotifier = ref.read(salaryImageUploadProvider.notifier);
    final viewModel = ref.read(salaryDetailsFormViewModelProvider);
    final fetchAsyncValue = ref.watch(salaryDetailsProvider(widget.customerId));
    final imageNotifier = ref.read(threemonthsimageUploadProvider.notifier);

    print("output for get ${fetchAsyncValue}");

    return fetchAsyncValue.when(
      loading: () =>
          Center(child: CircularProgressIndicator()), // Show loading indicator
      error: (error, stack) =>
          Center(child: Text('Error: $error')), // Show error message
      data: (salaryDetails) {
        // When data is loaded, populate the form
        if (SalaryincomeForm_AddressSalayProvider.text.isEmpty) {
          SalaryincomeForm_CompanyName.text = salaryDetails?.items?.data.companyName ?? '';
          SalaryincomeForm_AddressSalayProvider.text =
              salaryDetails?.items?.data.addressOfSalaryProvider ?? '';
          SalaryincomeForm_MobileNo.text =
              salaryDetails?.items?.data.mobNoOfSalaryProvider ?? '';
          SalaryincomeForm_FromNumberYear.text =
              salaryDetails?.items?.data.doingFromNoYears ?? '';
          SalaryincomeForm_SalaryPaid.text =
              salaryDetails?.items?.data.salaryPaidThrough ?? '';
          SalaryincomeForm_MonthlySalary.text =
              salaryDetails?.items?.data.monthlyNetSalary ?? '';
        }
        return SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 15),
                  child: CustomTextFormField(
                    inerHint: 'Company Name',
                    onValidate: (value) {
                      if (value?.trim().isEmpty ?? true) {
                        return "This is a required field";
                      }
                      return null;
                    },
                    controller: SalaryincomeForm_CompanyName,
                    textInputAction: TextInputAction.next,
                    textInputType: TextInputType.name,
                  ),
                ),
                sizedBoxWithContext(context, 0.03),

                Padding(
                  padding: const EdgeInsets.only(right: 15),
                  child: CustomTextFormField(
                    inerHint: 'Address of salary provider',
                    onValidate: (value) {
                      if (value?.trim().isEmpty ?? true) {
                        return "This is a required field";
                      }
                      return null;
                    },
                    controller: SalaryincomeForm_AddressSalayProvider,
                    textInputAction: TextInputAction.next,
                    textInputType: TextInputType.name,
                  ),
                ),
                sizedBoxWithContext(context, 0.03),

                Padding(
                  padding: const EdgeInsets.only(right: 15),
                  child: CustomTextFormField(
                    inerHint: 'Mobile no. of salary provider',
                    onValidate: (value) {
                      if (value?.trim().isEmpty ?? true) {
                        return "This is a required field";
                      }
                      return null;
                    },
                    controller: SalaryincomeForm_MobileNo,
                    textInputAction: TextInputAction.next,
                    textInputType: TextInputType.phone,
                  ),
                ),
                sizedBoxWithContext(context, 0.03),

                Padding(
                  padding: const EdgeInsets.only(right: 15),
                  child: CustomTextFormField(
                    inerHint: 'Doing from no. years',
                    onValidate: (value) {
                      if (value?.trim().isEmpty ?? true) {
                        return "This is a required field";
                      }
                      return null;
                    },
                    controller: SalaryincomeForm_FromNumberYear,
                    textInputAction: TextInputAction.next,
                    textInputType: TextInputType.number,
                  ),
                ),
                sizedBoxWithContext(context, 0.03),

                Padding(
                  padding: const EdgeInsets.only(right: 15),
                  child: CustomTextFormField(
                    inerHint: 'Salary Paid Through',
                    onValidate: (value) {
                      if (value?.trim().isEmpty ?? true) {
                        return "This is a required field";
                      }
                      return null;
                    },
                    controller: SalaryincomeForm_SalaryPaid,
                    textInputAction: TextInputAction.next,
                    textInputType: TextInputType.text,
                  ),
                ),
                sizedBoxWithContext(context, 0.03),

                Padding(
                  padding: const EdgeInsets.only(right: 15),
                  child: CustomTextFormField(
                    inerHint: 'Monthly net salary',
                    onValidate: (value) {
                      if (value?.trim().isEmpty ?? true) {
                        return "This is a required field";
                      }
                      return null;
                    },
                    controller: SalaryincomeForm_MonthlySalary,
                    textInputAction: TextInputAction.next,
                    textInputType: TextInputType.number,
                  ),
                ),
                sizedBoxWithContext(context, 0.03),

                // Last three months of salary slip label
                Text('Last three months of salary slip',
                    style: AppStyles.blackText16),
                ImageListWidget(
                  imageUrls: salaryDetails?.items?.data.last3MonthSalarySlipPhotos??[''],
                  onRemove: (index) {
                    setState(() {
                      salaryDetails?.items?.data.last3MonthSalarySlipPhotos.removeAt(index);
                    });
                  },
                  onAddImage: () async {
                    // Add new image logic (e.g., open image picker)
                    // String newImage = await uploadImage(); // Replace with your upload logic
                    // if (newImage.isNotEmpty) {
                    //   addImage(newImage);
                    // }
                    imageNotifier.pickImage().then(
                      (value) {
                        imageNotifier.uploadImage(value).then(
                          (value) {
                            setState(() {
                              // print('workphotoUrl: $value');
                              // workPhotosList.add(value);
                              salaryDetails?.items?.data.last3MonthSalarySlipPhotos
                                  .add(value);
                              // print(
                              //     'workPhotosList url length:: ${workPhotosList.length}');
                              print(
                                  'salaryDetails.last3MonthSalarySlipPhotos:: ${salaryDetails?.items?.data.last3MonthSalarySlipPhotos.length}');
                            });
                          },
                        );
                      },
                    );
                  },
                ),

                sizedBoxWithContext(context, 0.03),

                Text('Last three months of salary slip',
                    style: AppStyles.blackText16),
                ImageListWidget(
                  imageUrls: salaryDetails?.items?.data.last3MonthSalarySlipPhotos??[''],
                  onRemove: (index) {
                    setState(() {
                      salaryDetails?.items?.data.last3MonthSalarySlipPhotos.removeAt(index);
                    });
                  },
                  onAddImage: () async {
                    // Add new image logic (e.g., open image picker)
                    // String newImage = await uploadImage(); // Replace with your upload logic
                    // if (newImage.isNotEmpty) {
                    //   addImage(newImage);
                    // }
                    imageNotifier.pickImage().then(
                      (value) {
                        imageNotifier.uploadImage(value).then(
                          (value) {
                            setState(() {
                              // print('workphotoUrl: $value');
                              // workPhotosList.add(value);
                              salaryDetails?.items?.data.last3MonthSalarySlipPhotos
                                  .add(value);
                              // print(
                              //     'workPhotosList url length:: ${workPhotosList.length}');
                              print(
                                  'salaryDetails.last3MonthSalarySlipPhotos:: ${salaryDetails?.items?.data.last3MonthSalarySlipPhotos.length}');
                            });
                          },
                        );
                      },
                    );
                  },
                ),
                sizedBoxWithContext(context, 0.03),
                Text('Bank Statement',
                    // textAlign: TextAlign.left,
                    style: AppStyles.blackText16),

                CommonImagePicker(
                  applicantImage: salaryDetails?.items?.data.bankStatementPhoto ?? '',
                  onImageUploaded: (imageUrl) {
                    setState(() {
                      if( salaryDetails?.items?.data.bankStatementPhoto!=null){
                        salaryDetails!.items!.data.bankStatementPhoto.isNotEmpty
                            ? salaryDetails.items!.data.bankStatementPhoto = imageUrl
                            : // Update the image URL
                        bankStatementUrl = imageUrl;
                        print('bankStatementUrl:: $bankStatementUrl');
                      }

                    });
                  },
                ),
                sizedBoxWithContext(context, 0.03),

                Text('Salary Photos', style: AppStyles.blackText16),
                ImageListWidget(
                  imageUrls: salaryDetails?.items?.data.salaryPhotos ?? [''],
                  onRemove: (index) {
                    setState(() {
                      salaryDetails?.items?.data.salaryPhotos.removeAt(index);
                    });
                  },
                  onAddImage: () async {
                    // Add new image logic (e.g., open image picker)
                    // String newImage = await uploadImage(); // Replace with your upload logic
                    // if (newImage.isNotEmpty) {
                    //   addImage(newImage);
                    // }
                    imageNotifier.pickImage().then(
                      (value) {
                        imageNotifier.uploadImage(value).then(
                          (value) {
                            setState(() {
                              // print('workphotoUrl: $value');
                              // workPhotosList.add(value);
                              salaryDetails?.items?.data.salaryPhotos.add(value);
                              // print(
                              //     'workPhotosList url length:: ${workPhotosList.length}');
                              print(
                                  'salaryDetails.last3MonthSalarySlipPhotos:: ${salaryDetails?.items?.data.salaryPhotos.length}');
                            });
                          },
                        );
                      },
                    );
                  },
                ),
                // Submit Button
                sizedBoxWithContext(context, 0.03),
                ElevatedButton(
                    onPressed: () async {
                      print("Button pressed");
                      if (_formKey.currentState!.validate()) {
                        print("Form validated successfully");

                        final formData = SalaryDetailsModel(
                            incomeSourceType: "salaryIncome",
                            data: SalaryDetailsData(
                                numberOfCattrels: "",
                                companyName: SalaryincomeForm_CompanyName.text,
                                addressOfSalaryProvider:
                                    SalaryincomeForm_AddressSalayProvider.text,
                                mobNoOfSalaryProvider:
                                    SalaryincomeForm_MobileNo.text,
                                doingFromNoYears:
                                    SalaryincomeForm_FromNumberYear.text,
                                salaryPaidThrough:
                                    SalaryincomeForm_SalaryPaid.text,
                                monthlyNetSalary:
                                    SalaryincomeForm_MonthlySalary.text,
                                salaryCredited6Month: "",
                                last3MonthSalarySlipPhotos:
                                salaryDetails?.items?.data.last3MonthSalarySlipPhotos?? [],
                                bankStatementPhoto:
                                salaryDetails?.items?.data.bankStatementPhoto??'',
                                // salaryPhotos: ["/uploads/default_milk_photo.png"],
                                salaryPhotos: salaryDetails?.items?.data.salaryPhotos?? ['']));

                        await viewModel.submitSalaryDetailsForm(
                            formData, context);
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                              backgroundColor: AppColors.red,
                              content: Text(
                                'Please fill all requred details!',
                                style: AppStyles.whiteText16,
                              )),
                        );
                      }
                    },
                    child: Text(
                      'Save Form',
                      style: AppStyles.whiteText16,
                    )),
              ],
            ),
          ),
        );
      },
    );
  }

  // Helper function for spacing
  SizedBox sizedBoxWithContext(BuildContext context, double heightFactor) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * heightFactor,
    );
  }
}
