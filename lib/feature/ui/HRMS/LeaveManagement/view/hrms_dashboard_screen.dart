
import 'package:finexe/feature/base/dialog/logout_dialog.dart';
import 'package:finexe/feature/base/internetConnection/connection_overlay.dart';

import 'package:finexe/feature/base/internetConnection/networklistener.dart';
import 'package:finexe/feature/base/utils/namespase/display_size.dart';
import 'package:finexe/feature/base/utils/namespase/font_size.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_swipe_button/flutter_swipe_button.dart';
import 'package:intl/intl.dart';
import '../../../../base/api/api.dart';
import '../../../../base/utils/namespase/app_colors.dart';
import '../../../../base/utils/namespase/app_style.dart';
import '../../../Collection/Collection_home_dashboard/Widget/punct_in_out_action_dialog_content.dart';
import '../../../Collection/Collection_home_dashboard/home_collection_viewmodel/fetchUserProfile.dart';
import '../../../Sales/SalesProfile/view_model/login_user_view_model.dart';
import '../view_model/hrms_dashboard_view_model.dart';
import 'attendance_details_screen.dart';
import 'leave_details_form.dart';

class HRMSDashboardScreen extends ConsumerWidget {
  const HRMSDashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userProfileAsync = ref.watch(loginUserProfileProvider);
    final hrmsViewModel = ref.read(hrmsDashBordProvider.notifier);
    final punchOut = ref.read(apiResponseProvider.notifier);
    // final role = ref.watch(roleName)
    // final role = ref.watch(roleName)

    ref.listen(roleListProvider, (previous, next) {
      if (previous == null && next.role.isEmpty) {
        ref.read(roleListProvider.notifier).loadRoles();
      }
    });
    final role = ref.watch(roleListProvider);

    print('hr dashbord role ${role.role}');

    return NetworkListener(
        context: context,
        child: userProfileAsync.when(
          data: (userProfile) {
            final joiningDate = DateFormat('dd/MM/yyyy')
                .format(DateTime.parse(userProfile.joiningDate));
            final dateOfBirth = DateFormat('dd/MM/yyyy')
                .format(DateTime.parse(userProfile.dateOfBirth));
            return Scaffold(
              // bottomNavigationBar: BottomBar(
              //   punchInTime: userProfile.punchInTime,
              //   punchOutTime: userProfile.punchOutTime,
              // ),
              appBar: AppBar(
                title: Visibility(
                  replacement: Text('HRMS'),
                  visible: !(role.role.contains('sales') ||
                      role.role.contains('collection') ||
                      role.role.contains('pd') ||
                      role.role.contains('admin')),
                  child: Row(
                    children: [
                      CircleAvatar(
                        backgroundColor: AppColors.primary,
                        radius: 20,
                        // backgroundImage: NetworkImage(userProfile.employeePhoto),
                        backgroundImage: userProfile.employeePhoto.isNotEmpty &&
                                userProfile.employeePhoto.contains('upload')
                            ? NetworkImage(
                                '${Api.imageUrl}${userProfile.employeePhoto}')
                            : const AssetImage('assets/images/prof.jpeg')
                                as ImageProvider,
                        // Placeholder image
                        onBackgroundImageError: (error, stackTrace) {
                          // Set a default image if the API image fails to load
                        },
                      ),
                      SizedBox(
                        width: displayWidth(context) * 0.02,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            userProfile.employeName,
                            style: AppStyles.TextStyle16,
                          ),
                          Text(
                            userProfile.designationId['name'] ?? '',
                            style: AppStyles.blacktext14
                                .copyWith(color: AppColors.gray7),
                          )
                        ],
                      )
                    ],
                  ),
                ),
                actions: [
                  IconButton(
                      onPressed: () {
                        LogOutDialog.logOutDialog(context: context);
                      },
                      icon: const Icon(
                        Icons.logout,
                      ))
                ],
                // const Text("Dashboard", style: TextStyle(color: Colors.white)),
                // backgroundColor: AppColors.primary,
                // centerTitle: true,
                leading: Visibility(
                  replacement: SizedBox(),
                  visible: (role.role.contains('sales') ||
                      role.role.contains('collection') ||
                      role.role.contains('pd') ||
                      role.role.contains('admin')),
                  child: IconButton(
                    icon: const Icon(
                      CupertinoIcons.back,
                      color: Colors.black,
                    ),
                    onPressed: () => Navigator.pop(context),
                  ),
                ),
              ),
              body: SingleChildScrollView(
                physics: AlwaysScrollableScrollPhysics(),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Card(
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          side: const BorderSide(color: AppColors.boxBorderGray),
                          borderRadius:
                              BorderRadius.circular(12), // Rounded corners
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 16.0,right: 16,bottom: 25,top: 25),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                'Your Today Activity',
                                style: AppStyles.blackText16,
                              ),
                              SizedBox(height: displayHeight(context) * 0.01),
                              Text(
                                'Today Check In ${formatDate(userProfile.punchInTime)}, ${formatTime(userProfile.punchInTime)}',
                                style: AppStyles.headingTextStyleFooter
                                    .copyWith(color: AppColors.textDarkGray,fontSize: FontSize.fontSizeXS),
                              ),
                              SizedBox(
                                height: displayHeight(context) * 0.04,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  timeShow(
                                      icon: Icons.move_to_inbox_outlined,
                                      label: 'Check In',
                                      time: formatTime(userProfile.punchInTime),
                                      context: context),
                                  timeShow(
                                      icon: Icons.outbox_outlined,
                                      time: formatTime(
                                        userProfile.punchOutTime,
                                      ),
                                      label: 'Check Out',
                                      context: context),
                                  timeShow(
                                      icon: Icons.watch_later_outlined,
                                      label: 'Working HR’S',
                                      time: '00:00',
                                      context: context)
                                ],
                              ),
                              SizedBox(
                                height: displayHeight(context) * 0.05,
                              ),
                              SwipeButton.expand(
                                width: 500,
                                thumb: Container(
                                  width: 10, // Adjust the width of the thumb
                                  height: 10, // Adjust the height of the thumb
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(
                                        20), // Round the thumb if needed
                                  ),
                                  child: const Icon(
                                    Icons.double_arrow_rounded,
                                    color: Colors.red,
                                  ),
                                ),
                                activeThumbColor: Colors.white,
                                activeTrackColor: Colors.red.shade300,
                                // elevationThumb: 4.8,
                                height: 60,
                                thumbPadding: EdgeInsets.all(8),
                                child: const Text(
                                  "Swipe to Punch Out",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                ),
                                onSwipe: () {
                                  punchOut.clickPunchOut(context);
                                  ref.refresh(loginUserProfileProvider);
                                  // ref.read(attendanceProvider.notifier).clickPunch(context);
                                  // Handle Punch In Action
                                  print("Punch In Swiped");
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: displayHeight(context) * 0.04,
                      ),
                      Text(
                        'Short Navigation',
                        style: AppStyles.blackText16,
                      ),
                      SizedBox(height: displayHeight(context) * 0.02),
                      Row(
                        children: [
                          shortNavigation(
                              icon: CupertinoIcons.calendar,
                              label: 'Attendance',
                              onTap: () {
                                final String employeeId = userProfile
                                                      .employeeId; // Ensure this field exists in your model
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) =>
                                                          AttendanceDetailsScreen(
                                                              employeeId: employeeId),
                                                    ),
                                                  );
                              }),
                          SizedBox(
                            width: displayWidth(context) * 0.10,
                          ),
                          shortNavigation(
                              icon: CupertinoIcons.person,
                              label: 'Leave',
                              onTap: () {
                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            const LeaveRequestScreen()),
                                                  );
                              })
                        ],
                      ),
                      SizedBox(height: displayHeight(context) * 0.04),
                      Text(
                        'Attendance For This Month',
                        style: AppStyles.cardTextStyle16,
                      ),
                      SizedBox(height: displayHeight(context) * 0.02),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          showAttendanceCount(
                          count: '7878',
                          label: 'Total Attendance',
                          context: context,
                          bgColor: AppColors.primaryBg1,
                          borderColor: Colors.blue),
                  showAttendanceCount(
                      count: '7878',
                      label: 'Leave Request',
                      context: context,
                      bgColor: AppColors.bluePistaLight,
                      borderColor: AppColors.bluePista)
                        ],
                      ),
                      SizedBox(height: displayHeight(context) * 0.02),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          showAttendanceCount(
                              count: '7878',
                              label: 'Total Leaves',
                              context: context,
                              bgColor: AppColors.greenDarkLightbg,
                              borderColor: AppColors.greenDarkLight),
                          showAttendanceCount(
                              count: '7878',
                              label: 'Late Coming',
                              context: context,
                              bgColor: AppColors.redLightBg,
                              borderColor: AppColors.redLight)
                        ],
                      ),
                      // Expanded(
                      //   // child: GridView.builder(
                      //   //   itemCount: 4,
                      //   //   gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      //   //       childAspectRatio: 2.3,
                      //   //       crossAxisCount: 2,
                      //   //       crossAxisSpacing: 5,
                      //   //       mainAxisSpacing: 5),
                      //   //   itemBuilder: (context, index) {
                      //   //     return
                      //   //
                      //   //   },
                      //   // ),
                      // )

                      // Expanded(
                      //   child: Column(
                      //     children: [
                      //       Row(
                      //         mainAxisAlignment: MainAxisAlignment.spaceAround,
                      //         children: [
                      //           ActionButton(
                      //             icon: Icons.access_time,
                      //             label: "Attendance",
                      //             onPressed: () {
                      //               userProfileAsync.when(
                      //                 data: (userProfile) {
                      //                   final String employeeId = userProfile
                      //                       .employeeId; // Ensure this field exists in your model
                      //                   Navigator.push(
                      //                     context,
                      //                     MaterialPageRoute(
                      //                       builder: (context) =>
                      //                           AttendanceDetailsScreen(
                      //                               employeeId: employeeId),
                      //                     ),
                      //                   );
                      //                 },
                      //                 loading: () {
                      //                   ScaffoldMessenger.of(context)
                      //                       .showSnackBar(
                      //                     const SnackBar(
                      //                         content: Text(
                      //                             'Loading user profile...')),
                      //                   );
                      //                 },
                      //                 error: (error, stack) {
                      //                   ScaffoldMessenger.of(context)
                      //                       .showSnackBar(
                      //                     const SnackBar(
                      //                         content: Text(
                      //                             'Failed to load user profile')),
                      //                   );
                      //                 },
                      //               );
                      //             },
                      //           ),
                      //
                      //           /*ActionButton(
                      //         icon: Icons.access_time,
                      //         label: "Attendance", // Added a comma here
                      //         onPressed: () {
                      //           Navigator.push(context, MaterialPageRoute(builder: (context) =>  AttendanceDetailsScreen(employeeId:"hello")),);
                      //         },
                      //       ),*/
                      //           ActionButton(
                      //             icon: Icons.request_page,
                      //             label: "Leave Request", // Added a comma here
                      //             onPressed: () {
                      //               Navigator.push(
                      //                 context,
                      //                 MaterialPageRoute(
                      //                     builder: (context) =>
                      //                         const LeaveRequestScreen()),
                      //               );
                      //             },
                      //           ),
                      //         ],
                      //       ),
                      //       SizedBox(
                      //         height: displayHeight(context) * 0.02,
                      //       ),
                      //       /*Visibility(
                      //       visible: !(role.role.contains('sales') || role.role.contains('collection') || role.role.contains('pd') || role.role.contains('admin')),
                      //       child: */
                      //       Row(
                      //         mainAxisAlignment: MainAxisAlignment.spaceAround,
                      //         children: [
                      //           Column(
                      //             children: [
                      //               IconButton(
                      //                 onPressed: () {
                      //                   _showMyDialog(context);
                      //                   // hrmsViewModel.onPunchOut(context);
                      //                   // ref.refresh(loginUserProfileProvider);
                      //                 },
                      //                 icon: const Icon(Icons.fingerprint,
                      //                     size: 40, color: Colors.green),
                      //               ),
                      //               const Text('Punch Out')
                      //             ],
                      //           ),
                      //           Column(
                      //             children: [
                                    // IconButton(
                                    //   onPressed: () {
                                    //     LogOutDialog.logOutDialog(
                                    //         context: context);
                                    //   },
                                    //   icon: const Icon(
                                    //     Icons.logout,
                                    //     color: AppColors.primary,
                                    //   ),
                                    // ),
                                    // const Text('Logout')
                      //             ],
                      //           ),
                      //         ],
                      //       ),
                      //       // )
                      //     ],
                      //   ),
                      // ),

                      /*BottomBar(employee: userProfileAsync),*/
                    ],
                  ),
                ),
              ),
              /*BottomBar(employee: userProfileAsync),*/
            );
      },
     error: (error, stack) => Scaffold( appBar: AppBar(
              title:
              const Text("Dashboard", style: TextStyle(color: Colors.white)),
              backgroundColor: AppColors.primary,
              centerTitle: true,
              leading: Visibility(
                visible: (role.role.contains('sales') || role.role.contains('collection') || role.role.contains('pd') || role.role.contains('admin')),
                child: IconButton(
                  icon: const Icon(
                    Icons.arrow_back,
                    color: Colors.white,
                  ),
                  onPressed: () => Navigator.pop(context),
                ),
              ),
            ),body: NoDataFound(retry: true, ontap: () {
              ref.refresh(loginUserProfileProvider);
            },)),
      loading: () {
        return const Scaffold(
          body: Center(child: CircularProgressIndicator()),
        );
      },
    ));


  }

  Future<void> _showMyDialog(BuildContext context) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button to close dialog
      builder: (BuildContext context) {
        // final checkPunchProvider = ref.watch(attendanceProvider);
        return const AlertDialog(
          title: Text('Punch out'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Are you sure you want to punch out.'),
                // Text('Press the button below to close.'),
              ],
            ),
          ),
          actions: <Widget>[PunchOutActionContent()],
        );
      },
    );
  }

  Widget timeShow(
      {required IconData icon,
      required String time,
      required String label,
      required BuildContext context}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Icon(
          icon,
          color: AppColors.primary,
        ),
        SizedBox(
          height: displayHeight(context) * 0.01,
        ),
        Text(
          time,
          style: AppStyles.blacktext14.copyWith(fontWeight: FontWeight.w600),
        ),
        SizedBox(
          height: displayHeight(context) * 0.01,
        ),
        Text(
          label,
          style:
              AppStyles.headingTextStyleFooter.copyWith(color: AppColors.gray),
        )
      ],
    );
  }

  Widget shortNavigation(
      {required IconData icon,
      required String label,
      required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [Icon(icon), Text(label)],
      ),
    );
  }

  Widget showAttendanceCount(
      {required String count,
      required String label,
      required Color bgColor,
      required BuildContext context,
      required Color borderColor}) {
    return Container(
      padding: EdgeInsets.all(12),
      height: displayHeight(context) * 0.09,
      width: displayWidth(context) * 0.44,
      decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.all(Radius.circular(20)),
          border: Border.all(color: borderColor)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label,style: AppStyles.cardTextStyle16.copyWith(fontSize: FontSize.fontSize),),
          Text(count,style: AppStyles.blacktext14.copyWith(fontSize: FontSize.fontSizeXS,color: borderColor),),
        ],
      ),
    );
  }
}


