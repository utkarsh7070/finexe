
import 'package:finexe/feature/base/dialog/logout_dialog.dart';
import 'package:finexe/feature/base/internetConnection/connection_overlay.dart';
import 'package:finexe/feature/base/internetConnection/networklistener.dart';
import 'package:finexe/feature/base/routes/routes.dart';
import 'package:finexe/feature/base/utils/namespase/display_size.dart';
import 'package:finexe/feature/base/utils/namespase/font_size.dart';
import 'package:finexe/feature/ui/HRMS/LeaveManagement/style/neumorphic_convex_style.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_swipe_button/flutter_swipe_button.dart';
import 'package:intl/intl.dart';
import 'package:flutter_neumorphic_plus/flutter_neumorphic.dart';

import '../../../../base/api/api.dart';
import '../../../../base/utils/namespase/app_colors.dart';
import '../../../../base/utils/namespase/app_style.dart';
import '../../../Collection/Collection_home_dashboard/Widget/punct_in_out_action_dialog_content.dart';
import '../../../Collection/Collection_home_dashboard/home_collection_viewmodel/fetchUserProfile.dart';
import '../../../Sales/SalesProfile/view_model/sales_user_view_model.dart';
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
              backgroundColor: AppColors.attendanceBgColor1,

              appBar: customAppBar(context, role, userProfile),
              // AppBar(
              //   flexibleSpace: Container(
              //     color: AppColors.attendanceBgColor1,
              //   ),
              //
              //   title: Visibility(
              //     replacement: const Text('HRMS'),
              //     visible: !(role.role.contains('sales') ||
              //         role.role.contains('collection') ||
              //         role.role.contains('pd') ||
              //         role.role.contains('admin')),
              //     child: Row(
              //       children: [
              //         CircleAvatar(
              //           backgroundColor: AppColors.primary,
              //           radius: 20,
              //           // backgroundImage: NetworkImage(userProfile.employeePhoto),
              //           backgroundImage: userProfile.employeePhoto.isNotEmpty &&
              //                   userProfile.employeePhoto.contains('upload')
              //               ? NetworkImage(
              //                   '${Api.imageUrl}${userProfile.employeePhoto}')
              //               : const AssetImage('assets/images/prof.jpeg')
              //                   as ImageProvider,
              //           // Placeholder image
              //           onBackgroundImageError: (error, stackTrace) {
              //             // Set a default image if the API image fails to load
              //           },
              //         ),
              //         SizedBox(
              //           width: displayWidth(context) * 0.02,
              //         ),
              //         Column(
              //           crossAxisAlignment: CrossAxisAlignment.start,
              //           children: [
              //             Text(
              //               userProfile.employeName,
              //               style: AppStyles.TextStyle16,
              //             ),
              //             Text(
              //               userProfile.designationId['name'] ?? '',
              //               style: AppStyles.blacktext14
              //                   .copyWith(color: AppColors.gray7),
              //             )
              //           ],
              //         )
              //       ],
              //     ),
              //   ),
              //   actions: [
              //     IconButton(
              //         onPressed: () {
              //           LogOutDialog.logOutDialog(context: context);
              //         },
              //         icon: const Icon(
              //           Icons.logout,
              //         ))
              //   ],
              //   // const Text("Dashboard", style: TextStyle(color: Colors.white)),
              //   // backgroundColor: AppColors.primary,
              //   // centerTitle: true,
              //   leading: Visibility(
              //     visible: (role.role.contains('sales') ||
              //         role.role.contains('collection') ||
              //         role.role.contains('pd') ||
              //         role.role.contains('admin')),
              //     child: IconButton(
              //       icon: const Icon(
              //         CupertinoIcons.back,
              //         color: Colors.black,
              //       ),
              //       onPressed: () => Navigator.pop(context),
              //     ),
              //   ),
              // ),
              body: SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [

                      NeumorphicWidget(
                          boxShape: NeumorphicBoxShape.roundRect(
                              BorderRadius.circular(12)),

                        child: Padding(
                          padding: const EdgeInsets.only(
                              left: 16.0, right: 16, bottom: 25, top: 25),
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
                                    .copyWith(
                                        color: AppColors.textDarkGray,
                                        fontSize: FontSize.fontSizeXS),
                              ),
                              SizedBox(
                                height: displayHeight(context) * 0.04,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  NeumorphicWidget(
                                      depth: -2,
                                      // Controls the shadow depth
                                      intensity: 0.7,
                                      // Controls the shadow intensity
                                      // Background color
                                      boxShape: NeumorphicBoxShape.roundRect(
                                          BorderRadius.circular(12)),

                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      // Padding inside Neumorphic widget
                                      child: timeShow(
                                        icon: Icons.move_to_inbox_outlined,
                                        label: 'Check In',
                                        time:
                                            formatTime(userProfile.punchInTime),
                                        context: context,
                                      ),
                                    ),
                                  ),
                                  NeumorphicWidget(
                                    depth: -2,
                                    // Controls the shadow depth
                                    intensity: 0.7,
                                    // Controls the shadow intensity
                                    // Background color
                                    boxShape: NeumorphicBoxShape.roundRect(
                                        BorderRadius.circular(12)),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: timeShow(
                                        icon: Icons.watch_later_outlined,
                                        label: 'Working HR’S',
                                        time: hrmsViewModel.hoursCalculate(
                                                userProfile.punchInTime,
                                                userProfile.punchOutTime) ??
                                            '00:00',
                                        context: context,
                                      ),
                                    ),
                                  ),
                                  NeumorphicWidget(
                                    depth: -2,
                                    // Controls the shadow depth
                                    intensity: 0.7,
                                    // Controls the shadow intensity
                                    // Background color
                                    boxShape: NeumorphicBoxShape.roundRect(
                                        BorderRadius.circular(12)),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: timeShow(
                                        icon: Icons.outbox_outlined,
                                        time: formatTime(
                                            userProfile.punchOutTime),
                                        label: 'Check Out',
                                        context: context,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: displayHeight(context) * 0.05,
                              ),
                              SwipeButton.expand(
                                elevationTrack: 10,
                                width: 500,
                                thumb: Container(
                                  width: 10, // Adjust the width of the thumb
                                  height: 10, // Adjust the height of the thumb
                                  decoration: BoxDecoration(
                                    color: AppColors.attendanceBgColor1,
                                    borderRadius: BorderRadius.circular(
                                        20), // Round the thumb if needed
                                  ),
                                  child: const Icon(
                                    Icons.double_arrow_rounded,
                                    color: AppColors.hrmsRedColor,
                                  ),
                                ),
                                activeThumbColor: Colors.white,
                                activeTrackColor: AppColors.attendanceBgColor1,
                                // elevationThumb: 4.8,
                                height: 60,
                                thumbPadding: const EdgeInsets.all(8),
                                child: const Text(
                                  "Swipe to Punch Out",
                                  style: TextStyle(
                                    color: AppColors.hrmsRedColor,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 13,
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
                      // ),
                      SizedBox(
                        height: displayHeight(context) * 0.04,
                      ),
                      Text(
                        'Short Navigation',
                        style: AppStyles.blackText16,
                      ),
                      SizedBox(height: displayHeight(context) * 0.02),
                      Padding(
                        padding: const EdgeInsets.only(right: 36.0),
                        // Add space on the right
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          // Align cards to the start


                          children: [
                            NeumorphicWidget(
                              boxShape: NeumorphicBoxShape.roundRect(BorderRadius.circular(12)),
                              child: SizedBox(
                                width: displayWidth(context) * 0.3,
                                // Adjust card width
                                child: Padding(
                                  padding: const EdgeInsets.all(12.0),
                                  child: shortNavigation(
                                    icon: CupertinoIcons.calendar,
                                    label: 'Attendance',
                                    onTap: () {
                                      final String employeeId =
                                          userProfile.employeeId;
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              AttendanceDetailsScreen(
                                                  employeeId: employeeId),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(width: displayWidth(context) * 0.05),
                            // Space between the cards
                            NeumorphicWidget(
                              boxShape: NeumorphicBoxShape.roundRect(
                                  BorderRadius.circular(12)),
                              child: SizedBox(
                                width: displayWidth(context) * 0.3,
                                // Same width as the first card
                                child: Padding(
                                  padding: const EdgeInsets.all(12.0),
                                  child: shortNavigation(
                                    icon: CupertinoIcons.person,
                                    label: 'Leave',
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                          const LeaveRequestScreen(),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ),
                            ),
                          ],

                          /*children: [
                            SizedBox(
                              width: displayWidth(context) * 0.4,
                              child: NeumorphicButton(
                                onPressed: () {
                                  final String employeeId = userProfile.employeeId;
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => AttendanceDetailsScreen(employeeId: employeeId),
                                    ),
                                  );
                                },
                                style: NeumorphicStyles.neuMorphicButtonStyle(),
                                child: Padding(
                                  padding: const EdgeInsets.all(12.0),
                                  child: shortNavigation(
                                    icon: CupertinoIcons.calendar,
                                    label: 'Attendance',
                                    onTap: () {
                                      *//*final String employeeId =
                                          userProfile.employeeId;
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              AttendanceDetailsScreen(
                                                  employeeId: employeeId),
                                        ),
                                      );*//*
                                    },
                                  ),
                                ),
                              ),
                            ),

                            SizedBox(width: displayWidth(context) * 0.05),
                            // Space between the cards
                            SizedBox(
                              width: displayWidth(context) * 0.3,
                              height: displayHeight(context) * 0.1,
                              child: NeumorphicButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => const LeaveRequestScreen(),
                                    ),
                                  );
                                },
                                style: NeumorphicStyles.neuMorphicButtonStyle(),
                                child: Padding(
                                  padding: const EdgeInsets.all(12.0),
                                  child: shortNavigation(
                                    icon: CupertinoIcons.person,
                                    label: 'Leave',
                                    onTap: () {
                                      *//* Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              const LeaveRequestScreen(),
                                        ),
                                      );*//*
                                    },
                                  ),
                                ),
                              ),
                            ),
                          ],*/
                        ),
                      ),

                      SizedBox(height: displayHeight(context) * 0.04),
                    ],
                  ),
                ),
              ),
              /*BottomBar(employee: userProfileAsync),*/
            );
          },
          error: (error, stack) => Scaffold(
              appBar: AppBar(
                title: const Text("Dashboard",
                    style: TextStyle(color: Colors.white)),
                backgroundColor: AppColors.primary,
                centerTitle: true,
                leading: Visibility(
                  visible: (role.role.contains('sales') ||
                      role.role.contains('collection') ||
                      role.role.contains('pd') ||
                      role.role.contains('admin')),
                  child: IconButton(
                    icon: const Icon(
                      Icons.arrow_back,
                      color: Colors.white,
                    ),
                    onPressed: () => Navigator.pop(context),
                  ),
                ),
              ),
              body: NoDataFound(
                retry: true,
                ontap: () {
                  ref.refresh(loginUserProfileProvider);
                },
              )),
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


 /* Widget shortNavigation(
      {required Widget icon,
        required String label,
        required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        *//*children: [Icon(icon), Text(label)],*//*

        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 40, // Set the size of the icon container
            height: 40,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.grey[200], // Background color of the icon container
            ),
            child: Center(child: icon), // Custom icon or image widget
          ),
          const SizedBox(height: 8),
          Text(
            label,
            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
          ),
        ],
      ),

    );
  }*/

  Widget showAttendanceCount(
      {required String count,
      required String label,
      required Color bgColor,
      required BuildContext context,
      required Color borderColor}) {
    return Container(
      padding: const EdgeInsets.all(12),
      height: displayHeight(context) * 0.09,
      width: displayWidth(context) * 0.44,
      decoration: BoxDecoration(
          color: bgColor,
          borderRadius: const BorderRadius.all(Radius.circular(20)),
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

  PreferredSizeWidget customAppBar(BuildContext context, role ,userProfile){
    return PreferredSize(preferredSize: Size(displayWidth(context), displayHeight(context)*0.10),
        child:SafeArea(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(children: [
                    Visibility(
                      visible: (role.role.contains('sales') ||
                          role.role.contains('collection') ||
                          role.role.contains('pd') ||
                          role.role.contains('admin')),
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(15,0,0,0),
                        child: SizedBox(
                          height: 40,
                          width: 40,
                          child: NeumorphicWidget(
                            boxShape: NeumorphicBoxShape.roundRect(BorderRadius.circular(12)),
                            child: IconButton(
                              icon: const Icon(
                                CupertinoIcons.back,
                                color: Colors.black,
                                size: 20,
                              ),
                              onPressed: () => Navigator.pop(context),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(5,0,0,0,),
                      child: Row(
                        children: [
                          GestureDetector(
                            onTap: () {
                              Navigator.pushNamed(context, AppRoutes.hrmsProfileUpdate);
                            },
                            child: CircleAvatar(
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
                          ),
                          SizedBox(
                            width: displayWidth(context) * 0.02,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                userProfile.employeName,
                                style: AppStyles.TextStyle16,
                              ),
                              Text(
                                userProfile.designationId ?? '',
                                style: AppStyles.blacktext14
                                    .copyWith(color: AppColors.gray7),
                              )
                            ],
                          )
                        ],
                      ),
                    ),

                  ],),
          Padding(
            padding: const EdgeInsets.fromLTRB(0,0,15,0),
            child: SizedBox(
              height: 40,
              width: 40,
              child: NeumorphicWidget(
                boxShape: NeumorphicBoxShape.roundRect(BorderRadius.circular(12)),
                child: IconButton(
                    onPressed: () {
                      LogOutDialog.logOutDialog(context: context);
                    },
                    icon: const Icon(
                      Icons.logout,
                    )),
              ),
            ),
          )
                ],
              ),
        ) );

  }

}


