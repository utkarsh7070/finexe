import 'dart:async';
import 'dart:convert';
import 'package:finexe/feature/base/extentions/capital_letter.dart';
import 'package:finexe/feature/base/utils/namespase/app_colors.dart';
import 'package:finexe/feature/base/utils/namespase/display_size.dart';
import 'package:finexe/feature/ui/Collection/Collection_home_dashboard/Widget/profile_update_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:roam_flutter/roam_flutter.dart';
import '../../../../base/api/api.dart';
import '../../../../base/utils/widget/custom_snackbar.dart';
import '../home_collection_viewmodel/fetchUserProfile.dart';
import '../../../../Punch_In_Out/viewmodel/attendance_view_model.dart';
import '../Widget/punct_in_out_action_dialog_content.dart';
import 'dashboard_side_bar.dart';

class CollectionDashboardScreen extends ConsumerStatefulWidget {
  const CollectionDashboardScreen({super.key});

  @override
  _CollectionDashboardScreenState createState() => _CollectionDashboardScreenState();
}

class _CollectionDashboardScreenState extends ConsumerState<CollectionDashboardScreen> {
  // final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  late Timer trackingTimer;
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(apiResponseProvider.notifier).fetchDashboardData().then((value) {
        final data = ref.watch(apiResponseProvider);
        print('${data.value?.name}');
        if(data.value?.name != null){
          initialiseRoamSdk(data.value!.name);
        }
      },);


    });
  }

  Future<void> initialiseRoamSdk(String name) async {
    print("Attempting to initialize Roam SDK...");
    try {
      await requestLocationPermissions();
      print("Permissions granted, initializing Roam SDK...");

      Roam.initialize(
        publishKey: '58f73be503e069888cf19289bf728c14c2e841c47e5842a1054f9e5f12f52583',
      );
      print("Roam SDK initialized."); // Check if this is reached

      // Roam.getUser(userId:'672b16d23e8a8f5a915d743e', callBack: ({user}) {
      //   print('User name - $user');
      // });
      Roam.createUser(description:name,callBack: ({user}) {
// do something on create user
        print(user);
      });

      Map<String, dynamic> fitnessTracking = {
        "timeInterval": 10
      };
      Roam.startTracking(trackingMode: "custom", customMethods: fitnessTracking);
      print("Custom tracking started with 10-second interval.");



      listenToLocationUpdates();

      trackingTimer = Timer(Duration(minutes: 15), () {
        Roam.stopTracking();
        print("Tracking stopped after 15 minutes.");
      });

    } catch (e) {
      print("Failed to initialize Roam SDK: $e");
    }
  }

  Future<void> listenToLocationUpdates() async {
    print("Setting location listener...");
    Roam.onLocation((location) {
      print("Received location from Roam SDK: ${jsonEncode(location)}");
      showCustomSnackBar(
          context, "Received location from Roam SDK: ${jsonEncode(location)}", Colors.green);
    });
    print("Location listener set.");
  }

  Future<void> requestLocationPermissions() async {
    final locationWhenInUse = await Permission.locationWhenInUse.request();
    if (locationWhenInUse.isGranted) {
      final locationAlways = await Permission.locationAlways.request();
      if (!locationAlways.isGranted) {
        print("Location always permission not granted.");
      } else {
        print("Location permissions granted.");
        await getCurrentLocation();
      }
    } else {
      print("Location permission denied.");
    }
  }

  Future<void> getCurrentLocation() async {
    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );
    print("Initial location: ${position.latitude}, ${position.longitude}");
  }



  // Step 1: Define the GlobalKey

  @override
  Widget build(BuildContext context) {
    final isDialogOpen = ref.watch(dialogVisibilityProvider);

    void _toggleDialog() {
      // Toggle dialog state
      ref.read(dialogVisibilityProvider.notifier).state = !isDialogOpen;
    }

    final data = ref.watch(apiResponseProvider);
    final dataViewModel = ref.read(apiResponseProvider.notifier);
    return data.when(
      data: (data) {
        return Scaffold(
          drawer: const DashBoardSideBar(),
          backgroundColor: Colors.white,
          appBar: AppBar(
            // automaticallyImplyLeading: true,
            actions: [
              GestureDetector(
                  onTap: () {
                    _showMyDialog(context, ref);
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(right: 5.0),
                    child: Image.asset(
                      'assets/images/fingerprint.png',
                      height: displayHeight(context) * 0.06,
                      width: displayWidth(context) * 0.10,
                    ),
                  )),
              SizedBox(
                width: displayWidth(context) * 0.05,
              ),
              GestureDetector(
                onTap: () {
                  ProfileUpdateDialog.profileUpdateDialog(context: context, userProfile: data);
                  // ProfileUpdateContent(userProfile: data);
                },
                // _toggleDialog,
                child: Padding(
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
              ),
            ],
            flexibleSpace: Container(
              color: AppColors.white,
            ),
            backgroundColor: AppColors.white,
          ),
          body: SingleChildScrollView(
            child: Column(
              children: [
                Row(
                  children: [
                    SizedBox(
                      width: displayWidth(context) * 0.05,
                    ),
                    SizedBox(
                        height: displayHeight(context) * 0.08,
                        width: displayWidth(context) * 0.1,
                        child: const Image(
                            image:
                                AssetImage('assets/images/Morning.png'))),
                    SizedBox(
                      width: displayWidth(context) * 0.04,
                    ),
                    Text(
                      dataViewModel.greeting(),
                      style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: Color(0xff475467)),
                    )
                  ],
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  padding:
                      EdgeInsets.only(left: displayWidth(context) * 0.05),
                  child: Text(
                      CaplitalizeSentence().capitalizeEachWord(data.name),
                    textAlign: TextAlign.left,
                    style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        color: Colors.black),
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
                    const Text(
                      'Get Ready- ',
                      style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w500,
                          color: Color(0xff0082C6)),
                    ),
                    const Text(
                      'You will do your best on today we will meet',
                      style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w500,
                          color: Color(0xff475467)),
                    )
                  ],
                ),
                SizedBox(
                  height: displayHeight(context) * 0.03,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Image(
                      image: const AssetImage(
                        'assets/images/leftside.png',
                      ),
                      height: displayHeight(context) * 0.02,
                      width: displayWidth(context) * 0.25,
                    ),
                    SizedBox(
                      width: displayWidth(context) * 0.02,
                    ),
                    const Text(
                      'Visit Update’s',
                      style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 18,
                          color: Color(0xff475467)),
                    ),
                    SizedBox(
                      width: displayWidth(context) * 0.02,
                    ),
                    Image(
                      image:
                          const AssetImage('assets/images/rightside.png'),
                      height: displayHeight(context) * 0.02,
                      width: displayWidth(context) * 0.25,
                    ),
                  ],
                ),
                rectBox(
                    backImage: 'assets/images/backgreen.png',
                    iconImage: 'assets/images/right.png',
                    title: 'Visit Updated',
                    stitle: 'Case ${data.visitAccepted} Now',
                    context: context),
                Row(
                  children: [
                    SquareBox(
                        backImage: 'assets/images/square.png',
                        iconImage: 'assets/images/watch.png',
                        title: 'Visit pending',
                        stitle: 'Case ${data.visitPendingForApproval} Now',
                        context: context,
                        titleColor: const Color(0xffFFA500),
                        stitleColor: Colors.orange),
                    SquareBox(
                        backImage: 'assets/images/rejected.png',
                        iconImage: 'assets/images/rejected_icon.png',
                        title: 'Visit rejected',
                        stitle: 'Case ${data.visitRejected} Now',
                        context: context,
                        titleColor: const Color(0xffEE6C52),
                        stitleColor:
                            const Color.fromARGB(255, 218, 96, 87)),
                  ],
                ),
                SizedBox(
                  height: displayHeight(context) * 0.02,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Image(
                        image: const AssetImage(
                          'assets/images/leftside.png',
                        ),
                        height: displayHeight(context) * 0.02,
                        width: displayWidth(context) * 0.18,
                      ),
                      SizedBox(
                        width: displayWidth(context) * 0.025,
                      ),
                      const Text(
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
                        image:
                            const AssetImage('assets/images/rightside.png'),
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
                      stitle: 'Case ${data.collectionAcceptAmount} Now',
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
                        stitle:
                            'Case ${data.collectionEmiAmountPendingForApproval} Now',
                        context: context,
                        titleColor: const Color(0xffFFA500),
                        stitleColor: Colors.orange),
                    SquareBoxBottom(
                        backImage: 'assets/images/pinkback.png',
                        iconImage: 'assets/images/pink_dollar.png',
                        title: 'Collection rejected',
                        stitle: 'Case ${data.collectionRejectAmount} Now',
                        context: context,
                        titleColor: const Color(0xffEE6C52),
                        stitleColor:
                            const Color.fromARGB(255, 218, 96, 87)),
                  ],
                ),
                SizedBox(
                  height: displayHeight(context) * 0.1,
                ),
              ],
            ),
          ),
        );
      },
      error: (error, stackTrace) {
        return const Scaffold();
      },
      loading: () {
        return const Scaffold(
          body: Center(child: CircularProgressIndicator()),
        );
      },
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
                    style: const TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                        color: Color(0xff05BA65)),
                  ),
                  Text(
                    stitle ?? 'Case 180+ Now ',
                    style: const TextStyle(
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
