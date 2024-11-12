// views/lead_generation_form.dart
import 'dart:io';

import 'package:finexe/feature/base/utils/namespase/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../base/utils/widget/custom_snackbar.dart';
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
  final TextEditingController otherIncomeController = TextEditingController();
  final TextEditingController feedbackController = TextEditingController();
  final TextEditingController loanTypeController = TextEditingController();
  final TextEditingController squareFeetController = TextEditingController();
  final TextEditingController bighaController = TextEditingController();
  File? selfieImageUrl; // URL of selfie image
  final _formKey = GlobalKey<FormState>();

  bool pakkaHouse = false;
  bool agriland = false;

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

    return Scaffold(
      /*appBar: AppBar(title: const Text('Lead Generation')),*/
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        title: Text("Lead Generation"),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),

      ),
      body: SingleChildScrollView(
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
              buildForm(
                /* formKey: _nameFormKey,*/
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
              /*TextField(
                controller: customerNameController,
                decoration: const InputDecoration(labelText: 'Customer Name *'),
              ),*/
             /* TextField(
                controller: customerMobileNoController,
                decoration: const InputDecoration(labelText: 'Customer Mobile No. *'),
                keyboardType: TextInputType.phone,
              ),*/
              /*TextField(
                controller: cityVillageController,
                decoration: const InputDecoration(labelText: 'City/Village Name *'),
              ),*/
              buildForm(
                /* formKey: _nameFormKey,*/
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
              buildForm(
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
              /*TextField(
                controller: districtController,
                decoration: const InputDecoration(labelText: 'District Name *'),
              ),*/
              /*TextField(
                controller: pincodeController,
                decoration: const InputDecoration(labelText: 'Pincode *'),
                keyboardType: TextInputType.number,
              ),*/

              buildForm(
                /* formKey: _nameFormKey,*/
                controller: branchController,
                label: 'Select Branch *',
                keyboardType: TextInputType.text,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please Select Branch';
                  }
                  return null;
                },
              ),
             /* TextField(
                controller: branchController,
                decoration: const InputDecoration(labelText: 'Select Branch'),
              ),*/
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
                  const Text("Pakka House"),
                  Checkbox(
                    value: agriland,
                    onChanged: (value) {
                      setState(() {
                        agriland = value ?? false;
                      });
                    },
                  ),
                  const Text("Agriland"),
                ],
              ),
              if (pakkaHouse) // Show Square Feet field if Pakka House is checked
                buildForm(
                  /* formKey: _nameFormKey,*/
                  controller: squareFeetController,
                  label: 'Square Feet *',
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter Square Feet';
                    }
                    return null;
                  },
                ),
               /* TextField(
                  controller: squareFeetController,
                  decoration: const InputDecoration(labelText: 'Square Feet *'),
                  keyboardType: TextInputType.number,
                ),*/
              if (agriland) // Show Bigha field if Agriland is checked
                buildForm(
                  /* formKey: _nameFormKey,*/
                  controller: bighaController,
                  label: 'Bigha *',
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter Bigha';
                    }
                    return null;
                  },
                ),
                /*TextField(
                  controller: bighaController,
                  decoration: const InputDecoration(labelText: 'Bigha *'),
                  keyboardType: TextInputType.number,
                ),*/

              buildForm(
                /* formKey: _nameFormKey,*/
                controller: loanAmountController,
                label: 'Required Loan Amount *',
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter loan amount';
                  }
                  return null;
                },
              ),

              /*TextField(
                controller: loanAmountController,
                decoration: const InputDecoration(labelText: 'Required Loan Amount *'),
                keyboardType: TextInputType.number,
              ),*/

              buildForm(
                /* formKey: _nameFormKey,*/
                controller: monthlyIncomeController,
                label: 'Monthly Income *',
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter Monthly Income';
                  }
                  return null;
                },
              ),
             /* TextField(
                controller: monthlyIncomeController,
                decoration: const InputDecoration(labelText: 'Monthly Income *'),
                keyboardType: TextInputType.number,
              ),*/

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

             /* TextField(
                controller: otherIncomeController,
                decoration: const InputDecoration(labelText: 'Other Source of Income - Detail'),
              ),*/

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

             /* TextField(
                controller: feedbackController,
                decoration: const InputDecoration(labelText: 'Customer Feedback'),
              ),*/

              buildForm(
                /* formKey: _nameFormKey,*/
                controller: loanTypeController,
                label: 'Loan Type *',
                keyboardType: TextInputType.text,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter Loan Type';
                  }
                  return null;
                },
              ),
             /* TextField(
                controller: loanTypeController,
                decoration: const InputDecoration(labelText: 'Loan Type *'),
              ),*/
              const SizedBox(height: 20),
              // Display the captured selfie image if available
              if (selfieImageUrl != null)
                Image.file(
                  selfieImageUrl!,
                  width: 150,
                  height: 100,
                ),
              const SizedBox(height: 10),

              SizedBox(
                width: 250,
                child: ElevatedButton(
                  onPressed: _captureSelfie,
                  /*child: const Text("Selfie with customer"),*/
                  child: Text(
                    'Selfie with customer',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ), // Set text color to white
                
                  ),
                ),
              ),

              SizedBox(height: 20),

              SizedBox(
                width: 250,
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
                 /* child: const Text("Submit"),*/
                  child: Text(
                  'Submit',
                  style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  ), // Set text color to white

                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      ),
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
      padding: const EdgeInsets.symmetric(vertical: 8.0),
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

