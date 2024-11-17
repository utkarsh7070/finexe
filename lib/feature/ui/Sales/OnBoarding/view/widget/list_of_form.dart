import 'package:finexe/feature/base/utils/namespase/app_colors.dart';
import 'package:finexe/feature/base/utils/namespase/display_size.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../view_model/on_boarding_view_model.dart';

class DashBoardFormList extends ConsumerStatefulWidget {
  const DashBoardFormList({super.key});

  @override
  _DashBoardFormList createState() => _DashBoardFormList();
}

class _DashBoardFormList extends ConsumerState<DashBoardFormList>
    with SingleTickerProviderStateMixin {
  bool _isAnimationPlayed = false;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!_isAnimationPlayed) {
        _controller.forward();
        _isAnimationPlayed = true;
        ref.read(dashboardShowViewModelProvider).fetchLeads(context, ref);
      }
    });
    super.initState();
  }

  late final AnimationController _controller = AnimationController(
      duration: const Duration(milliseconds: 500), vsync: this);
  late final Animation<double> _animation = CurvedAnimation(
    parent: _controller,
    curve: Curves.easeInOut,
  );

  @override
  void dispose() {
    _controller.dispose();
    // TODO: implement dispose
    super.dispose();
  }

// class DashBoardFormList extends ConsumerWidget {
  // DashBoardFormList({super.key});
  @override
  Widget build(BuildContext context) {
    final gridItems = ref.watch(gridItemProvider);
    final getCasesDataViewModel = ref.read(getCasesData.notifier);
    final customer = ref.watch(customerName);
    final drawer = ref.watch(openDrawerProvider);
    final drawerViewModel = ref.read(openDrawerProvider.notifier);

    return Column(
      children: [
        SizeTransition(
          axisAlignment: -1,
          axis: Axis.vertical,
          sizeFactor: CurvedAnimation(
            parent: _animation,
            curve: Curves.easeIn,
          ),
          child: Container(
            decoration: const BoxDecoration(
                borderRadius:
                    BorderRadius.only(bottomLeft: Radius.circular(70)),
                color: AppColors.primary),
            width: displayWidth(context),
            height: displayHeight(context) * 0.34,
            child: Stack(
              children: [
                // Align(
                //     alignment: Alignment.bottomRight,
                //     child: Image.asset(
                //       'assets/images/dashboard_design.png',
                //       height: displayHeight(context) * 0.35,
                //     )),
                Align(
                    alignment: Alignment.bottomLeft,
                    child: Container(
                      height: displayHeight(context) * 0.35,
                      padding: const EdgeInsets.only(left: 16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Hi,',
                            style: TextStyle(
                                color: AppColors.white,
                                fontSize: 32,
                                fontWeight: FontWeight.w700),
                          ),
                          Text(
                            customer ?? '',
                            style: const TextStyle(
                                color: AppColors.white,
                                fontSize: 32,
                                fontWeight: FontWeight.w700),
                          ),
                          SizedBox(
                            height: displayHeight(context) * 0.01,
                          ),
                          SizedBox(
                              width: displayWidth(context) * 0.50,
                              child: const Text(
                                '"Welcome back! Ready to dive into your tasks?"',
                                style: TextStyle(color: AppColors.white),
                              )),
                        ],
                      ),
                    )),
                // SafeArea(
                //   child: IconButton(onPressed: () {
                //     if(drawer){
                //       Navigator.of(context).pop();
                //       drawerViewModel.state=false;
                //     }else{
                //       keyScaffold.currentState?.openDrawer();
                //       drawerViewModel.state=true;
                //     }
                //
                //   }, icon: Icon(Icons.menu,color: AppColors.white,)),
                // )
              ],
            ),
          ),
        ),
        // SizedBox(
        //   height: displayHeight(context) * 0.03,
        // ),
        Expanded(
            child: SizedBox(
          width: displayWidth(context),
          height: displayHeight(context),
          child: GridView.builder(
            padding: const EdgeInsets.only(right: 16, left: 16, top: 10),
            itemCount: 4,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisSpacing: 10, mainAxisSpacing: 10, crossAxisCount: 2),
            itemBuilder: (context, index) {
              return Container(
                decoration: BoxDecoration(
                    border: Border.all(color: AppColors.boxBorderGray),
                    borderRadius: const BorderRadius.all(Radius.circular(15))),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                        height: displayHeight(context) * 0.07,
                        width: displayWidth(context) * 0.20,
                        padding: const EdgeInsets.all(9),
                        decoration: const BoxDecoration(
                          color: AppColors.boxBagGray,
                          borderRadius: BorderRadius.all(Radius.circular(15)),
                        ),
                        child: SizedBox(
                            child: Image.asset(gridItems[index].icon))),
                    SizedBox(
                      height: displayHeight(context) * 0.01,
                    ),
                    Text(
                      gridItems[index].title,
                      style: const TextStyle(
                          fontWeight: FontWeight.w600, fontSize: 16),
                    ),
                    SizedBox(
                      height: displayHeight(context) * 0.01,
                    ),
                    Text(gridItems[index].subTitle),
                  ],
                ),
              );
            },
          ),
        )),
      ],
    );
  }
}
