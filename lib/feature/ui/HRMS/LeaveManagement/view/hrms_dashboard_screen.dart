import 'package:finexe/feature/base/internetConnection/networklistener.dart';
import 'package:finexe/feature/base/utils/namespase/display_size.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import '../../../../base/api/api.dart';
import '../../../../base/dialog/logout_dialog.dart';
import '../../../../base/utils/namespase/app_colors.dart';
import '../../../../base/utils/namespase/app_style.dart';
import '../../../Collection/Collection_home_dashboard/Widget/punct_in_out_action_dialog_content.dart';
import '../../../Sales/SalesProfile/view_model/login_user_view_model.dart';
import '../view_model/attendance_listing_view_model.dart';
import '../view_model/hrms_dashboard_view_model.dart';
import 'action_button.dart';
import 'attendance_details_screen.dart';
import 'bottom_bar.dart';
import 'leave_details_form.dart';

class HRMSDashboardScreen extends ConsumerWidget {
  const HRMSDashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userProfileAsync = ref.watch(loginUserProfileProvider);
    final hrmsViewModel = ref.read(hrmsDashBordProvider.notifier);
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
            bottomNavigationBar: BottomBar(
              punchInTime: userProfile.punchInTime,
              punchOutTime: userProfile.punchOutTime,
            ),
      
      
            appBar: AppBar(
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
            ),
            body: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Center(
                    // Center the profile content horizontally
                    child: Column(
                      children: [
                        Card(
                          elevation: 4,
                          // Adds shadow to the card
                          color: AppColors.lightBlue,
                          // Set your desired background color
                          shape: RoundedRectangleBorder(
                            borderRadius:
                            BorderRadius.circular(12), // Rounded corners
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Display the employee's photo
                                Center(
                                  child: CircleAvatar(
                                    backgroundColor: AppColors.primary,
                                    radius: 50,
                                    // backgroundImage: NetworkImage(userProfile.employeePhoto),
                                    backgroundImage: userProfile
                                        .employeePhoto.isNotEmpty &&
                                        userProfile.employeePhoto
                                            .contains('upload')
                                        ? NetworkImage(
                                        '${Api.imageUrl}${userProfile.employeePhoto}')
                                        : const AssetImage(
                                        'assets/images/prof.jpeg')
                                    as ImageProvider,
                                    // Placeholder image
                                    onBackgroundImageError: (error, stackTrace) {
                                      // Set a default image if the API image fails to load
                                    },
                                  ),
                                ),
                                const SizedBox(height: 16),
      
                                // Display the employee name with father's name
                                Center(
                                  child: Column(
                                    children: [
                                      Text(
                                        userProfile.fullName,
                                        style: const TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold),
                                        textAlign:
                                        TextAlign.center, // Center the name
                                      ),
                                      Text(
                                        userProfile.email,
                                        style: AppStyles.subTextStyle,
                                        textAlign:
                                        TextAlign.center, // Center the name
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(height: 20),
                                // Display the mobile number
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    const Text('Mobile Number:',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold)),
                                    const SizedBox(width: 8),
                                    Expanded(
                                      child: Text(userProfile.mobileNo.toString(),
                                          textAlign: TextAlign.right),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 8),
      
                                // Display the joining date
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    const Text('Joining Date:',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold)),
                                    const SizedBox(width: 8),
                                    Expanded(
                                      child: Text(joiningDate,
                                          textAlign: TextAlign.right),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 8),
      
                                // Display the date of birth
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    const Text('Date of Birth:',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold)),
                                    const SizedBox(width: 8),
                                    Expanded(
                                      child: Text(dateOfBirth,
                                          textAlign: TextAlign.right),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 8),
      
                                // Display the employee unique ID
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    const Text('Employee Unique ID:',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold)),
                                    const SizedBox(width: 8),
                                    Expanded(
                                      child: Text(userProfile.employeUniqueId,
                                          textAlign: TextAlign.right),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Expanded(
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          ActionButton(
                            icon: Icons.access_time,
                            label: "Attendance",
                            onPressed: () {
                              userProfileAsync.when(
                                data: (userProfile) {
                                  final String? employeeId = userProfile
                                      .employeeId; // Ensure this field exists in your model
                                  if (employeeId != null) {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            AttendanceDetailsScreen(
                                                employeeId: employeeId),
                                      ),
                                    );
                                  } else {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                          content:
                                          Text('Employee ID not available')),
                                    );
                                  }
                                },
                                loading: () {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                        content: Text('Loading user profile...')),
                                  );
                                },
                                error: (error, stack) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                        content:
                                        Text('Failed to load user profile')),
                                  );
                                },
                              );
                            },
                          ),
      
                          /*ActionButton(
                          icon: Icons.access_time,
                          label: "Attendance", // Added a comma here
                          onPressed: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context) =>  AttendanceDetailsScreen(employeeId:"hello")),);
                          },
                        ),*/
                          ActionButton(
                            icon: Icons.request_page,
                            label: "Leave Request", // Added a comma here
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                    const LeaveRequestScreen()),
                              );
                            },
                          ),
                        ],
                      ),
                      SizedBox(
                        height: displayHeight(context) * 0.02,
                      ),
                      /*Visibility(
                        visible: !(role.role.contains('sales') || role.role.contains('collection') || role.role.contains('pd') || role.role.contains('admin')),
                        child: */
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Column(
                            children: [
                              IconButton(
                                onPressed: () {
                                  _showMyDialog(context);
                                 // hrmsViewModel.onPunchOut(context);
                                 // ref.refresh(loginUserProfileProvider);
                                },
                                icon: const Icon(Icons.fingerprint,
                                    size: 40, color: Colors.green),
                              ),
                              const Text('Punch Out')
                            ],
                          ),
                          Column(
                            children: [
                              IconButton(
                                onPressed: () {
                                  LogOutDialog.logOutDialog(context: context);
                                },
                                icon: Icon(Icons.logout,color: AppColors.primary,),
                              ),
                              Text('Logout')
                            ],
                          ),
                        ],
                      ),
                   // )
                  ],
                ),
              ),

              /*BottomBar(employee: userProfileAsync),*/
            ],
          ),
        );
      },
      error: (error, stackTrace) {
        throw Exception(error);
      },
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


}
