

import 'package:finexe/feature/base/internetConnection/networklistener.dart';
import 'package:finexe/feature/base/utils/widget/app_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import '../../../../base/utils/namespase/app_colors.dart';
import '../../../../base/utils/widget/custom_text_form.dart';
import '../../../../base/utils/widget/dropdown_style.dart';
import '../model/leave_request_model.dart';
import '../view_model/leave_request_view_model.dart';

class LeaveRequestForm extends ConsumerStatefulWidget {
  const LeaveRequestForm({super.key});

  @override
  ConsumerState<LeaveRequestForm> createState() => _LeaveRequestFormState();
}

class _LeaveRequestFormState extends ConsumerState<LeaveRequestForm> {


  @override
  Widget build(BuildContext context) {


    final fetchLeaveType=ref.watch(fetchLeaveTypeProvider);
    final viewModel = ref.watch(leaveRequestViewModelProvider);

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
          /*  key: _formKey,*/
            child: SingleChildScrollView(
              physics: AlwaysScrollableScrollPhysics(),

              child: Column(
                children: [
                  const SizedBox(height: 20),
                  TextFormField(

                    controller: viewModel.leaveTittleController,
                    decoration: customInputDecoration("Tittle"),
                    maxLines: 1,
                    validator: (value) => value == null || value.isEmpty
                        ? "Please enter leave tittle"
                        : null,
                  ),

                  const SizedBox(height: 10),

                  Row(
                    children: [
                      Expanded(
                        child: fetchLeaveType.when(
                          data: (itemList) {
                            return DropdownButtonFormField<String>(
                              value: viewModel.leaveTypeController.text.isEmpty ? null : viewModel.leaveTypeController.text,
                              onChanged: (value) {
                               // _leaveTypeController.text = value!;
                                viewModel.selectedLeaveTypeId = value;
                              },
                              items: itemList.map((item) {
                                return DropdownMenuItem<String>(
                                  value: item.id, // Or whatever field you need
                                  child: Text(item.leaveType),
                                );
                              }).toList(),
                              decoration: dropdownDecoration('Select Leave Type *'),
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
                          error: (error, _) => const Text('Failed to load Leave Type'),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 10),

                  TextFormField(

                    readOnly: true,
                    decoration: customInputDecoration(
                      "Start Date",
                      suffixIcon: IconButton(
                        icon: const Icon(Icons.calendar_month,color: AppColors.primary,),

                        onPressed: () =>  viewModel.pickDate(context, true),
                      ),
                    ),
                    controller: TextEditingController(
                      text: viewModel.startDate!= null
                          ? DateFormat('yyyy-MM-dd').format(viewModel.startDate!)
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

                        onPressed: () => viewModel.pickDate(context, false),
                      ),
                    ),
                    controller: TextEditingController(
                      text: viewModel.endDate != null
                          ? DateFormat('yyyy-MM-dd').format(viewModel.endDate!)

                          : '',
                    ),
                    validator: (value) => value == null || value.isEmpty
                        ? "Please select an end date"
                        : null,

                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: viewModel.leaveReasonController,
                    decoration: customInputDecoration("Leave Reason"),
                    maxLines: 3,
                    validator: (value) => value == null || value.isEmpty
                        ? "Please enter a leave reason"
                        : null,
                  ),
                  const SizedBox(height: 32),
                  ElevatedButton(
                    onPressed: () => viewModel.submitLeaveRequest(context),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary, // Set your desired background color here
                      foregroundColor: Colors.white, // This sets the text and icon color
                    ),
                    child: const Text("Submit",),
                  ),

                ],
              ),
            ),
          ),
        ),
      ),
    );
  }


}
