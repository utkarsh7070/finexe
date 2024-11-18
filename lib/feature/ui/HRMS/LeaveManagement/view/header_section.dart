
/*import 'package:flutter/material.dart';

import '../../../Sales/SalesProfile/model/login_user_profile.dart';


class HeaderSection extends StatelessWidget {
  final LoginUserProfile employee;

  const HeaderSection({Key? key, required this.employee}) : super(key: key);

  @override
  Widget build(BuildContext context) {
   // final userProfileAsync = ref.watch(loginUserProfileProvider);
    return Container(
      color: Colors.green,
      padding: const EdgeInsets.all(16),
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
                          if (userProfile.employeePhoto.isNotEmpty)
                            Center(
                              child: CircleAvatar(
                                radius: 50,
                                *//*backgroundImage: NetworkImage(userProfile.employeePhoto),*//*
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
      *//*child: Row(
        children: [
          CircleAvatar(
            radius: 30,
            backgroundImage: AssetImage('assets/profile.jpg'), // Replace with your asset
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  employee.name,
                  style: const TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  employee.designation,
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.white70,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  "Entry Code: ${employee.entryCode}",
                  style: const TextStyle(color: Colors.white),
                ),
                Text(
                  "Email: ${employee.email}",
                  style: const TextStyle(color: Colors.white),
                ),
                Text(
                  "Reporting Manager: ${employee.reportingManager}",
                  style: const TextStyle(color: Colors.white),
                ),
              ],
            ),
          ),
        ],
      ),*//*
    );
  }
}*/
