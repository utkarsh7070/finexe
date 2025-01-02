import 'package:finexe/feature/base/internetConnection/networklistener.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../../../base/utils/namespase/app_colors.dart';
import '../model/leave_listing_model.dart';
import '../view_model/leave_list_show_view_model.dart';

import 'leave_details_screen_second.dart';
import 'leave_request_form.dart';


class LeaveRequestScreen extends ConsumerStatefulWidget {
  const LeaveRequestScreen({super.key});

  @override
  ConsumerState<LeaveRequestScreen> createState() => _LeaveRequestScreenState();
}

class _LeaveRequestScreenState extends ConsumerState<LeaveRequestScreen> {
  bool _isApiRefreshed = false; // Flag to ensure API is refreshed only once

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    if (!_isApiRefreshed) {
      _isApiRefreshed = true; // Mark the flag as true to prevent future calls
      WidgetsBinding.instance.addPostFrameCallback((_) {
        ref.refresh(leaveRequestDetailsViewModelProvider);
      });
    }
  }

  @override
  Widget build(BuildContext context) {

    final leaveRequestAsync = ref.watch(leaveRequestDetailsViewModelProvider);

    return NetworkListener(
      context: context,
      child: Scaffold(
        appBar: AppBar(
          title: const Text("All Leaves",style: TextStyle(color: Colors.white)),
          backgroundColor: AppColors.primary,
          centerTitle: true,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back,color: Colors.white,),
            onPressed: () => Navigator.pop(context),
          ),
        ),
        body: leaveRequestAsync.when(
          data: (leaveData) {
            final counters = leaveData["counters"] as CountersModel;
            final leaveRequests = leaveData["leaveRequests"] as List<LeaveRequestModel>;
            return Column(
              children: [
                const SizedBox(height: 20),
                // Counters at the top
                _buildCounters(
                  totalLeave: counters.totalLeave,
                  totalApprove: counters.totalApprove,
                  totalReject: counters.totalReject,
                ),
      
                const SizedBox(height: 0),
                // Header Row
               // _buildHeader(),
      
                // Leave List
                Expanded(
                  child: ListView.builder(
                    itemCount: leaveRequests.length,
                    itemBuilder: (context, index) {
                      final leave = leaveRequests[index];
                     // return _buildLeaveRow(leave);
                      return _buildLeaveCard(leave,context);
                    },
                  ),
                ),
              ],
            );
          },
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (err, stack) => Center(child: Text("Error: $err")),
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: AppColors.primary,
          onPressed: () {
            // Add leave request functionality
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) =>  const LeaveRequestForm()),
            ).then((refreshNeeded) {
              // Check if refresh is needed
              if (refreshNeeded == true) {
                // Trigger the data refresh in the ViewModel
                ref.refresh(leaveRequestDetailsViewModelProvider);
              }
            });
          },
          child: const Icon(Icons.add),
        ),
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
          _buildCounter("Apply", totalLeave, Colors.blue),
          _buildCounter("Approve", totalApprove, Colors.green),
          _buildCounter("Reject", totalReject, Colors.red),
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
  /*Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      color: Colors.grey[200],
      child: const Row(
        children: [
          Expanded(child: Text("FromDt", style: TextStyle(fontWeight: FontWeight.bold))),
          Expanded(child: Text("EndDt", style: TextStyle(fontWeight: FontWeight.bold))),
          Expanded(child: Text("Status", style: TextStyle(fontWeight: FontWeight.bold))),
        ],
      ),
    );
  }*/

  // Leave Card
  Widget _buildLeaveCard(LeaveRequestModel leave, BuildContext context) {
    String formatDate(String date) {
      try {
        final parsedDate = DateTime.parse(date);
        return DateFormat("MMM dd, yyyy").format(parsedDate);
      } catch (e) {
        debugPrint("Invalid date format: $date. Error: $e");
        return "Invalid Date"; // Fallback value
      }
    }

    String getApprovalStatus(String status) {
      switch (status) {
        case "active":
          return "Pending";
        case "yes":
          return "Approved";
        case "no":
          return "Rejected";
        default:
          return "Unknown";
      }
    }

    Color getStatusColor(String status) {
      switch (status) {
        case "yes":
          return Colors.green;
        case "no":
          return Colors.red;
        default:
          return Colors.orange;
      }
    }

    /// Calculate the number of days between startDate and endDate
    int calculateApplyDays(String startDate, String endDate) {
      try {
        final start = DateTime.parse(startDate);
        final end = DateTime.parse(endDate);
        return end.difference(start).inDays + 1; // Add 1 to include the start day
      } catch (e) {
        debugPrint("Invalid date range: $startDate - $endDate. Error: $e");
        return 0; // Fallback value for invalid dates
      }
    }

    return GestureDetector(
      onTap: () {
        // Navigate to the detail screen and pass the selected leave request
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => LeaveDetailsScreenSecond(leave: leave),
          ),
        );
      },
      child: Card(
        margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        elevation: 4,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Date",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: Colors.grey[600],
                        ),
                      ),
                      Text(
                        "${formatDate(leave.startDate)} - ${formatDate(leave.endDate)}",
                        style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                    decoration: BoxDecoration(
                      color: getStatusColor(leave.approvalByReportingManager).withOpacity(0.2),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      getApprovalStatus(leave.approvalByReportingManager),
                      style: TextStyle(
                        color: getStatusColor(leave.approvalByReportingManager),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween, // Align left and right content
                children: [
                  // Left Column: Apply Days
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Apply Days",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: Colors.grey[600],
                        ),
                      ),
                      Text(
                        "${calculateApplyDays(leave.startDate, leave.endDate)} Days",
                        style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),

                  // Right Column: Approved By
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        "Approved By",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: Colors.grey[600],
                        ),
                      ),
                      Text(
                        leave.reportingManagerName ?? "N/A",
                        style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ],
              ),

             /* if (leave.approvalByReportingManager == "no")
                Padding(
                  padding: const EdgeInsets.only(top: 16),
                  child: Text(
                    "Reject Reason: ${leave.reasonByReportingManager}",
                    style: const TextStyle(color: Colors.red, fontSize: 14),
                  ),
                ),*/
            ],
          ),
        ),
      ),
    );
  }


// Leave Row
 /* Widget _buildLeaveRow(LeaveRequestModel leave) {
   *//* String formatDate(String date) {
      final parsedDate = DateTime.parse(date);
      return DateFormat("dd-MM-yyyy").format(parsedDate);
    }*//*
    String formatDate(String date) {
      try {
        final parsedDate = DateTime.parse(date);
        return DateFormat("dd-MM-yyyy").format(parsedDate);
      } catch (e) {
        debugPrint("Invalid date format: $date. Error: $e");
        return "Invalid Date"; // Fallback value
      }
    }

    String getApprovalStatus(String status) {
      switch (status) {
        case "active":
          return "Pending";
        case "yes":
          return "Approved";
        case "no":
          return "Reject";
        default:
          return "Unknown";
      }
    }
    return Container(

      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            child: Row(
              children: [
                Expanded(child: Text(formatDate(leave.startDate))),
                Expanded(child: Text(formatDate(leave.endDate))),
                Expanded(
                  child: Text(
                    getApprovalStatus(leave.approvalByReportingManager),
                    style: TextStyle(
                      color: leave.approvalByReportingManager == "yes"
                          ? Colors.green
                          : leave.approvalByReportingManager == "no"
                          ? Colors.red
                          : Colors.orange,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),
          Text("Reason: ${leave.reasonForLeave}"),
          if (leave.approvalByReportingManager == "no")
            Text("Reject Reason: ${leave.reasonByReportingManager}",
                style: const TextStyle(color: Colors.red)),
          const Divider(color: Colors.grey,),
        ],
      ),
    );
  }*/


}