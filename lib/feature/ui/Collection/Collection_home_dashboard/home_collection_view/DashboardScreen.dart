// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import '../home_collection_model/user_profile_model.dart';
//
// class DashboardScreen extends ConsumerWidget {
//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     // Automatically trigger profile fetch when the widget is built
//     ref.read(userProfileProvider.notifier).fetchUserProfile();
//
//     final userProfile = ref.watch(userProfileProvider);
//
//     return Scaffold(
//       appBar: AppBar(
//         leading: Icon(Icons.menu),
//         title: Text("Ho Dashboard"),
//         actions: [
//           IconButton(
//             icon: Icon(Icons.refresh),
//             onPressed: () {
//               ref.read(userProfileProvider.notifier).fetchUserProfile();
//             },
//           ),
//           CircleAvatar(
//             backgroundImage: NetworkImage("https://miro.medium.com/v2/resize:fit:1400/format:webp/1*U4gZLnRtHEeJuc6tdVLwPw.png"), // Replace with actual image URL
//           ),
//         ],
//       ),
//       body: userProfile == null
//           ? Center(child: CircularProgressIndicator())
//           : SingleChildScrollView(
//         child: Column(
//           children: [
//             Card(
//               elevation: 2,
//               margin: EdgeInsets.all(16),
//               child: Padding(
//                 padding: const EdgeInsets.all(16.0),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.center,
//                   children: [
//                     CircleAvatar(
//                       radius: 40,
//                       backgroundImage: NetworkImage('https://miro.medium.com/v2/resize:fit:1400/format:webp/1*U4gZLnRtHEeJuc6tdVLwPw.png'), // Replace with actual image URL
//                     ),
//                     SizedBox(height: 10),
//                     Text(
//                       userProfile.name,
//                       style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//                     ),
//                     Text(userProfile.email),
//                     SizedBox(height: 10),
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         Text("Employee Unique Id:"),
//                         Text(userProfile.employeeId),
//                       ],
//                     ),
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         Text("Mobile No:"),
//                         Text(userProfile.mobileNo),
//                       ],
//                     ),
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         Text("Current Address:"),
//                         Text(userProfile.address),
//                       ],
//                     ),
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         Text("Joining Date:"),
//                         Text(userProfile.joiningDate),
//                       ],
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//             // Visit status cards
//             Card(
//               margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
//               child: ListTile(
//                 leading: Icon(Icons.person),
//                 title: Text('0 Visit Accepted'),
//               ),
//             ),
//             Card(
//               margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
//               child: ListTile(
//                 leading: Icon(Icons.person),
//                 title: Text('0 Visit Pending'),
//               ),
//             ),
//             Card(
//               margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
//               child: ListTile(
//                 leading: Icon(Icons.person),
//                 title: Text('0 Visit Rejected'),
//               ),
//             ),
//             Card(
//               margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
//               child: ListTile(
//                 leading: Icon(Icons.person),
//                 title: Text('0 Collection Accepted'),
//               ),
//             ),
//             Card(
//               margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
//               child: ListTile(
//                 leading: Icon(Icons.person),
//                 title: Text('0 Collection Pending'),
//               ),
//             ),
//             Card(
//               margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
//               child: ListTile(
//                 leading: Icon(Icons.person),
//                 title: Text('0 Collection Rejected'),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'package:finexe/feature/base/utils/namespase/app_colors.dart';
import 'package:finexe/feature/base/utils/namespase/display_size.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../Punch_In_Out/viewmodel/attendance_view_model.dart';
import '../Widget/punct_in_out_action_dialog_content.dart';
import '../home_collection_model/user_profile_model.dart';
import '../home_collection_viewmodel/fetchUserProfile.dart';
import 'dashboard_side_bar.dart';

class DashboardScreen extends ConsumerWidget {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  DashboardScreen({super.key}); // Step 1: Define the GlobalKey

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.read(userProfileProvider.notifier).fetchUserProfile();
    final userProfile = ref.watch(userProfileProvider);
    // final checkpunchProvider = ref.watch(attendanceProvider);

    return Scaffold(
      key: _scaffoldKey,
      // Step 2: Assign the scaffoldKey to the Scaffold
      // backgroundColor: AppColors.primary,
      appBar: AppBar(
        /* leading: Icon(Icons.menu),*/

        leading: IconButton(
          onPressed: () {
            // Handle the click action here
            _scaffoldKey.currentState?.openDrawer(); // Open the end drawer
          },
          icon: const Icon(Icons.menu), // Choose the appropriate icon
          iconSize: 30, // Set the size of the icon
          color: Colors.black, // Set the color of the icon
        ),
        title: const Text("Collection Dashboard"),
        actions: [
          GestureDetector(
              onTap: () {
                _showMyDialog(context, ref);
              },
              child: Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: Image.asset(
                  'assets/images/fingerprint.png',
                  height: displayHeight(context) * 0.04,
                  width: displayWidth(context) * 0.06,
                ),
              )),

        ],
      ),

      drawer: const DashBoardSideBar(),

      body: userProfile == null
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Column(
                children: [
                  // User profile card
                  Card(
                    elevation: 2,
                    margin: const EdgeInsets.all(16),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const CircleAvatar(
                            radius: 40,
                            backgroundImage: NetworkImage(
                                'https://miro.medium.com/v2/resize:fit:1400/format:webp/1*U4gZLnRtHEeJuc6tdVLwPw.png'), // Replace with actual image URL
                          ),
                          const SizedBox(height: 10),
                          Text(
                            userProfile.name,
                            style: const TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                          Text(userProfile.email),
                          const SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text("Employee Unique Id:"),
                              Text(userProfile.employeeId),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text("Mobile No:"),
                              Text(userProfile.mobileNo),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text("Current Address:"),
                              Text(userProfile.address),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text("Joining Date:"),
                              Text(userProfile.joiningDate),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),

                  // GridView for six square cards
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: GridView.count(
                      physics: const NeverScrollableScrollPhysics(),
                      // To prevent GridView from scrolling
                      shrinkWrap: true,
                      // To fit content within the SingleChildScrollView
                      crossAxisCount: 2,
                      // Two cards per row
                      crossAxisSpacing: 16,
                      mainAxisSpacing: 16,
                      childAspectRatio: 1,
                      // To make the cards square
                      children: [
                        buildCard(Icons.person, '100', 'Visits Accepted'),
                        buildCard(Icons.person, '50', 'Visits Pending'),
                        buildCard(Icons.person, '10', 'Visits Rejected'),
                        buildCard(
                            Icons.attach_money, '200', 'Collections Accepted'),
                        buildCard(
                            Icons.attach_money, '30', 'Collections Pending'),
                        buildCard(
                            Icons.attach_money, '5', 'Collections Rejected'),
                      ],
                    ),
                  ),

                  const SizedBox(height: 10),
                ],
              ),
            ),
    );
  }

  // Function to build each card
  Widget buildCard(IconData icon, String amount, String label) {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(icon, size: 30),
                Text(
                  amount,
                  style: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Text(
              label,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _showMyDialog(BuildContext context, WidgetRef ref) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button to close dialog
      builder: (BuildContext context) {
        final checkPunchProvider = ref.watch(attendanceProvider);
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
