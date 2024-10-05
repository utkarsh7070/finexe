import 'package:finexe/feature/base/utils/namespase/display_size.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../base/utils/namespase/app_colors.dart';
import '../view_model/dashboard_view_model.dart';

class DashBoardBottomNavigationBar extends ConsumerWidget {
  final TabController tabController;

  const DashBoardBottomNavigationBar({super.key, required this.tabController});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tabModel =
        ref.watch(tabViewModelProvider); // Get the selected tab index
    const List<Widget> _icons = [
      Icon(CupertinoIcons.bag),
      Icon(CupertinoIcons.house_alt_fill),
      Icon(CupertinoIcons.person),
    ];

    final List<String> _labels = ['cases', 'Home', 'Profile'];

    return Container(
      height: displayHeight(context) * 0.12,
      width: displayWidth(context) * 0.30,
      padding: const EdgeInsets.all(12),
      child: Card(
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(40))),
        child: Center(
          child: TabBar(
            controller: tabController,
            onTap: (index) {
              ref.read(tabViewModelProvider.notifier).setTabIndex(index);
            },
            labelColor: AppColors.primary,
            unselectedLabelColor: AppColors.blueShadeColor,
            indicator: const UnderlineTabIndicator(
              borderSide: BorderSide.none,
            ),

            tabs: [
              for (int i = 0; i < _icons.length; i++)
                _tabItem(_icons[i], _labels[i], context,
                    isSelected: i == tabModel.selectedIndex),
            ],
          ),
        ),
      ),
    );
  }

  Widget _tabItem(Widget child, String label, BuildContext context,
      {bool isSelected = false}) {
    return AnimatedContainer(
      width: displayWidth(context) * 0.30,
      // width: displayWidth(context)*0.10,
      //  margin: const EdgeInsets.all(8),
      alignment: Alignment.center,
      duration: const Duration(milliseconds: 500),
      decoration: !isSelected
          ? null
          : BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              // color: Colors.black,
            ),
      padding: const EdgeInsets.all(10),
      child: Column(
        children: [
          child,
          Text(label, style: const TextStyle(fontSize: 9)),
        ],
      ),
    );
  }
}

// class DashBoardBottomNavigationBar extends ConsumerWidget {
//   const DashBoardBottomNavigationBar({super.key});
//
//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final tabController = ref.read(tabViewModelProvider.notifier);
//     final tabCurrent = ref.watch(tabViewModelProvider);
//     final tab = TabController(
//       length: 3,
//       vsync: TickerProviderStateMixin.of(context),
//     );
//     return
    // MotionTabBar(
    // initialSelectedTab: 'Dashboard',
    // labels: const ["Dashboard", "Home", "Profile", "Settings"],
    // icons: const [Icons.dashboard, Icons.home, Icons.people_alt, Icons.settings],
    // tabSize: 50,
    // tabBarHeight: 55,
    // textStyle: const TextStyle(
    //   fontSize: 12,
    //   color: Colors.black,
    //   fontWeight: FontWeight.w500,
    // ),
    // tabIconColor: Colors.blue[600],
    // tabIconSize: 28.0,
    // tabIconSelectedSize: 26.0,
    // tabSelectedColor: Colors.blue[900],
    // tabIconSelectedColor: Colors.white,
    // tabBarColor: Colors.white,
    // onTabItemSelected: (int value) {
    //   tabController.setTabIndex(value);
    //     // _tabController!.index = value;
    //     // _motionTabBarController!.index = value;
    //
    // },
    // );
// }
