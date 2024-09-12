import 'package:finexe/feature/base/utils/namespase/app_colors.dart';
import 'package:finexe/feature/base/utils/namespase/display_size.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:motion_tab_bar/MotionTabBar.dart';
import '../view_model/dashboard_view_model.dart';

class DashBoardBottomNavigationBar extends ConsumerWidget {
  const DashBoardBottomNavigationBar({super.key});


  @override
  Widget build(BuildContext context, WidgetRef ref) {
   // Watching the TabViewModel state
    final tabController = ref.read(tabViewModelProvider.notifier);

    return MotionTabBar(
      initialSelectedTab: 'Dashboard',
      labels: const ["Dashboard", "Home", "Profile", "Settings"],
      icons: const [Icons.dashboard, Icons.home, Icons.people_alt, Icons.settings],
      tabSize: 50,
      tabBarHeight: 55,
      textStyle: const TextStyle(
        fontSize: 12,
        color: Colors.black,
        fontWeight: FontWeight.w500,
      ),
      tabIconColor: Colors.blue[600],
      tabIconSize: 28.0,
      tabIconSelectedSize: 26.0,
      tabSelectedColor: Colors.blue[900],
      tabIconSelectedColor: Colors.white,
      tabBarColor: Colors.white,
      onTabItemSelected: (int value) {
        tabController.setTabIndex(value);
          // _tabController!.index = value;
          // _motionTabBarController!.index = value;

      },
    );


    //
    //   Stack(
    //   alignment: Alignment.center,
    //   children: <Widget>[
    //     Container(
    //       margin: EdgeInsets.only(top: displayHeight(context) * 0.04),
    //       decoration: const BoxDecoration(color: AppColors.white, boxShadow: [
    //         BoxShadow(
    //             color: AppColors.buttonBorderGray,
    //             blurRadius: 10,
    //             spreadRadius: 2,
    //             offset: Offset(0, 3.0))
    //       ]),
    //       child: Padding(
    //         padding: const EdgeInsets.only(left: 16, right: 16),
    //         child: Row(
    //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //           children: [
    //             tabItem(1, Icons.home),
    //             tabItem(2, Icons.home),
    //             const SizedBox(
    //               width: 45,
    //               height: 45,
    //             ),
    //             tabItem(3, Icons.dashboard),
    //             tabItem(4, Icons.access_time_filled),
    //           ],
    //         ),
    //       ),
    //     ),
    //     Container(
    //       clipBehavior: Clip.none,
    //       child: FloatingActionButton(
    //         shape: CircleBorder(),
    //         clipBehavior: Clip.none,
    //         backgroundColor: AppColors.primery,
    //         child: const Icon(
    //           Icons.add,
    //           color: AppColors.white,
    //         ),
    //         onPressed: () {},
    //       ),
    //     ),
    //   ],
    // );
  }

  // Widget tabItem(int pos, IconData icon) {
  //   return Consumer(
  //     builder: (context, ref, child) {
  //       final isSelected = ref.watch(bottomNavigationSelected);
  //       return GestureDetector(
  //         onTap: () {
  //           ref.read(bottomNavigationSelected.notifier).state = pos;
  //         },
  //         child: Container(
  //           width: 45,
  //           height: 45,
  //           alignment: Alignment.center,
  //           decoration: isSelected == pos
  //               ? const BoxDecoration(
  //                   shape: BoxShape.circle, color: AppColors.primaryLight)
  //               : const BoxDecoration(),
  //           child: Icon(
  //             icon,
  //             color: isSelected == pos ? AppColors.primery : AppColors.inactive,
  //           ),
  //         ),
  //       );
  //     },
  //   );
  // }
}
