

import 'package:finexe/feature/base/internetConnection/networklistener.dart';
import 'package:finexe/feature/ui/HRMS/LeaveManagement/style/neumorphic_convex_style.dart';
import 'package:flutter_neumorphic_plus/flutter_neumorphic.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import '../../../../base/utils/namespase/app_colors.dart';
import '../../../../base/utils/namespase/display_size.dart';
import '../../../../base/utils/widget/neuphormic_dropdown_style.dart';
import '../style/decoration_text.dart';
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
        backgroundColor: AppColors.attendanceBgColor1,
        appBar: customAppBar(context,),
       /* appBar: PreferredSize(
          preferredSize: const Size.fromHeight(70),
          child: AppBar(
            title: const Text("Apply Leave",style: TextStyle(color: AppColors.black2,fontSize: 16)),
            backgroundColor: AppColors.attendanceBgColor1,
            centerTitle: true,
            leading: Padding(
              padding: const EdgeInsets.fromLTRB(15,0,0,0),
              child: NeumorphicWidget(
                depth: 10,
                boxShape: NeumorphicBoxShape.roundRect(BorderRadius.circular(12)),
                child: Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: IconButton(
                    icon: const Icon(Icons.arrow_back,color: AppColors.darkTextColor,),
                    onPressed: () => Navigator.pop(context),
                  ),
                ),
              ),
            ),
          ),
        ),*/

        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
          /*  key: _formKey,*/
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              child: Column(
                children: [
                  const SizedBox(height: 20),

                  Neumorphic(
                    style: NeumorphicStyles.neuMorphicButtonStyle2(),
                    child: TextFormField(
                      controller: viewModel.leaveTittleController,
                      decoration: neuMorphicCustomInputDecoration("Leave Tittle"),
                      maxLines: 1,
                      validator: (value) => value == null || value.isEmpty
                          ? "Please enter leave tittle"
                          : null,
                    ),
                  ),

                  const SizedBox(height: 10),

                  Row(
                    children: [
                      Expanded(
                        child: fetchLeaveType.when(
                          data: (itemList) {
                            return NeumorphicWidget(
                              depth: -2,
                              boxShape: NeumorphicBoxShape.roundRect(BorderRadius.circular(12)),
                              child: DropdownButtonFormField<String>(
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
                                decoration: neudropdownDecoration('Select Leave Type *'),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please select Branch';
                                  }
                                  return null;
                                },
                              ),
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

                  Neumorphic(
                    style: NeumorphicStyles.neuMorphicButtonStyle2(),
                    child: TextFormField(
                      readOnly: true,
                      decoration: neuMorphicCustomInputDecoration(
                        "Start Date",
                        suffixIcon: IconButton(
                          icon:Image.asset('assets/images/leave_calender.png',height: 20,width: 20,),
                         /* icon: const Icon(Icons.calendar_month,color: AppColors.iconBlackColor,),*/

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
                  ),
                  const SizedBox(height: 16),

                  Neumorphic(
                    style: NeumorphicStyles.neuMorphicButtonStyle2(),
                    child: TextFormField(
                      readOnly: true,
                      decoration: neuMorphicCustomInputDecoration(
                        "End Date",
                        suffixIcon: IconButton(
                          icon:Image.asset('assets/images/leave_calender.png',height: 20,width: 20,),
                          /*icon: const Icon(Icons.calendar_month,color: AppColors.iconBlackColor,),*/
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
                  ),
                  const SizedBox(height: 16),

                  Neumorphic(
                    style: NeumorphicStyles.neuMorphicButtonStyle2(),
                    child: TextFormField(
                      controller: viewModel.leaveReasonController,
                      decoration: neuMorphicCustomInputDecoration("Leave Reason"),
                      maxLines: 3,
                      validator: (value) => value == null || value.isEmpty
                          ? "Please enter a leave reason"
                          : null,
                    ),
                  ),
                  const SizedBox(height: 102),

                  Neumorphic(
                    style: NeumorphicStyles.neuMorphicButtonStyle(),
                    child: Container(
                      color: AppColors.attendanceBgColor1,
                      child: SizedBox(
                        width: double.infinity,
                        height: 50,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.only(top: 10, bottom: 10),
                            shape: RoundedRectangleBorder(side: const BorderSide(color: AppColors.white,width: 2),
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          onPressed: () => viewModel.submitLeaveRequest(context),
                          /*style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.primary, // Set your desired background color here
                            *//*foregroundColor: Colors.white,*//* // This sets the text and icon color
                          ),*/
                          child: const Text("Apply Leave",style: TextStyle(color: Colors.white),),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  PreferredSizeWidget customAppBar(BuildContext context,) {
    return PreferredSize(
      preferredSize: Size(displayWidth(context), displayHeight(context) * 0.09),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0,vertical: 10.0),
          child: Stack(
            alignment: Alignment.center,
            children: [
              // Back button on the left
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.only(left: 5.0),
                  child: SizedBox(
                    width: 40,
                    height: 40,
                    child: NeumorphicWidget(
                      depth: 10,
                      boxShape: NeumorphicBoxShape.roundRect(BorderRadius.circular(12)),
                      child: IconButton(
                        icon: const Icon(Icons.arrow_back, color: AppColors.darkTextColor,size: 25,),
                        onPressed: () => Navigator.pop(context),
                      ),
                    ),
                  ),
                ),
              ),

              // Title in the center
              const Text(
                "Apply Leave",
                style: TextStyle(
                  color: AppColors.black2,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

}
