import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../base/routes/routes.dart';
import '../../OnBoarding/view/on_boarding_screen.dart';
import '../view_model/dashboard_view_model.dart';
import 'dash_board_bottom_navigation_bar.dart';
import 'dashboard_drawer.dart';

class DashBoardScreen extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final stageProvider = ref.watch(stepStageProvider);
    final data = ref.read(stepStageProvider.notifier).state.trim();
    final tabViewModel = ref.watch(tabViewModelProvider);
    return Scaffold(
        floatingActionButton:tabViewModel.selectedIndex==0? FloatingActionButton(
          onPressed: () {
            Navigator.pushNamed(context, AppRoutes.saleForm);
          },
          child: const Center(child: Text('New Loan',textAlign: TextAlign.center,)),
        ):null,
        bottomNavigationBar: const DashBoardBottomNavigationBar(),
        appBar: AppBar(
          title: const Icon(CupertinoIcons.moon),
        ),
        drawer: const DrawerScreen(),
        body: IndexedStack(
          index: tabViewModel.selectedIndex,
          children: <Widget>[
            OnBoardingScreen(),
            Container(
              child: const Text('sdmfb'),
            ),
            Container(
              child: const Text('jhsdalj'),
            ),
            Container(
              child: const Text('ljoil'),
            )
          ],
        )
        // switch(data.runtimeType){
        //   // TODO: Handle this case.
        //   Type() => throw UnimplementedError(),
        // }

        );
  }
}
