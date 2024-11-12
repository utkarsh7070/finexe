import 'dart:developer';

import 'package:finexe/feature/Punch_In_Out/viewmodel/attendance_view_model.dart';
import 'package:finexe/feature/base/dialog/logout_dialog.dart';
import 'package:finexe/feature/base/utils/namespase/app_colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../base/routes/routes.dart';
import '../../LeadGeneration/view/lead_dashboard_form.dart';
import '../../OnBoarding/view/on_boarding_screen.dart';
import '../../OnBoarding/view/sales_cases/sales_cases_screen.dart';
import '../view_model/dashboard_view_model.dart';
import 'dash_board_bottom_navigation_bar.dart';
import 'dashboard_drawer.dart';

class MyDashBoardWidget extends ConsumerStatefulWidget {
  const MyDashBoardWidget({Key? key}) : super(key: key);

  @override
  _DashBoardScreen createState() => _DashBoardScreen();
}

class _DashBoardScreen extends ConsumerState<MyDashBoardWidget>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

// class DashBoardScreen extends ConsumerWidget {
//   const DashBoardScreen({super.key});
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);

  }
  @override
  void dispose() {
    _tabController.dispose();
    // TODO: implement dispose
    super.dispose();
  }

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
      child: Scaffold(
          floatingActionButton: tabViewModel.selectedIndex == 1
              ? FloatingActionButton(
                  foregroundColor: AppColors.black,
                  backgroundColor: AppColors.white,
                  elevation: 5,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50)),
                  onPressed: () {
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
          drawer: const DrawerScreen(),
          body: IndexedStack(
            index: tabViewModel.selectedIndex,
            children: <Widget>[
              const SalesCasesScreen(),
              const OnBoardingScreen(),
              Container(
                  child: Center(
                child: Column(
                  children: [
                    SizedBox(height: 300),
                    ElevatedButton(
                      // onPressed: () async {
                      //   bool result = await SessionService.deleteSession();
                      //   if (result) {
                      //     // Optionally navigate or show a message after successful deletion
                      //     ScaffoldMessenger.of(context).showSnackBar(
                      //       SnackBar(content: Text('Logout successfully')),
                      //     );
                      //     // Navigate to the login screen and remove all previous routes
                      //     Navigator.pushNamedAndRemoveUntil(
                      //       context,
                      //       AppRoutes.login, // Name of your login route
                      //       (route) =>
                      //           false, // Remove all routes until the login route
                      //     );
                      //     log('Logout');
                      //   } else {
                      //     ScaffoldMessenger.of(context).showSnackBar(
                      //       SnackBar(content: Text('Failed to logout')),
                      //     );
                      //   }
                      // },
                      onPressed: () {
                        LogOutDialog.logOutDialog(context: context);
                      },
                      child: Text(
                        'Logout',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        log('onPunchOut');
                        ref.read(attendanceProvider.notifier).onPunchOut(context).then(
                          (value) {
                            log('punchout');
                            // Navigator.pushNamedAndRemoveUntil(
                            //   context,
                            //   AppRoutes.attendance,
                            //   (route) => false,
                            // );
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
                  ],
                ),
              )),
              LeadListScreen()
            ],
          )),
    );
  }
}
