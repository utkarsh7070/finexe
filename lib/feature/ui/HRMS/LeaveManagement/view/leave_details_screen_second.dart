


import 'package:finexe/feature/base/internetConnection/networklistener.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../model/leave_listing_model.dart'; // for date formatting

class LeaveDetailsScreenSecond extends StatelessWidget {
  final LeaveRequestModel leave;

  // Constructor to pass the selected LeaveRequestModel to this screen
  const LeaveDetailsScreenSecond({Key? key, required this.leave}) : super(key: key);

  // Helper methods for formatting
  String formatDate(String date) {
    try {
      final parsedDate = DateTime.parse(date);
      return DateFormat("MMM dd, yyyy").format(parsedDate);
    } catch (e) {
      debugPrint("Invalid date format: $date. Error: $e");
      return "Invalid Date";
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

  @override
  Widget build(BuildContext context) {
    return NetworkListener(
      context: context,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Leave Details'),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context); // Back to previous screen
            },
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            child: Card(
              margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              elevation: 4,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                   /* Text(
                      "Leave Request Details",
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),*/


                    const SizedBox(height: 0),


                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Title", style: TextStyle(color: Colors.grey[600]),),
                              Text(leave.title ?? "N/A", style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold),),
                              const Divider(color: Colors.grey, thickness: 0.5, height: 16, endIndent: 20,),// Space between the divider and text above),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                "Leave Type",
                                style: TextStyle(color: Colors.grey[600]),
                              ),
                               Text(
                                   leave.leaveType!.isNotEmpty ? leave.leaveType! : "N/A",
                                style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
                              ),
                              const Divider(color: Colors.grey, thickness: 0.5, height: 16, indent: 20,),
                            ],
                          ),
                        ),
                      ],
                    ),



                    const SizedBox(height: 16),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Approved By", style: TextStyle(color: Colors.grey[600]),),
                              Text(leave.reportingManagerName ?? "N/A", style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold),),
                              const Divider(color: Colors.grey, thickness: 0.5, height: 16,endIndent: 20,),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text("Approval Status", style: TextStyle(color: Colors.grey[600]),),
                              Text(getApprovalStatus(leave.approvalByReportingManager), style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold),),
                              const Divider(color: Colors.grey, thickness: 0.5, height: 16,indent: 20,),

                            ],
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Date Range", style: TextStyle(color: Colors.grey[600]),),
                            Text("${formatDate(leave.startDate)} - ${formatDate(leave.endDate)}", style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold),),
                          ],
                        ),
                      ],
                    ),

                    const Divider(color: Colors.grey, thickness: 0.5, height: 16,endIndent: 0,),

                    const SizedBox(height: 16),
                    Text("Reason for Leave:", style: TextStyle(color: Colors.grey[600]),),
                    Text(leave.reasonForLeave ?? "", style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold),),

                    const Divider(color: Colors.grey, thickness: 0.5, height: 16,endIndent: 0,),

                    if (leave.approvalByReportingManager == "no") ...[
                      const SizedBox(height: 16),
                      Text(
                        "Reject Reason: ${leave.reasonByReportingManager}",
                        style: const TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
