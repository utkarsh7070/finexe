

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import '../../../../base/api/api.dart';
import '../../../Sales/SalesProfile/view_model/login_user_view_model.dart';
import 'action_button.dart';
import 'attendance_details_screen.dart';
import 'bottom_bar.dart';
import 'leave_details_form.dart';


class HRMSDashboardScreen extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    //final employee = ref.watch(employeeProvider);
    final userProfileAsync = ref.watch(loginUserProfileProvider);

    return
      userProfileAsync.when(data: (userProfile) {
        final joiningDate = DateFormat('dd/MM/yyyy').format(DateTime.parse(userProfile.joiningDate));
        final dateOfBirth = DateFormat('dd/MM/yyyy').format(DateTime.parse(userProfile.dateOfBirth));
        return   Scaffold(
          bottomNavigationBar: BottomBar(punchInTime: userProfile.punchInTime,punchOutTime: userProfile.punchOutTime,),
          appBar: AppBar(
            title: const Text("Dashboard",style: TextStyle(color: Colors.white)),
            backgroundColor: Colors.green,
            centerTitle: true,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back,color: Colors.white,),
              onPressed: () => Navigator.pop(context),
            ),
          ),
          body: Column(
            children: [
          Padding(
          padding: const EdgeInsets.all(16.0),
          child: Center( // Center the profile content horizontally
            child: Column(
              children: [
                Card(
                  elevation: 4, // Adds shadow to the card
                  color: Colors.green.shade100, // Set your desired background color
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12), // Rounded corners
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Display the employee's photo
                        if (userProfile.employeePhoto.isNotEmpty)
                          Center(
                            child: CircleAvatar(
                              backgroundColor: Colors.green.shade200,
                              radius: 50,
                              /*backgroundImage: NetworkImage(userProfile.employeePhoto),*/
                              backgroundImage: userProfile.employeePhoto.isNotEmpty
                                  ? NetworkImage('${Api.imageUrl}${userProfile.employeePhoto}')
                                  : const AssetImage('assets/images/prof.jpeg'),
                              // Placeholder image
                              onBackgroundImageError: (error, stackTrace) {
                                // Set a default image if the API image fails to load
                              },

                            ),
                          ),
                        const SizedBox(height: 16),

                        // Display the employee name with father's name
                        Center(
                          child: Text(
                            userProfile.fullName,
                            style: Theme.of(context).textTheme.titleLarge,
                            textAlign: TextAlign.center, // Center the name
                          ),
                        ),
                        const SizedBox(height: 20),

                        // Display the email with label on the left and data on the right
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            const Text('Email:', style: TextStyle(fontWeight: FontWeight.bold)),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Text(userProfile.email, textAlign: TextAlign.right),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),

                        // Display the mobile number
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            const Text('Mobile Number:', style: TextStyle(fontWeight: FontWeight.bold)),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Text(userProfile.mobileNo.toString(), textAlign: TextAlign.right),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),

                        // Display the joining date
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            const Text('Joining Date:', style: TextStyle(fontWeight: FontWeight.bold)),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Text(joiningDate, textAlign: TextAlign.right),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),

                        // Display the date of birth
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            const Text('Date of Birth:', style: TextStyle(fontWeight: FontWeight.bold)),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Text(dateOfBirth, textAlign: TextAlign.right),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),

                        // Display the employee unique ID
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            const Text('Employee Unique ID:', style: TextStyle(fontWeight: FontWeight.bold)),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Text(userProfile.employeUniqueId, textAlign: TextAlign.right),
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
                child: GridView.count(
                  crossAxisCount: 2,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                  padding: const EdgeInsets.all(16),
                  children: [
                    ActionButton(
                      icon: Icons.access_time,
                      label: "Attendance",
                      onPressed: () {
                        userProfileAsync.when(
                          data: (userProfile) {
                            final String? employeeId = userProfile.employeeId; // Ensure this field exists in your model
                            if (employeeId != null) {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => AttendanceDetailsScreen(employeeId: employeeId),
                                ),
                              );
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text('Employee ID not available')),
                              );
                            }
                          },
                          loading: () {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Loading user profile...')),
                            );
                          },
                          error: (error, stack) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Failed to load user profile')),
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
                          MaterialPageRoute(builder: (context) => const LeaveRequestScreen()),
                        );
                      },
                    ),

                  ],
                ),
              ),

              /*BottomBar(employee: userProfileAsync),*/

            ],
          ),
        );
      }, error: (error, stackTrace) {
        throw Exception(error);
      }, loading: () {
        return const Scaffold(body: Center(child: CircularProgressIndicator()),);
      },);

  }
}
