import 'dart:io';

import 'package:dropdown_textfield/dropdown_textfield.dart';
import 'package:finexe/feature/base/utils/namespase/display_size.dart';
import 'package:finexe/feature/ui/PD/view/PD%20Form/pd_fromfilds.dart/view/Income%20Details/view/Agriculutre/view_model/agri_view_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../../../../../base/utils/namespase/app_colors.dart';
import '../../../../../../../Common Widgets/CustomDropdownWithCross.dart';
import '../../../../../../../Common Widgets/common_textfield.dart';
import '../../../../../../../Common Widgets/simple_dropdown.dart';
import '../Milk Form/milkviewmodel.dart';

class AgricultureIncomeDetail extends ConsumerStatefulWidget {
  const AgricultureIncomeDetail({super.key});

  @override
  _AgricultureIncomeDetailState createState() =>
      _AgricultureIncomeDetailState();
}

class _AgricultureIncomeDetailState
    extends ConsumerState<AgricultureIncomeDetail> {
  TextEditingController incomeForm_AgriOwner = TextEditingController();
  TextEditingController incomeForm_KasraNo = TextEditingController();
  TextEditingController incomeForm_Relationofapplicant =
      TextEditingController();
  TextEditingController incomeForm_AgrilandAcre = TextEditingController();
  TextEditingController incomeForm_AddressPawti = TextEditingController();
  TextEditingController incomeForm_DistrictName = TextEditingController();
  TextEditingController incomeForm_AgrilandSurvey = TextEditingController();
  TextEditingController incomeForm_FertilizerOwnername =
      TextEditingController();
  TextEditingController incomeForm_FertilizerOwnerContact =
      TextEditingController();
  TextEditingController incomeForm_TypeofIrrigation = TextEditingController();
  TextEditingController incomeForm_TypeSignificantChallenge =
      TextEditingController();
  TextEditingController incomeForm_SignificationSeason =
      TextEditingController();
  TextEditingController incomeForm_AgriIncome = TextEditingController();
  TextEditingController incomeForm_CropDestroyed = TextEditingController();
  TextEditingController incomeForm_CropPlanted = TextEditingController();
  TextEditingController incomeForm_AgriFromYear = TextEditingController();
  TextEditingController incomeForm_DetailLastCrop = TextEditingController();
  TextEditingController incomeForm_CropSOLD = TextEditingController();
  TextEditingController incomeForm_OtherRelation = TextEditingController();
  TextEditingController incomeForm_OtherName = TextEditingController();
  TextEditingController incomeForm_OtherRemark = TextEditingController();

  final Set<String> selectedOptions = {"Ravi Mehta", "Sumit Rathod "};
  bool isOtherSelected = false;
  bool isDropdownOpen = false;

  // Function to toggle the selection of options
  void toggleOption(String option) {
    setState(() {
      if (option == "Other") {
        isOtherSelected = !isOtherSelected;
      } else {
        if (selectedOptions.contains(option)) {
          selectedOptions.remove(option);
        } else {
          selectedOptions.add(option);
        }
      }
    });
  }

  // Function to toggle dropdown open/close
  void toggleDropdown() {
    setState(() {
      isDropdownOpen = !isDropdownOpen;
    });
  }

  final _formKey = GlobalKey<FormState>();

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
      incomeForm_CropPlanted.text = selectedCrops.join(', ');
    });
  }

  @override
  Widget build(BuildContext context) {
    final images =
        ref.watch(agriimageUploadProvider); // Watch the image list state
    final imageNotifier = ref.read(agriimageUploadProvider.notifier);
    return SingleChildScrollView(
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 0),
              child: GestureDetector(
                onTap: toggleDropdown,
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey, width: 1),
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white.withOpacity(0.7), // Semi-transparent
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 8),
                      // Toggle Button for Dropdown (Open/Close)
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            isDropdownOpen
                                ? "Select Agri Owner"
                                : "Name of Agri Owner",
                            style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                color: isDropdownOpen
                                    ? Color(0xff0082c6)
                                    : Colors.grey),
                          ),
                          Icon(
                            isDropdownOpen
                                ? Icons.arrow_drop_up
                                : Icons.arrow_drop_down,
                            color: isDropdownOpen
                                ? Color(0xff0082c6)
                                : Colors.grey,
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      // Display options when dropdown is open
                      if (isDropdownOpen) ...[
                        CheckboxListTile(
                          value: selectedOptions.contains("Ravi"),
                          onChanged: (_) => toggleOption("Ravi"),
                          title: Text(
                            "Ravi",
                            style: TextStyle(
                              color: selectedOptions.contains("Ravi")
                                  ? AppColors.primary
                                  : AppColors.black, // Change title text color
                              fontWeight: FontWeight.w400, // Change font weight
                            ),
                          ),
                          controlAffinity: ListTileControlAffinity.leading,
                          activeColor:
                              AppColors.primary, // Checkbox color when selected
                        ),
                        CheckboxListTile(
                          value: selectedOptions.contains("Sagar"),
                          onChanged: (_) => toggleOption("Sagar"),
                          title: Text(
                            "Sagar",
                            style: TextStyle(
                              color: selectedOptions.contains("Sagar")
                                  ? AppColors.primary
                                  : Colors.black,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          controlAffinity: ListTileControlAffinity.leading,
                          selectedTileColor: AppColors
                              .primary, // Background color when selected
                          activeColor:
                              Color(0xff0082c6), // Checkbox color when selected
                        ),
                        CheckboxListTile(
                          value: isOtherSelected,
                          onChanged: (_) => toggleOption("Other"),
                          title: Text(
                            "Other",
                            style: TextStyle(
                              color: isOtherSelected
                                  ? Color(0xff0082c6)
                                  : Colors.black,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          controlAffinity: ListTileControlAffinity.leading,
                          activeColor: Color(0xff0082c6),
                        ),
                      ],
                    ],
                  ),
                ),
              ),
            ),

            if (isOtherSelected)
              Padding(
                padding: const EdgeInsets.only(right: 15, top: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
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
                    sizedBoxWithContext(context, 0.03),
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
                    sizedBoxWithContext(context, 0.03),
                    CustomTextFormField(
                      //  width: ,
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
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            print("Upload Image button clicked");
                          },
                          child: const Text(
                            "Upload Document",
                            style: TextStyle(color: Colors.white),
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                                Color(0xff0082c6), // Set button color to blue
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8, vertical: 14),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(
                                  12), // Adjust the border radius as needed
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            print("Upload Image button clicked");
                          },
                          child: Text(
                            "Preview Document Image",
                            style: TextStyle(
                                color: Colors.blue,
                                fontSize: 14.5,
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

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
                textInputAction: TextInputAction.next,
                textInputType: TextInputType.name,
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
                inerHint: 'Agri Land in Acre',
                onValidate: (value) {
                  if (value?.trim().isEmpty ?? true) {
                    return "This is a required field";
                  }
                  return null;
                },
                controller: incomeForm_AgrilandAcre,
                textInputAction: TextInputAction.next,
                textInputType: TextInputType.name,
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
                textInputType: TextInputType.name,
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
                controller: incomeForm_Relationofapplicant,
                textInputAction: TextInputAction.next,
                textInputType: TextInputType.name,
              ),
            ),

            sizedBoxWithContext(context, 0.03),
            Padding(
              padding: const EdgeInsets.only(right: 18),
              child: CustomDropDownTextField(
                items: [
                  DropDownValueModel(name: "Rainfed", value: "Rainfed"),
                  DropDownValueModel(name: "Tubewell", value: "Tubewell"),
                  DropDownValueModel(
                      name: "Canal Irrigation", value: "Canal Irrigation"),
                  DropDownValueModel(
                      name: "Drip Irrigation", value: "Drip Irrigation"),
                  DropDownValueModel(
                      name: "Sprinkle System", value: "Sprinkle System"),
                ],
                labelText: " What Type of Irrigation Method",
                controller: incomeForm_TypeofIrrigation, // Pass controller
              ),
            ),

            sizedBoxWithContext(context, 0.03),
            Padding(
              padding: const EdgeInsets.only(right: 18),
              child: CustomDropDownTextField(
                items: [
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
                textInputType: TextInputType.name,
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
                items: [
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
                placeholder: "Which crop is planted",
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
                controller: incomeForm_CropDestroyed,
                textInputAction: TextInputAction.next,
                textInputType: TextInputType.name,
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Land Book Image',
                style: TextStyle(
                    color: Colors.blueAccent,
                    fontSize: 16,
                    fontWeight: FontWeight.w500),
                textAlign: TextAlign.start,
              ),
            ),

            // Display uploaded images
            ...images.asMap().entries.map((entry) {
              final int index = entry.key;
              final File image = entry.value;

              return Stack(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Container(
                      height: MediaQuery.of(context).size.height * 0.2,
                      width: MediaQuery.of(context).size.width * 0.8,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: Colors.grey,
                          width: 1,
                        ),
                        image: DecorationImage(
                          image: FileImage(image),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    right: -2,
                    child: GestureDetector(
                      onTap: () {
                        imageNotifier.removeImage(index); // Remove the image
                      },
                      child: Image.asset(
                        'assets/images/remove.png',
                        height: 20,
                        width: 20,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ],
              );
            }).toList(),
            // Container for uploading new images
            GestureDetector(
              onTap: () => imageNotifier.pickImage(),
              child: Container(
                height: MediaQuery.of(context).size.height * 0.2,
                width: MediaQuery.of(context).size.width * 0.8,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: Colors.grey,
                    width: 1,
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Icon(Icons.upload),
                    Text('Drop your file here'),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
