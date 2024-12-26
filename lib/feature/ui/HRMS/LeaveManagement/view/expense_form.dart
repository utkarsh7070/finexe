
import 'package:finexe/feature/base/utils/namespase/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../base/api/api.dart';
import '../../../../base/utils/widget/custom_snackbar.dart';
import '../../../../base/utils/widget/custom_text_form.dart';
import '../../../../base/utils/widget/dropdown_style.dart';
import '../view_model/expense_form_view_model.dart';

class ExpenseForm extends ConsumerStatefulWidget {
  const ExpenseForm({super.key});

  @override
  _ExpenseFormState createState() => _ExpenseFormState();
}

class _ExpenseFormState extends ConsumerState<ExpenseForm> {

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {

    final controllerNotifier = ref.watch(expenseFormControllerProvider);
    final getAllReportingManager = ref.watch(fetchAllManagerProvider(context));
    final getAllEmployee=ref.watch(fetchAllEmployeeProvider(context));

    // Access state or handle form submission here
    final viewModel = ref.read(expenseSubmitViewModelProvider.notifier);
    final expenseImageUrl = viewModel.state.uploadedSelfieUrl;

    return Scaffold(
      /*appBar: AppBar(title: const Text('Lead Generation')),*/
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        title: const Text("Expense Form",style: TextStyle(color: Colors.white)),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back,color: Colors.white,),
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
                  controller: controllerNotifier.merchantNameController,
                  label: 'Merchant Name *',
                  keyboardType: TextInputType.text,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter Merchant';
                    }
                    return null;
                  },
                ),

                const SizedBox(height: 5),

                 DropdownButtonFormField<String>(
                  value: controllerNotifier.expenseCategoryController.text.isEmpty ? null : controllerNotifier.expenseCategoryController.text,
                  onChanged: (value) {
                    controllerNotifier.expenseCategoryController.text = value!;
                  },
                  items: controllerNotifier.expenseCategoryOptions.map((String option) {
                    return DropdownMenuItem<String>(
                      value: option,
                      child: Text(option),
                    );
                  }).toList(),
                  decoration: dropdownDecoration('Category *'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please select Category';
                    }
                    return null;
                  },
                ),

                const SizedBox(height: 10),

                getAllEmployee.when(
                  data: (itemList) {
                    return DropdownButtonFormField<String>(
                      value: controllerNotifier.employeeListController.text.isEmpty ? null : controllerNotifier.employeeListController.text,
                      onChanged: (value) {
                        controllerNotifier.employeeListController.text = value!;
                      },
                      items: itemList.map((item) {
                        return DropdownMenuItem<String>(
                          value: item.id, // Or whatever field you need
                          child: Text(item.employeName!),
                        );
                      }).toList(),
                      decoration: dropdownDecoration('Attendees *'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Select Attendees';
                        }
                        return null;
                      },
                    );
                  },
                  loading: () {
                    return const Center(child: CircularProgressIndicator());
                  },
                  error: (error, _) => const Text('Failed to load Employee list'),
                ),

                const SizedBox(height: 10),

                       getAllReportingManager.when(
                        data: (itemList) {
                          return DropdownButtonFormField<String>(
                            value: controllerNotifier.repManagerController.text.isEmpty ? null : controllerNotifier.repManagerController.text,
                            onChanged: (value) {
                              controllerNotifier.repManagerController.text = value!;
                            },
                            items: itemList.map((item) {
                              return DropdownMenuItem<String>(
                                value: item.id, // Or whatever field you need
                                child: Text(item.name),
                              );
                            }).toList(),
                            decoration: dropdownDecoration('Reporting Manager *'),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Select Reporting Manager';
                              }
                              return null;
                            },
                          );
                        },
                        loading: () {
                          return const Center(child: CircularProgressIndicator());
                        },
                        error: (error, _) => const Text('Failed to load Report Manager'),
                      ),

                const SizedBox(height: 10),

                TextFormField(
                  readOnly: true,
                  controller: controllerNotifier.startDateController,
                  decoration: customInputDecoration(
                    "Expense Date",
                    suffixIcon: IconButton(
                      icon: const Icon(Icons.calendar_month, color: AppColors.primary),
                      onPressed: () => controllerNotifier.pickDate(context),
                    ),
                  ),
                  validator: (value) => value == null || value.isEmpty
                      ? "Please select a Expense date"
                      : null,
                ),

                const SizedBox(height: 10),

                TextFormField(
                  controller: controllerNotifier.descriptionController,
                  decoration: customInputDecoration("Description *",),
                  keyboardType: TextInputType.multiline,
                  maxLines: 5, // Set the number of lines (adjust as needed)
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a description';
                    }
                    return null;
                  },
                ),

                const SizedBox(height: 5),

                buildForm(
                  controller: controllerNotifier.totalAmountController,
                  label: 'Total Amount *',
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter Amount';
                    }
                    return null;
                  },
                ),


                const SizedBox(height: 10),
                // Display the captured selfie image if available

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Image display
                Consumer(builder: (context, ref, _) {
                  final selfieUrl = ref.watch(expenseSubmitViewModelProvider).uploadedSelfieUrl;
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      if (selfieUrl != null)
                        Image.network(
                          '${Api.imageUrl}$selfieUrl',
                          width: 150,
                          height: 100,
                          fit: BoxFit.cover,
                        ),
                      // Attach image button
                      SizedBox(
                        width: 200,
                        child: ElevatedButton(
                          onPressed: () async {
                            await ref.read(expenseSubmitViewModelProvider.notifier).pickImage();
                          },
                          child: const Text(
                            'Attach Expense Image',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
                }),

              ],
            ),

                const SizedBox(height: 20),
                // Second column with only the submit button
                SizedBox(
                  width: 100, // Adjust width as needed
                  child: ElevatedButton(
                    onPressed: () async {

                      if (expenseImageUrl != null) {
                        // Include imageUrl in your form submission logic
                      //  await submitForm(expenseImageUrl);
                      } else {
                        showCustomSnackBar(context, 'Please attach an image first', Colors.red);
                      }

                    /*  if (_formKey.currentState!.validate()) {
                        final viewModel = ref.read(leadGenerationViewModelProvider);

                        await viewModel.leadFormSubmit(leadData, context);
                      } else {
                        showCustomSnackBar(context, 'Please fill all the fields', Colors.red);
                      }*/
                    },
                    child: const Text(
                      'Submit',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 20),

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
          contentPadding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 12.0), // Adjust vertical padding
          labelStyle: const TextStyle(color: Colors.grey),

          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
          //  borderSide: const BorderSide(color: Colors.grey),
            borderSide: const BorderSide(
              color: Colors.grey,
              width: 0.5,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
            borderSide: const BorderSide(color: AppColors.primary),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
            borderSide: const BorderSide(color: Colors.red),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
            borderSide: const BorderSide(color: Colors.red),
          ),
          filled: true,
          fillColor: Colors.white,
        ),
      ),
    );
  }



}
