import 'package:finexe/feature/base/utils/namespase/display_size.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../base/api/api.dart';
import '../home_collection_viewmodel/fetchUserProfile.dart';
import '../../../../Punch_In_Out/viewmodel/attendance_view_model.dart';
import '../Widget/punct_in_out_action_dialog_content.dart';
import 'dashboard_side_bar.dart';


class DashboardScreen extends ConsumerWidget {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  DashboardScreen({super.key}); // Step 1: Define the GlobalKey

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var responseData = ref.watch(fetchEmployeeData);
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

      body:responseData.when(data: (data) {
        return
          SingleChildScrollView(
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
                      /*CircleAvatar(
                            radius: 40,
                            backgroundImage: NetworkImage(
                                'https://miro.medium.com/v2/resize:fit:1400/format:webp/1*U4gZLnRtHEeJuc6tdVLwPw.png'), // Replace with actual image URL
                          ),*/

                      CircleAvatar(
                        radius: 40,
                        backgroundImage: data.items.employeeDetail.employeePhoto!=null
                            ? NetworkImage('${Api.imageUrl}${data.items.employeeDetail.employeePhoto}')
                            : const AssetImage('assets/images/check.png'), // Placeholder image
                        onBackgroundImageError: (error, stackTrace) {
                          // Set a default image if the API image fails to load
                        },
                      ),

                      const SizedBox(height: 10),
                      Text(
                        data.items.employeeDetail.employeName!,
                        style: const TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      Text(data.items.employeeDetail.email!),
                      const SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text("Employee Unique Id:"),
                          Text(data.items.employeeDetail.employeUniqueId!),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text("Mobile No:"),
                          Text(data.items.employeeDetail.mobileNo.toString()),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text("Current Address:"),
                          Text(data.items.employeeDetail.currentAddress!),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text("Joining Date:"),
                          Text(data.items.employeeDetail.joiningDate.toString()),
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
                  physics:
                  const NeverScrollableScrollPhysics(), // To prevent GridView from scrolling
                  shrinkWrap:
                  true, // To fit content within the SingleChildScrollView
                  crossAxisCount: 2, // Two cards per row
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                  childAspectRatio: 1, // To make the cards square
                  children: [
                    buildCard(Icons.person, '${data.items.visitAccepted??''}', 'Visits Accepted'),
                    buildCard(Icons.person, '${data.items.visitPendingForApproval??''}', 'Visits Pending'),
                    buildCard(Icons.person, '${data.items.visitRejected??''}', 'Visits Rejected'),
                    buildCard(
                        Icons.currency_rupee, '${data.items.collectionAcceptAmount??''}', 'Collections Accepted'),
                    buildCard(
                        Icons.currency_rupee, '${data.items.collectionEmiAmountPendingForApproval??''}', 'Collections Pending'),
                    buildCard(
                        Icons.currency_rupee, '${data.items.collectionRejectAmount??''}', 'Collections Rejected'),
                  ],
                ),
              ),

              const SizedBox(height: 10),
            ],
          ),
        );
      }, error: (error, stackTrace) {
        return Text('$error');
      }, loading: () {
        return const CircularProgressIndicator();
      },)

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
