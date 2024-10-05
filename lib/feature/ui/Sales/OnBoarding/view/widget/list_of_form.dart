import 'package:finexe/feature/base/utils/namespase/app_colors.dart';
import 'package:finexe/feature/base/utils/namespase/display_size.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../view_model/on_boarding_view_model.dart';
class DashBoardFormList extends ConsumerStatefulWidget {
  const DashBoardFormList({Key? key}) : super(key: key);

  @override
  _DashBoardFormList createState() => _DashBoardFormList();
}

class _DashBoardFormList extends ConsumerState<DashBoardFormList>
    with SingleTickerProviderStateMixin{
  bool _isAnimationPlayed = false;
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!_isAnimationPlayed) {
        _controller.forward();
        _isAnimationPlayed = true;
      }
    });
    super.initState();
  }

  late final AnimationController _controller = AnimationController(
    duration: const Duration(milliseconds: 500),
    vsync: this
  );
  late final Animation<double> _animation = CurvedAnimation(
    parent: _controller,
    curve: Curves.easeInOut,
  );

// class DashBoardFormList extends ConsumerWidget {
  final List<Color> gradientColors = [
    Colors.cyan,
    Colors.blue,
  ];
  // DashBoardFormList({super.key});
  @override
  Widget build(BuildContext context) {
    final gridItems = ref.watch(gridItem);
    return Column(
      children: [
        SizeTransition(
          axisAlignment: -1,
          axis: Axis.vertical,
          sizeFactor:
            CurvedAnimation(
              parent: _animation,
              curve: Curves.easeIn,
            ),

          child: Container(
            decoration: const BoxDecoration(
                borderRadius:
                    BorderRadius.only(bottomLeft: Radius.circular(70)),
                color: AppColors.primary),
            width: displayWidth(context),
            height: displayHeight(context) * 0.55,
            child: Stack(
              children: [
                Align(
                    alignment: Alignment.bottomRight,
                    child: Image.asset(
                      'assets/images/dashboard_design.png',
                      height: displayHeight(context) * 0.35,
                    )),
                Align(
                    alignment: Alignment.bottomLeft,
                    child: Container(
                      height: displayHeight(context)*0.35,
                      padding: EdgeInsets.only(left: 16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Hi,',
                            style: TextStyle(color: AppColors.white,fontSize: 32,fontWeight: FontWeight.w700),
                          ),
                          Text(
                            'Ajay sagar',
                            style: TextStyle(color: AppColors.white,fontSize: 32,fontWeight: FontWeight.w700),
                          ),
                          SizedBox(height: displayHeight(context)*0.01,),
                          SizedBox(
                              width: displayWidth(context) * 0.50,
                              child: Text(
                                '"Welcome! Discover and enjoy the perfect coffee experience with us."',
                                style: TextStyle(color: AppColors.white),
                              )),
                        ],
                      ),
                    ))
              ],
            ),
          ),
        ),
        SizedBox(
          height: displayHeight(context) * 0.03,
        ),
        Expanded(
            child: SizedBox(
          width: displayWidth(context),
          height: displayHeight(context),
          child: GridView.builder(
            padding: const EdgeInsets.only(right: 16, left: 16, top: 10),
            itemCount: 4,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisSpacing: 15, mainAxisSpacing: 15, crossAxisCount: 2),
            itemBuilder: (context, index) {
              return Container(
                decoration: BoxDecoration(
                    border: Border.all(color: AppColors.boxBorderGray),
                    borderRadius:
                        const BorderRadius.all(Radius.circular(15))),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                        height: displayHeight(context) * 0.07,
                        width: displayWidth(context) * 0.17,
                        padding: EdgeInsets.all(15),
                        decoration: const BoxDecoration(
                          color: AppColors.boxBagGray,
                          borderRadius: BorderRadius.all(Radius.circular(15)),
                        ),
                        child: Image.asset(gridItems[index].icon)),
                    SizedBox(
                      height: displayHeight(context) * 0.01,
                    ),
                    Text(
                      gridItems[index].title,
                      style: TextStyle(
                          fontWeight: FontWeight.w600, fontSize: 16),
                    ),
                    SizedBox(
                      height: displayHeight(context) * 0.01,
                    ),
                    Text(gridItems[index].subTitle),
                  ],
                ),
                // height: displayHeight(context)*0.16,
                // width: displayWidth(context)*0.30,
              );
            },
          ),
          // child:
          // ListView.builder(
          //   itemCount: 2,
          //   itemBuilder: (context, index) {
          //     return SizedBox(
          //       width: displayWidth(context),
          //       height: displayHeight(context) * 0.20,
          //       child: Card(
          //           elevation: 2,
          //           child: Container(
          //             padding: const EdgeInsets.all(16),
          //
          //             child: Row(
          //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //               children: [
          //                 Column(
          //                   mainAxisAlignment: MainAxisAlignment.spaceAround,
          //                   crossAxisAlignment: CrossAxisAlignment.start,
          //                   // crossAxisAlignment: CrossAxisAlignment.start,
          //                   children: [
          //                     Text(
          //                       'Rejected',
          //                       style: AppStyles.cardTextStyle16,
          //                     ),
          //                     Text(
          //                       '2420',
          //                       style: AppStyles.cardTextStyle16
          //                           .copyWith(fontSize: FontSize.fontSize30),
          //                     ),
          //                     Row(
          //                       children: [
          //                         const Icon(Icons.arrow_downward,color: Colors.red,),
          //                         RichText(
          //                           text: TextSpan(
          //                             text: '20% ',
          //                             style: AppStyles.subHeading.copyWith(
          //                                 fontWeight: FontWeight.w500,
          //                                 color: Colors.red),
          //                             children:  <TextSpan>[
          //                               TextSpan(text: ' vs last month', style: AppStyles.subHeading.copyWith(
          //                                   fontWeight: FontWeight.w500,
          //                                   color: AppColors.grayCardContentColor),),
          //                             ],
          //                           ),
          //                         ),
          //                       ],
          //                     ),
          //                   ],
          //                 ),
          //                 SizedBox(
          //                   height: displayHeight(context) * 0.10,
          //                   width: displayWidth(context) * 0.30,
          //                   child: LineChart(
          //                     LineChartData(
          //                       lineTouchData:
          //                           const LineTouchData(enabled: false),
          //                       gridData: FlGridData(
          //                         show: true,
          //                         drawHorizontalLine: false,
          //                         drawVerticalLine: false,
          //                         verticalInterval: 1,
          //                         horizontalInterval: 1,
          //                         getDrawingVerticalLine: (value) {
          //                           return const FlLine(
          //                             color: Color(0xff37434d),
          //                             strokeWidth: 1,
          //                           );
          //                         },
          //                         getDrawingHorizontalLine: (value) {
          //                           return const FlLine(
          //                             color: Color(0xff37434d),
          //                             strokeWidth: 1,
          //                           );
          //                         },
          //                       ),
          //                       titlesData: const FlTitlesData(
          //                         show: true,
          //                         topTitles: AxisTitles(
          //                           sideTitles: SideTitles(showTitles: false),
          //                         ),
          //                         bottomTitles: AxisTitles(
          //                           sideTitles: SideTitles(showTitles: false),
          //                         ),
          //                         leftTitles: AxisTitles(
          //                           sideTitles: SideTitles(showTitles: false),
          //                         ),
          //                         rightTitles: AxisTitles(
          //                           sideTitles: SideTitles(showTitles: false),
          //                         ),
          //                       ),
          //                       borderData: FlBorderData(
          //                         show: false,
          //                         // border:,
          //                       ),
          //                       minX: 0,
          //                       maxX: 11,
          //                       minY: 0,
          //                       maxY: 6,
          //                       lineBarsData: [
          //                         LineChartBarData(
          //                           spots: const [
          //                             FlSpot(0, 1.44),
          //                             FlSpot(2.6, 2.43),
          //                             FlSpot(4.9, 5.44),
          //                             FlSpot(6.8, 1.44),
          //                             FlSpot(8, 4.44),
          //                             FlSpot(9.5, 3.44),
          //                             FlSpot(11, 3.44),
          //                           ],
          //                           isCurved: true,
          //                           gradient: LinearGradient(
          //                             colors: [
          //                               ColorTween(
          //                                     begin: gradientColors[0],
          //                                     end: gradientColors[1],
          //                                   ).lerp(0.2) ??
          //                                   gradientColors[0],
          //                               // Fallback to non-null value
          //                               ColorTween(
          //                                     begin: gradientColors[0],
          //                                     end: gradientColors[1],
          //                                   ).lerp(0.2) ??
          //                                   gradientColors[1],
          //                               // Fallback to non-null value
          //                             ],
          //                           ),
          //                           barWidth: 2,
          //                           isStrokeCapRound: true,
          //                           dotData: const FlDotData(
          //                             show: false,
          //                           ),
          //                           belowBarData: BarAreaData(
          //                             show: true,
          //                             gradient: LinearGradient(
          //                               colors: [
          //                                 ColorTween(
          //                                       begin: gradientColors[0],
          //                                       end: gradientColors[1],
          //                                     ).lerp(0.2)?.withOpacity(0.1) ??
          //                                     gradientColors[0].withOpacity(0.1),
          //                                 ColorTween(
          //                                       begin: gradientColors[0],
          //                                       end: gradientColors[1],
          //                                     ).lerp(0.2)?.withOpacity(0.1) ??
          //                                     gradientColors[0].withOpacity(0.1),
          //                               ],
          //                             ),
          //                           ),
          //                         ),
          //                       ],
          //                     ),
          //                   ),
          //                 ),
          //               ],
          //             ),
          //           )),
          //     );
          //   },
          // ),
        )),
      ],
    );
  }
}

//
// Card(
// elevation: 2,
// child: ListTile(
// leading: const Column(
// crossAxisAlignment: CrossAxisAlignment.start,
// children: [
// Text('Rejected'),
// Row(
// children: [
// Icon(Icons.arrow_downward),
// Text('20% vs last month'),
// ],
// ),
// ],
// ),
// trailing: SizedBox(
// height: displayHeight(context) * 0.30,
// width: displayWidth(context) * 0.30,
// child: LineChart(LineChartData(
// lineTouchData: const LineTouchData(enabled: false),
// gridData: FlGridData(
// show: true,
// drawHorizontalLine: false,
// drawVerticalLine: false,
// verticalInterval: 1,
// horizontalInterval: 1,
// getDrawingVerticalLine: (value) {
// return const FlLine(
// color: Color(0xff37434d),
// strokeWidth: 1,
// );
// },
// getDrawingHorizontalLine: (value) {
// return const FlLine(
// color: Color(0xff37434d),
// strokeWidth: 1,
// );
// },
// ),
// titlesData: const FlTitlesData(
// show: true,
// // bottomTitles: AxisTitles(
// //   sideTitles: SideTitles(
// //     showTitles: true,
// //     reservedSize: 30,
// //     getTitlesWidget: bottomTitleWidgets,
// //     interval: 1,
// //   ),
// // ),
// // leftTitles: AxisTitles(
// //   sideTitles: SideTitles(
// //     showTitles: true,
// //     getTitlesWidget: leftTitleWidgets,
// //     reservedSize: 42,
// //     interval: 1,
// //   ),
// // ),
// topTitles: AxisTitles(
// sideTitles: SideTitles(showTitles: false),
// ),
// bottomTitles: AxisTitles(
// sideTitles: SideTitles(showTitles: false),
// ),
// leftTitles: AxisTitles(
// sideTitles: SideTitles(showTitles: false),
// ),
// rightTitles: AxisTitles(
// sideTitles: SideTitles(showTitles: false),
// ),
// ),
// borderData: FlBorderData(
// show: true,
// border: Border.all(),
// ),
// minX: 0,
// maxX: 11,
// minY: 0,
// maxY: 6,
// lineBarsData: [
// LineChartBarData(
// spots: const [
// FlSpot(0, 1.44),
// FlSpot(2.6, 2.43),
// FlSpot(4.9, 5.44),
// FlSpot(6.8, 1.44),
// FlSpot(8, 4.44),
// FlSpot(9.5, 3.44),
// FlSpot(11, 3.44),
// ],
// isCurved: true,
// gradient: LinearGradient(
// colors: [
// ColorTween(
// begin: gradientColors[0],
// end: gradientColors[1])
//     .lerp(0.2)!,
// ColorTween(
// begin: gradientColors[0],
// end: gradientColors[1])
//     .lerp(0.2)!,
// ],
// ),
// barWidth: 5,
// isStrokeCapRound: true,
// dotData: const FlDotData(
// show: false,
// ),
// belowBarData: BarAreaData(
// show: true,
// gradient: LinearGradient(
// colors: [
// ColorTween(
// begin: gradientColors[0],
// end: gradientColors[1])
//     .lerp(0.2)!
//     .withOpacity(0.1),
// ColorTween(
// begin: gradientColors[0],
// end: gradientColors[1])
//     .lerp(0.2)!
//     .withOpacity(0.1),
// ],
// ),
// ),
// ),
// ],
// )),
// ),
// ),
// );
