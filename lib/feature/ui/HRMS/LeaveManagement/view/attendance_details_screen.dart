import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../../../Punch_In_Out/viewmodel/attendance_view_model.dart';
import '../../../../base/utils/namespase/app_colors.dart';
import '../../../../base/utils/widget/dropdown_style.dart';
import '../model/attendance_listing_model.dart';
import '../view_model/attendance_listing_view_model.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import '../../../../base/utils/namespase/app_colors.dart';
import '../../../../base/utils/widget/dropdown_style.dart';
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

    return Scaffold(
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
      DateFormat format = DateFormat("yyyy-MM-dd'T'HH:mm:ss");
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

}
