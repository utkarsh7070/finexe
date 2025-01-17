import 'dart:ui';

import 'package:finexe/feature/base/internetConnection/networklistener.dart';
import 'package:flutter_neumorphic_plus/flutter_neumorphic.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../../../base/utils/namespase/app_colors.dart';

import '../../../../base/utils/namespase/display_size.dart';
import '../model/leave_listing_model.dart';
import '../style/neumorphic_convex_style.dart';
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
        backgroundColor: AppColors.attendanceBgColor1,
        appBar: customAppBar(context,),

        body: leaveRequestAsync.when(
          data: (leaveData) {
            final counters = leaveData["counters"] as CountersModel;
            final leaveRequests = leaveData["leaveRequests"] as List<LeaveRequestModel>;
            return Column(
              children: [
                const SizedBox(height: 10),
                // Counters at the top
                _buildCounters(
                  totalLeave: counters.totalLeave,
                  totalApprove: counters.totalApprove,
                  totalReject: counters.totalReject,
                ),

                const SizedBox(height: 0),
                // Header Row

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
                "All Leaves",
                style: TextStyle(
                  color: AppColors.black2,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),

              // Icons on the right
              Align(
                alignment: Alignment.centerRight,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
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
                            showFilterModal(context, ref);
                          },
                        ),
                                           ),
                     ),


                    const SizedBox(width: 10),
                    SizedBox(
                      width: 40,
                      height: 40,
                      child: NeumorphicWidget(
                        boxShape: const NeumorphicBoxShape.circle(),
                        child: IconButton(
                          icon: Image.asset(
                            'assets/images/circle_plus_icon.png',
                            // Path to your custom image
                            width: 20, // Adjust width
                            height: 20, // Adjust height
                            fit:
                                BoxFit.contain, // Ensures the image fits properly
                          ),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const LeaveRequestForm()),
                            ).then((refreshNeeded) {
                              if (refreshNeeded == true) {
                                ref.refresh(leaveRequestDetailsViewModelProvider);
                              }
                            });
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCounters({
    required int totalLeave,
    required int totalApprove,
    required int totalReject,
  }) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(5,0,5,0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildCounter("Leave Balance", 0, AppColors.leaveBlueColor),
              _buildCounter("Leave Pending", totalLeave, AppColors.leaveOrangeColor),

            ],
          ),
          const SizedBox(height: 1),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [

              _buildCounter("Leave Cancelled", totalReject, AppColors.leavePinkColor),
              _buildCounter("Leave Approved", totalApprove, AppColors.leaveGreenColor),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildCounter(String label, int value, Color color) {
    return Expanded(
      /*child: Container(
        padding: const EdgeInsets.all(8),
        margin: const EdgeInsets.all(6), // Add spacing between cards
        decoration: BoxDecoration(
          color: color.withOpacity(0.1),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: color, width: 1), // Border to match the image
        ),*/
        child: Padding(
          padding: const EdgeInsets.fromLTRB(10,5,10,5),
          child: NeumorphicWidget(
            boxShape: NeumorphicBoxShape.roundRect(BorderRadius.circular(12)),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start, // Align text to the start
                children: [
                  Text(
                    label,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: color,
                    ),
                  ),
                  const SizedBox(height: 1),
                  Text(
                    "$value",
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: AppColors.darkTextColor,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      //),
    );
  }

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
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.02), // Custom shadow color
              blurRadius: 12, // Shadow spread and blur
              offset: const Offset(0, 0), // No offset for shadow
            ),
          ],
        ),
        // child: Card(
        //   shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        //   elevation: 0, // Disable default elevation
          child: NeumorphicWidget(
            boxShape: NeumorphicBoxShape.roundRect(BorderRadius.circular(12)),
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
                          const Text(
                            "Date",
                            style: TextStyle(
                              fontSize: 12.25,
                             /* fontWeight: FontWeight.w600,*/
                              color: AppColors.lightTextColor,
                            ),
                          ),
                          Text(
                            "${formatDate(leave.startDate)} - ${formatDate(leave.endDate)}",
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: AppColors.darkTextColor,
                            ),
                          ),
                        ],
                      ),
                     /* NeumorphicButton(
                          margin: EdgeInsets.only(top: 3),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => LeaveDetailsScreenSecond(leave: leave),
                              ),
                            );
                          },
                          style: NeumorphicStyle(
                            shape: NeumorphicShape.flat,
                            boxShape:
                            NeumorphicBoxShape.roundRect(BorderRadius.circular(8)),
                          ),
                          padding: const EdgeInsets.all(12.0),
                        child: Text(
                          getApprovalStatus(leave.approvalByReportingManager),
                          style: TextStyle(
                            color: getStatusColor(leave.approvalByReportingManager),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),*/
                    /*  Container(
                        padding: const EdgeInsets.symmetric(vertical: 3, horizontal: 8),
                        decoration: BoxDecoration(
                          color: getStatusColor(leave.approvalByReportingManager).withOpacity(0.2),
                          borderRadius: BorderRadius.circular(8),
                        ),*/
                       /* child:*/
                      Neumorphic(
                        style: NeumorphicStyles.neuMorphicButtonStyle(),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                              getApprovalStatus(leave.approvalByReportingManager),
                              style: TextStyle(
                                color: getStatusColor(leave.approvalByReportingManager),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                        ),
                      ),
                     // ),

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
                          const Text(
                            "Apply Days",
                            style: TextStyle(
                              fontSize: 12.25,
                              /*fontWeight: FontWeight.w600,*/
                              color: AppColors.lightTextColor,
                            ),
                          ),
                          Text(
                            "${calculateApplyDays(leave.startDate, leave.endDate)} Days",
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: AppColors.darkTextColor,
                            ),
                          ),
                        ],
                      ),

                      // Right Column: Approved By
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          const Text(
                            "Approved By",
                            style: TextStyle(
                              fontSize: 12.25,
                              /*fontWeight: FontWeight.w600,*/
                              color: AppColors.lightTextColor,
                            ),
                          ),
                          Text(
                            leave.reportingManagerName ?? "N/A",
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: AppColors.darkTextColor,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        //),
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
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Drag indicator
                Center(
                  child: Container(
                    width: 50,
                    height: 5,
                    margin: const EdgeInsets.only(bottom: 16),
                    decoration: BoxDecoration(
                      color: AppColors.attendanceBgColor1,
                      borderRadius: BorderRadius.circular(10),
                    ),
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
                // Title
               /* const Text(
                  "Filter By",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),*/
                const SizedBox(height: 5),
                const Text(
                  "Status",
                  style: TextStyle(fontSize: 14, color: AppColors.black2,fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 16),

                // Status filter section
                Consumer(
                  builder: (context, ref, _) {
                    final selectedFilter = ref.watch(leaveStatusFilterProvider);

                    Widget filterOption(String label) {
                      return Row(
                        children: [
                          Transform.scale(
                            scale: 1.3,
                            child: Radio<String>(
                              value: label,
                              groupValue: selectedFilter,
                              onChanged: (value) {
                                ref.read(leaveStatusFilterProvider.notifier).selectFilter(value);
                              },
                            ),
                          ),
                          Expanded(
                            child: Text(label, style: const TextStyle(fontSize: 14)),
                          ),
                        ],
                      );
                    }

                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        filterOption("Approved"),
                        filterOption("Unapproved"),
                        filterOption("Pending"),
                      ],
                    );
                  },
                ),

                const SizedBox(height: 24),
                const Text(
                  "Leave Type",
                  style: TextStyle(fontSize: 14,  color: AppColors.black2,fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 16),

                // Leave type filter section
                Consumer(
                  builder: (context, ref, _) {
                    final selectedFilter = ref.watch(leaveTypeFilterProvider);

                    Widget filterOption(String label) {
                      return Row(
                        children: [
                          Transform.scale(
                            scale: 1.3,
                            child: Radio<String>(
                              value: label,
                              groupValue: selectedFilter,
                              onChanged: (value) {
                                ref.read(leaveTypeFilterProvider.notifier).selectFilter(value);
                              },
                            ),
                          ),
                          Expanded(
                            child: Text(label, style: const TextStyle(fontSize: 14)),
                          ),
                        ],
                      );
                    }

                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        filterOption("Sick Leave"),
                        filterOption("Planned Leave"),
                        filterOption("Holiday"),
                      ],
                    );
                  },
                ),

                const SizedBox(height: 80),

                // Reset and Apply buttons
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
                          ref.read(leaveStatusFilterProvider.notifier).resetFilter();
                          ref.read(leaveTypeFilterProvider.notifier).resetFilter();
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