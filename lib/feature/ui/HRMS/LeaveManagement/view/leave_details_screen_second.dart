


import 'package:finexe/feature/base/internetConnection/networklistener.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic_plus/flutter_neumorphic.dart';
import 'package:intl/intl.dart';

import '../../../../base/utils/namespase/app_colors.dart';
import '../../../../base/utils/namespase/display_size.dart';
import '../model/leave_listing_model.dart';
import '../style/neumorphic_convex_style.dart'; // for date formatting

class LeaveDetailsScreenSecond extends StatelessWidget {
  final LeaveRequestModel leave;

  // Constructor to pass the selected LeaveRequestModel to this screen
  const LeaveDetailsScreenSecond({super.key, required this.leave});

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
        backgroundColor: AppColors.attendanceBgColor1,

        appBar: customAppBar(context,),

        body: Padding(
          padding: const EdgeInsets.all(10.0),
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),

              child: Padding(
                padding: const EdgeInsets.all(10),
                child: NeumorphicWidget(
                  boxShape: NeumorphicBoxShape.roundRect(BorderRadius.circular(12)),
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [

                        const SizedBox(height: 10),

                        Text("Title", style: TextStyle(color: AppColors.lightTextColor,fontSize: 12),),
                        Text(leave.title ?? "N/A", style: const TextStyle(color: Colors.black,fontSize: 14, fontWeight: FontWeight.bold),),
                        const Divider(color: Colors.grey, thickness: 0.5, height: 16, endIndent: 0,),// Space between the divider and text above),

                        const SizedBox(height: 16),

                        Text("Leave Type", style: TextStyle(color: AppColors.lightTextColor,fontSize: 12),),
                        Text(leave.leaveType!.isNotEmpty ? leave.leaveType! : "N/A",
                          style: const TextStyle(color: Colors.black,fontSize: 14, fontWeight: FontWeight.bold),
                        ),
                        const Divider(color: Colors.grey, thickness: 0.5, height: 16, indent: 0,),

                        const SizedBox(height: 16),

                        Text("Approved By", style: TextStyle(color: AppColors.lightTextColor,fontSize: 12),),
                        Text(leave.reportingManagerName ?? "N/A", style: const TextStyle(color: Colors.black,fontSize: 14, fontWeight: FontWeight.bold),),
                        const Divider(color: Colors.grey, thickness: 0.5, height: 16,endIndent: 0,),

                        const SizedBox(height: 16),

                        Text("Approval Status", style: TextStyle(color: AppColors.lightTextColor,fontSize: 12),),
                        Text(getApprovalStatus(leave.approvalByReportingManager), style: const TextStyle(color: Colors.black,fontSize: 14, fontWeight: FontWeight.bold),),
                        const Divider(color: Colors.grey, thickness: 0.5, height: 16,indent: 20,),


                        const SizedBox(height: 16),

                        Text("Date Range", style: TextStyle(color: AppColors.lightTextColor,fontSize: 12),),
                        Text("${formatDate(leave.startDate)} - ${formatDate(leave.endDate)}", style: const TextStyle(color: Colors.black,fontSize: 14, fontWeight: FontWeight.bold),),
                        const Divider(color: Colors.grey, thickness: 0.5, height: 16,endIndent: 0,),

                        const SizedBox(height: 16),

                        Text("Reason for Leave:", style: TextStyle(color: AppColors.lightTextColor,fontSize: 12),),
                        Text(leave.reasonForLeave ?? "", style: const TextStyle(color: Colors.black,fontSize: 14, fontWeight: FontWeight.bold),),
                        const Divider(color: Colors.grey, thickness: 0.5, height: 16,endIndent: 0,),

                        const SizedBox(height: 16),

                        if (leave.approvalByReportingManager == "no") ...[
                          const SizedBox(height: 16),
                          Text(
                            "Reject Reason: ${leave.reasonByReportingManager}",
                            style: const TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
                          ),
                        ],

                        const SizedBox(height: 16),
                      ],
                    ),
                  ),
                ),
              ),

          ),
        ),

       /* body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            child: Card(
              margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              elevation: 2,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

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
        ),*/
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
             /* Align(
                alignment: Alignment.centerLeft,
                child: NeumorphicButton(
                  style: NeumorphicStyles.neuMorphicButtonStyle(),
                  child: Icon(Icons.arrow_back, color: AppColors.darkTextColor,size: 20,),

                  *//* icon:Image.asset('assets/images/cancel_gray.png',width: 20,height: 20,),*//*
                  *//* icon: const Icon(Icons.cancel, color: AppColors.darkTextColor,size: 25,),*//*
                  onPressed: () => Navigator.pop(context),
                ),
                // ),
              ),*/
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.only(left: 10.0),
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
                "Leave Details",
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
