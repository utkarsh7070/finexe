import 'package:finexe/feature/Punch_In_Out/viewmodel/attendance_view_model.dart';
import 'package:finexe/feature/base/api/dio_exception.dart';
import 'package:finexe/feature/base/dialog/logout_dialog.dart';
import 'package:finexe/feature/base/internetConnection/networklistener.dart';
import 'package:finexe/feature/base/utils/namespase/app_colors.dart';
import 'package:finexe/feature/base/utils/namespase/app_style.dart';
import 'package:finexe/feature/base/utils/namespase/display_size.dart';
import 'package:finexe/feature/base/utils/widget/app_button.dart';
import 'package:finexe/feature/ui/HRMS/LeaveManagement/view/leave_request_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:one_clock/one_clock.dart';
import '../../base/utils/widget/custom_text_form.dart';
import '../../ui/HRMS/LeaveManagement/model/leave_request_model.dart';
import '../viewmodel/leave_request_home_view_model.dart';
import '../viewmodel/punch_in_outside_view_model.dart';
import 'package:flutter_swipe_button/flutter_swipe_button.dart';

class AttendanceScreen extends ConsumerStatefulWidget {
  const AttendanceScreen({super.key});

  @override
  _AttendanceScreenState createState() => _AttendanceScreenState();
}

class _AttendanceScreenState extends ConsumerState<AttendanceScreen> {
  String selectedOption = "Punch";
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
    // final punchInOutSideViewModel = ref.read(punchInOutSideViewModelProvider);

    final checkPunchProvider = ref.watch(attendanceProvider);
    bool? isallowed;

    isallowed =
    checkPunchProvider.punchAllowed;
    // final socketService = ref.read(socketServiceProvider);
    final data = ref.watch(attendanceProvider);
    //--------------------------------new code in progress-----------------------------------
    // final attendeance
    //---------------------------------------------------------------------------------------
    return NetworkListener(
      context: context,
      child: Scaffold(
        appBar: AppBar(
          actions: [
            IconButton(
              onPressed: () {
                LogOutDialog.logOutDialog(context: context);
              },
              icon: const Icon(
                Icons.logout,
                color: AppColors.primary,
              ),
            ),
          ],
          title: const Text(
            "Punch In",
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 18,
              color: AppColors.black,
            ),
          ),
          centerTitle: true,
          flexibleSpace: Container(
            color: Colors.white,
          ),
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.only(left: 15.0, right: 10.0),
            child: isallowed != null
                ? Column(
                    children: [
                      Align(
                        alignment: Alignment.topRight,
                        child: InkWell(
                          onTap: () {
                             Navigator.push(
              context,
              MaterialPageRoute(builder: (context) =>  const LeaveRequestForm()));
                            // setState(() {
                            //   selectedOption =
                            //       selectedOption == 'Punch' ? 'Leave' : 'Punch';
                            // });
                            // Handle apply leave action
                            print("Apply Leave clicked");
                          },
                          child: Text(
                            selectedOption == 'Punch' ? 'Apply Leave >' : 'Punch >',
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 18,
                              color: AppColors.primary,
                            ),
                          ),
                        ),
                      ),
      
                      // AnalogClock(
      
                      //                         // showSeconds: true,
      
                      //                         isLive: true,
                      //                         // digitalClockTextColor: Colors.white,
                      //                         decoration: const BoxDecoration(
                      //                             color: Colors.yellow,
                      //                             shape: BoxShape.rectangle,
                      //                             borderRadius: BorderRadius.all(Radius.circular(15))),
                      //                         datetime: DateTime.now()),
      
                      Image.asset(
                        "assets/images/icons_clock.png",
                        width: MediaQuery.of(context).size.width * 0.85,
                        height: MediaQuery.of(context).size.height * 0.35,
                        fit: BoxFit.contain,
                      ),
                      const SizedBox(height: 19),
      
                      Visibility(
                        visible: selectedOption == 'Leave',
                        child: Container(
                          width: MediaQuery.of(context).size.width * 0.85,
                          // height: MediaQuery.of(context).size.height * 0.18,
                          padding: EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            // border: Border.all(color: Colors.grey, width: 1),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(
                                    0.5), // Shadow color with opacity
                                spreadRadius:
                                    2, // Adjust the spread of the shadow
                                blurRadius:
                                    5, // Adjust the blur radius of the shadow
                                offset: const Offset(
                                    0, 4), // Adjust the shadow position
                              ),
                            ],
                          ),
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  "Leave Request",
                                  style: TextStyle(
                                      fontSize: 18, fontWeight: FontWeight.bold),
                                ),
                                SizedBox(height: 20),
                                Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: TextFormField(
                                    controller: _leaveReasonController,
                                    decoration: customInputDecoration(
                                        "Enter your remark"),
                                    maxLines: 3,
                                    // validator: (value) =>
                                    //     value == null || value.isEmpty
                                    //         ? "Please enter a reason"
                                    //         : null,
                                  ),
                                ),
                                const SizedBox(height: 16),
                                AppButton(
                                  textStyle: TextStyle(color: Colors.white),
                                  label: 'Submit',
      
                                  onTap: () async {
                                    print('reasonForLeave Clicked');
                                    // Handle leave submission
                                    String reasonForLeave = _leaveReasonController
                                        .text
                                        .trim()
                                        .toString();
                                    print('reasonForLeave $reasonForLeave');
                                    if (reasonForLeave.isNotEmpty) {
                                      final DateTime currentDate = DateTime.now();
                                      final String formattedStartDate =
                                          DateFormat('yyyy-MM-dd')
                                              .format(currentDate);
                                      final String formattedEndDate =
                                          DateFormat('yyyy-MM-dd')
                                              .format(currentDate);
      
                                      print(
                                          'formattedStartDate-$formattedStartDate & formattedEndDate- $formattedEndDate');
      
                                      final leadData = LeaveRequestItem(
                                        startDate: formattedStartDate,
                                        endDate: formattedEndDate,
                                        reasonForLeave: reasonForLeave,
                                      );
      
                                      try {
                                        viewModel.submitLeaveHomeRequest(
                                            leadData, context).then((value) {
                                              setState(() {
                                                 selectedOption ='Punch';
                                                 _leaveReasonController.text='';
                                               
                                              });
                                            },);
      
                                      } catch (e) { 
                                        ExceptionHandler().handleError(e);
                                        // ScaffoldMessenger.of(context)
                                        //     .showSnackBar(
                                        //   SnackBar(content: Text(e.toString())),
                                        // );
                                      }
                                    } else {
                                     Fluttertoast.showToast(msg: 'Please write a reason');
                                    }
                                  },
      
                                  // Restart.restartApp(
                                  //   notificationTitle: 'Restarting App',
                                  //   notificationBody:
                                  //       'Please tap here to open the app again.',
                                  // );
                                ),
                                // ElevatedButton(
                                //   onPressed: () async {
                                //     print('reasonForLeave Clicked');
                                //     // Handle leave submission
                                //     String reasonForLeave = _leaveReasonController
                                //         .text
                                //         .trim()
                                //         .toString();
                                //     print('reasonForLeave $reasonForLeave');
                                //     if (reasonForLeave.isNotEmpty) {
                                //       final DateTime currentDate = DateTime.now();
                                //       final String formattedStartDate =
                                //           DateFormat('yyyy-MM-dd')
                                //               .format(currentDate);
                                //       final String formattedEndDate =
                                //           DateFormat('yyyy-MM-dd')
                                //               .format(currentDate);
      
                                //       print(
                                //           'formattedStartDate-$formattedStartDate & formattedEndDate- $formattedEndDate');
      
                                //       final leadData = LeaveRequestItem(
                                //         startDate: formattedStartDate,
                                //         endDate: formattedEndDate,
                                //         reasonForLeave: reasonForLeave,
                                //       );
      
                                //       try {
                                //         viewModel.submitLeaveHomeRequest(
                                //             leadData, context);
                                //       } catch (e) {
                                //         ScaffoldMessenger.of(context)
                                //             .showSnackBar(
                                //           SnackBar(content: Text(e.toString())),
                                //         );
                                //       }
                                //     } else {
                                //       ScaffoldMessenger.of(context).showSnackBar(
                                //         const SnackBar(
                                //             content:
                                //                 Text("Please fill Leave Reason")),
                                //       );
                                //     }
                                //   },
                                //   style: ElevatedButton.styleFrom(
                                //     backgroundColor: AppColors.primary,
                                //     foregroundColor: Colors.white,
                                //   ),
                                //   child: const Text("Submit"),
                                // ),
                              ],
                            ),
                          ),
                        ),
                      ),
      
                      Visibility(
                        visible: !isallowed ,
                        // && selectedOption == 'Punch',
                        child: Container(
                          width: MediaQuery.of(context).size.width * 0.85,
                          height: MediaQuery.of(context).size.height * 0.18,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            // border: Border.all(color: Colors.grey, width: 1),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(
                                    0.5), // Shadow color with opacity
                                spreadRadius:
                                    2, // Adjust the spread of the shadow
                                blurRadius:
                                    5, // Adjust the blur radius of the shadow
                                offset: const Offset(
                                    0, 4), // Adjust the shadow position
                              ),
                            ],
                          ),
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                const Text(
                                  'Punch In Out Side',
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                ),
                                const SizedBox(height: 10),
                                ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    // backgroundColor: const Color(0x0082C61A),
                                    backgroundColor: AppColors.primary,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  ),
                                  onPressed: () {
                                    _showCustomBottomSheet(
                                        context, _punchReasonController, ref);
                                  },
                                  child: const Text(
                                    'Punch In Out Side',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 15,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 10),
                                const Text(
                                  'If You Are Login Outside Put Remark',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.grey,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  )
                : const SizedBox(),
          ),
        ),
        bottomNavigationBar: isallowed != null
            ? Visibility(
                visible: isallowed && selectedOption == 'Punch',
                child: Container(
                  color: Colors.white,
                  padding: const EdgeInsets.all(16.0),
                  child: SwipeButton.expand(
                    width: 500,
                    thumb: Container(
                      width: 10, // Adjust the width of the thumb
                      height: 10, // Adjust the height of the thumb
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(
                            25), // Round the thumb if needed
                      ),
                      child: const Icon(
                        Icons.double_arrow_rounded,
                        color: AppColors.primary,
                      ),
                    ),
                    activeThumbColor: Colors.white,
                    activeTrackColor: AppColors.primary,
                    elevationThumb: 4.8,
                    height: 60,
                    child: checkPunchProvider.isLoading
                        ? const Center(
                            child: CircularProgressIndicator(
                              color: AppColors.primary,
                            ),
                          )
                        : const Text(
                            "Swipe to Punch In",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                    onSwipe: () {
                      ref.read(attendanceProvider.notifier).clickPunch(context);
                      // Handle Punch In Action
                      print("Punch In Swiped");
                    },
                  ),
                ),
              )
            : const SizedBox(),
      ),
    );

    // return isallowed != null
    //     ? Scaffold(
    // appBar: AppBar(
    //   actions: [
    //     IconButton(
    //       onPressed: () {
    //         LogOutDialog.logOutDialog(context: context);
    //       },
    //       icon: const Icon(
    //         Icons.logout,
    //         color: AppColors.primary,
    //       ),
    //     ),
    //   ],
    // ),
    //         body: SizedBox(
    //           height: MediaQuery.of(context).size.height,
    //           width: MediaQuery.of(context).size.width,
    //           child: Padding(
    //             padding: const EdgeInsets.all(20.0),
    //             child: Column(
    //               crossAxisAlignment: CrossAxisAlignment.start,
    //               mainAxisAlignment: MainAxisAlignment.start,
    //               children: [
    //                 const Text(
    //                   'Hello',
    //                   style: TextStyle(
    //                       color: Colors.black,
    //                       fontSize: 30,
    //                       fontWeight: FontWeight.w500),
    //                 ),
    //                 Text(
    //                   data.employeeName,
    //                   style: const TextStyle(
    //                       color: Colors.grey,
    //                       fontSize: 20,
    //                       fontWeight: FontWeight.w500),
    //                 ),
    //                 SizedBox(
    //                   height: MediaQuery.of(context).size.height * 0.03,
    //                 ),
    //                 Visibility(
    //                   visible: !isallowed,
    //                   child:  Container(
    //                     color: AppColors.lightBlue,
    //                     child: Padding(
    //                       padding: const EdgeInsets.all(18.0),
    //                       child: Column(
    //                         // mainAxisSize: MainAxisSize.min,
    //                         children: [
    //                           Padding(
    //                             padding: const EdgeInsets.all(20.0),
    //                             child: Row(
    //                               mainAxisAlignment:
    //                                   MainAxisAlignment.spaceEvenly,
    //                               children: [
    //                                 GestureDetector(
    //                                   onTap: () {
    // setState(() {
    //    selectedOption = "Leave";
    //    });
    //                                   },
    //                                   child: const Column(
    //                                     children: [
    //                                       Icon(Icons.calendar_today,
    //                                           size: 40, color: Colors.blue),
    //                                       Text("Leave"),
    //                                     ],
    //                                   ),
    //                                 ),
    //                                 GestureDetector(
    //                                   onTap: () {
    //                                     setState(() {
    //                                       selectedOption = "Punch";
    //                                     });
    //                                   },
    //                                   child: const Column(
    //                                     children: [
    //                                       Icon(Icons.fingerprint,
    //                                           size: 40, color: Colors.green),
    //                                       Text("Punch In OutSide"),
    //                                     ],
    //                                   ),
    //                                 ),
    //                               ],
    //                             ),
    //                           ),
    //                           const SizedBox(height: 20),
    //                           if (selectedOption == "Leave") ...[
    // const Text(
    //   "Leave Request",
    //   style: TextStyle(
    //       fontSize: 18,
    //       fontWeight: FontWeight.bold),
    // ),
    // const SizedBox(height: 20),
    // Padding(
    //   padding: const EdgeInsets.all(10.0),
    //   child: TextFormField(
    //     controller: _leaveReasonController,
    //     decoration: customInputDecoration(
    //         "Enter your remark"),
    //     maxLines: 3,
    //     validator: (value) =>
    //         value == null || value.isEmpty
    //             ? "Please enter a reason"
    //             : null,
    //   ),
    // ),
    // const SizedBox(height: 16),
    // ElevatedButton(
    //   onPressed: () async {
    //     print('reasonForLeave Clicked');
    //     // Handle leave submission
    //     String reasonForLeave =
    //         _leaveReasonController.text
    //             .trim()
    //             .toString();
    //     print('reasonForLeave $reasonForLeave');
    //     if (reasonForLeave.isNotEmpty) {
    //       final DateTime currentDate =
    //           DateTime.now();
    //       final String formattedStartDate =
    //           DateFormat('yyyy-MM-dd')
    //               .format(currentDate);
    //       final String formattedEndDate =
    //           DateFormat('yyyy-MM-dd')
    //               .format(currentDate);

    //       print(
    //           'formattedStartDate-$formattedStartDate & formattedEndDate- $formattedEndDate');

    //       final leadData = LeaveRequestItem(
    //         startDate: formattedStartDate,
    //         endDate: formattedEndDate,
    //         reasonForLeave: reasonForLeave,
    //       );

    //       try {
    //         viewModel.submitLeaveHomeRequest(
    //             leadData, context);
    //       } catch (e) {
    //         ScaffoldMessenger.of(context)
    //             .showSnackBar(
    //           SnackBar(content: Text(e.toString())),
    //         );
    //       }
    //     } else {
    //       ScaffoldMessenger.of(context)
    //           .showSnackBar(
    //         const SnackBar(
    //             content: Text(
    //                 "Please fill Leave Reason")),
    //       );
    //     }
    //   },
    //   style: ElevatedButton.styleFrom(
    //     backgroundColor: AppColors.primary,
    //     foregroundColor: Colors.white,
    //   ),
    //   child: const Text("Submit"),
    // ),
    //                             const SizedBox(height: 16),
    //                           ] else if (selectedOption == "Punch") ...[
    //                             const Text(
    //                               "Punch In OutSide",
    //                               style: TextStyle(
    //                                   fontSize: 18,
    //                                   fontWeight: FontWeight.bold),
    //                             ),
    //                             const SizedBox(height: 20),
    //                             Padding(
    //                               padding: const EdgeInsets.all(10.0),
    //                               child: TextFormField(
    // keyboardType: TextInputType.text,
    // controller: _punchReasonController,
    //                                 decoration: customInputDecoration(
    //                                     "Enter your remark"),
    //                                 maxLines: 3,
    //                                 validator: (value) =>
    //                                     value == null || value.isEmpty
    //                                         ? "Please enter a reason"
    //                                         : null,
    //                               ),
    //                             ),
    //                             const SizedBox(height: 16),
    //                             ElevatedButton(
    //                               onPressed: () async {
    // print('reasonForPunch Clicked');
    // String reasonForPunch =
    //     _punchReasonController.text.trim();

    // if (reasonForPunch.isNotEmpty) {
    //   try {
    //     // Call ViewModel to handle API and navigation logic
    //     punchInOutSideViewModel
    //         .punchInOutSideRequestWithRole(
    //             reasonForPunch, context);
    //   } catch (e) {
    //     ScaffoldMessenger.of(context)
    //         .showSnackBar(
    //       SnackBar(content: Text(e.toString())),
    //     );
    //   }
    // } else {
    //   ScaffoldMessenger.of(context)
    //       .showSnackBar(
    //     const SnackBar(
    //         content:
    //             Text("Please fill Remark")),
    //   );
    // }
    //                               },
    //                               style: ElevatedButton.styleFrom(
    //                                 backgroundColor: AppColors.primary,
    //                                 foregroundColor: Colors.white,
    //                               ),
    //                               child: const Text("Submit"),
    //                             ),
    //                             const SizedBox(height: 16),
    //                           ],
    //                         ],
    //                       ),
    //                     ),
    //                   ),
    //                 ),
    //                 Visibility(
    //                   visible: isallowed,
    //                   child: Card(
    //                     child: Container(
    //                       height: MediaQuery.of(context).size.height * 0.11,
    //                       decoration: const BoxDecoration(
    //                           gradient: LinearGradient(
    //                               begin: Alignment.topLeft,
    //                               end: Alignment.bottomRight,
    //                               colors: [
    //                                 Color(0xFF0082C6),
    //                                 Color(0xFF09ABFF),
    //                               ]),
    //                           // color: Colors.blue,
    //                           borderRadius:
    //                               BorderRadius.all(Radius.circular(10))),
    //                       padding: const EdgeInsets.all(16),
    //                       child: Row(
    //                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //                         children: [
    //                           Column(
    //                             crossAxisAlignment: CrossAxisAlignment.start,
    //                             mainAxisAlignment:
    //                                 MainAxisAlignment.spaceAround,
    //                             children: [
    //                               Text(
    //                                 'Last Check in Time',
    //                                 style: TextStyle(
    //                                     color: Colors.grey.shade200,
    //                                     fontSize: 16,
    //                                     fontWeight: FontWeight.w400),
    //                               ),
    // DigitalClock(
    //     showSeconds: false,
    //     isLive: true,
    //     digitalClockTextColor: Colors.white,
    //     // decoration: const BoxDecoration(
    //     //     color: Colors.yellow,
    //     //     shape: BoxShape.rectangle,
    //     //     borderRadius: BorderRadius.all(Radius.circular(15))),
    //     datetime: DateTime.now())
    //                               // Text(controller.formattedDate.toString(),style: TextStyle(color:Colors.grey.shade200,fontSize: 20,fontWeight: FontWeight.w500),),
    //                             ],
    //                           ),
    //                           ElevatedButton(
    //                             style: ElevatedButton.styleFrom(
    //                                 backgroundColor: Colors.grey.shade200,
    //                                 shape: const RoundedRectangleBorder(
    //                                     borderRadius: BorderRadius.all(
    //                                         Radius.circular(10)))),
    //                             onPressed: () {
    //                               // controller.clickPunch();
    //                               ref
    //                                   .read(attendanceProvider.notifier)
    //                                   .clickPunch(context);
    //                               // ref
    //                               //     .read(attendanceProvider.notifier)
    //                               //     .onPunchIn(context);
    //                             },
    // child: checkPunchProvider.isLoading
    //     ? const Center(
    //         child: CircularProgressIndicator(
    //           color: Colors.blue,
    //         ),
    //       )
    //     :
    //                                 //   checkPunchProvider.punchStatus?
    //                                 // const Text(
    //                                 //         'Punch Out',
    //                                 //         style: TextStyle(color: Colors.blue),
    //                                 //       ):
    //                                 const Text(
    //                                     'punch In',
    //                                     style: TextStyle(color: Colors.blue),
    //                                   ),
    //                           )
    //                         ],
    //                       ),
    //                     ),
    //                   ),
    //                 ),
    //               ],
    //             ),
    //           ),
    //         ),
    //       )
    //     : Scaffold(
    //         body: SizedBox(),
    //       );
  }
}

void _showCustomBottomSheet(
    BuildContext context, TextEditingController controller, ref) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(25.0)),
    ),
    backgroundColor:
        Colors.transparent, // Make background transparent to see the cross icon
    builder: (BuildContext bc) {
      return Stack(
        children: [
          // Bottom sheet content
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              padding: const EdgeInsets.all(20.0),
              height: displayHeight(context) *
                  0.55, // Adjust height here (75% of screen height)
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius:
                    const BorderRadius.vertical(top: Radius.circular(25.0)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Login Time Heading
                  const Text(
                    'Login Time',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: displayHeight(context) * 0.01),

                  // Display current time
                  Text(
                    DateFormat('hh:mm a').format(DateTime.now()),
                    style: const TextStyle(fontSize: 16, color: Colors.black54),
                  ),
                  SizedBox(height: displayHeight(context) * 0.04),

                  // Write Attendance Remark Heading

                  const Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      'Write Your Attendance Remark',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                    ),
                  ),
                  SizedBox(height: displayHeight(context) * 0.02),

                  // Text Field for remark
                  TextField(
                    keyboardType: TextInputType.text,
                    controller: controller,
                    maxLines: 4,
                    decoration: InputDecoration(
                      hintText: 'Write remark here',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: const BorderSide(
                            color: Colors.grey,
                          )),
                    ),
                    style: const TextStyle(fontSize: 16, color: Colors.grey),
                  ),
                  SizedBox(height: displayHeight(context) * 0.04),

                  // Submit Button
                  AppButton(
                    onTap: () {
                      String reasonForPunch = controller.text.trim();

                      if (reasonForPunch.isNotEmpty) {
                        try {
                          // Call ViewModel to handle API and navigation logic
                          ref
                              .read(punchInOutSideViewModelProvider)
                              .punchInOutSideRequestWithRole(
                                  reasonForPunch, context);
                        } catch (e) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text(e.toString())),
                          );
                        }
                      } else {
                        Fluttertoast.showToast(msg: "Remark can't be empty");
                        // ScaffoldMessenger.of(context)
                        //     .showSnackBar(
                        //   const SnackBar(
                        //       content:
                        //           Text("Please fill Remark")),
                        // );
                      }
                    },
                    textStyle: AppStyles.buttonLightTextStyle,
                    label: 'Submit',
                    height: MediaQuery.of(context).size.height * 0.06,
                    width: displayWidth(context),
                  ),
                ],
              ),
            ),
          ),

          // Cross icon above the bottom sheet
        ],
      );
    },
  );
}

void showAttendanceSuccessPopup(BuildContext context, String remark) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        child: Container(
          padding: const EdgeInsets.all(20.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: Colors.white,
          ),
          child: Column(
            // crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              // Success Message
              const Text(
                'Attendance Submission Successful!',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 1, 80, 122),
                ),
              ),
              const SizedBox(height: 16),

              // Image
              Image.asset(
                'assets/images/right_tick.png', // Replace with your success icon image
                height: 150,
                width: 150,
              ),
              const SizedBox(height: 16),

              // Description Text
              const Text(
                'Your attendance has been successfully marked.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black54,
                ),
              ),
              const SizedBox(height: 16),

              // Row with Icon, Text, and Time
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: displayWidth(context) * 0.4,
                    child: Row(
                      children: [
                        SizedBox(
                          width: displayWidth(context) * 0.1,
                        ),
                        Icon(
                          Icons.access_time, // Clock Icon
                          color: Colors.black54,
                        ),
                        SizedBox(width: 6),
                        Text(
                          'Time',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.black54,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Container(
                      child: Text(
                        DateFormat('hh:mm a').format(DateTime.now()),
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w300,
                          color: Colors.black45,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 5),
              Divider(
                thickness: 1,
                color: Colors.grey[300],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: displayWidth(context) * 0.4,
                    child: Row(
                      children: [
                        SizedBox(
                          width: displayWidth(context) * 0.1,
                        ),
                        Icon(
                          Icons.location_on, // Clock Icon
                          color: Colors.black54,
                        ),
                        SizedBox(width: 6),
                        Text(
                          'Location',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.black54,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Container(
                      child: Text(
                        'Out Side', // Replace with dynamic time if needed
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w300,
                          color: Colors.black45,
                        ),
                      ),
                    ),
                  ),
                ],
              ),

              // const Row(
              //   mainAxisAlignment: MainAxisAlignment.spaceAround,
              //   children: [
              //     SizedBox(
              //       width: 80,
              //       child: Row(
              //         children: [
              //           Icon(
              //             Icons.location_on, // Clock Icon
              //             color: Colors.black54,
              //           ),
              //           SizedBox(width: 8),
              //           Text(
              //             'Location',
              //             style: TextStyle(
              //               fontSize: 18,
              //               fontWeight: FontWeight.bold,
              //               color: Colors.black54,
              //             ),
              //           ),
              //         ],
              //       ),
              //     ),
              //     SizedBox(
              //       width: 150,
              //       child: Text(
              //         'Out Side', // Replace with dynamic time if needed
              //         style: TextStyle(
              //           fontSize: 16,
              //           fontWeight: FontWeight.w300,
              //           color: Colors.black45,
              //         ),
              //       ),
              //     ),
              //   ],
              // ),
              const SizedBox(height: 5),
              Divider(
                thickness: 1,
                color: Colors.grey[300],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: displayWidth(context) * 0.4,
                    child: Row(
                      children: [
                        SizedBox(
                          width: displayWidth(context) * 0.1,
                        ),
                        Icon(
                          Icons.location_pin, // Clock Icon
                          color: Colors.black54,
                        ),
                        SizedBox(width: 6),
                        Text(
                          'Remark',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.black54,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Container(
                      child: Text(
                        remark,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w300,
                          color: Colors.black45,
                        ),
                      ),
                    ),
                  ),
                ],
              ),

              // const SizedBox(
              //   width: 260,
              //   child: Row(
              //     crossAxisAlignment: CrossAxisAlignment.start,
              //     mainAxisAlignment: MainAxisAlignment.spaceAround,
              //     children: [
              //       Row(
              //         children: [
              //           Icon(
              //             Icons.location_pin, // Clock Icon
              //             color: Colors.black54,
              //           ),
              //           SizedBox(width: 8),
              //           Text(
              //             'Remark',
              //             style: TextStyle(
              //               fontSize: 18,
              //               fontWeight: FontWeight.bold,
              //               color: Colors.black54,
              //             ),
              //           ),
              //         ],
              //       ),
              //       SizedBox(
              //         width: 95,
              //         child: Text(
              //           'Content this show remark', // Replace with dynamic time if needed
              //           style: TextStyle(
              //             fontSize: 16,
              //             fontWeight: FontWeight.w300,
              //             color: Colors.black45,
              //           ),
              //         ),
              //       ),
              //     ],
              //   ),
              // ),
              const SizedBox(height: 15),
            ],
          ),
        ),
      );
    },
  );
}
