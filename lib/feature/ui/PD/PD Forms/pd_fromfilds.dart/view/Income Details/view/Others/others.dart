// import 'package:finexe/feature/ui/PD/view/PD%20Form/pd_fromfilds.dart/pd_update_data/view/Income%20Details/view/Others/other_model/other_income_model.dart';
import 'package:finexe/feature/base/utils/namespase/app_style.dart';
import 'package:finexe/feature/ui/PD/Common%20Widgets/common_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../../common imagePicker/dynamic_listing_images.dart';
import 'other_model/other_income_model.dart';
import 'other_view_model.dart';

class Others extends ConsumerStatefulWidget {
  // const Others({super.key});
  final String customerId;
  Others({required this.customerId});
  @override
  ConsumerState<Others> createState() => _OthersState();
}

class _OthersState extends ConsumerState<Others> {
  late TextEditingController otherNatureBusiness;
  late TextEditingController otherMonthlyIncome;
  late TextEditingController otherYearlyIncome;
  late TextEditingController otherDescBusiness;
  late TextEditingController otherBusinessSince;

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    otherNatureBusiness = TextEditingController();
    otherMonthlyIncome = TextEditingController();
    otherYearlyIncome = TextEditingController();
    otherDescBusiness = TextEditingController();
    otherBusinessSince = TextEditingController();
  }

  @override
  void dispose() {
    otherNatureBusiness.dispose();
    otherMonthlyIncome.dispose();
    otherYearlyIncome.dispose();
    otherDescBusiness.dispose();
    otherBusinessSince.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // final images =
    //     ref.watch(otherImageUploadProvider); // Watch the image list state
    // final imageNotifier = ref.read(otherImageUploadProvider.notifier);
    final viewModel = ref.read(otherDetailsFormViewModelProvider);
    final fetchAsyncValue = ref.watch(salaryDetailsProvider(widget.customerId));
    print("other for get ${fetchAsyncValue}");
    final imageNotifier = ref.read(imageUploadProvider.notifier);

    return fetchAsyncValue.when(
      data: (otherData) {
        if (otherNatureBusiness.text.isEmpty) {
          otherNatureBusiness.text = otherData?.items?.data.natureOfBusiness ?? '';
          otherDescBusiness.text = otherData?.items?.data.discriptionOfBusiness ?? '';
          otherBusinessSince.text = otherData?.items?.data.bussinessFromSinceYear ?? '';
          if(otherData?.items?.data.monthlyIncome !=null ){
            otherMonthlyIncome.text = otherData!.items!.data.monthlyIncome
                .toStringAsFixed(2); // Rounds to 2 decimal places
          }
          if(otherData?.items?.data.yearlyIncome !=null ){
            otherYearlyIncome.text = otherData!.items!.data.yearlyIncome
                .toStringAsFixed(2); // Rounds to 2 decimal places
          }
          // otherYearlyIncome.text = otherData.yearlyIncome.toStringAsFixed(2);
        }
        return SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Nature of Business
                Padding(
                  padding: const EdgeInsets.only(right: 15),
                  child: CustomTextFormField(
                    inerHint: 'Nature of Business',
                    onValidate: (value) {
                      if (value?.trim().isEmpty ?? true) {
                        return "This is a required field";
                      }
                      return null;
                    },
                    controller: otherNatureBusiness,
                    textInputAction: TextInputAction.next,
                    textInputType: TextInputType.text,
                  ),
                ),

                sizedBoxWithContext(context, 0.03),

                // Monthly Income
                Padding(
                  padding: const EdgeInsets.only(right: 15),
                  child: CustomTextFormField(
                    inerHint: 'Monthly Income',
                    onValidate: (value) {
                      if (value?.trim().isEmpty ?? true) {
                        return "This is a required field";
                      }
                      return null;
                    },
                    controller: otherMonthlyIncome,
                    textInputAction: TextInputAction.next,
                    textInputType: TextInputType.number,
                  ),
                ),

                sizedBoxWithContext(context, 0.03),

                // Yearly Income
                Padding(
                  padding: const EdgeInsets.only(right: 15),
                  child: CustomTextFormField(
                    inerHint: 'Yearly Income',
                    onValidate: (value) {
                      if (value?.trim().isEmpty ?? true) {
                        return "This is a required field";
                      }
                      return null;
                    },
                    controller: otherYearlyIncome,
                    textInputAction: TextInputAction.next,
                    textInputType: TextInputType.number,
                  ),
                ),

                sizedBoxWithContext(context, 0.03),

                // Description of Business
                Padding(
                  padding: const EdgeInsets.only(right: 15),
                  child: CustomTextFormField(
                    inerHint: 'Description of Business',
                    onValidate: (value) {
                      if (value?.trim().isEmpty ?? true) {
                        return "This is a required field";
                      }
                      return null;
                    },
                    controller: otherDescBusiness,
                    textInputAction: TextInputAction.next,
                    textInputType: TextInputType.text,
                  ),
                ),

                sizedBoxWithContext(context, 0.03),

                // Business Since
                Padding(
                  padding: const EdgeInsets.only(right: 15),
                  child: CustomTextFormField(
                    inerHint: 'Business Since',
                    onValidate: (value) {
                      if (value?.trim().isEmpty ?? true) {
                        return "This is a required field";
                      }
                      return null;
                    },
                    controller: otherBusinessSince,
                    textInputAction: TextInputAction.done,
                    textInputType: TextInputType.number,
                  ),
                ),

                sizedBoxWithContext(context, 0.03),

                Text('Business Images', style: AppStyles.blackText16),
                ImageListWidget(
                  imageUrls: otherData?.items?.data.incomeOtherImages?? [''],
                  onRemove: (index) {
                    setState(() {

                      otherData?.items?.data.incomeOtherImages.removeAt(index);
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
                              otherData?.items?.data.incomeOtherImages.add(value);
                              // print(
                              //     'workPhotosList url length:: ${workPhotosList.length}');
                              print(
                                  'otherData.incomeOtherImages:: ${otherData?.items?.data.incomeOtherImages.length}');
                            });
                          },
                        );
                      },
                    );
                  },
                ),

                ElevatedButton(
                  onPressed: () async {
                    // Validate the form before submission
                    if (_formKey.currentState!.validate()) {
                      final formData = OtherIncomeModel(
                          incomeSourceType: "other",
                          data: OtherIncomeData(
                              bussinessFromSinceYear: otherBusinessSince.text,
                              natureOfBusiness: otherNatureBusiness.text,
                              monthlyIncome: double.tryParse(
                                      otherMonthlyIncome.text.trim()) ??
                                  0.0,
                              yearlyIncome: double.tryParse(
                                      otherYearlyIncome.text.trim()) ??
                                  0.0,
                              discriptionOfBusiness: otherDescBusiness.text,
                              // incomeOtherImages: [
                              //   "/uploads/default_milk_photo.png"
                              // ],
                              incomeOtherImages: otherData?.items?.data.incomeOtherImages?? ['']));

                      // Submit the data
                      await viewModel.submitOtherDetailsForm(formData, context,widget.customerId);


                    } else {
                      // Validation failed
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          backgroundColor: Colors.red,
                          content: Text(
                            'Please fill all required fields!',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      );
                    }
                  },
                  child: Text(
                    'Save Form',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
        );
      },
      loading: () =>
          Center(child: CircularProgressIndicator()), // Show loading indicator
      error: (error, stack) => Center(child: Text('Error: $error')), // Sh
    );
  }

  SizedBox sizedBoxWithContext(BuildContext context, double heightFactor) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * heightFactor,
    );
  }
}
