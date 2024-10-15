import 'package:finexe/feature/base/utils/namespase/app_colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../base/routes/routes.dart';
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
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    final stageProvider = ref.watch(stepStageProvider);
    final data = ref.read(stepStageProvider.notifier).state.trim();
    final tabViewModel = ref.watch(tabViewModelProvider);
    final tabState = ref.read(tabViewModelProvider.notifier);
    return Scaffold(
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
            Container(child: const Text('jhsdalj')),
          ],
        ));
  }
}
