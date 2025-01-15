import 'dart:ui';

import 'package:finexe/feature/base/internetConnection/networklistener.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../../../base/utils/namespase/app_colors.dart';
import '../../../../base/utils/widget/dropdown_style.dart';
import '../../../Sales/SalesProfile/view_model/login_user_view_model.dart';
import '../model/attendance_listing_model.dart';
import '../view_model/attendance_listing_view_model.dart';



class AttendanceDetailsScreen extends ConsumerStatefulWidget {
  // const AttendanceDetailsScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<AttendanceDetailsScreen> createState() => _AttendanceDetailsScreenState();

  final String employeeId;

  AttendanceDetailsScreen({required this.employeeId });

}

class _AttendanceDetailsScreenState extends ConsumerState<AttendanceDetailsScreen> {
  int? selectedRowIndex; // Track the selected row index
  String? selectedFilter; // Add this to manage the selected value

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

                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween, // Ensures space between text and icon
                      children: [
                        Expanded(
                          flex: 1, // Adjust flex as needed for column width
                          child: Text(
                            "My Attendance",
                            style: TextStyle(fontWeight: FontWeight.bold),
                            textAlign: TextAlign.start,
                          ),
                        ),
                        SizedBox(
                          width: 30, // Fixed width for the icon
                          height: 30, // Fixed height for the icon
                          child: GestureDetector(
                            onTap: () {
                              showFilterModal(context,ref);
                            },
                            child:Icon(CupertinoIcons.square_list,size: 30,),
                          ),
                        ),
                      ],
                    ),
                  ),


                  SizedBox(height: 20),

                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.grey.shade100,
                        border: Border(top: BorderSide(color: Colors.grey.shade300)),
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
                        final isSelected = selectedRowIndex == index;
                        return Column(
                          children: [
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  selectedRowIndex = isSelected ? null : index;
                                });
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
                  style: TextStyle(fontSize: 14),
                  textAlign: TextAlign.start,
                ),
              ),
              Expanded(
                flex: 2,
                child: Text(
                  (leave.workedHour == null || leave.workedHour!.isEmpty) ? '0' : leave.workedHour!,
                  style: TextStyle(fontSize: 14),
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
                      color: Colors.green, // Background color
                      borderRadius: BorderRadius.circular(5), // Circular corners
                    ),// Optional padding
                    child: Text(
                      "P",
                      style: TextStyle(fontSize: 14, color: Colors.white), // Text with white color
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ),
            ],
          ),
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
          Padding(
            padding: const EdgeInsets.all(1),
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
                    style: TextStyle(fontWeight: FontWeight.bold),
                    textAlign: TextAlign.start,
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Text(
                    formatDateWithDay(leave.date!),
                    style: TextStyle(fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Text(
                    leave.approvalStatus ?? 'N/A',
                    style: TextStyle(fontWeight: FontWeight.bold),
                    textAlign: TextAlign.end,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(1,5,0,0),
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
                    style: TextStyle(fontWeight: FontWeight.bold),
                    textAlign: TextAlign.start,
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Text(
                    formatTime(leave.punchOutTime!),
                    style: TextStyle(fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Text(
                    leave.workedHour ?? 'N/A',
                    style: TextStyle(fontWeight: FontWeight.bold),
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
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 50,
                  height: 5,
                  margin: EdgeInsets.only(bottom: 16),
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  "Filter By",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 5),
                Text(
                  "Attendance status",
                  style: TextStyle(fontSize: 14, color: Colors.grey),
                ),
                SizedBox(height: 16),
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
                            child: Text(label, style: TextStyle(fontSize: 14)),
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
                      physics: NeverScrollableScrollPhysics(),
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
                SizedBox(height: 80),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          ref.read(attendanceFilterProvider.notifier).resetFilter();
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.grey[300],
                        ),
                        child: Text("Reset", style: TextStyle(color: Colors.black)),
                      ),
                    ),
                    const SizedBox(width: 30),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primary,
                          foregroundColor: Colors.white,
                        ),
                        child: const Text("Apply"),
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
