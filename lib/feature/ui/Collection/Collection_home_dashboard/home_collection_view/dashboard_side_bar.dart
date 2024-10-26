import 'package:finexe/feature/base/utils/namespase/display_size.dart';
import 'package:finexe/feature/ui/Collection/Collection_home_dashboard/home_collection_view/DashboardScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../base/routes/routes.dart';
import '../../../../base/utils/namespase/app_colors.dart';
import '../home_collection_model/user_profile_model.dart';
import '../home_collection_viewmodel/fetchUserProfile.dart';

class DashBoardSideBar extends ConsumerWidget{
  const DashBoardSideBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final sessionOut =  ref.read(userProfileProvider.notifier);
  return SafeArea(
    child: Container(
      height: displayHeight(context)*0.95,
      width: displayWidth(context)*0.60,
      decoration:  const BoxDecoration(
          gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color(0xFFFFFFFF),
            Color(0xFF3CBCFF),
            Color(0xFF09ABFF),
            Color(0xFF0082C6),
          ]),
          borderRadius: BorderRadius.all(Radius.circular(20))),
      // padding: const EdgeInsets.only(top: 15),
      child: Column(
          children: [
            // Top white section with image
            Column(
              children: [
                const SizedBox(height: 10),
                SizedBox(
                  height: 100,
                  child: Padding(
                    padding: const EdgeInsets.all(10), // Add padding around the image for spacing
                    child: Image.asset(
                      'assets/images/finexe_text_image.png',height: displayHeight(context)*0.10,width: displayWidth(context)*0.30, // Your image path
                      fit: BoxFit.contain, // Ensure the image is contained within the available space
                    ),
                  ),

                ),
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

                  ListTile(
                    leading: const Icon(Icons.home, color: AppColors.white),
                    title: const Text(
                      'Home',
                      style: TextStyle(color: AppColors.white),
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DashboardScreen(),
                        ),
                      );
                    },
                  ),

                  const Divider(
                    color: Colors.white,
                    height: 5,
                    thickness: 1,
                    indent: 20,
                    endIndent: 20,
                  ),

                  ListTile(
                    leading: const Icon(Icons.money, color: AppColors.white),
                    title: const Text(
                      'Collection',
                      style: TextStyle(color: AppColors.white),
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
                    color: Colors.white,
                    height: 5,
                    thickness: 1,
                    indent: 20,
                    endIndent: 20,
                  ),

                  ListTile(
                    leading: const Icon(Icons.logout, color: AppColors.white),
                    title: const Text(
                      'Logout',
                      style: TextStyle(color: AppColors.white),
                    ),
                    onTap: () {
                      // Handle logout
                      sessionOut.logoutSession().then((value) {
                        Navigator.pushNamedAndRemoveUntil(context, AppRoutes.login, (route) => false,);
                      },);
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