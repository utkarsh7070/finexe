import 'package:finexe/feature/base/dialog/logout_dialog.dart';
import 'package:finexe/feature/base/service/session_service.dart';
import 'package:finexe/feature/base/utils/namespase/display_size.dart';
import 'package:finexe/feature/ui/Collection/Collection_home_dashboard/Widget/dialog/collection_logout_dialog.dart';
import 'package:finexe/feature/ui/Collection/Collection_home_dashboard/home_collection_view/DashboardScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../base/routes/routes.dart';
import '../../../../base/utils/namespase/app_colors.dart';
import '../../../HRMS/LeaveManagement/view/hrms_dashboard_screen.dart';
import '../../../Sales/DashBoard/view/dash_board.dart';
import '../home_collection_model/user_profile_model.dart';
import '../home_collection_viewmodel/fetchUserProfile.dart';

class DashBoardSideBar extends ConsumerWidget {
  const DashBoardSideBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // final sessionOut = ref.read(apiResponseProvider.notifier);
    final role = ref.watch(roleName);
    print('role ${role}');
    return SafeArea(
      child: Container(
        height: role.role.contains('collection') || role.role.contains('pd') || role.role.contains('admin')
            ? displayHeight(context) * 0.50
            : displayHeight(context) * 0.36,
        width: displayWidth(context) * 0.35,
        decoration: const BoxDecoration(
            color: AppColors.white,
            // gradient: LinearGradient(
            // begin: Alignment.topCenter,
            // end: Alignment.bottomCenter,
            // colors: [
            //   Color(0xFFFFFFFF),
            //   Color(0xFF3CBCFF),
            //   Color(0xFF09ABFF),
            //   Color(0xFF0082C6),
            // ]),
            borderRadius: BorderRadius.all(Radius.circular(20))),
        // padding: const EdgeInsets.only(top: 15),
        child: Column(
          children: [
            // Top white section with image
            const Column(
              children: [
                // SizedBox(
                //   height: 100,
                //   child: Padding(
                //     padding: const EdgeInsets.all(10), // Add padding around the image for spacing
                //     child: Image.asset(
                //       'assets/images/finexe_text_image.png',height: displayHeight(context)*0.10,width: displayWidth(context)*0.30, // Your image path
                //       fit: BoxFit.contain, // Ensure the image is contained within the available space
                //     ),
                //   ),
                //
                // ),
              ],
            ),


            // Bottom blue section with menu items
            Expanded(
              child: ListView(
                padding: EdgeInsets.zero,
                children: [
                  // ListTile(
                  //   contentPadding: const EdgeInsets.fromLTRB(20, 30, 0, 10), // Adjust the horizontal padding as needed
                  //   title: const Text(
                  //     'Menu',
                  //     style: TextStyle(
                  //       fontSize: 24,
                  //       fontWeight: FontWeight.bold,
                  //       color: AppColors.white,
                  //     ),
                  //   ),
                  //   onTap: () {
                  //     // Handle navigation to settings
                  //   },
                  // ),

                  Visibility(
                    visible: role.role.contains('sales') || role.role.contains('admin'),
                    child: ListTile(
                      title:
                      Column(
                        children: [
                          Image.asset('assets/images/home.png',
                            width: displayWidth(context) * 0.10,
                            height: displayHeight(context) * 0.07,),
                          const Text(
                            'Sales',
                            style: TextStyle(color: AppColors.black),
                          ),
                        ],
                      ),
                      onTap: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const MyDashBoardWidget(),
                          ),
                        );
                      },
                    ),
                  ),

                  const Divider(
                    color: Colors.grey,
                    height: 5,
                    thickness: 1,
                    indent: 20,
                    endIndent: 20,
                  ),

                  ListTile(
                    // leading: const Icon(Icons.money, color: AppColors.black),
                    title:
                    Column(
                      children: [
                        Image.asset('assets/images/visit_pending_drawer_image.png',
                          width: displayWidth(context) * 0.10,
                          height: displayHeight(context) * 0.07,),
                        const Text(
                          'Visit',
                          style: TextStyle(color: AppColors.black),
                        ),
                      ],
                    ),
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.pushNamed(
                          context,
                          AppRoutes.cases
                      );
                    },
                  ),

                  const Divider(
                    color: Colors.grey,
                    height: 5,
                    thickness: 1,
                    indent: 20,
                    endIndent: 20,
                  ),
                  ListTile(
                    title: Column(
                      children: [
                        Image.asset(
                          'assets/images/hrms_icon.png',
                          width: displayWidth(context) * 0.10,
                          height: displayHeight(context) * 0.07,
                        ),
                        const Text(
                          'HRMS',
                          style: TextStyle(color: AppColors.black),
                        ),
                      ],
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>  HRMSDashboardScreen(),
                        ),
                      );
                    },
                  ),
                  const Divider(
                    color: Colors.grey,
                    height: 5,
                    thickness: 1,
                    indent: 20,
                    endIndent: 20,
                  ),

                  ListTile(
                    title:
                    Column(
                      children: [
                        Image.asset('assets/images/logout.png',
                          width: displayWidth(context) * 0.10,
                          height: displayHeight(context) * 0.07,),
                        const Text(
                          'Logout',
                          style: TextStyle(color: AppColors.black),
                        ),
                      ],
                    ),
                    onTap: () {
                      // Handle logout
                      // LogOutDialog.logOutDialog(context: context);
                      CollectionLogOutDialog.collectionLogOutDialog(
                          context: context);
                      // ref.read(apiResponseProvider.notifier).clearData();
                      // SessionService.deleteSession();
                      // Navigator.pushNamedAndRemoveUntil(context, AppRoutes.login, (route) =>false,);
                    },
                  ),

                  const Divider(
                    color: Colors.white,
                    height: 5,
                    thickness: 1,
                    indent: 20,
                    endIndent: 20,
                  ),
                ],
              ),

            ),
          ],
        ),
      ),
    );
  }

}