import 'dart:developer';

import 'package:finexe/feature/Punch_In_Out/viewmodel/viewmodel.dart';
import 'package:finexe/feature/base/utils/namespase/app_colors.dart';
import 'package:finexe/feature/base/utils/namespase/display_size.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:one_clock/one_clock.dart';

class AttendanceScreen extends ConsumerWidget {
  const AttendanceScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final checkpunchProvider = ref.watch(attendanceProvider);
    log('loading: ' + checkpunchProvider.isLoading.toString());
    return Scaffold(
      appBar: AppBar(),
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const Text(
                'Hello',
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 30,
                    fontWeight: FontWeight.w500),
              ),
              const Text(
                'Singh, Utkarsh',
                style: TextStyle(
                    color: Colors.grey,
                    fontSize: 20,
                    fontWeight: FontWeight.w500),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * .03,
              ),
              Card(
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.10,
                  decoration: const BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text(
                            'Last Check in Time',
                            style: TextStyle(
                                color: Colors.grey.shade200,
                                fontSize: 16,
                                fontWeight: FontWeight.w400),
                          ),
                          DigitalClock(
                              showSeconds: false,
                              isLive: true,
                              digitalClockTextColor: Colors.white,
                              // decoration: const BoxDecoration(
                              //     color: Colors.yellow,
                              //     shape: BoxShape.rectangle,
                              //     borderRadius: BorderRadius.all(Radius.circular(15))),
                              datetime: DateTime.now())
                          // Text(controller.formattedDate.toString(),style: TextStyle(color:Colors.grey.shade200,fontSize: 20,fontWeight: FontWeight.w500),),
                        ],
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.grey.shade200,
                            shape: const RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10)))),
                        onPressed: () {
                          // controller.clickPunch();
                          ref
                              .read(attendanceProvider.notifier)
                              .clickPunch(context);
                          // ref
                          //     .read(attendanceProvider.notifier)
                          //     .onPunchIn(context);
                        },
                        child: checkpunchProvider.isLoading
                            ? const Center(
                                child: CircularProgressIndicator(
                                  color: Colors.blue,
                                ),
                              )
                            :
                            // checkpunchProvider.punchStatus
                            //     ? const Text(
                            //         'Punch In',
                            //         style: TextStyle(color: Colors.blue),
                            //       )
                            //     : const Text(
                            //         'Punch Out',
                            //         style: TextStyle(color: Colors.blue),
                            //       ),
                            Text(
                                'punchIn',
                                style: TextStyle(color: Colors.blue),
                              ),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
