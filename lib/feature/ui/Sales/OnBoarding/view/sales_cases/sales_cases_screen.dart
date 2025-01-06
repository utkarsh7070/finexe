import 'package:custom_sliding_segmented_control/custom_sliding_segmented_control.dart';
import 'package:finexe/feature/base/extentions/capital_letter.dart';
import 'package:finexe/feature/base/utils/namespase/app_style.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import '../../../../../base/utils/namespase/app_colors.dart';
import '../../../../../base/utils/namespase/display_size.dart';
import '../../view_model/on_boarding_view_model.dart';
import '../cases_details.dart';

class SalesCasesScreen extends ConsumerStatefulWidget {
  const SalesCasesScreen({super.key});

  @override
  _SalesCasesScreen createState() => _SalesCasesScreen();
}

// class _DashBoardScreen extends ConsumerState<MyDashBoardWidget>

class _SalesCasesScreen extends ConsumerState<SalesCasesScreen> {
  bool _isApiRefreshed = false; // Flag to ensure API is refreshed only once

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    if (!_isApiRefreshed) {
      _isApiRefreshed = true; // Mark the flag as true to prevent future calls
      WidgetsBinding.instance.addPostFrameCallback((_) {
       // ref.refresh(leaveRequestDetailsViewModelProvider);
        ref.refresh(getCasesData.notifier).fetchAllCases();
      });
    }
  }

 /* @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      ref.read(getCasesData.notifier).fetchAllCases();
    });
  }*/

  /*@override
  Widget build(BuildContext context) {
    final data = ref.watch(getCasesData);
    final dataViewModel = ref.read(getCasesData.notifier);
    return Container(
        width: displayWidth(context),
        height: displayHeight(context),
        color: AppColors.primary,
        padding: const EdgeInsets.only(top: 70),
        child: Container(
          height: displayHeight(context),
          padding: const EdgeInsets.only(left: 16, right: 16, top: 20),
          decoration: const BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30), topRight: Radius.circular(30))),
          child: Column(
            children: [
              const Text(
                textAlign: TextAlign.center,
                'Cases',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(
                height: displayHeight(context) * 0.02,
              ),
              CustomSlidingSegmentedControl<int>(
                padding: displayWidth(context) * 0.05,
                initialValue: 1,
                children: const {
                  1: Text('All'),
                  2: Text('Approved'),
                  3: Text('Pending'),
                  4: Text('Reject'),
                },
                decoration: BoxDecoration(
                  color: CupertinoColors.lightBackgroundGray,
                  borderRadius: BorderRadius.circular(8),
                ),
                thumbDecoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(6),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(.3),
                      blurRadius: 4.0,
                      spreadRadius: 1.0,
                      offset: const Offset(
                        0.0,
                        2.0,
                      ),
                    ),
                  ],
                ),
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeInToLinear,
                onValueChanged: (v) {
                  dataViewModel.switchTab(v);
                  print(v);
                },
                onTapSegment: (segment) {
                  // dataViewModel.switchTab(segment!);
                  print(segment);
                  return true;
                },
              ),
              data.isLoading
                  ? Expanded(
                      child: const Center(child: CircularProgressIndicator()))
                  : Expanded(
                      child: SizedBox(
                        height: displayHeight(context),
                        width: displayWidth(context),
                        child: ListView.builder(
                          itemCount: data.listData.length,
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onTap: () {
                                Navigator.pushNamed(
                                    context, AppRoutes.casesDetails);
                              },
                              child: SizedBox(
                                height: displayHeight(context) * 0.09,
                                width: displayWidth(context) * 0.100,
                                child: Stack(
                                  children: [
                                    Align(
                                      alignment: Alignment.centerRight,
                                      child: SizedBox(
                                        width: displayWidth(context) * 0.84,
                                        child: Stack(
                                          children: [
                                            SizedBox(
                                              width:
                                                  displayWidth(context) * 0.85,
                                              child: Card(
                                                  shape: RoundedRectangleBorder(
                                                    side: const BorderSide(
                                                        color: AppColors
                                                            .boxBorderGray),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            15.0),
                                                  ),
                                                  elevation: 0,
                                                  child: Container(
                                                    padding:
                                                        const EdgeInsets.all(8),
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        SizedBox(
                                                          width: displayWidth(
                                                                  context) *
                                                              0.35,
                                                          child: Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            // mainAxisAlignment:
                                                            //     MainAxisAlignment.spaceBetween,
                                                            children: [
                                                              Text(
                                                                CaplitalizeSentence()
                                                                    .capitalizeEachWord(
                                                                        data.listData[index].customerName ??
                                                                            ''),
                                                                overflow:
                                                                    TextOverflow
                                                                        .ellipsis,
                                                                style: AppStyles
                                                                    .subHeadingW500,
                                                              ),
                                                              Text(
                                                                data
                                                                    .listData[
                                                                        index]
                                                                    .customerFinId
                                                                    .toString(),
                                                                style: AppStyles
                                                                    .subHeading
                                                                    .copyWith(
                                                                        fontSize:
                                                                            12),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                        Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          // mainAxisAlignment:
                                                          //     MainAxisAlignment.center,
                                                          children: [
                                                            Text(
                                                              DateFormat(
                                                                      'dd/MM/yyyy')
                                                                  .format(data
                                                                      .listData[
                                                                          index]
                                                                      .createdAt),
                                                              // '11/09/2024',
                                                              style: AppStyles
                                                                  .subHeadingW500,
                                                            ),
                                                            Text(
                                                              DateFormat.jm()
                                                                  .format(data
                                                                      .listData[
                                                                          index]
                                                                      .createdAt),

                                                              // '11:30AM',
                                                              style: AppStyles
                                                                  .subHeading
                                                                  .copyWith(
                                                                      fontSize:
                                                                          12),
                                                            ),
                                                          ],
                                                        ),
                                                        const Icon(
                                                          CupertinoIcons
                                                              .forward,
                                                          size: 22,
                                                          color: AppColors.gray,
                                                        ),
                                                      ],
                                                    ),
                                                  )

                                                  ),
                                            ),
                                            Positioned(
                                              left: -2,
                                              right: 0,
                                              top: 0,
                                              bottom: 0,
                                              child: Align(
                                                alignment: Alignment.centerLeft,
                                                child: SizedBox(
                                                    width:
                                                        displayWidth(context) *
                                                            0.03,
                                                    height:
                                                        displayHeight(context) *
                                                            0.05,
                                                    child: Card(
                                                      color:statusColor(data.listData[index].currentStatus??'')
                                                    )),
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                    Align(
                                      alignment: Alignment.centerLeft,
                                      child: RotatedBox(
                                          quarterTurns: 3,
                                          child: Text(
                                            data.listData[index].currentStatus
                                                .toString().capitalize(),
                                            style: TextStyle(
                                                fontSize: 10,
                                                fontWeight: FontWeight.w400,
                                                color: statusColor(data.listData[index].currentStatus??'')

                                            ),
                                          )),
                                    )
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    )
            ],
          ),
        ));
  }*/

  @override
  Widget build(BuildContext context) {
    final data = ref.watch(getCasesData);
    final dataViewModel = ref.read(getCasesData.notifier);

    return Container(
      width: displayWidth(context),
      height: displayHeight(context),
      color: AppColors.primary,
      padding: const EdgeInsets.only(top: 70),
      child: Container(
        height: displayHeight(context),
        padding: const EdgeInsets.only(left: 16, right: 16, top: 20),
        decoration: const BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
          ),
        ),
        child: Column(
          children: [
            const Text(
              textAlign: TextAlign.center,
              'Cases',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(
              height: displayHeight(context) * 0.02,
            ),
            CustomSlidingSegmentedControl<int>(
              padding: displayWidth(context) * 0.05,
              initialValue: 1,
              children: const {
                1: Text('All'),
                2: Text('Approved'),
                3: Text('Pending'),
                4: Text('Reject'),
              },
              decoration: BoxDecoration(
                color: CupertinoColors.lightBackgroundGray,
                borderRadius: BorderRadius.circular(8),
              ),
              thumbDecoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(6),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(.3),
                    blurRadius: 4.0,
                    spreadRadius: 1.0,
                    offset: const Offset(0.0, 2.0),
                  ),
                ],
              ),
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInToLinear,
              onValueChanged: (v) {
                dataViewModel.switchTab(v);
                print(v);
              },
              onTapSegment: (segment) {
                print(segment);
                return true;
              },
            ),
            data.isLoading
                ? const Expanded(
              child: Center(child: CircularProgressIndicator()),
            )
                : data.listData.isEmpty
                ? const Expanded(
              child: Center(
                child: Text(
                  'No cases available.',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    color: AppColors.gray,
                  ),
                ),
              ),
            )
                : Expanded(
              child: SizedBox(
                height: displayHeight(context),
                width: displayWidth(context),
                child: ListView.builder(
                  itemCount: data.listData.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => CasesDetails(
                              customerId: data.listData[index].customerId ?? 'Unknown Customer',
                              customerName: data.listData[index].customerName ?? 'Unknown Customer',
                            ),
                          ),
                        );
                        /*Navigator.pushNamed(
                            context, *//*AppRoutes.casesDetails*//* CasesDetails());*/
                      },
                      child: SizedBox(
                        height: displayHeight(context) * 0.09,
                        width: displayWidth(context) * 0.100,
                        child: Stack(
                          children: [
                            Align(
                              alignment: Alignment.centerRight,
                              child: SizedBox(
                                width: displayWidth(context) * 0.84,
                                child: Stack(
                                  children: [
                                    SizedBox(
                                      width: displayWidth(context) * 0.85,
                                      child: Card(
                                        shape: RoundedRectangleBorder(
                                          side: const BorderSide(
                                            color: AppColors.boxBorderGray,
                                          ),
                                          borderRadius:
                                          BorderRadius.circular(15.0),
                                        ),
                                        elevation: 0,
                                        child: Container(
                                          padding: const EdgeInsets.all(8),
                                          child: Row(
                                            mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                            children: [
                                              SizedBox(
                                                width: displayWidth(
                                                    context) *
                                                    0.35,
                                                child: Column(
                                                  crossAxisAlignment:
                                                  CrossAxisAlignment
                                                      .start,
                                                  children: [
                                                    Text(
                                                      CaplitalizeSentence()
                                                          .capitalizeEachWord(
                                                          data.listData[index]
                                                              .customerName ??
                                                              ''),
                                                      overflow:
                                                      TextOverflow.ellipsis,
                                                      style: AppStyles
                                                          .subHeadingW500,
                                                    ),
                                                    Text(
                                                      data.listData[index]
                                                          .customerFinId
                                                          .toString(),
                                                      style: AppStyles
                                                          .subHeading
                                                          .copyWith(
                                                          fontSize: 12),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Column(
                                                crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    DateFormat('dd/MM/yyyy')
                                                        .format(data
                                                        .listData[index]
                                                        .createdAt),
                                                    style: AppStyles
                                                        .subHeadingW500,
                                                  ),
                                                  Text(
                                                    DateFormat.jm().format(
                                                        data.listData[index]
                                                            .createdAt),
                                                    style: AppStyles
                                                        .subHeading
                                                        .copyWith(
                                                        fontSize: 12),
                                                  ),
                                                ],
                                              ),
                                              const Icon(
                                                CupertinoIcons.forward,
                                                size: 22,
                                                color: AppColors.gray,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                      left: -2,
                                      right: 0,
                                      top: 0,
                                      bottom: 0,
                                      child: Align(
                                        alignment: Alignment.centerLeft,
                                        child: SizedBox(
                                          width: displayWidth(context) *
                                              0.03,
                                          height: displayHeight(context) *
                                              0.05,
                                          child: Card(
                                            color: statusColor(
                                              data.listData[index]
                                                  .currentStatus ??
                                                  '',
                                            ),
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                            Align(
                              alignment: Alignment.centerLeft,
                              child: RotatedBox(
                                quarterTurns: 3,
                                child: Text(
                                  data.listData[index].currentStatus
                                      .toString()
                                      .capitalize(),
                                  style: TextStyle(
                                    fontSize: 10,
                                    fontWeight: FontWeight.w400,
                                    color: statusColor(
                                      data.listData[index].currentStatus ??
                                          '',
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }


  Color statusColor(String status) {
    switch (status) {
      case 'complete':
        return Colors.green;
      case 'rejected':
        return Colors.red;
      case 'incomplete':
        return Colors.yellow.shade700;
      case 'approved':
        return Colors.green;
      case 'pending':
        return Colors.orange;
      default:
        return Colors.orange;
    }
  }
}
