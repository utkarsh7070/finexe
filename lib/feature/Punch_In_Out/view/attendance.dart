import 'dart:math';

import 'package:finexe/feature/Punch_In_Out/viewmodel/attendance_view_model.dart';
import 'package:finexe/feature/base/internetConnection/networklistener.dart';
import 'package:finexe/feature/base/utils/namespase/app_colors.dart';
import 'package:finexe/feature/base/utils/namespase/app_style.dart';
import 'package:finexe/feature/base/utils/namespase/display_size.dart';
import 'package:finexe/feature/ui/HRMS/LeaveManagement/view/leave_request_form.dart';
import 'package:flutter_neumorphic_plus/flutter_neumorphic.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_swipe_button/flutter_swipe_button.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';

import '../../base/api/api.dart';import '../../ui/HRMS/LeaveManagement/style/decoration_text.dart';
import '../../ui/HRMS/LeaveManagement/style/neumorphic_convex_style.dart';
import '../viewmodel/leave_request_home_view_model.dart';
import '../viewmodel/punch_in_outside_view_model.dart';

class AttendanceScreen extends ConsumerStatefulWidget {
  const AttendanceScreen({super.key});

  @override
  _AttendanceScreenState createState() => _AttendanceScreenState();
}

class _AttendanceScreenState extends ConsumerState<AttendanceScreen> {
  // String selectedOption = "Punch";
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
    // final checkPunchProvider = ref.watch(attendanceProvider);
    // final data = ref.watch(attendanceProvider);
    final userProfileAsync = ref.watch(loginAttendanceUserProfileProvider);
    final currentTime = ref.watch(clockProvider);
    // print("mp punching status ${checkPunchProvider.punchAllowed}");
    //--------------------------------new code in progress-----------------------------------
    //---------------------------------------------------------------------------------------
    return NetworkListener(
      context: context,
      child: userProfileAsync.when(
        data: (userProfile) {
          return Scaffold(
              backgroundColor: AppColors.attendanceBgColor,
              appBar: AppBar(
                toolbarHeight: 70,
                bottom: const PreferredSize(
                    preferredSize: Size.fromHeight(20), child: SizedBox()),
                title: Row(
                  children: [
                    NeumorphicWidget(
                      intensity: 1.0,
                      shape: NeumorphicShape.convex,
                      boxShape: const NeumorphicBoxShape.circle(),
                      child: CircleAvatar(
                        backgroundColor: AppColors.primary,
                        radius: 20,
                        // backgroundImage: NetworkImage(userProfile.employeePhoto),
                        backgroundImage: userProfile?.employeePhoto != null &&
                                userProfile?.employeePhoto.contains('upload')
                            ? NetworkImage(
                                '${Api.imageUrl}${userProfile?.employeePhoto}')
                            : const AssetImage('assets/images/prof.jpeg')
                                as ImageProvider,
                        // Placeholder image
                        onBackgroundImageError: (error, stackTrace) {
                          // Set a default image if the API image fails to load
                        },
                      ),
                    ),
                    SizedBox(
                      width: displayWidth(context) * 0.02,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          userProfile?.employeName ?? '',
                          style: AppStyles.TextStyle16,
                        ),
                        Text(
                          userProfile?.designationId?.name ?? '',
                          style: AppStyles.blacktext14
                              .copyWith(color: AppColors.gray7),
                        )
                      ],
                    )
                  ],
                ),
                actions: [
                  InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const LeaveRequestForm()));

                      print("Apply Leave clicked");
                    },
                    child: const Padding(
                      padding: EdgeInsets.fromLTRB(0, 0, 10, 0),
                      child: Text(
                        // selectedOption == 'Punch' ?
                        'Apply Leave >',
                        // : 'Punch >',
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                          color: AppColors.leaveTextColor,
                        ),
                      ),
                    ),
                  ),
                ],
                flexibleSpace: Container(
                  color: AppColors.attendanceBgColor,
                ),
              ),
              body: SafeArea(
                child: SingleChildScrollView(
                    padding: const EdgeInsets.only(
                        left: 15.0, right: 10.0, top: 10.0),
                    child: Column(
                      children: [
                        const SizedBox(height: 39),

                        SizedBox(
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              _buildRealTimeClock(currentTime),
                            ],
                          ),
                        ),

                        const SizedBox(height: 40),
                        // Visibility(
                        //   visible: selectedOption == 'Leave',
                        //   child: Container(
                        //     width: displayWidth(context)* 0.85,
                        //     // height: MediaQuery.of(context).size.height * 0.18,
                        //     padding: const EdgeInsets.all(12),
                        //     decoration: BoxDecoration(
                        //       color: Colors.white,
                        //       borderRadius: BorderRadius.circular(10),
                        //       // border: Border.all(color: Colors.grey, width: 1),
                        //       boxShadow: [
                        //         BoxShadow(
                        //           color: Colors.grey.withOpacity(
                        //               0.5), // Shadow color with opacity
                        //           spreadRadius:
                        //           2, // Adjust the spread of the shadow
                        //           blurRadius:
                        //           5, // Adjust the blur radius of the shadow
                        //           offset: const Offset(
                        //               0, 4), // Adjust the shadow position
                        //         ),
                        //       ],
                        //     ),
                        //     child: Center(
                        //       child: Column(
                        //         mainAxisAlignment: MainAxisAlignment.center,
                        //         crossAxisAlignment: CrossAxisAlignment.center,
                        //         children: [
                        //           const Text(
                        //             "Leave Request",
                        //             style: TextStyle(
                        //                 fontSize: 18,
                        //                 fontWeight: FontWeight.bold),
                        //           ),
                        //           const SizedBox(height: 20),
                        //           Padding(
                        //             padding: const EdgeInsets.all(10.0),
                        //             child: TextFormField(
                        //               controller: _leaveReasonController,
                        //               decoration: customInputDecoration(
                        //                   "Enter your remark"),
                        //               maxLines: 3,
                        //               // validator: (value) =>
                        //               //     value == null || value.isEmpty
                        //               //         ? "Please enter a reason"
                        //               //         : null,
                        //             ),
                        //           ),
                        //           const SizedBox(height: 16),
                        //           AppButton(
                        //
                        //             textStyle:
                        //                 const TextStyle(color: Colors.white),
                        //
                        //             label: 'Submit',
                        //
                        //             onTap: () async {
                        //               print('reasonForLeave Clicked');
                        //               // Handle leave submission
                        //               String reasonForLeave =
                        //                   _leaveReasonController.text
                        //                       .trim()
                        //                       .toString();
                        //               print('reasonForLeave $reasonForLeave');
                        //               if (reasonForLeave.isNotEmpty) {
                        //
                        //                 final DateTime currentDate =
                        //                     DateTime.now();
                        //
                        //                 final String formattedStartDate =
                        //                 DateFormat('yyyy-MM-dd')
                        //                     .format(currentDate);
                        //                 final String formattedEndDate =
                        //
                        //                 DateFormat('yyyy-MM-dd')
                        //                     .format(currentDate);
                        //
                        //                 print(
                        //                     'formattedStartDate-$formattedStartDate & formattedEndDate- $formattedEndDate');
                        //
                        //                 final leadData = LeaveRequestItem(
                        //                   leaveType: '',
                        //                   title: '',
                        //                   startDate: formattedStartDate,
                        //                   endDate: formattedEndDate,
                        //                   reasonForLeave: reasonForLeave,
                        //                 );
                        //
                        //                 try {
                        //
                        //                   viewModel.submitLeaveHomeRequest(
                        //                       leadData, context).then((value) {
                        //                     setState(() {
                        //                       selectedOption = 'Punch';
                        //                       _leaveReasonController.text = '';
                        //                     });
                        //                   },);
                        //
                        //                 } catch (e) {
                        //                   ExceptionHandler().handleError(e);
                        //                   // ScaffoldMessenger.of(context)
                        //                   //     .showSnackBar(
                        //                   //   SnackBar(content: Text(e.toString())),
                        //                   // );
                        //                 }
                        //               } else {
                        //                 Fluttertoast.showToast(
                        //                     msg: 'Please write a reason');
                        //               }
                        //             },
                        //
                        //           ),
                        //
                        //         ],
                        //       ),
                        //     ),
                        //   ),
                        // ),

                        /* Visibility(
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
                        ),*/
                      ],
                    )),
              ),
              bottomNavigationBar: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(30.0),
                    child: NeumorphicWidget(
                      depth: 5,
                      shape: NeumorphicShape.flat,
                      boxShape: NeumorphicBoxShape.roundRect(BorderRadius.circular(30)),
                      child: SwipeButton.expand(
                        elevationTrack: 0,
                        width: 500,
                        thumb: NeumorphicWidget(
                          depth: -2,
                          shape: NeumorphicShape.concave,
                          color: AppColors.attendanceBgColor,
                          boxShape: const NeumorphicBoxShape.circle(),
                          child: Container(
                            width: 14, // Adjust the width of the thumb
                            height: 14, // Adjust the height of the thumb
                           /* decoration: BoxDecoration(
                              color: AppColors.attendanceBgColor1,
                              borderRadius: BorderRadius.circular(
                                  20), // Round the thumb if needed
                            ),*/
                            child: const Icon(
                              Icons.double_arrow_rounded,
                              color: Colors.blue,
                            ),
                          ),
                        ),
                        activeThumbColor: AppColors.attendanceBgColor,
                        activeTrackColor: AppColors.attendanceBgColor,
                        // elevationThumb: 4.8,
                        height: 60,
                        thumbPadding: const EdgeInsets.all(8),
                        child: const Text(
                          "Swipe to Punch In",
                          style: TextStyle(
                            color: Colors.blue,
                            fontWeight: FontWeight.bold,
                            fontSize: 13,
                          ),
                        ),
                        onSwipe: () {
                          ref
                              .read(attendanceProvider.notifier)
                              .clickPunch(context);
                          // Handle Punch In Action
                          print("Punch In Swiped");
                        },
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Text(
                    'OR',
                    style: TextStyle(
                      color: Colors.grey, // Optional: For a hyperlink effect
                      fontSize: 13, // Optional: Adjust font size
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  GestureDetector(
                    onTap: () {
                      // Define your click action here
                      _showCustomBottomSheet(
                          context, _punchReasonController, ref);
                      //print('Text clicked!');
                    },
                    child: const Text(
                      'Punch In Out Side',
                      style: TextStyle(
                        decoration: TextDecoration.underline,
                        color: Colors.grey,
                        // Optional: For a hyperlink effect
                        fontSize: 13, // Optional: Adjust font size
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                ],
              ));
        },
        loading: () => const Scaffold(
          body: Center(
            child: CircularProgressIndicator(),
          ),
        ),
        error: (error, stackTrace) {
          return Center(
            child: Text('Error: ${error.toString()}'),
          );
        },
      ),
    );
  }

  // Custom Real-Time Clock Widget
  Widget _buildRealTimeClock(DateTime currentTime) {
    double clockRadius = 150;
    return Stack(
      alignment: Alignment.center,
      children: [
        // Clock background
        SizedBox(
          width: clockRadius * 2,
          height: clockRadius * 2,
          /*width: 200,
          height: 200,*/
          /* decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.shade400,
                blurRadius: 10,
                spreadRadius: 2,
              ),
            ],
          ),*/
          child: Image.asset(
            "assets/images/clock_new.png", // Replace with your image path
            fit:
                BoxFit.cover, // Adjust the fit as needed (cover, contain, etc.)
          ),
        ),
        // Hour hand
        _buildHand(
          length: clockRadius * 0.6,
          angle: (currentTime.hour % 12) * 30 + currentTime.minute * 0.5,
          thickness: 3,
          color: Colors.black,
        ),
        // Minute hand
        _buildHand(
          length: clockRadius * 0.7,
          angle: currentTime.minute * 6,
          thickness: 2,
          color: Colors.black,
        ),
        // Second hand
        _buildHand(
          length: clockRadius * 0.9,
          angle: currentTime.second * 6,
          thickness: 1,
          color: Colors.blue,
        ),
        // Center pin
        Container(
          width: 10,
          height: 10,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.black,
          ),
        ),
      ],
    );
  }

  Widget _buildHand({
    required double length,
    required double angle,
    required double thickness,
    required Color color,
  }) {
    return Transform.rotate(
      angle: angle * pi / 180, // Rotate the hand by the given angle
      child: Transform.translate(
        offset: const Offset(0, -30),
        // Move the hand 10 pixels upward from the center
        child: Align(
          alignment: Alignment.topCenter,
          // Align the hand to start from the center
          child: Container(
            height: length,
            width: thickness,
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
      ),
    );
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
    backgroundColor: Colors.transparent,
    // Make background transparent to see the cross icon
    builder: (BuildContext bc) {
      return Padding(
        padding:
            EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        child: Container(
          padding: const EdgeInsets.only(top: 20.0, left: 16, right: 16),
          height: displayHeight(context) * 0.55,
          // Adjust height here (75% of screen height)
          decoration: const BoxDecoration(
            color: AppColors.attendanceBgColor1,
            borderRadius: BorderRadius.vertical(top: Radius.circular(25.0)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Login Time Heading
              const Text(
                'Log In Time',
                style: TextStyle(
                  fontSize: 12,
                ),
              ),
              SizedBox(height: displayHeight(context) * 0.01),

              // Display current time
              Text(
                DateFormat('hh:mm a').format(DateTime.now()),
                style: const TextStyle(
                    fontSize: 18,
                    color: Colors.black54,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(height: displayHeight(context) * 0.04),

              // Write Attendance Remark Heading

              const Align(
                alignment: Alignment.topLeft,
                child: Text(
                  'Write Your Attendance Remark',
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                ),
              ),
              SizedBox(height: displayHeight(context) * 0.02),

              // Text Field for remark
              /* NeumorphicWidget(
                      depth: -2,
                      boxShape: NeumorphicBoxShape.roundRect(BorderRadius.circular(12)),
                      child: TextField(
                        keyboardType: TextInputType.text,
                        controller: controller,
                        maxLines: 4,
                        decoration: InputDecoration(
                          hintText: 'Write remark',
                         */ /* border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide: const BorderSide(
                                color: Colors.grey,
                              )),*/ /*
                        ),
                        style: const TextStyle(fontSize: 10, color: Colors.grey),
                      ),
                    ),*/

              NeumorphicWidget(
                depth: -2,
                boxShape:
                    NeumorphicBoxShape.roundRect(BorderRadius.circular(12)),
                child: TextFormField(
                  controller: controller,
                  decoration: neuMorphicCustomInputDecoration("Write remark"),
                  maxLines: 3,
                  validator: (value) => value == null || value.isEmpty
                      ? "Please enter remark"
                      : null,
                ),
              ),

              SizedBox(height: displayHeight(context) * 0.05),

              // Submit Button
              Neumorphic(
                style: NeumorphicStyles.neuMorphicButtonStyle(),
                child: Container(
                  color: AppColors.attendanceBgColor1,
                  child: SizedBox(
                    width: double.infinity,
                    height: 60,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.only(top: 10, bottom: 10),
                        shape: RoundedRectangleBorder(
                          side: const BorderSide(
                              color: AppColors.white, width: 2),
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      onPressed: () {
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
                        }
                      },
                      child: const Text(
                        "Submit",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ),
              ),
              /* AppButton(
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
              ),*/

              SizedBox(height: displayHeight(context) * 0.04),
            ],
          ),
        ),
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
                'assets/images/right_tick.png',
                // Replace with your success icon image
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
                  SizedBox(
                    width: displayWidth(context) * 0.4,
                    child: Row(
                      children: [
                        SizedBox(
                          width: displayWidth(context) * 0.1,
                        ),
                        const Icon(
                          Icons.access_time, // Clock Icon
                          color: Colors.black54,
                        ),
                        const SizedBox(width: 6),
                        const Text(
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
                        style: const TextStyle(
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
                  SizedBox(
                    width: displayWidth(context) * 0.4,
                    child: Row(
                      children: [
                        SizedBox(
                          width: displayWidth(context) * 0.1,
                        ),
                        const Icon(
                          Icons.location_on, // Clock Icon
                          color: Colors.black54,
                        ),
                        const SizedBox(width: 6),
                        const Text(
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
                      child: const Text(
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
                  SizedBox(
                    width: displayWidth(context) * 0.4,
                    child: Row(
                      children: [
                        SizedBox(
                          width: displayWidth(context) * 0.1,
                        ),
                        const Icon(
                          Icons.location_pin, // Clock Icon
                          color: Colors.black54,
                        ),
                        const SizedBox(width: 6),
                        const Text(
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
                        style: const TextStyle(
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
