import 'package:custom_sliding_segmented_control/custom_sliding_segmented_control.dart';
import 'package:finexe/feature/base/utils/namespase/app_style.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../base/utils/namespase/app_colors.dart';
import '../../../../../base/utils/namespase/display_size.dart';

class SalesCasesScreen extends ConsumerWidget {
  const SalesCasesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
        width: displayWidth(context),
        height: displayHeight(context),
        color: AppColors.primary,
        padding: const EdgeInsets.only(top: 70),
        child: Container(
          height: displayHeight(context),
          padding: const EdgeInsets.only(left: 16,right: 16),
          decoration: const BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30), topRight: Radius.circular(30))),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const BackButton(),
                  const Text(
                    textAlign: TextAlign.center,
                    'Cases',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(
                    width: displayWidth(context) * 0.10,
                  )
                ],
              ),
              SizedBox(
                height: displayHeight(context) * 0.02,
              ),
              CustomSlidingSegmentedControl<int>(
                padding: displayWidth(context) * 0.05,
                initialValue: 2,
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
                  print(v);
                },
              ),
              Expanded(
                  child: SizedBox(
                    height: displayHeight(context),
                    width: displayWidth(context),
                    child: ListView.builder(
                      itemBuilder: (context, index) {
                        return SizedBox(
                          height: displayHeight(context) * 0.08,
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
                                                color: AppColors.boxBorderGray),
                                            borderRadius: BorderRadius.circular(15.0),
                                          ),
                                          elevation: 0,
                                          child: ListTile(
                                            titleAlignment:
                                            ListTileTitleAlignment.center,
                                            leading: Column(
                                              crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                              // mainAxisAlignment:
                                              //     MainAxisAlignment.center,
                                              children: [
                                                Text(
                                                  'Shree Raj',
                                                  style: AppStyles.subHeadingW500,
                                                ),
                                                Text(
                                                  '7489455607',
                                                  style: AppStyles.subHeading
                                                      .copyWith(fontSize: 12),
                                                ),
                                              ],
                                            ),
                                            title: Column(
                                              crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                              // mainAxisAlignment:
                                              //     MainAxisAlignment.center,
                                              children: [
                                                Text(
                                                  '11/09/2024',
                                                  style: AppStyles.subHeadingW500,
                                                ),
                                                Text(
                                                  '11:30AM',
                                                  style: AppStyles.subHeading
                                                      .copyWith(fontSize: 12),
                                                ),
                                              ],
                                            ),
                                            trailing:Icon(
                                              CupertinoIcons.forward,

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
                                              width: displayWidth(context) * 0.03,
                                              height: displayHeight(context) * 0.05,
                                              child: const Card(
                                                color: Colors.green,
                                              )),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              const Align(
                                alignment: Alignment.centerLeft,
                                child: RotatedBox(
                                    quarterTurns: 3,
                                    child: Text(
                                      'Pending',
                                      style: TextStyle(
                                          fontSize: 10,
                                          fontWeight: FontWeight.w400,
                                          color: Colors.orange),
                                    )),
                              )
                            ],
                          ),
                        );
                      },
                    ),
                  ),
              )
            ],
          ),
        ));
  }
}
