

import 'package:finexe/feature/base/internetConnection/networklistener.dart';
import 'package:finexe/feature/base/utils/widget/app_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import '../../../../base/utils/namespase/app_colors.dart';
import '../../../../base/utils/widget/custom_text_form.dart';
import '../model/leave_request_model.dart';
import '../view_model/leave_request_view_model.dart';

class LeaveRequestForm extends ConsumerStatefulWidget {
  const LeaveRequestForm({super.key});

  @override
  ConsumerState<LeaveRequestForm> createState() => _LeaveRequestFormState();
}

class _LeaveRequestFormState extends ConsumerState<LeaveRequestForm> {
  final _formKey = GlobalKey<FormState>();
  final _leaveReasonController = TextEditingController();
  DateTime? _startDate;
  DateTime? _endDate;

  void _pickDate(BuildContext context, bool isStartDate) async {
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(), // Disable past dates
      lastDate: DateTime(2100),
    );

    if (pickedDate != null) {
      setState(() {
        if (isStartDate) {
          _startDate = pickedDate;
        } else {
          _endDate = pickedDate;
        }
      });
    }
  }

  void _submitForm() async {
    if (_formKey.currentState!.validate() && _startDate != null && _endDate != null) {
      final viewModel = ref.read(leaveRequestViewModelProvider);
      final formattedStartDate = DateFormat('yyyy-MM-dd').format(_startDate!);
      final formattedEndDate = DateFormat('yyyy-MM-dd').format(_endDate!);

      final leadData = LeaveRequestItem(
        startDate: formattedStartDate,
        endDate: formattedEndDate,
        reasonForLeave: _leaveReasonController.text.trim(),
      );

      try {
        viewModel.submitLeaveRequest(leadData, context);

      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(e.toString())),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please fill all fields")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return NetworkListener(
      context: context,
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Leave Request Form",style: TextStyle(color: Colors.white)),
          backgroundColor: AppColors.primary,
          centerTitle: true,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back,color: Colors.white,),
            onPressed: () => Navigator.pop(context),
          ),
        ),
      
      
      
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                const SizedBox(height: 20),
                TextFormField(
                  readOnly: true,
                  decoration: customInputDecoration(
                    "Start Date",
                    suffixIcon: IconButton(
                      icon: const Icon(Icons.calendar_month,color: AppColors.primary,),
                      onPressed: () => _pickDate(context, true),
                    ),
                  ),
                  controller: TextEditingController(
                    text: _startDate != null
                        ? DateFormat('yyyy-MM-dd').format(_startDate!)
                        : '',
                  ),
                  validator: (value) => value == null || value.isEmpty
                      ? "Please select a start date"
                      : null,
                ),
                const SizedBox(height: 16),
                TextFormField(
                  readOnly: true,
                  decoration: customInputDecoration(
                    "End Date",
                    suffixIcon: IconButton(
                      icon: const Icon(Icons.calendar_month,color: AppColors.primary,),
                      onPressed: () => _pickDate(context, false),
                    ),
                  ),
                  controller: TextEditingController(
                    text: _endDate != null
                        ? DateFormat('yyyy-MM-dd').format(_endDate!)
                        : '',
                  ),
                  validator: (value) => value == null || value.isEmpty
                      ? "Please select an end date"
                      : null,
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _leaveReasonController,
                  decoration: customInputDecoration("Leave Reason"),
                  maxLines: 3,
                  validator: (value) => value == null || value.isEmpty
                      ? "Please enter a leave reason"
                      : null,
                ),
                const SizedBox(height: 32),
                AppButton(onTap: _submitForm,label: 'Submit',isFill: true,),
                // ElevatedButton(
                //   onPressed: _submitForm,
                //   style: ElevatedButton.styleFrom(
                //     backgroundColor: AppColors.primary, // Set your desired background color here
                //     foregroundColor: Colors.white, // This sets the text and icon color
                //   ),
                //   child: const Text("Submit",),
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }


}
