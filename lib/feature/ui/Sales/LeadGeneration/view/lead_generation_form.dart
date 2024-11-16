// views/lead_generation_form.dart
import 'dart:io';
import 'package:finexe/feature/base/utils/namespase/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import '../../../../base/utils/widget/custom_snackbar.dart';
import '../../../../base/utils/widget/dropdown_style.dart';
import '../../NewLone/view_model/new_loan_view_model.dart';
import '../model/lead_generation_model.dart';
import '../view_model/lead_generation_viewmodel.dart';

class LeadGenerationForm extends ConsumerStatefulWidget {
  LeadGenerationForm({Key? key}) : super(key: key);

  @override
  _LeadGenerationFormState createState() => _LeadGenerationFormState();
}

class _LeadGenerationFormState extends ConsumerState<LeadGenerationForm> {
  final TextEditingController customerNameController = TextEditingController();
  final TextEditingController customerMobileNoController = TextEditingController();
  final TextEditingController cityVillageController = TextEditingController();
  final TextEditingController districtController = TextEditingController();
  final TextEditingController pincodeController = TextEditingController();
  final TextEditingController branchController = TextEditingController();
  final TextEditingController loanAmountController = TextEditingController();
  final TextEditingController monthlyIncomeController = TextEditingController();
  final TextEditingController otherIncomeController =  TextEditingController(text: "Default Income Detail");
  final TextEditingController feedbackController = TextEditingController(text: "Default Feedback");
  final TextEditingController loanTypeController = TextEditingController();
  final TextEditingController squareFeetController = TextEditingController();
  final TextEditingController bighaController = TextEditingController();
  File? selfieImageUrl; // URL of selfie image
  final _formKey = GlobalKey<FormState>();

  bool pakkaHouse = false;
  bool agriland = false;

  bool showOtherIncomeField = false;
  bool feedbackField=false;

  final ImagePicker _picker = ImagePicker();

  Future<void> _captureSelfie() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.camera);
    if (image != null) {
      setState(() {
        selfieImageUrl = File(image.path); // Convert XFile to File
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = ref.read(leadGenerationViewModelProvider);
    final getAllProduct = ref.watch(fetchDataProvider);
    final getAllBranch = ref.watch(fetchAllBranchProvider);

    return Scaffold(
      /*appBar: AppBar(title: const Text('Lead Generation')),*/
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        title: Text("Lead Generation",style: TextStyle(color: Colors.white)),
        leading: IconButton(
          icon: Icon(Icons.arrow_back,color: Colors.white,),
          onPressed: () => Navigator.of(context).pop(),
        ),

      ),
      body:
      SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [

                buildForm(
                  /* formKey: _nameFormKey,*/
                  controller: customerNameController,
                  label: 'Customer Name *',
                  keyboardType: TextInputType.text,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter Name';
                    }
                    return null;
                  },
                ),

                buildForm(
                  /* formKey: _nameFormKey,*/
                  controller: customerMobileNoController,
                  label: 'Customer Mobile No. *',
                  keyboardType: TextInputType.phone,
                  maxLength: 10,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter contact number';
                    }
                    return null;
                  },
                ),

                Row(
                  children: [
                    Expanded(
                      child: buildForm(
                        controller: cityVillageController,
                        label: 'City/Village Name *',
                        keyboardType: TextInputType.text,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter City/Village Name';
                          }
                          return null;
                        },
                      ),
                    ),
                    SizedBox(width: 10), // Optional spacing between the fields
                    Expanded(
                      child: buildForm(
                        controller: districtController,
                        label: 'District Name *',
                        keyboardType: TextInputType.text,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter District Name';
                          }
                          return null;
                        },
                      ),
                    ),
                  ],
                ),

                Row(
                  children: [

                    Expanded(
                      child: buildForm(
                        /* formKey: _nameFormKey,*/
                        controller: pincodeController,
                        label: 'Pincode *',
                        keyboardType: TextInputType.number,
                        maxLength: 6,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter Pincode';
                          }
                          return null;
                        },
                      ),
                    ),

                  ],
                ),

                /*  Row(
                  children: [
                    // Optional spacing between the fields
                    Expanded(
                      child: DropdownButtonFormField<String>(
                        value: branchController.text.isEmpty ? null : branchController.text,
                        onChanged: (value) {
                          branchController.text = value!;
                        },
                        items: itemList.map((item) {
                          return DropdownMenuItem<String>(
                            value: item.id, // Or whatever field you need
                            child: Text(item.productName),
                          );
                        }).toList(),
                        decoration: dropdownDecoration('Select Branch *'),
                        *//* decoration: InputDecoration(
                        labelText: 'Monthly Income *',
                        border: OutlineInputBorder(),
                      ),*//*
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please select Branch';
                          }
                          return null;
                        },
                      ),
                    ),

                  ],
                ),*/

                Row(
                  children: [
                    Expanded(
                      child: getAllBranch.when(
                        data: (itemList) {
                          return DropdownButtonFormField<String>(
                            value: branchController.text.isEmpty ? null : branchController.text,
                            onChanged: (value) {
                              branchController.text = value!;
                            },
                            items: itemList.map((item) {
                              return DropdownMenuItem<String>(
                                value: item.id, // Or whatever field you need
                                child: Text(item.name),
                              );
                            }).toList(),
                            decoration: dropdownDecoration('Select Branch *'),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please select Branch';
                              }
                              return null;
                            },
                          );
                        },
                        loading: () {
                          return const Center(child: CircularProgressIndicator());
                        },
                        error: (error, _) => Text('Failed to load branch'),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 10),

                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,

                  children: [
                    Text(
                      'Type of construction ',
                      style: TextStyle(fontSize: 16,color: Colors.grey), // Add any styling as needed
                    ),
                    Icon(
                      Icons.arrow_forward, // The forward arrow icon
                      size: 20,            // Adjust size as needed
                      color: Colors.grey,   // Adjust color as needed
                    ),
                  ],
                ),



                Row(
                  children: [
                    Checkbox(
                      value: pakkaHouse,
                      onChanged: (value) {
                        setState(() {
                          pakkaHouse = value ?? false;
                        });
                      },
                    ),
                    const Text(
                      "Pakka House",
                      style: TextStyle(color: Colors.grey), // Set the text color
                    ),
                    Checkbox(
                      value: agriland,
                      onChanged: (value) {
                        setState(() {
                          agriland = value ?? false;
                        });
                      },
                    ),
                    const Text(
                      "Agriland",
                      style: TextStyle(color: Colors.grey), // Set a different text color
                    ),
                  ],
                ),


                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (pakkaHouse)
                      Expanded(
                        child:  buildForm(
                          /* formKey: _nameFormKey,*/
                          controller: squareFeetController,
                          label: 'Construction(in Sqr Ft)',
                          keyboardType: TextInputType.number,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter Square Feet';
                            }
                            return null;
                          },
                        ),
                      ),
                    SizedBox(width: 10), // Optional spacing between the fields
                    if (agriland) // Show Bigha field if Agriland is checked
                      Expanded(
                        child: buildForm(
                          /* formKey: _nameFormKey,*/
                          controller: bighaController,
                          label: 'Total Land(Bigha)',
                          keyboardType: TextInputType.number,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter Bigha';
                            }
                            return null;
                          },
                        ),
                      ),
                  ],
                ),

                SizedBox(height: 10),

                Row(
                  children: [
                    Expanded(
                      child: DropdownButtonFormField<String>(
                        value: loanAmountController.text.isEmpty ? null : loanAmountController.text,
                        onChanged: (value) {
                          loanAmountController.text = value!;
                        },
                        items: viewModel.loanAmountOptions.map((String option) {
                          return DropdownMenuItem<String>(
                            value: option,
                            child: Text(option),
                          );
                        }).toList(),
                        decoration: dropdownDecoration('Required Loan Amount *'),

                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please select loan amount';
                          }
                          return null;
                        },
                      ),
                    ),
                    SizedBox(width: 10), // Optional spacing between the fields
                    Expanded(
                      child: DropdownButtonFormField<String>(
                        value: monthlyIncomeController.text.isEmpty ? null : monthlyIncomeController.text,
                        onChanged: (value) {
                          monthlyIncomeController.text = value!;
                        },
                        items: viewModel.monthlyIncomeOptions.map((String option) {
                          return DropdownMenuItem<String>(
                            value: option,
                            child: Text(option),
                          );
                        }).toList(),
                        decoration: dropdownDecoration('Monthly Income *'),
                        /* decoration: InputDecoration(
                        labelText: 'Monthly Income *',
                        border: OutlineInputBorder(),
                      ),*/
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please select monthly income';
                          }
                          return null;
                        },
                      ),
                    ),
                  ],

                ),

                SizedBox(height: 10),

                if (showOtherIncomeField)
                  buildForm(
                    /* formKey: _nameFormKey,*/
                    controller: otherIncomeController,
                    label: 'Other Source of Income - Detail',
                    keyboardType: TextInputType.text,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter Other Source of Income';
                      }
                      return null;
                    },
                  ),


                if (feedbackField)
                  buildForm(
                    /* formKey: _nameFormKey,*/
                    controller: feedbackController,
                    label: 'Customer Feedback',
                    keyboardType: TextInputType.text,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter Customer Feedback';
                      }
                      return null;
                    },
                  ),


                /* Row(
                  children: [
                    Expanded(
                      child: DropdownButtonFormField<String>(
                        value: loanTypeController.text.isEmpty ? null : loanTypeController.text,
                        onChanged: (value) {
                          loanTypeController.text = value!;
                        },
                        items: itemList.map((item) {
                          return DropdownMenuItem<String>(
                            value: item.id, // Or whatever field you need
                            child: Text(item.productName),
                          );
                        }).toList(),
                        decoration: dropdownDecoration('Loan Type *'),
                        *//* decoration: InputDecoration(
                            labelText: 'Monthly Income *',
                            border: OutlineInputBorder(),
                          ),*//*
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Select Loan Type';
                          }
                          return null;
                        },
                      ),
                    ),


                  ],
                ),*/

                // Loan Type Dropdown (Using getAllBranch response)
                Row(
                  children: [
                    Expanded(
                      child: getAllProduct.when(
                        data: (Item) {
                          return DropdownButtonFormField<String>(
                            value: loanTypeController.text.isEmpty ? null : loanTypeController.text,
                            onChanged: (value) {
                              loanTypeController.text = value!;
                            },
                            items: Item.map((item) {
                              return DropdownMenuItem<String>(
                                value: item.id, // Or whatever field you need
                                child: Text(item.productName),
                              );
                            }).toList(),
                            decoration: dropdownDecoration('Select Loan Type *'),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Select Loan Type';
                              }
                              return null;
                            },
                          );
                        },
                        loading: () {
                          return const Center(child: CircularProgressIndicator());
                        },
                        /* loading: () => CircularProgressIndicator(),*/
                        error: (error, _) => Text('Failed to load branches'),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 20),
                // Display the captured selfie image if available

                Row(
                  mainAxisAlignment: MainAxisAlignment.center, // Use center instead of spaceAround
                  children: [
                    // First column with image and selfie button
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center, // Center the column content
                      children: [
                        if (selfieImageUrl != null)
                          Image.file(
                            selfieImageUrl!,
                            width: 150,
                            height: 100,
                          ),
                        // const SizedBox(height: 0), // Spacing between image and button

                        // Selfie button with centered text
                        SizedBox(
                          width: 200, // Adjust width as needed
                          child: ElevatedButton(
                            onPressed: _captureSelfie,
                            child: Text(
                              'Selfie with customer',
                              textAlign: TextAlign.center, // Ensure text is centered
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(width: 10), // Optional spacing between the two columns

                    // Second column with only the submit button
                    SizedBox(
                      width: 100, // Adjust width as needed
                      child: ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            final leadData = LeadGenerationModel(
                              customerName: customerNameController.text,
                              customerMobileNo: customerMobileNoController.text,
                              cityVillageName: cityVillageController.text,
                              districtName: districtController.text,
                              pincode: pincodeController.text,
                              branch: branchController.text,
                              pakkaHouse: squareFeetController.text,
                              agriland: bighaController.text,
                              requiredLoanAmount: loanAmountController.text,
                              monthlyIncome: monthlyIncomeController.text,
                              otherSourceOfIncome: otherIncomeController.text,
                              customerFeedback: feedbackController.text,
                              loanType: loanTypeController.text,
                              selfieImageUrl: selfieImageUrl?.path ?? '',
                            );
                            viewModel.leadFormSubmit(leadData, context);
                          } else {
                            showCustomSnackBar(context, 'Please fill all the fields', Colors.red);
                          }
                        },
                        child: Text(
                          'Submit',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),

              ],
            ),
          ),
        ),
      ),

      //),
    );
  }




  Widget buildForm({
    required TextEditingController controller,
    required String label,
    required TextInputType keyboardType,
    int? maxLength,
    required String? Function(String?) validator,
    List<TextInputFormatter>? inputFormatters,
    TextCapitalization textCapitalization = TextCapitalization.none,
    bool obscureText = false,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      child: TextFormField(
        controller: controller,
        keyboardType: keyboardType,
        maxLength: maxLength,
        inputFormatters: inputFormatters,
        textCapitalization: textCapitalization,
        obscureText: obscureText,
        cursorColor: AppColors.primary,
        validator: validator,
        decoration: InputDecoration(
          labelText: label,
          contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 12.0), // Adjust vertical padding
          labelStyle: TextStyle(color: Colors.grey),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
            borderSide: BorderSide(color: Colors.grey),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
            borderSide: BorderSide(color: AppColors.primary),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
            borderSide: BorderSide(color: Colors.red),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
            borderSide: BorderSide(color: Colors.red),
          ),
          filled: true,
          fillColor: Colors.white,
        ),
      ),
    );
  }



}

