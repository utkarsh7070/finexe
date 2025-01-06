
import 'package:cached_network_image/cached_network_image.dart';
import 'package:finexe/feature/base/api/api.dart';
import 'package:finexe/feature/base/utils/namespase/app_colors.dart';
import 'package:finexe/feature/base/utils/namespase/app_style.dart';
import 'package:finexe/feature/base/utils/namespase/display_size.dart';
import 'package:finexe/feature/base/utils/widget/custom_snackbar.dart';
import 'package:finexe/feature/base/utils/widget/upload_box.dart';
import 'package:finexe/feature/ui/PD/Common%20Widgets/common_textfield.dart';
// import 'package:finexe/feature/ui/PD/view/common%20imagePicker/dynamic_listing_images.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
// import '../../../../../../../../../../base/utils/namespase/app_colors.dart';
import '../../../../../../common imagePicker/dynamic_listing_images.dart';
import 'milk_model/milk_income_form_model.dart';
import 'milkviewmodel.dart';

class MilkForm extends ConsumerStatefulWidget {
  // const MilkForm({super.key});
  final String customerId;
  const MilkForm({super.key, required this.customerId});
  @override
  _MilkFormState createState() => _MilkFormState();
}

class _MilkFormState extends ConsumerState<MilkForm> {
  final TextEditingController milkForm_numberofyearesDoing =
      TextEditingController();
  final TextEditingController milkform_numberofcattelsController =
      TextEditingController();
  final TextEditingController milkform_milkGivingCattlesController =
      TextEditingController();
  final TextEditingController currentform_milkUtilizatinController =
      TextEditingController();
  final TextEditingController currentform_observeddesignatedController =
      TextEditingController();
  final TextEditingController currentform_milkSupplyperDayController =
      TextEditingController();
  final TextEditingController currentform_nameOfDiaryController =
      TextEditingController();
  final TextEditingController currentform_ownerMobNoController =
      TextEditingController();
  final TextEditingController currentform_milkProvideSinceyearController =
      TextEditingController();
  final TextEditingController currentform_monthlyIncomefromMilkController =
      TextEditingController();
  final TextEditingController currentform_expensesOfMilkController =
      TextEditingController();
  final TextEditingController currentform_diaryAddressController =
      TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    milkForm_numberofyearesDoing.dispose();
    milkform_numberofcattelsController.dispose();
    milkform_milkGivingCattlesController.dispose();
    currentform_milkUtilizatinController.dispose();
    currentform_observeddesignatedController.dispose();
    currentform_milkSupplyperDayController.dispose();
    currentform_nameOfDiaryController.dispose();
    currentform_ownerMobNoController.dispose();
    currentform_milkProvideSinceyearController.dispose();
    currentform_monthlyIncomefromMilkController.dispose();
    currentform_expensesOfMilkController.dispose();
    currentform_diaryAddressController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // final images = ref.watch(imageUploadProvider); // Watch the image list state
    final imageNotifier = ref.read(imageUploadProvider.notifier);
    final viewModel = ref.read(milkBusinessFormViewModelProvider);
    final milkBusinessAsyncValue = ref.watch(milkBusinessProvider(widget.customerId));
    print("output for get $milkBusinessAsyncValue");

    return milkBusinessAsyncValue.when(
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, stack) => Center(child: Text('Error: $error')),
      data: (milkBusiness) {
        if (milkForm_numberofyearesDoing.text.isEmpty) {
          milkForm_numberofyearesDoing.text =
              milkBusiness?.items?.data.doingFromNoOfYears.toString() ?? '';
          milkform_numberofcattelsController.text =
              milkBusiness?.items?.data.numberOfCattrels.toString() ?? '';
          milkform_milkGivingCattlesController.text =
              milkBusiness?.items?.data.noOfMilkGivingCattles.toString()?? '';
          currentform_milkUtilizatinController.text =
              milkBusiness?.items?.data.currentMilkUtilization ?? '';
          currentform_observeddesignatedController.text =
              milkBusiness?.items?.data.observedDesignatedCattleTyingArea ?? '';
          currentform_milkSupplyperDayController.text =
              milkBusiness?.items?.data.totalMilkSupplyPerDay.toString()??'';
          currentform_nameOfDiaryController.text =
              milkBusiness?.items?.data.nameOfDairy ?? '';
          currentform_ownerMobNoController.text =
              milkBusiness?.items?.data.dairyOwnerMobNo ?? '';
          currentform_milkProvideSinceyearController.text =
              milkBusiness?.items?.data.milkProvideFromSinceYear.toString()??'';
          currentform_monthlyIncomefromMilkController.text =
              milkBusiness?.items?.data.monthlyIncomeMilkBusiness ?? '';
          currentform_expensesOfMilkController.text =
              milkBusiness?.items?.data.expensesOfMilkBusiness ?? '';
          currentform_diaryAddressController.text =
              milkBusiness?.items?.data.dairyAddress ?? '';
        }

        return SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                CustomTextFormField(
                  textInputType: TextInputType.number,
                  inerHint: 'Doing from number of years',
                  onValidate: (value) {
                    if (value!.trim().isEmpty) {
                      return "This field is required";
                    }
                    return null;
                  },
                  controller: milkForm_numberofyearesDoing,
                  textInputAction: TextInputAction.next,
                ),
                constSizedbox(context),
                CustomTextFormField(
                  textInputType: TextInputType.number,
                  width: displayWidth(context) * 0.8,
                  inerHint: 'Number of Cattles',
                  onValidate: (value) {
                    if (value!.trim().isEmpty) {
                      return "This field is required";
                    }
                    return null;
                  },
                  controller: milkform_numberofcattelsController,
                  textInputAction: TextInputAction.next,
                ),
                constSizedbox(context),
                CustomTextFormField(
                  textInputType: TextInputType.number,
                  width: displayWidth(context) * 0.8,
                  inerHint: 'Number of milk giving cattles',
                  onValidate: (value) {
                    if (value!.trim().isEmpty) {
                      return "This field is required";
                    }
                    return null;
                  },
                  controller: milkform_milkGivingCattlesController,
                  textInputAction: TextInputAction.next,
                ),
                constSizedbox(context),
                CustomTextFormField(
                  textInputType: TextInputType.name,
                  width: displayWidth(context) * 0.8,
                  inerHint: 'Current milk utilization',
                  onValidate: (value) {
                    if (value!.trim().isEmpty) {
                      return "This field is required";
                    }
                    return null;
                  },
                  controller: currentform_milkUtilizatinController,
                  textInputAction: TextInputAction.next,
                ),
                constSizedbox(context),
                CustomTextFormField(
                  textInputType: TextInputType.name,
                  width: displayWidth(context) * 0.8,
                  inerHint: 'Observed Designated Cattle Tying Area',
                  onValidate: (value) {
                    if (value!.trim().isEmpty) {
                      return "this is a required  filed";
                    }
                    return null;
                  },
                  controller: currentform_observeddesignatedController,
                  textInputAction: TextInputAction.next,
                ),
                constSizedbox(context),
                CustomTextFormField(
                  textInputType: TextInputType.number,
                  width: displayWidth(context) * 0.8,
                  inerHint: 'Total milk Supply per fay',
                  onValidate: (value) {
                    if (value!.trim().isEmpty) {
                      return "this is a required  filed";
                    }
                    return null;
                  },
                  controller: currentform_milkSupplyperDayController,
                  textInputAction: TextInputAction.next,
                ),
                constSizedbox(context),
                CustomTextFormField(
                  textInputType: TextInputType.name,
                  width: displayWidth(context) * 0.8,
                  inerHint: 'Name of diary',
                  onValidate: (value) {
                    if (value!.trim().isEmpty) {
                      return "this is a required  filed";
                    }
                    return null;
                  },
                  controller: currentform_nameOfDiaryController,
                  textInputAction: TextInputAction.next,
                ),
                constSizedbox(context),
                CustomTextFormField(
                  textInputType: TextInputType.number,
                  width: displayWidth(context) * 0.8,
                  inerHint: 'diary owner mob no.',
                  onValidate: (value) {
                    if (value!.trim().isEmpty) {
                      return "this is a required  filed";
                    }
                    return null;
                  },
                  controller: currentform_ownerMobNoController,
                  textInputAction: TextInputAction.next,
                ),
                constSizedbox(context),
                CustomTextFormField(
                  textInputType: TextInputType.name,
                  width: displayWidth(context) * 0.8,
                  inerHint: 'Dairy Address',
                  onValidate: (value) {
                    if (value!.trim().isEmpty) {
                      return "this is a required  filed";
                    }
                    return null;
                  },
                  controller: currentform_diaryAddressController,
                  textInputAction: TextInputAction.next,
                ),

                constSizedbox(context),
                CustomTextFormField(
                  textInputType: TextInputType.number,
                  width: displayWidth(context) * 0.8,
                  inerHint: 'Milk provide from since year',
                  onValidate: (value) {
                    if (value!.trim().isEmpty) {
                      return "this is a required  filed";
                    }
                    return null;
                  },
                  controller: currentform_milkProvideSinceyearController,
                  textInputAction: TextInputAction.next,
                ),
                constSizedbox(context),
                CustomTextFormField(
                  textInputType: TextInputType.name,
                  width: displayWidth(context) * 0.8,
                  inerHint: 'Monthly income milk business',
                  onValidate: (value) {
                    if (value!.trim().isEmpty) {
                      return "this is a required  filed";
                    }
                    return null;
                  },
                  controller: currentform_monthlyIncomefromMilkController,
                  textInputAction: TextInputAction.next,
                ),
                constSizedbox(context),
                CustomTextFormField(
                  textInputType: TextInputType.name,
                  width: displayWidth(context) * 0.8,
                  inerHint: 'Expenses of milk business',
                  onValidate: (value) {
                    if (value!.trim().isEmpty) {
                      return "this is a required  filed";
                    }
                    return null;
                  },
                  controller: currentform_expensesOfMilkController,
                  textInputAction: TextInputAction.next,
                ),
                constSizedbox(context),
                Container(
                  alignment: Alignment.centerLeft,
                  margin: const EdgeInsets.only(left: 20),
                  child: Text('Animal photo with customer',
                      textAlign: TextAlign.left, style: AppStyles.blackText16),
                ),
                // constSizedbox(context),

                // Display uploaded images
                if(milkBusiness?.items?.data.animalPhotos !=null)
                ...milkBusiness!.items!.data.animalPhotos.asMap().entries.map((entry) {
                  final int index = entry.key;
                  final String image = entry.value;
                  // print(
                  //     'agriBusinessData.agriculturePhotos from server:: ${milkBusiness.animalPhotos?.length}');
                  print('image:: $image');
                  return Stack(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: CachedNetworkImage(
                            imageUrl:
                                //  workPhotosList.length == 0
                                //     ? '${Api.baseUrl}${agriAndWorkImages.workPhotos![index]}':
                                '${Api.baseUrl}$image',
                            height: displayHeight(context) * 0.16,
                            width: displayWidth(context) * 0.91,
                            fit: BoxFit.cover,
                            placeholder: (context, url) =>
                                const Center(child: CircularProgressIndicator()),
                            errorWidget: (context, url, error) => Image.asset(
                              'assets/images/no_internet.jpg',
                              height: 150,
                              width: double.infinity,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        right: -2,
                        child: GestureDetector(
                          onTap: () {
                            setState(() {

                                milkBusiness.items?.data.animalPhotos.removeAt(index);
                              print(
                                  'agriBusinessData.agriculturePhotos:: ${milkBusiness.items?.data.animalPhotos.length}');
                            });
                          },
                          child: Image.asset(
                            'assets/images/remove.png',
                            height: 25,
                            width: 25,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ],
                  );
                }),
                SizedBox(height: displayHeight(context) * 0.01),
                // Container for uploading new images
                GestureDetector(
                  // onTap: () => imageNotifier.pickImage(),
                  onTap: () {
                    imageNotifier.pickImage().then(
                      (value) {
                        imageNotifier.uploadImage(value).then(
                          (value) {
                            setState(() {
                              // print('workphotoUrl: $value');
                              // workPhotosList.add(value);
                              milkBusiness?.items?.data.animalPhotos.add(value);
                              // print(
                              //     'workPhotosList url length:: ${workPhotosList.length}');
                              print(
                                  'milkBusiness.animalPhotos:: ${milkBusiness?.items?.data.animalPhotos.length}');
                            });
                          },
                        );
                      },
                    );
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(right: 0),
                    child: UploadBox(
                      isImage: true,
                      height: displayHeight(context) * 0.16,
                      width: displayWidth(context) * 0.91,
                      color: AppColors.buttonBorderGray,
                      iconData: Icons.file_upload_outlined,
                      textColor: AppColors.gray5,
                      subTextColor: AppColors.primary,
                      title: 'Support: JPG, PNG',
                      subTitle: 'Click Image',
                    ),
                  ),
                ),

                constSizedbox(context),
                Container(
                  alignment: Alignment.centerLeft,
                  margin: const EdgeInsets.only(left: 20),
                  child: Text('Milk Photos',
                      textAlign: TextAlign.left, style: AppStyles.blackText16),
                ),
                // constSizedbox(context),

                ImageListWidget(
                  imageUrls: milkBusiness?.items?.data.milkPhotos??[''],
                  onRemove: (index) {
                    setState(() {
                      milkBusiness?.items?.data.milkPhotos.removeAt(index);
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
                              milkBusiness?.items?.data.milkPhotos.add(value);
                              // print(
                              //     'workPhotosList url length:: ${workPhotosList.length}');
                              print(
                                  'milkBusiness.animalPhotos:: ${milkBusiness?.items?.data.milkPhotos.length}');
                            });
                          },
                        );
                      },
                    );
                  },
                ),
                SizedBox(
                  height: displayHeight(context) * 0.02,
                ),

                ElevatedButton(
                    onPressed: () async {
                      print("Button pressed");
                      if (_formKey.currentState!.validate()) {
                        print("Form validated successfully");

                        final formData = MilkBusinessModel(
                          incomeSourceType: "milkBusiness",
                          data: MilkBusinessData(
                            numberOfCattrels: milkform_numberofcattelsController
                                    .text.isNotEmpty
                                ? milkform_numberofcattelsController.text
                                : '0',
                            noOfMilkGivingCattles:
                                milkform_milkGivingCattlesController
                                        .text.isNotEmpty
                                    ? milkform_milkGivingCattlesController.text
                                    : '0',
                            doingFromNoOfYears:
                                milkForm_numberofyearesDoing.text.isNotEmpty
                                    ? milkForm_numberofyearesDoing.text
                                    : '1',
                            totalMilkSupplyPerDay:
                                currentform_milkSupplyperDayController
                                        .text.isNotEmpty
                                    ? currentform_milkSupplyperDayController
                                        .text
                                    : '0',
                            nameOfDairy: currentform_nameOfDiaryController
                                    .text.isNotEmpty
                                ? currentform_nameOfDiaryController.text
                                : 'Unknown Dairy',
                            dairyOwnerMobNo:
                                currentform_ownerMobNoController.text.isNotEmpty
                                    ? currentform_ownerMobNoController.text
                                    : '00000',
                            dairyAddress: currentform_diaryAddressController
                                    .text.isNotEmpty
                                ? currentform_diaryAddressController.text
                                : 'Not Available',
                            milkProvideFromSinceYear:
                                currentform_milkProvideSinceyearController
                                        .text.isNotEmpty
                                    ? currentform_milkProvideSinceyearController
                                        .text
                                    : '2020',
                            expensesOfMilkBusiness:
                                currentform_expensesOfMilkController
                                        .text.isNotEmpty
                                    ? currentform_expensesOfMilkController.text
                                    : '0',
                            monthlyIncomeMilkBusiness:
                                currentform_monthlyIncomefromMilkController
                                        .text.isNotEmpty
                                    ? currentform_monthlyIncomefromMilkController
                                        .text
                                    : '0',
                            // Default value
                            // milkPhotos: ["/uploads/default_milk_photo.png"],
                            milkPhotos: milkBusiness?.items?.data.milkPhotos ??[''],
                            // Default value for photos
                            // animalPhotos: ["/uploads/default_animal_photo.png"],
                            animalPhotos: milkBusiness?.items?.data.animalPhotos?? [''],
                            currentMilkUtilization:
                                currentform_milkUtilizatinController
                                        .text.isNotEmpty
                                    ? currentform_milkUtilizatinController.text
                                    : 'Self Consumption',
                            // Default value
                            breedOfCattles: ["Jersey"],
                            ifCropDestroyedHowToPayEMI: "Savings",
                            observedDesignatedCattleTyingArea:
                                currentform_observeddesignatedController
                                        .text.isNotEmpty
                                    ? currentform_observeddesignatedController
                                        .text
                                    : 'No Designated Area', // Default value
                          ),
                        );

                        await viewModel.submitMilkBusinessForm(
                            formData, context,widget.customerId);
                      }
                      else {
                        showCustomSnackBar(context, 'Please fill all requred details!', AppColors.red);
                      }
                    },
                    child: Text(
                      'Next',
                      style: AppStyles.whiteText16,
                    ))
              ],
            ),
          ),
        );
      },
    );
  }

  Widget constSizedbox(BuildContext context) {
    return SizedBox(height: displayHeight(context) * 0.02);
  }
}
