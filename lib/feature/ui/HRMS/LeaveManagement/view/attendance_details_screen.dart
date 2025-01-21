import 'dart:ui';

import 'package:custom_date_range_picker/custom_date_range_picker.dart';
import 'package:finexe/feature/base/internetConnection/networklistener.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_date_range_picker/flutter_date_range_picker.dart';
import 'package:flutter_neumorphic_plus/flutter_neumorphic.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import '../../../../base/utils/namespase/app_colors.dart';
import '../../../../base/utils/namespase/display_size.dart';
import '../../../../base/utils/widget/neuphormic_dropdown_style.dart';
import '../../../Sales/SalesProfile/view_model/sales_user_view_model.dart';
import '../model/attendance_listing_model.dart';
import '../style/neumorphic_convex_style.dart';
import '../view_model/attendance_listing_view_model.dart';
import 'package:flutter_date_pickers/flutter_date_pickers.dart' as dp;



class AttendanceDetailsScreen extends ConsumerStatefulWidget {
  // const AttendanceDetailsScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<AttendanceDetailsScreen> createState() => _AttendanceDetailsScreenState();

  final String employeeId;

  AttendanceDetailsScreen({required this.employeeId });

}

class _AttendanceDetailsScreenState extends ConsumerState<AttendanceDetailsScreen> {

  DateTime? startDate = DateTime.now().subtract(const Duration(days: 7));
  DateTime? endDate = DateTime.now();

  @override
  void initState() {
    super.initState();
    // Reset the monthController to current month
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(controllerProvider).resetToCurrentMonth();
      ref.read(attendanceListingProvider(widget.employeeId).notifier).fetchAttendanceRequests(widget.employeeId);
    });
  }

  @override
  Widget build(BuildContext context) {

    // Access ControllerNotifier to get monthController
    final controllerNotifier = ref.watch(controllerProvider);
    final attendanceAsync = ref.watch(attendanceListingProvider(widget.employeeId));

    final selectedButton = ref.watch(selectedButtonProvider);

    return NetworkListener(
      context: context,
      child: Scaffold(
        backgroundColor: AppColors.attendanceBgColor1,
        appBar:customAppBar(context),

        body: attendanceAsync.when(
          data: (leaveData) {
            final counters = leaveData["counters"] as AttendanceItems?;
            final leaveRequests = leaveData["attendanceRecords"] as List<AttendanceRecord>;
            if (counters == null) {
              return const Center(child: Text("No attendance data available."));
            }
            return SingleChildScrollView(
              padding: const EdgeInsets.all(10.0),
              physics: const AlwaysScrollableScrollPhysics(),
              child: SizedBox(
                height: displayHeight(context),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [

                    Padding(
                      padding: const EdgeInsets.fromLTRB(5,0,5,0),
                      child: NeumorphicWidget(
                        depth: -2,
                        boxShape: NeumorphicBoxShape.roundRect(BorderRadius.circular(12)),
                        child: DropdownButtonFormField<String>(
                          value: controllerNotifier.monthController.text.isEmpty ? null : controllerNotifier.monthController.text,
                          onChanged: (value) {
                            if (value != null) {
                              controllerNotifier.monthController.text = value;
                              ref.read(attendanceListingProvider(widget.employeeId).notifier).fetchAttendanceRequests(widget.employeeId);
                            }
                          },
                          items: controllerNotifier.monthOptions.map((String option) {
                            return DropdownMenuItem<String>(
                              value: option,
                              child: Text(option),
                            );
                          }).toList(),
                          decoration: neudropdownDecoration('Select Month'),

                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please select a month';
                            }
                            return null;
                          },
                        ),
                      ),
                    ),

                    SizedBox(height: displayHeight(context)*0.01),
                    // Counters at the top
                    _buildCounters(
                      totalLeave: counters.monthDays,
                      punchCount: counters.punchCount,
                      sundayPresentCount: counters.sundayPresentCount,
                      totalReject: counters.absentDays,
                    ),

                    SizedBox(height:displayHeight(context)*0.01),

                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween, // Ensures space between text and icon
                        children: [
                          const Expanded(
                            flex: 1, // Adjust flex as needed for column width
                            child: Text(
                              "My Attendance",
                              style: TextStyle(fontWeight: FontWeight.bold),
                              textAlign: TextAlign.start,
                            ),
                          ),

                          SizedBox(
                            width: 40,
                            height: 40,
                            child: NeumorphicWidget(
                              boxShape: const NeumorphicBoxShape.circle(),
                              child: IconButton(
                                icon: Image.asset(
                                  'assets/images/filter_icon_image.png', // Path to your custom image
                                  width: 20, // Adjust width
                                  height: 20, // Adjust height
                                  fit: BoxFit.contain, // Ensures the image fits properly
                                ),
                                onPressed: () {
                                  showFilterModal(context,ref);
                                },
                              ),
                            ),
                          ),

                          /*  SizedBox(
                            width: 30, // Fixed width for the icon
                            height: 30, // Fixed height for the icon
                            child: GestureDetector(
                              onTap: () {
                                showFilterModal(context,ref);
                              },
                              child:Icon(CupertinoIcons.square_list,size: 30,),
                            ),
                          ),*/
                        ],
                      ),
                    ),

                    SizedBox(height:displayHeight(context)*0.01),

                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: NeumorphicWidget(
                        depth: -2, // Adjust for inner/outer shadow
                        color: AppColors.attendanceBgColor1,
                        boxShape: NeumorphicBoxShape.roundRect(BorderRadius.circular(16)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            _buildButton(context, ref, "Last Days", 0, selectedButton),
                            _buildButton(context, ref, "This Month", 1, selectedButton),
                            _buildButton(context, ref, "Custom", 2, selectedButton),
                          ],
                        ),
                      ),
                    ),

                    SizedBox(height:displayHeight(context)*0.01),

                    /*
                    Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Container(
                              decoration: BoxDecoration(
                                color: AppColors.attendanceHeaderGrayColor,
                                border: Border(top: BorderSide(color: AppColors.attendanceHeaderGrayColor)),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Expanded(
                                      flex: 2, // Adjust flex as needed for column width
                                      child: Text(
                                        "Date",
                                        style: TextStyle(fontWeight: FontWeight.bold),
                                        textAlign: TextAlign.start,
                                      ),
                                    ),
                                    Expanded(
                                      flex: 2,
                                      child: Text(
                                        "Work Hours",
                                        style: TextStyle(fontWeight: FontWeight.bold),
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                    Expanded(
                                      flex: 2,
                                      child: Text(
                                        "Attendance",
                                        style: TextStyle(fontWeight: FontWeight.bold),
                                        textAlign: TextAlign.end,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),

                          Expanded(
                            child: ListView.builder(
                              itemCount: leaveRequests.length,
                              itemBuilder: (context, index) {
                                final leave = leaveRequests[index];
                                final isSelected = ref.watch(selectedRowProvider) == index;

                                return Column(
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        // Toggle selected row using Riverpod
                                        ref.read(selectedRowProvider.notifier).toggleSelectedRow(index);
                                      },
                                      child: _buildLeaveRow(leave),
                                    ),
                                    if (isSelected) _buildDetailCard1(leave), // Show detail card if selected
                                  ],
                                );
                              },
                            ),
                          ),
                        ],
                      ),*/

                    // Padding(
                    //   padding: const EdgeInsets.all(10.0),
                    //   child: Container(
                    //     decoration: BoxDecoration(
                    //       color: AppColors.attendanceHeaderGrayColor,
                    //       border: Border(top: BorderSide(color: AppColors.attendanceHeaderGrayColor)),
                    //     ),
                    //     child: Padding(
                    //       padding: const EdgeInsets.all(5.0),
                    //       child:,
                    //     ),
                    //   ),
                    // ),
                    Flexible(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: NeumorphicWidget(
                          boxShape: NeumorphicBoxShape.roundRect(BorderRadius.circular(12)),
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Column(
                              children: [
                                const Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Expanded(
                                      flex: 2, // Adjust flex as needed for column width
                                      child: Padding(
                                        padding: EdgeInsets.only(left: 10),
                                        child: Text(
                                          "Date",
                                          style: TextStyle(fontWeight: FontWeight.bold),
                                          textAlign: TextAlign.start,
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 2,
                                      child: Text(
                                        "Work Hours",
                                        style: TextStyle(fontWeight: FontWeight.bold),
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                    Expanded(
                                      flex: 2,
                                      child: Text(
                                        "Attendance",
                                        style: TextStyle(fontWeight: FontWeight.bold),
                                        textAlign: TextAlign.end,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: displayHeight(context)*0.01,),
                                Expanded(
                                  child: ListView.builder(
                                    shrinkWrap: true,
                                    primary: false,
                                    itemCount: leaveRequests.length,
                                    itemBuilder: (context, index) {
                                      final leave = leaveRequests[index];
                                      final isSelected = ref.watch(selectedRowProvider) == index;

                                      return Column(
                                        children: [
                                          GestureDetector(
                                            onTap: () {
                                              // Toggle selected row using Riverpod
                                              ref.read(selectedRowProvider.notifier).toggleSelectedRow(index);
                                            },
                                            child: _buildLeaveRow(leave),
                                          ),
                                          if (isSelected) _buildDetailCard1(leave), // Show detail card if selected
                                        ],
                                      );
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (err, stack) => Center(child: Text("Error: $err")),
        ),

      ),
    );
  }



  Widget _buildButton(
      BuildContext context,
      WidgetRef ref,
      String label,
      int index,
      int selectedButton,
      )
  {
    final isSelected = selectedButton == index;
    return GestureDetector(
      onTap: () async {
        ref.read(selectedButtonProvider.notifier).state = index;

        if (index == 0) {

        }
        else if (index == 1) {

        } else if (index == 2) {

          showCustomDateRangePicker(
            context,
            dismissible: true,
            minimumDate: DateTime.now().subtract(const Duration(days: 30)),
            maximumDate: DateTime.now().add(const Duration(days: 30)),
            endDate: endDate,
            startDate: startDate,
            backgroundColor: AppColors.attendanceBgColor1,
            primaryColor: AppColors.primary,
            onApplyClick: (start, end) {
              setState(() {
                endDate = end;
                startDate = start;
              });
            },
            onCancelClick: () {
              setState(() {
                endDate = null;
                startDate = null;
              });
            },
          );

        } else {
        }
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Neumorphic(
          style: NeumorphicStyle(
            depth: isSelected ? 5 : 0, // Inner shadow for selected, outer for others
            color: isSelected ? AppColors.attendanceBgColor1 : AppColors.attendanceBgColor1,
            boxShape: NeumorphicBoxShape.roundRect(BorderRadius.circular(12)),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
            child: Text(
              label,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: isSelected ? Colors.blue : Colors.black54,
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
                "Attendance",
                style: TextStyle(
                  color: AppColors.black2,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),

              // Icons on the right

            ],
          ),
        ),
      ),
    );
  }

  // Counter Section
  Widget _buildCounters({
    required int totalLeave,
    required int punchCount,
    required int totalReject, required int sundayPresentCount,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        _buildCounter("Total", totalLeave/*, Colors.blue*/),
        _buildCounter("Punch", punchCount/*, Colors.green*/),
        _buildCounter("Sunday", sundayPresentCount/*, Colors.green*/),
        _buildCounter("Absent", totalReject/*, Colors.red*/),
      ],
    );
  }

  Widget _buildCounter(String label, int value/*, Color color*/) {
    return Container(
      padding: const EdgeInsets.fromLTRB(0,5,0,0),
      /* decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
      ),*/
      child: SizedBox(
        height: 80,
        width: 70,
        child: NeumorphicWidget(
          boxShape: NeumorphicBoxShape.roundRect(BorderRadius.circular(12)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center, // Centers vertically
            crossAxisAlignment: CrossAxisAlignment.center, // Centers horizontally
            children: [
              Text(
                "$value",
                style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold/*, color: color*/),
              ),
              const SizedBox(height: 4),
              Text(label, style: const TextStyle(fontSize: 14)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLeaveRow(AttendanceRecord leave) {
    String formatDate(String date) {
      try {
        final parsedDate = DateTime.parse(date);
        return DateFormat("dd MMM yyyy").format(parsedDate);
      } catch (e) {
        debugPrint("Invalid date format: $date. Error: $e");
        return "Invalid Date"; // Fallback value
      }
    }

    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: Colors.grey.shade300)),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 2,
                child: Text(
                  formatDate(leave.date),
                  style: const TextStyle(fontSize: 14),
                  textAlign: TextAlign.start,
                ),
              ),
              Expanded(
                flex: 2,
                child: Text(
                  (leave.workedHour == null || leave.workedHour!.isEmpty) ? '0' : leave.workedHour!,
                  style: const TextStyle(fontSize: 14),
                  textAlign: TextAlign.center,
                ),
              ),
               Expanded(
                flex: 2,
                child: Align(
                  alignment: Alignment.centerRight,
                  child: Container(
                    width: 30, // Fixed width for the green box
                    padding: const EdgeInsets.symmetric(vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.green,

                      borderRadius: BorderRadius.circular(5), // Circular corners
                    ),// Optional padding
                    child: const Text(
                      "P",
                      style: TextStyle(fontSize: 14, color: Colors.white), // Text with white color
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ),


            ],
          ),
          SizedBox(height: 15,),
          Divider(color: Colors.grey,height: 0.2,thickness: 0.2,),
        ],
      ),
    );
  }

  Widget _buildDetailCard1(AttendanceRecord leave) {
    String formatDate(String date) {
      try {
        final parsedDate = DateTime.parse(date);
        return DateFormat("dd-MMM-yy").format(parsedDate);
      } catch (e) {
        debugPrint("Invalid date format: $date. Error: $e");
        return "Invalid Date"; // Fallback value
      }
    }

    String formatDateWithDay(String date) {
      try {
        final parsedDate = DateTime.parse(date);
        final day = DateFormat('EEEE').format(parsedDate); // Gets the full day name (e.g., "Saturday")
        return "$day";
      } catch (e) {
        debugPrint("Invalid date format: $date. Error: $e");
        return "Invalid Date"; // Fallback value
      }
    }

    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        border: Border(top: BorderSide(color: Colors.grey.shade300)),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Padding(
            padding: EdgeInsets.all(1),
            child: Row(
              children: [
                Expanded(
                  flex: 2, // Adjust flex as needed for column width
                  child: Text(
                    "Date",
                    style: TextStyle(fontWeight: FontWeight.w400),
                    textAlign: TextAlign.start,
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Text(
                    "Day",
                    style: TextStyle(fontWeight: FontWeight.w400),
                    textAlign: TextAlign.center,
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Text(
                    "Status",
                    style: TextStyle(fontWeight: FontWeight.w400),
                    textAlign: TextAlign.end,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(1),
            child: Row(
              children: [
                Expanded(
                  flex: 2, // Adjust flex as needed for column width
                  child: Text(
                    formatDate(leave.date!),
                    style: const TextStyle(fontWeight: FontWeight.bold),
                    textAlign: TextAlign.start,
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Text(
                    formatDateWithDay(leave.date!),
                    style: const TextStyle(fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Text(
                    leave.approvalStatus ?? 'N/A',
                    style: const TextStyle(fontWeight: FontWeight.bold),
                    textAlign: TextAlign.end,
                  ),
                ),
              ],
            ),
          ),
          const Padding(
            padding: EdgeInsets.fromLTRB(1,5,0,0),
            child: Row(
              children: [
                Expanded(
                  flex: 2, // Adjust flex as needed for column width
                  child: Text(
                    "Punch In",
                    style: TextStyle(fontWeight: FontWeight.w400),
                    textAlign: TextAlign.start,
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Text(
                    "Punch Out",
                    style: TextStyle(fontWeight: FontWeight.w400),
                    textAlign: TextAlign.center,
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Text(
                    "Spend Time",
                    style: TextStyle(fontWeight: FontWeight.w400),
                    textAlign: TextAlign.end,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(1,1,0,0),
            child: Row(
              children: [
                Expanded(
                  flex: 2, // Adjust flex as needed for column width
                  child: Text(
                    formatTime(leave.punchInTime!),
                    style: const TextStyle(fontWeight: FontWeight.bold),
                    textAlign: TextAlign.start,
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Text(
                    formatTime(leave.punchOutTime!),
                    style: const TextStyle(fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Text(
                    leave.workedHour ?? 'N/A',
                    style: const TextStyle(fontWeight: FontWeight.bold),
                    textAlign: TextAlign.end,
                  ),
                ),
              ],
            ),
          ),

        ],
      ),
    );
  }

  void showFilterModal(BuildContext context, WidgetRef ref) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (BuildContext context) {
        return BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: const BoxDecoration(
              color: AppColors.attendanceBgColor1,
              borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 50,
                  height: 5,
                  margin: const EdgeInsets.only(bottom: 16),
                  decoration: BoxDecoration(
                    color: AppColors.attendanceBgColor1,
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: NeumorphicButton(
                    style: NeumorphicStyles.neuMorphicButtonStyle(),
                    child: SizedBox(
                      width: 20,
                      height: 20,
                      child: Image.asset('assets/images/cancel_gray.png', fit: BoxFit.contain),
                    ),
                    /* icon:Image.asset('assets/images/cancel_gray.png',width: 20,height: 20,),*/
                    /* icon: const Icon(Icons.cancel, color: AppColors.darkTextColor,size: 25,),*/
                    onPressed: () => Navigator.pop(context),
                  ),
                  // ),
                ),

                const SizedBox(height: 10),
                const Text(
                  "Filter By",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 5),
                const Text(
                  "Attendance status",
                  style: TextStyle(fontSize: 14, color: Colors.grey),
                ),
                const SizedBox(height: 16),
                Consumer(
                  builder: (context, ref, _) {
                    final selectedFilter = ref.watch(attendanceFilterProvider);

                    Widget filterOption(String label) {
                      return Row(
                        children: [
                          Transform.scale(
                            scale: 1.3,
                            child: Radio<String>(
                              value: label,
                              groupValue: selectedFilter,
                              onChanged: (value) {
                                ref.read(attendanceFilterProvider.notifier).selectFilter(value);
                              },
                            ),
                          ),
                          Expanded(
                            child: Text(label, style: const TextStyle(fontSize: 14)),
                          ),
                        ],
                      );
                    }

                    return GridView.count(
                      crossAxisCount: 3,
                      shrinkWrap: true,
                      childAspectRatio: 2.5,
                      mainAxisSpacing: 5,
                      crossAxisSpacing: 5,
                      physics: const NeverScrollableScrollPhysics(),
                      children: [
                        filterOption("Present"),
                        filterOption("Absent"),
                        filterOption("Holidays"),
                        filterOption("Leaves"),
                        filterOption("Half Days"),
                        filterOption("Weekly Offs"),
                        filterOption("Missed Punch In"),
                        filterOption("Missed Punch Out"),
                      ],
                    );
                  },
                ),
                const SizedBox(height: 80),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [

                    SizedBox(
                      width: displayWidth(context)* 0.4,
                      height: displayHeight(context) * 0.08,
                      child: NeumorphicButton(
                        style: NeumorphicStyle(
                          shape: NeumorphicShape.flat,
                          color: AppColors.attendanceBgColor1,
                          boxShape: NeumorphicBoxShape.roundRect(BorderRadius.circular(12)),
                        ),
                        onPressed: () {
                          ref.read(attendanceFilterProvider.notifier).resetFilter();
                        },

                        child: const Center(child: Text("Reset", style: TextStyle(color: Colors.black))),
                      ),
                    ),
                    const SizedBox(width: 30),

                    SizedBox(
                      width: displayWidth(context)* 0.4,
                      height: displayHeight(context) * 0.08,
                      child: NeumorphicButton(
                        style: NeumorphicStyle(
                          shape: NeumorphicShape.flat,
                          color: AppColors.primary,
                          boxShape: NeumorphicBoxShape.roundRect(BorderRadius.circular(12)),
                          //border: NeumorphicBorder()
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                        },

                        child: const Center(child: Text("Apply",style: TextStyle(color: Colors.white))),
                      ),
                    ),

                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }


}




/*class _AttendanceDetailsScreenState extends ConsumerState<AttendanceDetailsScreen> {

  @override
  void initState() {
    super.initState();
    // Reset the monthController to current month
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(controllerProvider).resetToCurrentMonth();
      ref.read(attendanceListingProvider(widget.employeeId).notifier).fetchAttendanceRequests(widget.employeeId);
    });
  }

  @override
  Widget build(BuildContext context) {

    // Access ControllerNotifier to get monthController
    final controllerNotifier = ref.watch(controllerProvider);

    final attendanceAsync = ref.watch(attendanceListingProvider(widget.employeeId));

    return NetworkListener(
      context: context,
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Attendance Details",style: TextStyle(color: Colors.white)),
          backgroundColor: AppColors.primary,
          centerTitle: true,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back,color: Colors.white,),
            onPressed: () => Navigator.pop(context),
          ),
        ),
        body: attendanceAsync.when(
          data: (leaveData) {
            final counters = leaveData["counters"] as AttendanceItems?;
            final leaveRequests = leaveData["attendanceRecords"] as List<AttendanceRecord>;
            if (counters == null) {
              return const Center(child: Text("No attendance data available."));
            }
            return Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [

                  Padding(
                    padding: const EdgeInsets.fromLTRB(10,20,10,0),
                    child: DropdownButtonFormField<String>(
                      value: controllerNotifier.monthController.text.isEmpty ? null : controllerNotifier.monthController.text,
                      onChanged: (value) {
                        if (value != null) {
                          controllerNotifier.monthController.text = value;
                          ref.read(attendanceListingProvider(widget.employeeId).notifier).fetchAttendanceRequests(widget.employeeId);
                        }
                      },
                      items: controllerNotifier.monthOptions.map((String option) {
                        return DropdownMenuItem<String>(
                          value: option,
                          child: Text(option),
                        );
                      }).toList(),
                      decoration: dropdownDecoration('Select Month'),

                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please select a month';
                        }
                        return null;
                      },
                    ),
                  ),

                  const SizedBox(height: 10),
                  // Counters at the top
                  _buildCounters(
                    totalLeave: counters.monthDays,
                    punchCount: counters.punchCount,
                    sundayPresentCount: counters.sundayPresentCount,
                    totalReject: counters.absentDays,
                  ),

                  const SizedBox(height: 20),
                  // Header Row
                  // _buildHeader(),

                  // Leave List
                  Expanded(
                    child: ListView.builder(
                      itemCount: leaveRequests.length,
                      itemBuilder: (context, index) {
                        final leave = leaveRequests[index];
                        return _buildLeaveCard(leave);
                      },
                    ),
                  ),
                ],
              ),
            );
          },
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (err, stack) => Center(child: Text("Error: $err")),
        ),

      ),
    );
  }


  // Counter Section
  Widget _buildCounters({
    required int totalLeave,
    required int punchCount,
    required int totalReject, required int sundayPresentCount,
  }) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(10,0,10,0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _buildCounter("Total", totalLeave, Colors.blue),
          _buildCounter("Punch", punchCount, Colors.green),
          _buildCounter("Sunday", sundayPresentCount, Colors.green),
          _buildCounter("Absent", totalReject, Colors.red),
        ],
      ),
    );
  }

  Widget _buildCounter(String label, int value, Color color) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: [
          Text(
            "$value",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: color),
          ),
          const SizedBox(height: 4),
          Text(label, style: const TextStyle(fontSize: 14)),
        ],
      ),
    );
  }

  Widget _buildLeaveCard(AttendanceRecord leave) {
    String formatDate(String date) {
      final parsedDate = DateTime.parse(date);
      return DateFormat("dd-MM-yyyy").format(parsedDate); // Format to dd-MM-yyyy
    }

    String formatTime(String? dateTimes) {
      if (dateTimes == null || dateTimes.isEmpty) return 'N/A';
      DateFormat format = DateFormat("yyyy-MM-dd'T'hh:mm:ss a");
      DateTime dateTime = format.parse(dateTimes);
      return DateFormat.jm().format(dateTime); // Format to hh:mm a
    }

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      elevation: 3,
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // First Row: Date and Work Hours
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildLabelWithValue("Date", formatDate(leave.date)),
                _buildLabelWithValue("Work Hours",
                    (leave.workedHour == null || leave.workedHour!.isEmpty) ? '0' : leave.workedHour!,
                    alignRight: true),
              ],
            ),
            const SizedBox(height: 3),
            // Second Row: Punch In and Punch Out Times
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildLabelWithValue("Punch In", formatTime(leave.punchInTime)),
                _buildLabelWithValue("Punch Out", formatTime(leave.punchOutTime), alignRight: true),
              ],
            ),
          ],
        ),
      ),
    );

  }

  Widget _buildLabelWithValue(String label, String value, {bool alignRight = false}) {
    return Column(
      crossAxisAlignment: alignRight ? CrossAxisAlignment.end : CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 1),
        Text(
          value,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w400,
            color: Colors.black54,
          ),
        ),
      ],
    );
  }



}*/
