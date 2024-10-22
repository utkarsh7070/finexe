

// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import '../home_collection_model/UserProfile.dart';
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
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../home_collection_model/UserProfile.dart';

class DashboardScreen extends ConsumerWidget {

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>(); // Step 1: Define the GlobalKey

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Automatically trigger profile fetch when the widget is built
    ref.read(userProfileProvider.notifier).fetchUserProfile();

    final userProfile = ref.watch(userProfileProvider);

    return Scaffold(
      key: _scaffoldKey, // Step 2: Assign the scaffoldKey to the Scaffold
      backgroundColor: AppColors.primary,
      appBar: AppBar(

       /* leading: Icon(Icons.menu),*/

        leading: IconButton(
          onPressed: () {
            // Handle the click action here
            _scaffoldKey.currentState?.openDrawer(); // Open the end drawer
          },
          icon: Icon(Icons.menu), // Choose the appropriate icon
          iconSize: 30, // Set the size of the icon
          color: Colors.black, // Set the color of the icon
        ),

        title: Text("Collection Dashboard"),
        actions: [
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: () {
              ref.read(userProfileProvider.notifier).fetchUserProfile();
            },
          ),
         /* CircleAvatar(
            backgroundImage: NetworkImage("https://miro.medium.com/v2/resize:fit:1400/format:webp/1*U4gZLnRtHEeJuc6tdVLwPw.png"), // Replace with actual image URL
          ),*/
        ],
      ),

      drawer: Padding(
        padding: const EdgeInsets.fromLTRB(0, 20, 80, 20),
        child: Drawer(
          backgroundColor: AppColors.blueShadeColor,
          child: ListView(
           /* padding: EdgeInsets.zero,*/
            padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
            children: [
              SizedBox(height: 10,),

             /* SizedBox(
                height: 170,
                child: Container(
                  padding: EdgeInsets.all(30),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey), // Border color
                    borderRadius: BorderRadius.circular(0), // Border radius
                    image: DecorationImage(
                      image: AssetImage('assets/images/finexe_text_image.png'), // Replace with your image path
                      fit: BoxFit.contain, // Adjust how the image is fit inside the container
                    ),
                  ),
                ),
              ),*/

              SizedBox(
                height: 100,
                child: Container(
                  padding: EdgeInsets.all(10), // Reduce padding to give the image more space
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.transparent), // Remove border or make it transparent
                    borderRadius: BorderRadius.circular(0), // You can adjust the radius if needed
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(10), // Add padding around the image for spacing
                    child: Image.asset(
                      'assets/images/finexe_text_image.png', // Your image path
                      fit: BoxFit.contain, // Ensure the image is contained within the available space
                    ),
                  ),
                ),
              ),


              ListTile(
                contentPadding: EdgeInsets.fromLTRB(20, 30, 0, 10), // Adjust the horizontal padding as needed

                title: Text('Menu', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold,color: AppColors.primary),),
                onTap: () {
                  // Handle navigation to settings
                },
              ),

              ListTile(
                leading: Icon(Icons.home,color: AppColors.white,),
                title: Text('Home',style: TextStyle(
                  color: AppColors.white, // Change this to your desired color
                ),),
                onTap: () {
                  // Handle navigation to settings
                /*  Navigator.push(
                      context, MaterialPageRoute(
                      builder: (context) => PortfolioScreen()));*/
                },
              ),
               Divider(
                color: Colors.black38, // Set the color of the divider
                height: 5, // Set the height of the divider
                thickness: 2, // Set the thickness of the divider
                indent: 20, // Set the indent (left padding) of the divider
                endIndent: 20, // Set the end indent (right padding) of the divider
              ),

              ListTile(
                leading: Icon(Icons.money,color: AppColors.white,),
                title: Text('Collection',style: TextStyle(
                  color: AppColors.white, // Change this to your desired color
                ),),
                onTap: () {
                  // Handle navigation to about
                 /* Navigator.push(
                      context, MaterialPageRoute(
                      builder: (context) => WithdrawalInterestPage()));*/
                },
              ),
               Divider(
                color: Colors.black38, // Set the color of the divider
                height: 5, // Set the height of the divider
                thickness: 2, // Set the thickness of the divider
                indent: 20, // Set the indent (left padding) of the divider
                endIndent: 20, // Set the end indent (right padding) of the divider
              ),


              ListTile(
                leading: Icon(Icons.logout,color: AppColors.white,),
                title: Text('Logout',style: TextStyle(
                  color: AppColors.white, // Change this to your desired color
                ),),
                onTap: () {
                  // Handle navigation to about
                 // _logoutAndRedirectToLogin();
                },
              ),

            ],
          ),
        ),
      ),

      body: userProfile == null
          ? Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
        child: Column(
          children: [
            // User profile card
            Card(
              elevation: 2,
              margin: EdgeInsets.all(16),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      radius: 40,
                      backgroundImage: NetworkImage('https://miro.medium.com/v2/resize:fit:1400/format:webp/1*U4gZLnRtHEeJuc6tdVLwPw.png'), // Replace with actual image URL
                    ),
                    SizedBox(height: 10),
                    Text(
                      userProfile.name,
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    Text(userProfile.email),
                    SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Employee Unique Id:"),
                        Text(userProfile.employeeId),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Mobile No:"),
                        Text(userProfile.mobileNo),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Current Address:"),
                        Text(userProfile.address),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Joining Date:"),
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
                physics: NeverScrollableScrollPhysics(), // To prevent GridView from scrolling
                shrinkWrap: true, // To fit content within the SingleChildScrollView
                crossAxisCount: 2, // Two cards per row
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                childAspectRatio: 1, // To make the cards square
                children: [
                  buildCard(Icons.person, '100', 'Visits Accepted'),
                  buildCard(Icons.person, '50', 'Visits Pending'),
                  buildCard(Icons.person, '10', 'Visits Rejected'),
                  buildCard(Icons.attach_money, '200', 'Collections Accepted'),
                  buildCard(Icons.attach_money, '30', 'Collections Pending'),
                  buildCard(Icons.attach_money, '5', 'Collections Rejected'),
                ],
              ),
            ),

            SizedBox(height: 10),
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
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            SizedBox(height: 10),
            Text(
              label,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
