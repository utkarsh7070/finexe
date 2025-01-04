import 'dart:async';
import 'package:finexe/feature/Punch_In_Out/viewmodel/attendance_view_model.dart';
import 'package:finexe/feature/base/internetConnection/networklistener.dart';
import 'package:finexe/feature/base/utils/namespase/app_colors.dart';
import 'package:finexe/feature/ui/Sales/SalesProfile/view/sales_profile.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../base/routes/routes.dart';
import '../../LeadGeneration/view/lead_dashboard_form.dart';
import '../../OnBoarding/view/on_boarding_screen.dart';
import '../../OnBoarding/view/sales_cases/sales_cases_screen.dart';
import '../view_model/dashboard_view_model.dart';
import 'dash_board_bottom_navigation_bar.dart';
import 'dashboard_drawer.dart';

class MyDashBoardWidget extends ConsumerStatefulWidget {
  const MyDashBoardWidget({super.key});

  @override
  _DashBoardScreen createState() => _DashBoardScreen();
}

class _DashBoardScreen extends ConsumerState<MyDashBoardWidget>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  late Timer trackingTimer;

// class DashBoardScreen extends ConsumerWidget {
//   const DashBoardScreen({super.key});
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this,initialIndex: 0);
    // initialiseRoamSdk();
  }
  @override
  void dispose() {
    _tabController.dispose();
    // TODO: implement dispose
    super.dispose();
  }

  // Future<void> initialiseRoamSdk() async {
  //   print("Attempting to initialize Roam SDK...");
  //   try {
  //     await requestLocationPermissions();
  //     print("Permissions granted, initializing Roam SDK...");
  //
  //     Roam.initialize(
  //       publishKey: '58f73be503e069888cf19289bf728c14c2e841c47e5842a1054f9e5f12f52583',
  //     );
  //     print("Roam SDK initialized."); // Check if this is reached
  //
  //     Roam.getUser(userId:'672b16d23e8a8f5a915d743e', callBack: ({user}) {
  //       print('User name - $user');
  //     });
  //
  //     Map<String, dynamic> fitnessTracking = {
  //       "timeInterval": 10
  //     };
  //     Roam.startTracking(trackingMode: "custom", customMethods: fitnessTracking);
  //     print("Custom tracking started with 10-second interval.");
  //
  //
  //
  //     listenToLocationUpdates();
  //
  //     trackingTimer = Timer(Duration(hours: 12), () {
  //       Roam.stopTracking();
  //       print("Tracking stopped after 15 minutes.");
  //     });
  //
  //   } catch (e) {
  //     print("Failed to initialize Roam SDK: $e");
  //   }
  // }
  //
  // Future<void> listenToLocationUpdates() async {
  //   print("Setting location listener...");
  //   Roam.onLocation((location) {
  //     print("Received location from Roam SDK: ${jsonEncode(location)}");
  //     showCustomSnackBar(
  //         context, "Received location from Roam SDK: ${jsonEncode(location)}", Colors.green);
  //   });
  //   print("Location listener set.");
  // }
  //
  // Future<void> requestLocationPermissions() async {
  //   final locationWhenInUse = await Permission.locationWhenInUse.request();
  //   if (locationWhenInUse.isGranted) {
  //     final locationAlways = await Permission.locationAlways.request();
  //     if (!locationAlways.isGranted) {
  //       print("Location always permission not granted.");
  //     } else {
  //       print("Location permissions granted.");
  //       await getCurrentLocation();
  //     }
  //   } else {
  //     print("Location permission denied.");
  //   }
  // }
  //
  // Future<void> getCurrentLocation() async {
  //   Position position = await Geolocator.getCurrentPosition(
  //     desiredAccuracy: LocationAccuracy.high,
  //   );
  //   print("Initial location: ${position.latitude}, ${position.longitude}");
  // }

  // final SessionService userSession = SessionService();
  @override
  Widget build(BuildContext context) {
    final tabViewModel = ref.watch(tabViewModelProvider);
    final checkpunchProvider = ref.watch(attendanceProvider);

    return PopScope(
     canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        SystemNavigator.pop();
      },

      // canPop: () async {
      //   // Close the app
      //   SystemNavigator.pop();
      //   return false; // Prevents back navigation
      // },

      child: NetworkListener(
      context: context,
        child: Scaffold(
            floatingActionButton: tabViewModel.selectedIndex == 0
                ? FloatingActionButton(
                    foregroundColor: AppColors.black,
                    backgroundColor: AppColors.white,
                    elevation: 5,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50)),
                    onPressed: () {
                      // Navigator.pushNamed(context, AppRoutes.employeeBasicDetails);
                      Navigator.pushNamed(context, AppRoutes.newLone);
                    },
                    child: const Icon(
                      Icons.add,
                      color: Colors.black,
                    ),
                  )
                : null,
        
            bottomNavigationBar:
                DashBoardBottomNavigationBar(tabController: _tabController),
            appBar: tabViewModel.selectedIndex == 0?AppBar(iconTheme: const IconThemeData(color: AppColors.white),
              backgroundColor: AppColors.primary,
            ):null,
            drawer:  const DrawerScreen(),
            body: IndexedStack(
              index: tabViewModel.selectedIndex,
              children: const <Widget>[
                OnBoardingScreen(),
                SalesCasesScreen(),
                LeadListScreen(),
                SalesProfile(),
        
              ],
            )),
      ),

    );
  }
}
