import 'package:finexe/feature/base/extentions/capital_letter.dart';
import 'package:finexe/feature/base/utils/namespase/display_size.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../base/api/api.dart';
import '../home_collection_viewmodel/fetchUserProfile.dart';
import '../../../../Punch_In_Out/viewmodel/attendance_view_model.dart';
import '../Widget/punct_in_out_action_dialog_content.dart';
import 'dashboard_side_bar.dart';

class DashboardScreen extends ConsumerStatefulWidget {
  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends ConsumerState<DashboardScreen> {
  @override
  void initState() {
    super.initState();
    ref.read(apiResponseProvider.notifier).fetchDashboardData();
  }

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  // Step 1: Define the GlobalKey

  @override
  Widget build(BuildContext context) {
    final data = ref.watch(apiResponseProvider);
    final dataViewModel = ref.read(apiResponseProvider.notifier);
    return data.when(data: (data) {
      return   Scaffold(
        drawer: const DashBoardSideBar(),
        backgroundColor: Colors.white,
        appBar: AppBar(
          // automaticallyImplyLeading: true,
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: CircleAvatar(
                radius: 20,
                backgroundImage: data.imageUrl != null
                    ? NetworkImage('${Api.imageUrl}${data.imageUrl}')
                    : const AssetImage('assets/images/prof.jpeg'),
                // Placeholder image
                onBackgroundImageError: (error, stackTrace) {
                  // Set a default image if the API image fails to load
                },
              ),
            ),
            // CircleAvatar(
            //   radius: 20,
            //   child: ClipOval(
            //     child: Image.asset(
            //       'assets/images/prof.jpeg',
            //       fit: BoxFit.cover,
            //       width:
            //       40, // Adjust width and height to match CircleAvatar radius
            //       height: 40,
            //     ),
            //   ),
            // ),
          ],
          flexibleSpace: Container(
            color: Colors.white,
          ),
          backgroundColor: Colors.white,

          // title: Row(
          //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //   children: [
          //     Image(
          //       image: AssetImage('assets/images/drawer.png'),
          //       height: displayHeight(context) * 0.1,
          //       width: displayWidth(context) * 0.15,
          //     ),
          //     CircleAvatar(
          //       radius: 20,
          //       child: ClipOval(
          //         child: Image.asset(
          //           'assets/images/prof.jpeg',
          //           fit: BoxFit.cover,
          //           width:
          //           40, // Adjust width and height to match CircleAvatar radius
          //           height: 40,
          //         ),
          //       ),
          //     ),
          //   ],
          // ),
        ),
        body:
        SingleChildScrollView(
          child: Column(
            children: [
              Row(
                children: [
                  SizedBox(
                    width: displayWidth(context) * 0.05,
                  ),
                  Container(
                      height: displayHeight(context) * 0.08,
                      width: displayWidth(context) * 0.1,
                      child:
                      Image(image: AssetImage('assets/images/Morning.png'))),
                  SizedBox(
                    width: displayWidth(context) * 0.04,
                  ),
                  Text(
                    'Good morning',
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: Color(0xff475467)),
                  )
                ],
              ),
              Container(
                alignment: Alignment.centerLeft,
                padding: EdgeInsets.only(left: displayWidth(context) * 0.05),
                child: Text(
                 data.name.capitalize(),
                  textAlign: TextAlign.left,
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      color: Color(0xff101828)),
                ),
              ),
              SizedBox(
                height: displayHeight(context) * 0.01,
              ),
              Row(
                children: [
                  SizedBox(
                    width: displayWidth(context) * 0.05,
                  ),
                  Text(
                    'Get Ready- ',
                    style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w500,
                        color: Color(0xff0082C6)),
                  ),
                  Text(
                    'You will do your best on today we will meet',
                    style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w500,
                        color: Color(0xff475467)),
                  )
                ],
              ),
              SizedBox(
                height: displayHeight(context) * 0.02,
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Image(
                      image: AssetImage(
                        'assets/images/leftside.png',
                      ),
                      height: displayHeight(context) * 0.02,
                      width: displayWidth(context) * 0.25,
                    ),
                    SizedBox(
                      width: displayWidth(context) * 0.025,
                    ),
                    Text(
                      'Visit Update’s',
                      style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 18,
                          color: Color(0xff475467)),
                    ),
                    SizedBox(
                      width: displayWidth(context) * 0.025,
                    ),
                    Image(
                      image: AssetImage('assets/images/rightside.png'),
                      height: displayHeight(context) * 0.02,
                      width: displayWidth(context) * 0.25,
                    ),
                  ],
                ),
              ),
              rectBox(
                  backImage: 'assets/images/backgreen.png',
                  iconImage: 'assets/images/right.png',
                  title: 'Visit Updated',
                  stitle: 'Case 180+ Now',
                  context: context),
              Row(
                children: [
                  SquareBox(
                      backImage: 'assets/images/square.png',
                      iconImage: 'assets/images/watch.png',
                      title: 'Visit pending',
                      stitle: 'Case 180+ Now',
                      context: context,
                      titleColor: Color(0xffFFA500),
                      stitleColor: Colors.orange),
                  SquareBox(
                      backImage: 'assets/images/rejected.png',
                      iconImage: 'assets/images/rejected_icon.png',
                      title: 'Visit rejected',
                      stitle: 'Case 180+ Now',
                      context: context,
                      titleColor: Color(0xffEE6C52),
                      stitleColor: const Color.fromARGB(255, 218, 96, 87)),
                ],
              ),
              SizedBox(
                height: displayHeight(context) * 0.03,
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Image(
                      image: AssetImage(
                        'assets/images/leftside.png',
                      ),
                      height: displayHeight(context) * 0.02,
                      width: displayWidth(context) * 0.18,
                    ),
                    SizedBox(
                      width: displayWidth(context) * 0.025,
                    ),
                    Text(
                      'Collection Update’s',
                      style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 18,
                          color: Color(0xff475467)),
                    ),
                    SizedBox(
                      width: displayWidth(context) * 0.025,
                    ),
                    Image(
                      image: AssetImage('assets/images/rightside.png'),
                      height: displayHeight(context) * 0.02,
                      width: displayWidth(context) * 0.18,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 10),
                child: rectBox(
                    backImage: 'assets/images/rectgreen.png',
                    iconImage: 'assets/images/rectgreen_icon.png',
                    title: 'Collection Accepted',
                    stitle: 'Case 180+ Now',
                    context: context),
              ),
              SizedBox(
                height: displayHeight(context) * 0.001,
              ),
              Row(
                children: [
                  SquareBoxBottom(
                      backImage: 'assets/images/tback.png',
                      iconImage: 'assets/images/orange_dollar.png',
                      title: 'Collection pending',
                      stitle: 'Case 180+ Now',
                      context: context,
                      titleColor: Color(0xffFFA500),
                      stitleColor: Colors.orange),
                  SquareBoxBottom(
                      backImage: 'assets/images/pinkback.png',
                      iconImage: 'assets/images/pink_dollar.png',
                      title: 'Collection rejected',
                      stitle: 'Case 180+ Now',
                      context: context,
                      titleColor: Color(0xffEE6C52),
                      stitleColor: const Color.fromARGB(255, 218, 96, 87)),
                ],
              ),
              SizedBox(
                height: displayHeight(context) * 0.1,
              ),
            ],
          ),
        ),
      );
    }, error: (error, stackTrace) {
      return Scaffold();
    }, loading: () {
      return Scaffold(body: Center(child: CircularProgressIndicator()),);
    },) ;



    // Scaffold(
    //   key: _scaffoldKey,
    //   // Step 2: Assign the scaffoldKey to the Scaffold
    //   // backgroundColor: AppColors.primary,
    //   appBar: AppBar(
    //     /* leading: Icon(Icons.menu),*/
    //
    //     leading: IconButton(
    //       onPressed: () {
    //         // Handle the click action here
    //         _scaffoldKey.currentState?.openDrawer(); // Open the end drawer
    //       },
    //       icon: const Icon(Icons.menu), // Choose the appropriate icon
    //       iconSize: 30, // Set the size of the icon
    //       color: Colors.black, // Set the color of the icon
    //     ),
    //     title: const Text("Collection Dashboard"),
    //     actions: [
    //       dataViewModel.isPunchOutStatus? GestureDetector(
    //           onTap: () {
    //             _showMyDialog(context, ref);
    //           },
    //           child: Padding(
    //             padding: const EdgeInsets.only(right: 8.0),
    //             child: Image.asset(
    //               'assets/images/fingerprint.png',
    //               height: displayHeight(context) * 0.04,
    //               width: displayWidth(context) * 0.06,
    //             ),
    //           )):SizedBox(),
    //     ],
    //   ),
    //   drawer: const DashBoardSideBar(),
    //   body: data.when(
    //     data: (data) {
    //       DateTime dateTime =
    //       DateFormat("yyyy-MM-dd'T'h:mm:ssZ").parse(data.joiningDate);
    //       return SingleChildScrollView(
    //         child: Column(
    //           children: [
    //             // User profile card
    //             Card(
    //               elevation: 2,
    //               margin: const EdgeInsets.all(16),
    //               child: Padding(
    //                 padding: const EdgeInsets.all(16.0),
    //                 child: Column(
    //                   crossAxisAlignment: CrossAxisAlignment.center,
    //                   children: [
    //                     /*CircleAvatar(
    //                       radius: 40,
    //                       backgroundImage: NetworkImage(
    //                           'https://miro.medium.com/v2/resize:fit:1400/format:webp/1*U4gZLnRtHEeJuc6tdVLwPw.png'), // Replace with actual image URL
    //                     ),*/
    //
    //                     CircleAvatar(
    //                       radius: 40,
    //                       backgroundImage: data.imageUrl != null
    //                           ? NetworkImage(
    //                               '${Api.imageUrl}${data.imageUrl}')
    //                           : const AssetImage('assets/images/check.png'),
    //                       // Placeholder image
    //                       onBackgroundImageError: (error, stackTrace) {
    //                         // Set a default image if the API image fails to load
    //                       },
    //                     ),
    //                     const SizedBox(height: 10),
    //                     Text(
    //                       data.name,
    //                       style: const TextStyle(
    //                           fontSize: 20, fontWeight: FontWeight.bold),
    //                     ),
    //                     Text(data.email),
    //                     const SizedBox(height: 10),
    //                     Row(
    //                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //                       children: [
    //                         const Text("Employee Unique Id:"),
    //                         Text(data.employeeUniqueId),
    //                       ],
    //                     ),
    //                     Row(
    //                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //                       children: [
    //                         const Text("Mobile No:"),
    //                         Text(data.mobileNo),
    //                       ],
    //                     ),
    //                     Row(
    //                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //                       children: [
    //                         const Text("Current Address:"),
    //                         Text(data.address),
    //                       ],
    //                     ),
    //                     Row(
    //                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //                       children: [
    //                         const Text("Joining Date:"),
    //                         Text( DateFormat.yMMMMd().format(dateTime)),
    //                       ],
    //                     ),
    //                   ],
    //                 ),
    //               ),
    //             ),
    //
    //             // GridView for six square cards
    //             Padding(
    //               padding: const EdgeInsets.symmetric(horizontal: 16),
    //               child: GridView.count(
    //                 physics: const NeverScrollableScrollPhysics(),
    //                 // To prevent GridView from scrolling
    //                 shrinkWrap: true,
    //                 // To fit content within the SingleChildScrollView
    //                 crossAxisCount: 2,
    //                 // Two cards per row
    //                 crossAxisSpacing: 16,
    //                 mainAxisSpacing: 16,
    //                 childAspectRatio: 1,
    //                 // To make the cards square
    //                 children: [
    //                   buildCard(Icons.person, '${data.visitAccepted ?? ''}',
    //                       'Visits Accepted'),
    //                   buildCard(
    //                       Icons.person,
    //                       '${data.visitPendingForApproval ?? ''}',
    //                       'Visits Pending'),
    //                   buildCard(Icons.person, '${data.visitRejected ?? ''}',
    //                       'Visits Rejected'),
    //                   buildCard(
    //                       Icons.currency_rupee,
    //                       '${data.collectionAcceptAmount ?? ''}',
    //                       'Collections Accepted'),
    //                   buildCard(
    //                       Icons.currency_rupee,
    //                       '${data.collectionEmiAmountPendingForApproval ?? ''}',
    //                       'Collections Pending'),
    //                   buildCard(
    //                       Icons.currency_rupee,
    //                       '${data.collectionRejectAmount ?? ''}',
    //                       'Collections Rejected'),
    //                 ],
    //               ),
    //             ),
    //
    //             const SizedBox(height: 10),
    //           ],
    //         ),
    //       );
    //     },
    //     error: (error, stackTrace) {
    //       print(error);
    //     },
    //     loading: () {
    //       return Center(child: CircularProgressIndicator());
    //     },
    //   )
    //
    //   // }, error: (error, stackTrace) {
    //   //   return Text('$error');
    //   // }, loading: () {
    //   //   return const CircularProgressIndicator();
    //   // },)
    //
    //   );
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

  Widget rectBox(
      {required String backImage,
      required String iconImage,
      required String title,
      required String stitle,
      required BuildContext context}) {
    return Stack(
      children: [
        Image(
          // image: AssetImage('assets/images/rectgreen.png'),
          image: AssetImage(backImage),
          fit: BoxFit.fill,
          height: displayHeight(context) * 0.2,
          width: displayWidth(context),
        ),
        Positioned(
          top: displayHeight(context) * 0.05,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: displayWidth(context) * 0.18,
              ),
              Image(
                //  image: AssetImage('assets/images/rectgreen_icon.png'),
                image: AssetImage(iconImage),
                height: displayHeight(context) * 0.1,
                width: displayWidth(context) * 0.15,
              ),
              SizedBox(
                width: displayWidth(context) * 0.04,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title ?? 'Visit Updated',
                    style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                        color: Color(0xff05BA65)),
                  ),
                  Text(
                    stitle ?? 'Case 180+ Now ',
                    style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 12,
                        // color: Color(0xff05BA65B2),
                        color: Colors.green),
                  )
                ],
              )
            ],
          ),
        )
      ],
    );
  }

  Widget SquareBox({
    required String backImage,
    required String iconImage,
    required String title,
    required String stitle,
    required BuildContext context,
    required Color titleColor, // Default color for title
    required Color stitleColor, // Default color for subtitle
  }) {
    return Stack(
      children: [
        Container(
          child: Image(
            image: AssetImage(backImage),
            height: displayHeight(context) * 0.2,
            width: displayWidth(context) * 0.5,
            fit: BoxFit.cover,
          ),
        ),
        Positioned(
          top: displayHeight(context) * 0.03,
          left: displayWidth(context) * 0.11,
          child: Column(
            children: [
              Image(
                image: AssetImage(iconImage),
                height: displayHeight(context) * 0.1,
                width: displayWidth(context) * 0.2,
              ),
              Text(
                title,
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                  color: titleColor,
                ),
              ),
              Text(
                stitle,
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 12,
                  color: stitleColor,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget SquareBoxBottom({
    required String backImage,
    required String iconImage,
    required String title,
    required String stitle,
    required BuildContext context,
    required Color titleColor, // Default color for title
    required Color stitleColor, // Default color for subtitle
  }) {
    return Stack(
      children: [
        Container(
          child: Image(
            image: AssetImage(backImage),
            height: displayHeight(context) * 0.2,
            width: displayWidth(context) * 0.5,
            fit: BoxFit.cover,
          ),
        ),
        Positioned(
          top: displayHeight(context) * 0.03,
          left: displayWidth(context) * 0.06,
          child: Column(
            children: [
              Image(
                image: AssetImage(iconImage),
                height: displayHeight(context) * 0.1,
                width: displayWidth(context) * 0.2,
              ),
              Text(
                title,
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 15,
                  color: titleColor,
                ),
              ),
              Text(
                stitle,
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 12,
                  color: stitleColor,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
