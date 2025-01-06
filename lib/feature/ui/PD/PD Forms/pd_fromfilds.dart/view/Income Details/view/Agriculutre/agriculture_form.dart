

import 'package:cached_network_image/cached_network_image.dart';
import 'package:dropdown_textfield/dropdown_textfield.dart';
import 'package:finexe/feature/base/api/api.dart';
import 'package:finexe/feature/base/utils/namespase/app_colors.dart';
import 'package:finexe/feature/base/utils/namespase/app_style.dart';
import 'package:finexe/feature/base/utils/namespase/display_size.dart';
import 'package:finexe/feature/base/utils/widget/upload_box.dart';
import 'package:finexe/feature/ui/PD/Common%20Widgets/CustomDropdownWithCross.dart';
import 'package:finexe/feature/ui/PD/Common%20Widgets/common_textfield.dart';
import 'package:finexe/feature/ui/PD/Common%20Widgets/simple_dropdown.dart';
import 'package:finexe/feature/ui/PD/PD%20Forms/pd_fromfilds.dart/view/Income%20Details/view/Agriculutre/view_model/agri_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../co-applicant_form.dart';
import 'agri_mode/agriculture_income_form_model.dart';

class AgricultureIncomeDetail extends ConsumerStatefulWidget {
  // const AgricultureIncomeDetail({super.key});
  final String customerId;
  const AgricultureIncomeDetail({super.key, required this.customerId});
  @override
  _AgricultureIncomeDetailState createState() =>
      _AgricultureIncomeDetailState();
}

class _AgricultureIncomeDetailState
    extends ConsumerState<AgricultureIncomeDetail> {
  final _formKey = GlobalKey<FormState>();

  late TextEditingController incomeForm_AgriOwner;
  late TextEditingController incomeForm_KasraNo;
  late TextEditingController incomeForm_Relationofapplicant;
  late TextEditingController incomeForm_villageName;
  late TextEditingController incomeForm_AgrilandAcre;
  late TextEditingController incomeForm_AddressPawti;
  late TextEditingController incomeForm_DistrictName;
  late TextEditingController incomeForm_AgrilandSurvey;
  late TextEditingController incomeForm_FertilizerOwnername;
  late TextEditingController incomeForm_FertilizerOwnerContact;
  late TextEditingController incomeForm_TypeofIrrigation;
  late TextEditingController incomeForm_TypeSignificantChallenge;
  late TextEditingController incomeForm_SignificationSeason;
  late TextEditingController incomeForm_AgriIncome;
  late TextEditingController incomeForm_CropDestroyed;
  late TextEditingController incomeForm_CropPlanted;
  late TextEditingController incomeForm_AgriFromYear;
  late TextEditingController incomeForm_DetailLastCrop;
  late TextEditingController incomeForm_CropSOLD;
  late TextEditingController incomeForm_OtherRelation;
  late TextEditingController incomeForm_OtherName;
  late TextEditingController incomeForm_OtherRemark;

  @override
  void initState() {
    super.initState();

    // Initialize all TextEditingControllers
    incomeForm_AgriOwner = TextEditingController();
    incomeForm_KasraNo = TextEditingController();
    incomeForm_Relationofapplicant = TextEditingController();
    incomeForm_villageName = TextEditingController();
    incomeForm_AgrilandAcre = TextEditingController();
    incomeForm_AddressPawti = TextEditingController();
    incomeForm_DistrictName = TextEditingController();
    incomeForm_AgrilandSurvey = TextEditingController();
    incomeForm_FertilizerOwnername = TextEditingController();
    incomeForm_FertilizerOwnerContact = TextEditingController();
    incomeForm_TypeofIrrigation = TextEditingController();
    incomeForm_TypeSignificantChallenge = TextEditingController();
    incomeForm_SignificationSeason = TextEditingController();
    incomeForm_AgriIncome = TextEditingController();
    incomeForm_CropDestroyed = TextEditingController();
    incomeForm_CropPlanted = TextEditingController();
    incomeForm_AgriFromYear = TextEditingController();
    incomeForm_DetailLastCrop = TextEditingController();
    incomeForm_CropSOLD = TextEditingController();
    incomeForm_OtherRelation = TextEditingController();
    incomeForm_OtherName = TextEditingController();
    incomeForm_OtherRemark = TextEditingController();
    // final agriBusinessAsyncValue = ref.watch(agriBusinessProvider);
  }

  final Set<String> selectedOptions = {}; // Use Set for unique values
  bool isDropdownOpen = false;

  List<String> finalOptions = []; // Stores the final selected values

// Ensure fetched pre-selections are initialized
//   void initializePreSelectedOptions(List<String> fetchedData) {
//     setState(() {
//       selectedOptions.clear(); // Clear any existing selections
//
//       // Iterate through fetched data and pre-select valid options
//       for (var item in fetchedData) {
//         selectedOptions.add(item); // Add predefined options
//       }
//
//       // Update finalOptions and input text
//       finalOptions = getCombinedSelectedOptions();
//       incomeForm_AgriOwner.text = finalOptions.join(", ");
//     });
//   }

// Function to toggle options
  void toggleOption(String option) {
    setState(() {
      // Add or remove predefined options
      if (selectedOptions.contains(option)) {
        selectedOptions.remove(option);
      } else {
        selectedOptions.add(option);
      }
      // Refresh finalOptions with combined selected options (including "Other")
      finalOptions = getCombinedSelectedOptions();
      if (!finalOptions.contains("Other")) {
        incomeForm_OtherName.text = "";
        incomeForm_OtherRemark.text = "";
        incomeForm_OtherRelation.text = "";
      }
    });
  }

// Get combined list of selected options and the "Other" value
  List<String> getCombinedSelectedOptions() {
    List<String> combinedOptions = selectedOptions.toList();
    return combinedOptions;
  }

// Function to toggle dropdown open/close
  void toggleDropdown() {
    setState(() {
      isDropdownOpen = !isDropdownOpen;
    });
  }

  SizedBox sizedBoxWithContext(BuildContext context, double heightFactor) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * heightFactor,
    );
  }

  // crop list
  List<String> selectedCrops = [];

  void onCropsSelectionChanged(List<String> crops) {
    setState(() {
      selectedCrops = crops;
      incomeForm_CropPlanted.text = crops.join(", ");
    });
  }

  @override
  void dispose() {
    incomeForm_CropPlanted.dispose();
    incomeForm_AgriOwner.dispose();
    incomeForm_KasraNo.dispose();
    incomeForm_Relationofapplicant.dispose();
    incomeForm_villageName.dispose();
    incomeForm_AgrilandAcre.dispose();
    incomeForm_AddressPawti.dispose();
    incomeForm_DistrictName.dispose();
    incomeForm_AgrilandSurvey.dispose();
    incomeForm_FertilizerOwnername.dispose();
    incomeForm_FertilizerOwnerContact.dispose();
    incomeForm_TypeofIrrigation.dispose();
    incomeForm_TypeSignificantChallenge.dispose();
    incomeForm_SignificationSeason.dispose();
    incomeForm_AgriIncome.dispose();
    incomeForm_CropDestroyed.dispose();
    incomeForm_CropPlanted.dispose();
    incomeForm_AgriFromYear.dispose();
    incomeForm_DetailLastCrop.dispose();
    incomeForm_CropSOLD.dispose();
    incomeForm_OtherRelation.dispose();
    incomeForm_OtherName.dispose();
    incomeForm_OtherRemark.dispose();
    super.dispose();
  }

  bool isInitialDataSet = false;

  @override
  Widget build(BuildContext context) {
    print('isInitialDataSet:: $isInitialDataSet');
    List<String> finalOptions = getCombinedSelectedOptions(); //from drop down
    // final images = ref.watch(imageUploadProvider); // Watch the image list state
    final imageNotifier = ref.read(imageUploadProvider.notifier);
    final viewModel = ref.read(agriBusinessFormViewModelProvider);
    final agriBusinessAsyncValue = ref.watch(agriBusinessProvider(widget.customerId));
    final otherDataAsyncValue = ref.watch(otherProvider(widget.customerId));

    return agriBusinessAsyncValue.when(
        loading: () => const Center(
              child: CircularProgressIndicator(),
            ),
        error: (error, stackTrace) => Center(
              child: Text('Error: $error'),
            ),
        data: (agriBusinessData) {
          var agriData = agriBusinessData?.items?.agricultureData;

          // var agriData = agriBusinessData?.items?.agricultureData;

          if (incomeForm_AgriOwner.text.isEmpty) {
            if (!isInitialDataSet) {
              print('isInitialDataSet:: $isInitialDataSet');
              print('object: ${incomeForm_AgriOwner.text.isEmpty}');

              // Ensure agriData is not null before using it
              if (agriData != null) {
                if (selectedOptions.isEmpty && agriData.nameOfAgriOwner != null) {
                  selectedOptions.addAll(agriData.nameOfAgriOwner!);
                  finalOptions = agriData.nameOfAgriOwner!;
                  incomeForm_AgriOwner.text = finalOptions.join(", "); // Pre-fill text
                }

                incomeForm_KasraNo.text = agriData.kasraSurveyNo ?? '';
                incomeForm_Relationofapplicant.text = agriData.relationOfApplicant ?? '';
                incomeForm_villageName.text = agriData.villageName ?? '';
                incomeForm_AgrilandAcre.text = agriData.agriLandInBigha ?? '';
                incomeForm_AddressPawti.text = agriData.addressAsPerPawti ?? '';
                incomeForm_DistrictName.text = agriData.districtName ?? '';
                incomeForm_AgrilandSurvey.text = agriData.agriLandSurveyNo ?? '';
                incomeForm_FertilizerOwnername.text = agriData.fertilizerShopOwnerName ?? '';
                incomeForm_FertilizerOwnerContact.text = agriData.fertilizerShopOwnerContactNumber ?? '';
                incomeForm_TypeofIrrigation.text = agriData.irrigationMethod ?? '';
                incomeForm_TypeSignificantChallenge.text = agriData.haveYouFaced ?? '';
                incomeForm_SignificationSeason.text = agriData.significantChallengesThisSeason ?? '';
                incomeForm_AgriIncome.text = agriData.agriIncomeYearly ?? '';
                incomeForm_CropDestroyed.text = agriData.ifCropDestroyedHowToPayEMI ?? '';
                incomeForm_CropPlanted.text = agriData.whichCropIsPlanted?.join(", ") ?? '';
                selectedCrops = agriData.whichCropIsPlanted ?? [];
                incomeForm_AgriFromYear.text = agriData.agriDoingFromNoOfYears ?? '';
                incomeForm_DetailLastCrop.text = agriData.detailOfLastCorp ?? '';
                incomeForm_CropSOLD.text = agriData.howMuchCropSoldInAmt ?? '';
                incomeForm_OtherRelation.text = agriData.otherRelation ?? '';
                incomeForm_OtherName.text = agriData.otherName ?? '';
                incomeForm_OtherRemark.text = agriData.otherRemark ?? '';
              } else {
                print("Error: agriData is null.");
              }

              isInitialDataSet = true; // Prevent further overwrites
            }
          }


          // if (!isInitialDataSet) {
          //   print('isInitialDataSet:: $isInitialDataSet');
          //   print('object: ${incomeForm_AgriOwner.text.isEmpty}');
          //
          //   var agriData = agriBusinessData?.items?.agricultureData;
          //
          //   if (selectedOptions.isEmpty && agriData?.nameOfAgriOwner != null) {
          //     selectedOptions.addAll(agriData!.nameOfAgriOwner!);
          //     finalOptions = agriData.nameOfAgriOwner!;
          //     incomeForm_AgriOwner.text = finalOptions.join(", "); // Pre-fill text
          //   }
          //
          //   incomeForm_KasraNo.text = agriData?.kasraSurveyNo ?? '';
          //   incomeForm_Relationofapplicant.text = agriData?.relationOfApplicant ?? '';
          //   incomeForm_villageName.text = agriData?.villageName ?? '';
          //   incomeForm_AgrilandAcre.text = agriData?.agriLandInBigha ?? '';
          //   incomeForm_AddressPawti.text = agriData?.addressAsPerPawti ?? '';
          //   incomeForm_DistrictName.text = agriData?.districtName ?? '';
          //   incomeForm_AgrilandSurvey.text = agriData?.agriLandSurveyNo ?? '';
          //   incomeForm_FertilizerOwnername.text = agriData?.fertilizerShopOwnerName ?? '';
          //   incomeForm_FertilizerOwnerContact.text = agriData?.fertilizerShopOwnerContactNumber ?? '';
          //   incomeForm_TypeofIrrigation.text = agriData?.irrigationMethod ?? '';
          //   incomeForm_TypeSignificantChallenge.text = agriData?.haveYouFaced ?? '';
          //   incomeForm_SignificationSeason.text = agriData?.significantChallengesThisSeason ?? '';
          //   incomeForm_AgriIncome.text = agriData?.agriIncomeYearly ?? '';
          //   incomeForm_CropDestroyed.text = agriData?.ifCropDestroyedHowToPayEMI ?? '';
          //
          //   if (agriData?.whichCropIsPlanted != null) {
          //     incomeForm_CropPlanted.text = agriData!.whichCropIsPlanted.join(", ");
          //     selectedCrops = agriData.whichCropIsPlanted;
          //   }
          //
          //   incomeForm_AgriFromYear.text = agriData?.agriDoingFromNoOfYears ?? '';
          //   incomeForm_DetailLastCrop.text = agriData?.detailOfLastCorp ?? '';
          //   incomeForm_CropSOLD.text = agriData?.howMuchCropSoldInAmt ?? '';
          //   incomeForm_OtherRelation.text = agriData?.otherRelation ?? '';
          //   incomeForm_OtherName.text = agriData?.otherName ?? '';
          //   incomeForm_OtherRemark.text = agriData?.otherRemark ?? '';
          //
          //   isInitialDataSet = true; // Prevent further overwrites
          // }


          return GestureDetector(
            onTap: () {
              setState(() {
                isDropdownOpen = false;
              });
              FocusScope.of(context).unfocus();
            },
            behavior: HitTestBehavior.translucent,
            child: SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 0),
                      child: GestureDetector(
                        onTap: () => toggleDropdown(),
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 8),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey, width: 1),
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.white
                                .withOpacity(0.7), // Semi-transparent
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(height: 8),
                              // Toggle Button for Dropdown (Open/Close)
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: Text(
                                      finalOptions.isNotEmpty
                                          ? finalOptions
                                              .join(", ") // Show selected options
                                          : "Name of Agri Owner", // Placeholder when no options selected
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400,
                                        color: finalOptions.isEmpty
                                            ? Colors.grey
                                            : Colors.black,
                                      ),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                  Icon(
                                    isDropdownOpen
                                        ? Icons.arrow_drop_up
                                        : Icons.arrow_drop_down,
                                    color: isDropdownOpen
                                        ? const Color(0xff0082c6)
                                        : Colors.grey,
                                  ),
                                ],
                              ),
                              const SizedBox(height: 8),

                              // Display options when dropdown is open
                              if (isDropdownOpen) ...[
                                otherDataAsyncValue.when(
                                  data: (otherData) => Column(
                                    children:  otherData.otherdrop!.map((option) {
                                      return CheckboxListTile(
                                        selected:
                                            selectedOptions.contains(option),
                                        value: selectedOptions.contains(option),
                                        onChanged: (_) => toggleOption(option),
                                        title: Text(option),
                                        controlAffinity:
                                            ListTileControlAffinity.leading,
                                        activeColor: const Color(0xff0082c6),
                                      );
                                    }).toList(),
                                  ),
                                  loading: () => const Center(
                                      child: CircularProgressIndicator()),
                                  error: (error, stackTrace) =>
                                      Center(child: Text('Error: $error')),
                                ),
                                // "Other" option
                                CheckboxListTile(
                                  value: selectedOptions.contains("Other"),
                                  onChanged: (_) {
                                    toggleOption(
                                        "Other"); // This toggles the "Other" option
                                  },
                                  title: const Text("Other"),
                                  controlAffinity:
                                      ListTileControlAffinity.leading,
                                  activeColor: const Color(0xff0082c6),
                                ),

// Show text input fields for "Other" if Other is true
                                if (selectedOptions.contains("Other")) ...[
                                  const SizedBox(height: 20),
                                  CustomTextFormField(
                                    width: displayWidth(context),
                                    inerHint: 'Name',
                                    onValidate: (value) {
                                      if (value?.trim().isEmpty ?? true) {
                                        return "This is a required field";
                                      }
                                      return null;
                                    },
                                    controller: incomeForm_OtherName,
                                    textInputAction: TextInputAction.next,
                                    textInputType: TextInputType.name,
                                  ),
                                  const SizedBox(height: 20),
                                  CustomTextFormField(
                                    inerHint: 'Relation',
                                    onValidate: (value) {
                                      if (value?.trim().isEmpty ?? true) {
                                        return "This is a required field";
                                      }
                                      return null;
                                    },
                                    controller: incomeForm_OtherRelation,
                                    textInputAction: TextInputAction.next,
                                    textInputType: TextInputType.name,
                                  ),
                                  const SizedBox(height: 20),
                                  CustomTextFormField(
                                    inerHint: 'Remark',
                                    onValidate: (value) {
                                      if (value?.trim().isEmpty ?? true) {
                                        return "This is a required field";
                                      }
                                      return null;
                                    },
                                    controller: incomeForm_OtherRemark,
                                    textInputAction: TextInputAction.next,
                                    textInputType: TextInputType.name,
                                  ),
                                  sizedBoxWithContext(context, 0.03),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      ElevatedButton(
                                        onPressed: () {
                                          print("Upload Image button clicked");
                                        },
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: const Color(0xff0082c6),
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 8, vertical: 14),
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(12),
                                          ),
                                        ),
                                        child: const Text(
                                          "Upload Document",
                                          style: TextStyle(color: Colors.white),
                                        ),
                                      ),
                                      InkWell(
                                        onTap: () {
                                          print("Upload Image button clicked");
                                        },
                                        child: const Text(
                                          "Preview Document Image",
                                          style: TextStyle(
                                              color: Colors.blue,
                                              fontSize: 14,
                                              fontWeight: FontWeight.w500),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ],
                            ],
                          ),
                        ),
                      ),
                    ),


                    //*************************************************
                    sizedBoxWithContext(context, 0.03),
                    Padding(
                      padding: const EdgeInsets.only(right: 15),
                      child: CustomTextFormField(
                        inerHint: 'Kasra/Survey No',
                        onValidate: (value) {
                          if (value?.trim().isEmpty ?? true) {
                            return "This is a required field";
                          }
                          return null;
                        },
                        controller: incomeForm_KasraNo,
                        // textInputAction: TextInputAction.next,
                        // textInputType: TextInputType.name,
                        // onChange: (value) => incomeForm_KasraNo,
                        textInputType: TextInputType.number,
                      ),
                    ),

                    sizedBoxWithContext(context, 0.03),
                    Padding(
                      padding: const EdgeInsets.only(right: 15),
                      child: CustomTextFormField(
                        inerHint: 'Relation of applicant',
                        onValidate: (value) {
                          if (value?.trim().isEmpty ?? true) {
                            return "This is a required field";
                          }
                          return null;
                        },
                        controller: incomeForm_Relationofapplicant,
                        textInputAction: TextInputAction.next,
                        textInputType: TextInputType.name,
                      ),
                    ),

                    sizedBoxWithContext(context, 0.03),
                    Padding(
                      padding: const EdgeInsets.only(right: 15),
                      child: CustomTextFormField(
                        inerHint: 'Village Name',
                        onValidate: (value) {
                          if (value?.trim().isEmpty ?? true) {
                            return "This is a required field";
                          }
                          return null;
                        },
                        controller: incomeForm_villageName,
                        textInputAction: TextInputAction.next,
                        textInputType: TextInputType.name,
                      ),
                    ),

                    sizedBoxWithContext(context, 0.03),
                    Padding(
                      padding: const EdgeInsets.only(right: 15),
                      child: CustomTextFormField(
                        inerHint: 'Agri Land in Acre',
                        onValidate: (value) {
                          if (value?.trim().isEmpty ?? true) {
                            return "This is a required field";
                          }
                          return null;
                        },
                        controller: incomeForm_AgrilandAcre,
                        textInputAction: TextInputAction.next,
                        textInputType: TextInputType.number,
                        // textInputType: TextInputType.name,
                      ),
                    ),

                    sizedBoxWithContext(context, 0.03),
                    Padding(
                      padding: const EdgeInsets.only(right: 15),
                      child: CustomTextFormField(
                        inerHint: 'Address as per pawti',
                        onValidate: (value) {
                          if (value?.trim().isEmpty ?? true) {
                            return "This is a required field";
                          }
                          return null;
                        },
                        controller: incomeForm_AddressPawti,
                        textInputAction: TextInputAction.next,
                        textInputType: TextInputType.name,
                      ),
                    ),

                    sizedBoxWithContext(context, 0.03),
                    Padding(
                      padding: const EdgeInsets.only(right: 15),
                      child: CustomTextFormField(
                        inerHint: 'Distict Name',
                        onValidate: (value) {
                          if (value?.trim().isEmpty ?? true) {
                            return "This is a required field";
                          }
                          return null;
                        },
                        controller: incomeForm_DistrictName,
                        textInputAction: TextInputAction.next,
                        textInputType: TextInputType.name,
                      ),
                    ),

                    sizedBoxWithContext(context, 0.03),
                    Padding(
                      padding: const EdgeInsets.only(right: 15),
                      child: CustomTextFormField(
                        inerHint: 'Agri land survey no.',
                        onValidate: (value) {
                          if (value?.trim().isEmpty ?? true) {
                            return "This is a required field";
                          }
                          return null;
                        },
                        controller: incomeForm_AgrilandSurvey,
                        textInputAction: TextInputAction.next,
                        textInputType: TextInputType.number,
                      ),
                    ),
                    // Spacing between buttons

                    sizedBoxWithContext(context, 0.03),
                    Padding(
                      padding: const EdgeInsets.only(right: 15),
                      child: CustomTextFormField(
                        inerHint: 'Fertilizer Shop Owner Name',
                        onValidate: (value) {
                          if (value?.trim().isEmpty ?? true) {
                            return "This is a required field";
                          }
                          return null;
                        },
                        controller: incomeForm_FertilizerOwnername,
                        textInputAction: TextInputAction.next,
                        textInputType: TextInputType.name,
                      ),
                    ),

                    // Dropdown
                    sizedBoxWithContext(context, 0.03),
                    Padding(
                      padding: const EdgeInsets.only(right: 15),
                      child: CustomTextFormField(
                        inerHint: 'Fertilizer shop Owner Contact Number',
                        onValidate: (value) {
                          if (value?.trim().isEmpty ?? true) {
                            return "This is a required field";
                          }
                          return null;
                        },
                        controller: incomeForm_FertilizerOwnerContact,
                        textInputAction: TextInputAction.next,
                        textInputType: TextInputType.number,
                      ),
                    ),

                    sizedBoxWithContext(context, 0.03),
                    Padding(
                      padding: const EdgeInsets.only(right: 18),
                      child: CustomDropDownTextField(
                        items: const [
                          DropDownValueModel(name: "Rainfed", value: "Rainfed"),
                          DropDownValueModel(
                              name: "Tubewell", value: "Tubewell"),
                          DropDownValueModel(
                              name: "Canal Irrigation",
                              value: "Canal Irrigation"),
                          DropDownValueModel(
                              name: "Drip Irrigation",
                              value: "Drip Irrigation"),
                          DropDownValueModel(
                              name: "Sprinkle System",
                              value: "Sprinkle System"),
                        ],
                        labelText: "What Type of Irrigation Method",
                        controller:
                            incomeForm_TypeofIrrigation, // Pass controller
                      ),
                    ),

                    sizedBoxWithContext(context, 0.03),
                    Padding(
                      padding: const EdgeInsets.only(right: 18),
                      child: CustomDropDownTextField(
                        items: const [
                          DropDownValueModel(name: "Yes", value: "Yes"),
                          DropDownValueModel(name: "No", value: "No"),
                        ],
                        labelText: 'Have you faced any significant challenges?',
                        controller:
                            incomeForm_TypeSignificantChallenge, // Pass controller
                      ),
                    ),

                    sizedBoxWithContext(context, 0.03),
                    Padding(
                      padding: const EdgeInsets.only(right: 15),
                      child: CustomTextFormField(
                        inerHint: 'Significant Challenges this season',
                        onValidate: (value) {
                          if (value?.trim().isEmpty ?? true) {
                            return "This is a required field";
                          }
                          return null;
                        },
                        controller: incomeForm_SignificationSeason,
                        textInputAction: TextInputAction.next,
                        textInputType: TextInputType.name,
                      ),
                    ),

                    sizedBoxWithContext(context, 0.03),
                    Padding(
                      padding: const EdgeInsets.only(right: 15),
                      child: CustomTextFormField(
                        inerHint: 'Agri Income (Yearly)',
                        onValidate: (value) {
                          if (value?.trim().isEmpty ?? true) {
                            return "This is a required field";
                          }
                          return null;
                        },
                        controller: incomeForm_AgriIncome,
                        textInputAction: TextInputAction.next,
                        textInputType: TextInputType.number,
                      ),
                    ),

                    sizedBoxWithContext(context, 0.03),
                    Padding(
                      padding: const EdgeInsets.only(right: 15),
                      child: CustomTextFormField(
                        inerHint: 'If Crop Destroyed, How to pay Me',
                        onValidate: (value) {
                          if (value?.trim().isEmpty ?? true) {
                            return "This is a required field";
                          }
                          return null;
                        },
                        controller: incomeForm_CropDestroyed,
                        textInputAction: TextInputAction.next,
                        textInputType: TextInputType.name,
                      ),
                    ),

                    // Crop dropdown
                    sizedBoxWithContext(context, 0.03),
                    Padding(
                      padding: const EdgeInsets.only(right: 18),
                      child: CustomDropdownWithCross(
                        items: const [
                          "Wheat",
                          "Corn",
                          "Soybean",
                          "Maize (Corn)",
                          "Rice",
                          "Mustard",
                          "Gram (Chickpea)",
                          "Sugarcane",
                          "Cotton",
                        ],
                        initialSelectedItems: selectedCrops,
                        placeholder: incomeForm_CropPlanted.text.isNotEmpty
                            ? '' // No placeholder when there's content
                            : "Which crop is planted",
                        onSelectionChanged: onCropsSelectionChanged,
                      ),
                    ),

                    sizedBoxWithContext(context, 0.03),
                    Padding(
                      padding: const EdgeInsets.only(right: 15),
                      child: CustomTextFormField(
                        inerHint: 'Agri doing from no. of years',
                        onValidate: (value) {
                          if (value?.trim().isEmpty ?? true) {
                            return "This is a required field";
                          }
                          return null;
                        },
                        controller: incomeForm_AgriFromYear,
                        textInputAction: TextInputAction.next,
                        textInputType: TextInputType.name,
                      ),
                    ),

                    sizedBoxWithContext(context, 0.03),
                    Padding(
                      padding: const EdgeInsets.only(right: 15),
                      child: CustomTextFormField(
                        inerHint: 'Detail of last crop',
                        onValidate: (value) {
                          if (value?.trim().isEmpty ?? true) {
                            return "This is a required field";
                          }
                          return null;
                        },
                        controller: incomeForm_DetailLastCrop,
                        textInputAction: TextInputAction.next,
                        textInputType: TextInputType.name,
                      ),
                    ),

                    sizedBoxWithContext(context, 0.03),
                    Padding(
                      padding: const EdgeInsets.only(right: 15),
                      child: CustomTextFormField(
                        inerHint: 'How much Crop sold (In AMT.)',
                        onValidate: (value) {
                          if (value?.trim().isEmpty ?? true) {
                            return "This is a required field";
                          }
                          return null;
                        },
                        controller: incomeForm_CropSOLD,
                        textInputAction: TextInputAction.next,
                        textInputType: TextInputType.name,
                      ),
                    ),

                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        'Land Book Image',
                        style: TextStyle(
                            color: Colors.blueAccent,
                            fontSize: 16,
                            fontWeight: FontWeight.w500),
                        textAlign: TextAlign.start,
                      ),
                    ),
                     if(agriData?.agriculturePhotos !=null)
                    ...agriData!.agriculturePhotos!
                        .asMap()
                        .entries
                        .map((entry) {
                      final int index = entry.key;
                      final String image = entry.value;
                      print(
                          'agriBusinessData.agriculturePhotos from server:: ${agriData.agriculturePhotos?.length}');
                      print('image:: $image');
                      return Stack(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(right: 15, top: 10),
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
                                errorWidget: (context, url, error) =>
                                    Image.asset(
                                  'assets/images/no_internet.jpg',
                                  height: 150,
                                  width: double.infinity,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                            right: 12,
                            top: 5,
                            child: GestureDetector(
                              onTap: () {
                                setState(() {
                                  if( agriBusinessData !=null){
                                    agriData.agriculturePhotos!
                                        .removeAt(index);
                                    print(
                                        'agriBusinessData.agriculturePhotos:: ${agriData.agriculturePhotos?.length}');
                                  }

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
                    // Container for uploading new images
                    constSizedbox(context),
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
                                  agriData?.agriculturePhotos?.add(value);
                                  // print(
                                  //     'workPhotosList url length:: ${workPhotosList.length}');
                                  print(
                                      'agriBusinessData.agriculturePhotos:: ${agriData?.agriculturePhotos?.length}');
                                });
                              },
                            );
                          },
                        );
                      },

                      child: Padding(
                        padding: const EdgeInsets.only(right: 15),
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

                    ElevatedButton(
                        onPressed: () async {
                          final formData = AgricultreItems(
                            incomeSourceType: "agricultureBusiness",
                            agricultureData: AgricultureData(
                              nameOfAgriOwner: finalOptions,
                              haveYouFaced:
                                  incomeForm_TypeSignificantChallenge.text,
                              relationOfApplicant:
                                  incomeForm_Relationofapplicant.text,
                              kasraSurveyNo: incomeForm_KasraNo.text,
                              agriLandInBigha: incomeForm_AgrilandAcre.text,
                              otherName: incomeForm_OtherName.text,
                              otherRelation: incomeForm_OtherRelation.text,
                              otherRemark: incomeForm_OtherRemark.text,
                              villageName: incomeForm_villageName.text,
                              howMuchCropSoldInAmt: incomeForm_CropSOLD.text,
                              // Corrected field name
                              // agriculturePhotos: [
                              //   "/uploads/file_1732020760659.screenshot(76).png"
                              // ],
                              agriculturePhotos:
                                  agriData?.agriculturePhotos,
                              whichCropIsPlanted: [incomeForm_CropPlanted.text],
                              agriDoingFromNoOfYears:
                                  incomeForm_AgriFromYear.text,
                              addressAsPerPawti: incomeForm_AddressPawti.text,
                              districtName: incomeForm_DistrictName.text,
                              agriLandSurveyNo: incomeForm_AgrilandSurvey.text,
                              fertilizerShopOwnerName:
                                  incomeForm_FertilizerOwnername.text,
                              fertilizerShopOwnerContactNumber:
                                  incomeForm_FertilizerOwnerContact.text,
                              irrigationMethod:
                                  incomeForm_TypeofIrrigation.text,
                              significantChallengesThisSeason:
                                  incomeForm_SignificationSeason.text,
                              agriIncomeYearly: incomeForm_AgriIncome.text,
                              detailOfLastCorp: incomeForm_DetailLastCrop.text,
                              ifCropDestroyedHowToPayEMI:
                                  incomeForm_CropDestroyed.text,
                            ),
                          );

                          await viewModel.submitAgricultureForm(
                              formData, context,widget.customerId);
                          // if (_formKey.currentState!.validate()) {
                          //   final formData = AgricultureDataModel(
                          //     incomeSourceType: "agricultureBusiness",
                          //     data: AgricultureData(
                          //       nameOfAgriOwner: finalOptions,
                          //       haveYouFaced:
                          //           incomeForm_TypeSignificantChallenge.text,
                          //       relationOfApplicant:
                          //           incomeForm_Relationofapplicant.text,
                          //       kasraSurveyNo: incomeForm_KasraNo.text,
                          //       agriLandInBigha: incomeForm_AgrilandAcre.text,
                          //       otherName: incomeForm_OtherName.text,
                          //       otherRelation: incomeForm_OtherRelation.text,
                          //       otherRemark: incomeForm_OtherRemark.text,
                          //       villageName: incomeForm_villageName.text,
                          //       howMuchCropSoldInAmt: incomeForm_CropSOLD.text,
                          //       // Corrected field name
                          //       // agriculturePhotos: [
                          //       //   "/uploads/file_1732020760659.screenshot(76).png"
                          //       // ],
                          //       agriculturePhotos:
                          //           agriBusinessData.agriculturePhotos,
                          //       whichCropIsPlanted: [
                          //         incomeForm_CropPlanted.text
                          //       ],
                          //       agriDoingFromNoOfYears:
                          //           incomeForm_AgriFromYear.text,
                          //       addressAsPerPawti: incomeForm_AddressPawti.text,
                          //       districtName: incomeForm_DistrictName.text,
                          //       agriLandSurveyNo:
                          //           incomeForm_AgrilandSurvey.text,
                          //       fertilizerShopOwnerName:
                          //           incomeForm_FertilizerOwnername.text,
                          //       fertilizerShopOwnerContactNumber:
                          //           incomeForm_FertilizerOwnerContact.text,
                          //       irrigationMethod:
                          //           incomeForm_TypeofIrrigation.text,
                          //       significantChallengesThisSeason:
                          //           incomeForm_SignificationSeason.text,
                          //       agriIncomeYearly: incomeForm_AgriIncome.text,
                          //       detailOfLastCorp:
                          //           incomeForm_DetailLastCrop.text,
                          //       ifCropDestroyedHowToPayEMI:
                          //           incomeForm_CropDestroyed.text,
                          //     ),
                          //   );

                          //   await viewModel.submitAgricultureForm(
                          //       formData, context);
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
                        },
                        child: Text(
                          'Next',
                          style: AppStyles.whiteText16,
                        ))
                  ],
                ),
              ),
            ),
          );
        });
  }
}
