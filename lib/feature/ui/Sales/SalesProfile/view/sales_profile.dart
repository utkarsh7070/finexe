// user_profile_screen.dart
import 'dart:developer';

import 'package:finexe/feature/ui/Sales/SalesProfile/view_model/login_user_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../../../Punch_In_Out/viewmodel/attendance_view_model.dart';
import '../../../../base/api/api.dart';
import '../../../../base/dialog/logout_dialog.dart'; // Make sure to import the intl package for date formatting

class SalesProfile extends ConsumerStatefulWidget {
  @override
  _SalesProfileState createState() => _SalesProfileState();
}

class _SalesProfileState extends ConsumerState<SalesProfile> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.refresh(loginUserProfileProvider);
    });

  }

  @override
  Widget build(BuildContext context) {
    print('Come to sales profile screen'); // This should only print once now

    final userProfileAsync = ref.watch(loginUserProfileProvider);
    final checkpunchProvider = ref.watch(attendanceProvider);

    print('user profile data ${userProfileAsync}');



    return Scaffold(
      appBar: AppBar(
        title: Text('User Profile'),
        centerTitle: true, // This centers the title
      ),
      body: userProfileAsync.when(
        data: (userProfile) {
          // Format the joining date and date of birth
          final joiningDate = DateFormat('dd/MM/yyyy').format(DateTime.parse(userProfile.joiningDate));
          final dateOfBirth = DateFormat('dd/MM/yyyy').format(DateTime.parse(userProfile.dateOfBirth));

          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Center( // Center the profile content horizontally
              child: Column(
                children: [
                  Card(
                    elevation: 4, // Adds shadow to the card
                    color: Colors.blue[50], // Set your desired background color
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12), // Rounded corners
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Display the employee's photo
                            Center(
                              child: CircleAvatar(
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
                              Text('Email:', style: TextStyle(fontWeight: FontWeight.bold)),
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
                              Text('Mobile Number:', style: TextStyle(fontWeight: FontWeight.bold)),
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
                              Text('Joining Date:', style: TextStyle(fontWeight: FontWeight.bold)),
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
                              Text('Date of Birth:', style: TextStyle(fontWeight: FontWeight.bold)),
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
                              Text('Employee Unique ID:', style: TextStyle(fontWeight: FontWeight.bold)),
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

                   Container(
                  child: Center(
                child: Column(
                  children: [
                    SizedBox(height: 30),
                    Container(
                      width: 250,
                      child: ElevatedButton(
                        onPressed: () {
                          LogOutDialog.logOutDialog(context: context);
                        },
                        child: Text(
                          'Logout',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      width: 250,
                      child: ElevatedButton(
                        onPressed: () {
                          log('onPunchOut');
                          ref.read(attendanceProvider.notifier).onPunchOut(context).then(
                            (value) {
                              log('punchout');

                            },
                          );
                        },
                        child: checkpunchProvider.isLoading
                            ? const Center(
                                child: CircularProgressIndicator(
                                  color: Colors.white,
                                ),
                              )
                            : Text(
                                'PuchOut',
                                style: TextStyle(color: Colors.white),
                              ),
                      ),
                    ),
                  ],
                ),
              )),
                ],
              ),
            ),
          );
        },
        loading: () => Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(child: Text('Failed to load user profile')),
      ),
    );


  }
}


