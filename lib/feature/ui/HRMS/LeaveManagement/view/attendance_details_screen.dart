import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../../../Punch_In_Out/viewmodel/attendance_view_model.dart';
import '../../../../base/utils/namespase/app_colors.dart';
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

/*class AttendanceDetailsScreen extends ConsumerStatefulWidget {


  @override
  ConsumerState<ConsumerStatefulWidget> createState() {
    // TODO: implement createState
    throw UnimplementedError();
  }*/

  @override
  Widget build(BuildContext context) {


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
          return Column(
            children: [
              const SizedBox(height: 20),
              // Counters at the top
              _buildCounters(
                totalLeave: counters.monthDays,
                totalApprove: counters.presentDays,
                totalReject: counters.absentDays,
              ),

              const SizedBox(height: 20),
              // Header Row
              _buildHeader(),

              // Leave List
              Expanded(
                child: ListView.builder(
                  itemCount: leaveRequests.length,
                  itemBuilder: (context, index) {
                    final leave = leaveRequests[index];
                    return _buildLeaveRow(leave);
                  },
                ),
              ),
            ],
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
    required int totalApprove,
    required int totalReject,
  }) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildCounter("Total", totalLeave, Colors.blue),
          _buildCounter("Present", totalApprove, Colors.green),
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

  // Header Row
  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      color: Colors.grey[200],
      child: const Row(
        children: [
          Expanded(child: Text("Date", style: TextStyle(fontWeight: FontWeight.bold))),
          Expanded(child: Text("Punch In", style: TextStyle(fontWeight: FontWeight.bold))),
          Expanded(child: Text("Punch Out", style: TextStyle(fontWeight: FontWeight.bold))),
        ],
      ),
    );
  }

  // Leave Row
  Widget _buildLeaveRow(AttendanceRecord leave) {
    String formatDate(String date) {
      final parsedDate = DateTime.parse(date);
      return DateFormat("dd-MM-yyyy").format(parsedDate);
    }

    String formatTime(String? dateTimes) {
      print('time formate ${dateTimes}');
     // if (dateTimes == null) return 'N/A'; // Handle null case
      if (dateTimes == null || dateTimes.isEmpty) return 'N/A'; // Handle null or empty case
      DateFormat format = DateFormat("yyyy-MM-dd'T'hh:mm:ss a");
      DateTime dateTime = format.parse(dateTimes);// Handle empty strings
      // final parsedTime = DateTime.parse(time);
      print('parse time ${dateTime}');
      return DateFormat.jm()
          .format(dateTime); // Format as 09:3
    }

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(child: Text(formatDate(leave.date))),
              Expanded(child: Text(formatTime(leave.punchInTime))), // Format punch-in time
              Expanded(child: Text(formatTime(leave.punchOutTime))), // Format punch-out time
            ],
          ),
          const SizedBox(height: 8),
          const Divider(color: Colors.grey),
        ],
      ),
    );
  }




}
