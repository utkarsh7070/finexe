import 'dart:developer';
import 'package:finexe/feature/Punch_In_Out/viewmodel/attendance_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:one_clock/one_clock.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../base/routes/routes.dart';
import '../../base/utils/namespase/app_colors.dart';
import '../../base/utils/widget/custom_text_form.dart';
import '../../ui/HRMS/LeaveManagement/model/leave_request_model.dart';
import '../viewmodel/leave_request_home_view_model.dart';
import '../viewmodel/punch_in_outside_view_model.dart';

class AttendanceScreen extends ConsumerStatefulWidget {
  const AttendanceScreen({super.key});
  @override
  _AttendanceScreenState createState() => _AttendanceScreenState();
}

class _AttendanceScreenState extends ConsumerState<AttendanceScreen> {
  String selectedOption = "";
  final _leaveReasonController = TextEditingController();
  final _punchReasonController = TextEditingController();

  @override
  void dispose() {
    _leaveReasonController.dispose();
    _punchReasonController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // final _formKey = GlobalKey<FormState>();
    final viewModel = ref.read(leaveRequestHomeViewModelProvider);
    final punchInOutSideViewModel=ref.read(punchInOutSideViewModelProvider);

    final checkPunchProvider = ref.watch(attendanceProvider);
    final data = ref.watch(attendanceProvider);

    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const Text(
                  'Hello',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 30,
                      fontWeight: FontWeight.w500),
                ),
                Text(
                  data.employeeName,
                  style: const TextStyle(
                      color: Colors.grey,
                      fontSize: 20,
                      fontWeight: FontWeight.w500),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.03,
                ),
                Visibility(
                  visible: checkPunchProvider.punchAllowed,
                  child: Card(
                    child: Container(
                      height: MediaQuery.of(context).size.height * 0.11,
                      decoration: const BoxDecoration(
                          gradient: const LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              colors: [
                                Color(0xFF0082C6),
                                Color(0xFF09ABFF),
                              ]),
                          // color: Colors.blue,
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                      padding: const EdgeInsets.all(16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Text(
                                'Last Check in Time',
                                style: TextStyle(
                                    color: Colors.grey.shade200,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400),
                              ),
                              DigitalClock(
                                  showSeconds: false,
                                  isLive: true,
                                  digitalClockTextColor: Colors.white,
                                  // decoration: const BoxDecoration(
                                  //     color: Colors.yellow,
                                  //     shape: BoxShape.rectangle,
                                  //     borderRadius: BorderRadius.all(Radius.circular(15))),
                                  datetime: DateTime.now())
                              // Text(controller.formattedDate.toString(),style: TextStyle(color:Colors.grey.shade200,fontSize: 20,fontWeight: FontWeight.w500),),
                            ],
                          ),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.grey.shade200,
                                shape: const RoundedRectangleBorder(
                                    borderRadius:
                                    BorderRadius.all(Radius.circular(10)))),
                            onPressed: () {
                              // controller.clickPunch();
                              ref
                                  .read(attendanceProvider.notifier)
                                  .clickPunch(context);
                              // ref
                              //     .read(attendanceProvider.notifier)
                              //     .onPunchIn(context);
                            },
                            child: checkPunchProvider.isLoading
                                ? const Center(
                              child: CircularProgressIndicator(
                                color: Colors.blue,
                              ),
                            )
                                :
                            //   checkPunchProvider.punchStatus?
                            // const Text(
                            //         'Punch Out',
                            //         style: TextStyle(color: Colors.blue),
                            //       ):
                            const Text(
                              'punch In',
                              style: TextStyle(color: Colors.blue),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                Container(
                  color: AppColors.lightBlue,
                  child: Padding(
                    padding: const EdgeInsets.all(18.0),
                    child:Column(
                      // mainAxisSize: MainAxisSize.min,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    selectedOption = "Leave";
                                  });
                                },
                                child: const Column(
                                  children: [
                                    Icon(Icons.calendar_today, size: 40, color: Colors.blue),
                                    Text("Leave"),
                                  ],
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    selectedOption = "Punch";
                                  });
                                },
                                child: const Column(
                                  children: [
                                    Icon(Icons.fingerprint, size: 40, color: Colors.green),
                                    Text("Punch In OutSide"),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 20),
                        if (selectedOption == "Leave") ...[
                          const Text(
                            "Leave Request",
                            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 20),
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: TextFormField(
                              controller: _leaveReasonController,
                              decoration: customInputDecoration("Enter your remark"),
                              maxLines: 3,
                              validator: (value) =>
                              value == null || value.isEmpty ? "Please enter a reason" : null,
                            ),
                          ),
                          const SizedBox(height: 16),
                          ElevatedButton(
                            onPressed: () async{
                              print('reasonForLeave Clicked');
                              // Handle leave submission
                              String reasonForLeave=_leaveReasonController.text.trim().toString();
                              print('reasonForLeave ${reasonForLeave}');
                              if (reasonForLeave.isNotEmpty) {

                                final DateTime currentDate = DateTime.now();
                                final String formattedStartDate = DateFormat('yyyy-MM-dd').format(currentDate);
                                final String formattedEndDate = DateFormat('yyyy-MM-dd').format(currentDate);

                                print('formattedStartDate-${formattedStartDate} & formattedEndDate- ${formattedEndDate}');

                                final leadData = LeaveRequestItem(
                                  startDate: formattedStartDate,
                                  endDate: formattedEndDate,
                                  reasonForLeave: reasonForLeave,
                                );

                                try {
                                  viewModel.submitLeaveHomeRequest(leadData, context);

                                } catch (e) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(content: Text(e.toString())),
                                  );
                                }
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(content: Text("Please fill Leave Reason")),
                                );
                              }
                            },

                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.primary,
                              foregroundColor: Colors.white,
                            ),
                            child: const Text("Submit"),
                          ),
                          const SizedBox(height: 16),
                        ] else if (selectedOption == "Punch") ...[
                          const Text(
                            "Punch In OutSide",
                            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 20),
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: TextFormField(keyboardType: TextInputType.text,
                              controller: _punchReasonController,
                              decoration: customInputDecoration("Enter your remark"),
                              maxLines: 3,
                              validator: (value) =>
                              value == null || value.isEmpty ? "Please enter a reason" : null,
                            ),
                          ),
                          const SizedBox(height: 16),

                          ElevatedButton(
                            onPressed: () async {
                              print('reasonForPunch Clicked');
                              String reasonForPunch = _punchReasonController.text.trim();

                              if (reasonForPunch.isNotEmpty) {
                                try {
                                  // Call ViewModel to handle API and navigation logic
                                  punchInOutSideViewModel.punchInOutSideRequestWithRole(reasonForPunch, context);
                                } catch (e) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(content: Text(e.toString())),
                                  );
                                }
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(content: Text("Please fill Remark")),
                                );
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.primary,
                              foregroundColor: Colors.white,
                            ),
                            child: const Text("Submit"),
                          ),


                          const SizedBox(height: 16),
                        ],
                      ],
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
}