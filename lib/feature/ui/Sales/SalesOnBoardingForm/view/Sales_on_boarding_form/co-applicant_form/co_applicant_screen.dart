import 'package:finexe/feature/ui/Sales/SalesOnBoardingForm/view/Sales_on_boarding_form/co-applicant_form/co_applicant_form1.dart';
import 'package:finexe/feature/ui/Sales/SalesOnBoardingForm/view/Sales_on_boarding_form/co-applicant_form/co_applicant_form2.dart';
import 'package:finexe/feature/ui/Sales/SalesOnBoardingForm/view/Sales_on_boarding_form/co-applicant_form/co_applicant_form3.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../view_model/co_applicant_form_view_model.dart';

class CoApplicantScreen extends ConsumerStatefulWidget{
  const CoApplicantScreen({super.key});


  @override
  _CoApplicantScreen createState() => _CoApplicantScreen();

}

class _CoApplicantScreen extends ConsumerState<CoApplicantScreen>
    with SingleTickerProviderStateMixin {
  // late PageController _pageViewController;
  late TabController _tabController;

// class DashBoardScreen extends ConsumerWidget {
//   const DashBoardScreen({super.key});
  @override
  void initState() {
    super.initState();
    // _pageViewController= PageController();
    _tabController = TabController(length: 2, vsync: this);
  }
  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }
  // void _handlePageViewChanged(int currentPageIndex) {
  //   if (!_isOnDesktopAndWeb) {
  //     return;
  //   }
  //   _tabController.index = currentPageIndex;
  //   ref.read(pageIndexProvider.notifier).setPageIndex(currentPageIndex);
  // }
  //----------------------------

  bool get _isOnDesktopAndWeb {
    if (kIsWeb) {
      return true;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.macOS:
      case TargetPlatform.linux:
      case TargetPlatform.windows:
        return true;
      case TargetPlatform.android:
      case TargetPlatform.iOS:
      case TargetPlatform.fuchsia:
        return false;
    }
  }

//----------------------------
//   void _updateCurrentPageIndex(int index) {
//     _tabController.index = index;
//     // _pageViewController.animateToPage(
//     //   index,
//     //   duration: const Duration(milliseconds: 400),
//     //   curve: Curves.easeInOut,
//     // );
//     // ref.read(pageIndexProvider.notifier).setPageIndex(index);
//   }

  //-----------------------use -------------------------------------
  //

  @override
  Widget build(BuildContext context) {
    final currentPageIndex = ref.watch(pageViewModelProvider);
    return  IndexedStack(
      index: currentPageIndex.selectedIndex,
      children: const [
        CoApplicantForm1(),
        CoApplicantForm3(),
        CoApplicantForm2(),
      ],
    );

    //   Stack(children: [
    //   PageView(
    //     controller: _pageViewController,
    //     onPageChanged: (index) => _handlePageViewChanged(index),
    //     children: <Widget>[
    //
    //       // Scaffold(body: Center(child: Text('First Page'))),
    //       // Center(child: Text('Second Page')),
    //       // Center(child: Text('Third Page')),
    //
    //     ],
    //   ),
    //   PageIndicator(
    //     tabController: _tabController,
    //     currentPageIndex: currentPageIndex,
    //     onUpdateCurrentPageIndex: _updateCurrentPageIndex,
    //     isOnDesktopAndWeb: _isOnDesktopAndWeb,
    //   ),
    // ],
    //
    // );
  }

}